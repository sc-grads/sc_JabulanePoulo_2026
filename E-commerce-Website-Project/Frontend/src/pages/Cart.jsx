import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import { useAuth } from "../context/AuthContext";
import { cartService } from "../services/cartService";
import { orderService } from "../services/orderService";
import { apiRequest } from "../services/api";
import { authService } from "../services/authService";
import Navbar from "../components/Navbar";
import NavDrawer from "../components/NavDrawer";
import ConfirmModal from "../components/ConfirmModal";
import PaymentConfirmModal from "../components/PaymentConfirmModal";
import Toast from "../components/Toast";
import "../styles/Home.css";
import "../styles/Cart.css";

function Cart() {
  const navigate = useNavigate();
  const { isCustomer } = useAuth();

  const [cart, setCart] = useState({ items: [], total: 0 });
  const [customerInfo, setCustomerInfo] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");
  const [checkingOut, setCheckingOut] = useState(false);
  const [drawerOpen, setDrawerOpen] = useState(false);
  const [showConfirm, setShowConfirm] = useState(false);

  const [deleteTarget, setDeleteTarget] = useState(null);
  const [deleting, setDeleting] = useState(false);

  const [toast, setToast] = useState({ open: false, type: "success", message: "" });
  const showToast = (message, type = "success") => setToast({ open: true, type, message });
  const hideToast = () => setToast((t) => ({ ...t, open: false }));

  const loadCart = async () => {
    try {
      setLoading(true);
      const data = await cartService.getCart();
      setCart(data);
    } catch (err) { setError(err.message); }
    finally { setLoading(false); }
  };

  const loadCustomerInfo = async () => {
    try {
      const data = await authService.getInformation();
      setCustomerInfo(data);
    } catch (err) { console.warn(err.message); }
  };

  useEffect(() => {
    if (!isCustomer) { navigate("/login"); return; }
    loadCart();
    loadCustomerInfo();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [isCustomer, navigate]);

  const handleUpdate = async (itemId, newQty) => {
    if (newQty < 1) return;
    try {
      await cartService.updateItem(itemId, newQty);
      loadCart();
      window.dispatchEvent(new Event("cart-updated"));
    } catch (err) { showToast(err.message, "error"); }
  };

  const requestRemove = (item) => setDeleteTarget({ cart_item_id: item.cart_item_id, title: item.book.title });

  const confirmRemove = async () => {
    if (!deleteTarget) return;
    setDeleting(true);
    try {
      await cartService.removeItem(deleteTarget.cart_item_id);
      showToast(`"${deleteTarget.title}" removed from cart.`);
      setDeleteTarget(null);
      loadCart();
      window.dispatchEvent(new Event("cart-updated"));
    } catch (err) { showToast(err.message, "error"); }
    finally { setDeleting(false); }
  };

  const handleCheckout = () => {
    if (cart.items.length === 0) return;
    setShowConfirm(true);
  };

  const performCheckout = async (deliveryMethod) => {
    try {
      setCheckingOut(true);
      const orderRes = await orderService.createOrder({
        delivery_method: deliveryMethod,
      });
      const orderId = orderRes.order.order_id;
      const intentRes = await apiRequest(`/api/orders/${orderId}/create-payment-intent`, { method: "POST" });
      window.dispatchEvent(new Event("cart-updated"));
      setShowConfirm(false);
      navigate(`/checkout/${orderId}`, { state: { clientSecret: intentRes.clientSecret } });
    } catch (err) {
      showToast(err.message, "error");
      setCheckingOut(false);
    }
  };

  return (
    <div className="cart-page-wrapper">
      <Navbar onOpenDrawer={() => setDrawerOpen(true)} />

      {loading ? (
        <div className="cart-page"><p className="loading-text">Loading cart…</p></div>
      ) : error ? (
        <div className="cart-page"><p className="form-error">{error}</p></div>
      ) : (
        <div className="cart-page">
          <h1>My Cart</h1>

          {cart.items.length === 0 ? (
            <div className="empty-cart">
              <p>Your cart is empty.</p>
              <button onClick={() => navigate("/books")}>Continue Shopping</button>
            </div>
          ) : (
            <>
              <div className="cart-items">
                {cart.items.map((item) => (
                  <div key={item.cart_item_id} className="cart-item">
                    <div className="cart-item-image">
                      {item.book.image_url ? (
                        <img src={item.book.image_url.startsWith("http") ? item.book.image_url : `${import.meta.env.VITE_API_URL}${item.book.image_url}`} alt={item.book.title} />
                      ) : (
                        <div className="book-cover">BOOK</div>
                      )}
                    </div>
                    <div className="cart-item-info">
                      <h3>{item.book.title}</h3>
                      <p>{item.book.author}</p>
                      <p className="price">R{Number(item.book.price).toFixed(2)}</p>
                    </div>
                    <div className="cart-item-qty">
                      <button onClick={() => handleUpdate(item.cart_item_id, item.quantity - 1)}>−</button>
                      <span>{item.quantity}</span>
                      <button onClick={() => handleUpdate(item.cart_item_id, item.quantity + 1)}>+</button>
                    </div>
                    <div className="cart-item-total">R{Number(item.item_total).toFixed(2)}</div>
                    <button className="remove-btn" onClick={() => requestRemove(item)}>✕</button>
                  </div>
                ))}
              </div>

              <div className="cart-summary">
                <h2>Subtotal: R{Number(cart.total).toFixed(2)}</h2>
                <button className="checkout-btn" onClick={handleCheckout} disabled={checkingOut}>
                  {checkingOut ? "Placing order…" : "Checkout"}
                </button>
              </div>
            </>
          )}
        </div>
      )}

      <ConfirmModal
        open={!!deleteTarget}
        title="Remove this item?"
        message={deleteTarget ? `"${deleteTarget.title}" will be removed from your cart.` : ""}
        confirmText="Remove" cancelText="Cancel" variant="danger"
        processing={deleting} onConfirm={confirmRemove}
        onCancel={() => setDeleteTarget(null)}
      />

      <PaymentConfirmModal
        open={showConfirm}
        info={customerInfo}
        subtotal={Number(cart.total)}
        processing={checkingOut}
        onConfirm={performCheckout}
        onCancel={() => setShowConfirm(false)}
      />

      <Toast open={toast.open} type={toast.type} message={toast.message} onClose={hideToast} />

      <NavDrawer open={drawerOpen} onClose={() => setDrawerOpen(false)} />
    </div>
  );
}

export default Cart;