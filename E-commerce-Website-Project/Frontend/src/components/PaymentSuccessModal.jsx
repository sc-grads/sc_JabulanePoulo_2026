import { CheckCircle } from "lucide-react";
import "../styles/PaymentSuccessModal.css";

function PaymentSuccessModal({ open, orderId, onClose }) {
  if (!open) return null;

  return (
    <div className="success-overlay">
      <div className="success-modal">
        <div className="success-icon">
          <CheckCircle size={56} strokeWidth={1.5} />
        </div>

        <h2>Payment successful!</h2>
        <p className="success-msg">
          Your order <strong>#{orderId}</strong> has been paid.
          <br />
          You can track it in <em>My Orders</em>.
        </p>

        <button className="success-btn" onClick={onClose}>
          View My Orders
        </button>
      </div>
    </div>
  );
}

export default PaymentSuccessModal;