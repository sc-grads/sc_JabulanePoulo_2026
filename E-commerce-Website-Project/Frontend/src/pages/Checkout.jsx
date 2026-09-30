import { useEffect, useState } from "react";
import { useParams, useNavigate, useLocation } from "react-router-dom";
import { loadStripe } from "@stripe/stripe-js";
import {
  Elements,
  PaymentElement,
  useStripe,
  useElements,
} from "@stripe/react-stripe-js";
import { useAuth } from "../context/AuthContext";
import Navbar from "../components/Navbar";
import NavDrawer from "../components/NavDrawer";
import PaymentSuccessModal from "../components/PaymentSuccessModal";
import "../styles/Checkout.css";

const stripePromise = loadStripe(
  import.meta.env.VITE_STRIPE_PUBLISHABLE_KEY
);

function Checkout() {
  const { orderId } = useParams();
  const navigate = useNavigate();
  const location = useLocation();
  const { isAuthenticated } = useAuth();

  const [drawerOpen, setDrawerOpen] = useState(false);
  const [success, setSuccess] = useState(false);
  const clientSecret = location.state?.clientSecret;

  useEffect(() => {
    if (!isAuthenticated) navigate("/login");
    if (!clientSecret) navigate("/cart");
  }, [isAuthenticated, clientSecret, navigate]);

  if (!clientSecret) return null;

  return (
    <div className="checkout-page">
      <Navbar onOpenDrawer={() => setDrawerOpen(true)} />

      <div className="checkout-content">
        <h1>Complete Payment</h1>
        <p className="order-label">Order #{orderId}</p>

        <Elements stripe={stripePromise} options={{ clientSecret }}>
          <CheckoutForm
            orderId={orderId}
            onSuccess={() => setSuccess(true)}
          />
        </Elements>
      </div>

      <PaymentSuccessModal
        open={success}
        orderId={orderId}
        onClose={() => {
          setSuccess(false);
          window.dispatchEvent(new Event("cart-updated"));
          navigate("/orders");
        }}
      />

      <NavDrawer open={drawerOpen} onClose={() => setDrawerOpen(false)} />
    </div>
  );
}

/* ============================================================
   CHECKOUT FORM — charges directly on Pay Now
   ============================================================ */

function CheckoutForm({ orderId, onSuccess }) {
  const stripe = useStripe();
  const elements = useElements();

  const [message, setMessage] = useState("");
  const [processing, setProcessing] = useState(false);

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!stripe || !elements) return;

    setProcessing(true);
    setMessage("");

    // 1. Validate the card
    const { error: submitError } = await elements.submit();
    if (submitError) {
      setMessage(submitError.message);
      setProcessing(false);
      return;
    }

    // 2. Confirm payment (no redirect for standard cards)
    const { error, paymentIntent } = await stripe.confirmPayment({
      elements,
      confirmParams: {
        return_url: `${window.location.origin}/orders`,
      },
      redirect: "if_required",
    });

    if (error) {
      setMessage(error.message);
      setProcessing(false);
      return;
    }

    // 3. Success — mark the order as paid
    if (paymentIntent && paymentIntent.status === "succeeded") {
      try {
        await fetch(
          `${import.meta.env.VITE_API_URL}/api/orders/${orderId}/mark-paid`,
          {
            method: "POST",
            headers: {
              Authorization: `Bearer ${localStorage.getItem("token")}`,
            },
          }
        );
      } catch (err) {
        console.warn("Manual mark-paid failed:", err);
      }

      setProcessing(false);
      onSuccess();
    } else {
      setMessage("Please complete the verification on the next screen…");
    }
  };

  return (
    <form onSubmit={handleSubmit} className="checkout-form">
      <PaymentElement />
      <button
        type="submit"
        className="pay-btn"
        disabled={processing || !stripe}
      >
        {processing ? "Processing…" : "Pay Now"}
      </button>
      {message && <p className="payment-error">{message}</p>}
    </form>
  );
}

export default Checkout;