import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import { Star, ChevronLeft, ChevronRight, RotateCcw } from "lucide-react";
import { useAuth } from "../context/AuthContext";
import { orderService } from "../services/orderService";
import { returnService } from "../services/returnService";
import Navbar from "../components/Navbar";
import NavDrawer from "../components/NavDrawer";
import ReviewModal from "../components/ReviewModal";
import ReturnModal from "../components/ReturnModal";
import ConfirmModal from "../components/ConfirmModal";
import Toast from "../components/Toast";
import "../styles/Home.css";
import "../styles/Orders.css";

const PER_PAGE = 5;

function Orders() {
  const navigate = useNavigate();
  const { isCustomer } = useAuth();

  const [orders, setOrders] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");
  const [drawerOpen, setDrawerOpen] = useState(false);

  // Modals
  const [reviewModal, setReviewModal] = useState(null);
  const [returnModal, setReturnModal] = useState(null);
  const [cancelTarget, setCancelTarget] = useState(null);

  const [cancelling, setCancelling] = useState(false);
  const [myReturns, setMyReturns] = useState([]);

  // Pagination
  const [page, setPage] = useState(1);
  const [totalPages, setTotalPages] = useState(1);
  const [totalOrders, setTotalOrders] = useState(0);

  // Toast
  const [toast, setToast] = useState({
    open: false,
    type: "success",
    message: "",
  });

  const showToast = (message, type = "success") =>
    setToast({ open: true, type, message });

  const hideToast = () => setToast((t) => ({ ...t, open: false }));

  // ============================================================
  // LOAD ORDERS
  // ============================================================
  const loadOrders = async (targetPage = 1) => {
    try {
      setLoading(true);
      setError("");

      const data = await orderService.getOrders(targetPage, PER_PAGE);
      setOrders(data.orders || []);
      setTotalPages(data.pagination?.total_pages || 1);
      setTotalOrders(data.pagination?.total_orders || 0);
      setPage(targetPage);

      window.scrollTo({ top: 0, behavior: "smooth" });
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

  // ============================================================
  // LOAD RETURNS
  // ============================================================
  const loadMyReturns = async () => {
    try {
      const data = await returnService.getMyReturns();
      setMyReturns(data.returns || []);
    } catch (err) {
      console.warn("Returns fetch failed:", err.message);
    }
  };

  useEffect(() => {
    if (!isCustomer) {
      navigate("/login");
      return;
    }
    loadOrders(1);
    loadMyReturns();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [isCustomer, navigate]);

  // ============================================================
  // CANCEL ORDER
  // ============================================================
  const confirmCancel = async () => {
    if (!cancelTarget) return;
    setCancelling(true);

    try {
      await orderService.cancelOrder(cancelTarget.order_id);
      showToast(`Order #${cancelTarget.order_id} cancelled`);
      setCancelTarget(null);
      loadOrders(page);
      window.dispatchEvent(new Event("cart-updated"));
    } catch (err) {
      showToast(err.message, "error");
    } finally {
      setCancelling(false);
    }
  };

  // ============================================================
  // HELPERS
  // ============================================================
  const markReviewed = (bookId) => {
    setOrders((prev) =>
      prev.map((o) => ({
        ...o,
        items: o.items.map((it) =>
          it.book_id === bookId ? { ...it, reviewed: true } : it
        ),
      }))
    );
  };

  const getReturnForOrder = (orderId) =>
    myReturns.find(
      (r) =>
        r.order_id === orderId &&
        (r.status === "pending" || r.status === "approved")
    );

  const canCancel = (status) =>
    status === "pending" || status === "paid";

  const getStatusLabel = (status) =>
    status.charAt(0).toUpperCase() + status.slice(1);

  // ============================================================
  // RENDER
  // ============================================================
  return (
    <div className="orders-page-wrapper">
      <Navbar onOpenDrawer={() => setDrawerOpen(true)} />

      <div className="orders-page">
        <div className="orders-header">
          <h1>My Orders</h1>
          {totalOrders > 0 && (
            <span className="orders-count">
              {totalOrders} order{totalOrders === 1 ? "" : "s"}
            </span>
          )}
        </div>

        {loading && <p className="loading-text">Loading orders…</p>}
        {error && <p className="form-error">{error}</p>}

        {!loading && !error && orders.length === 0 && (
          <div className="empty-orders">
            <p>You haven't placed any orders yet.</p>
            <button onClick={() => navigate("/books")}>Browse Books</button>
          </div>
        )}

        {!loading &&
          !error &&
          orders.map((order) => {
            const orderReturn = getReturnForOrder(order.order_id);
            const cancellable = canCancel(order.status);

            return (
              <div key={order.order_id} className="order-card">
                <div className="order-header">
                  <div>
                    <h3>Order #{order.order_id}</h3>
                    <p className="order-date">
                      {new Date(order.order_date).toLocaleString()}
                    </p>
                  </div>

                  <div className="order-header-right">
                    <span className={`status status-${order.status}`}>
                      {getStatusLabel(order.status)}
                    </span>

                    <span
                      className={`delivery-badge delivery-${order.delivery_method}`}
                    >
                      {order.delivery_method === "delivery"
                        ? " Delivery"
                        : " Pickup"}
                    </span>

                    {order.status === "delivered" && !orderReturn && (
                      <button
                        className="return-btn"
                        onClick={() => setReturnModal(order)}
                      >
                        <RotateCcw size={14} /> Return
                      </button>
                    )}

                    {orderReturn && (
                      <span
                        className={`return-badge return-${orderReturn.status}`}
                      >
                        Return {orderReturn.status}
                      </span>
                    )}

                    {cancellable && (
                      <button
                        className="cancel-order-btn"
                        onClick={() => setCancelTarget(order)}
                      >
                        Cancel Order
                      </button>
                    )}
                  </div>
                </div>

                <div className="order-items">
                  {order.items.map((item) => {
                    const canShowReviewBtn =
                      order.status === "delivered" && !item.reviewed;

                    return (
                      <div key={item.order_item_id} className="order-item">
                        <span>
                          {item.title} — {item.author}
                        </span>
                        <span>
                          {item.quantity} × R
                          {Number(item.price_at_purchase).toFixed(2)}
                        </span>
                        <strong>R{Number(item.item_total).toFixed(2)}</strong>

                        {canShowReviewBtn && (
                          <button
                            className="review-btn"
                            onClick={() =>
                              setReviewModal({
                                book: {
                                  book_id: item.book_id,
                                  title: item.title,
                                },
                                orderId: order.order_id,
                              })
                            }
                          >
                            <Star size={14} /> Review
                          </button>
                        )}

                        {order.status === "delivered" && item.reviewed && (
                          <span className="reviewed-tag">✓ Reviewed</span>
                        )}
                      </div>
                    );
                  })}
                </div>

                {orderReturn?.status === "pending" && (
                  <div className="return-info-banner">
                    Your return request is pending admin review.
                  </div>
                )}

                {orderReturn?.status === "approved" && (
                  <div className="return-info-banner return-approved">
                    Your return has been approved.
                  </div>
                )}

                <div className="order-total">
                  Total:{" "}
                  <strong>R{Number(order.total_amount).toFixed(2)}</strong>
                  {order.delivery_method === "delivery" &&
                    Number(order.delivery_fee) > 0 && (
                      <span className="delivery-note">
                        {" "}
                        (incl. R{Number(order.delivery_fee).toFixed(2)} delivery)
                      </span>
                    )}
                </div>
              </div>
            );
          })}

        {!loading && !error && totalPages > 1 && (
          <Pagination
            currentPage={page}
            totalPages={totalPages}
            onPageChange={loadOrders}
          />
        )}
      </div>

      {/* REVIEW MODAL */}
      {reviewModal && (
        <ReviewModal
          book={reviewModal.book}
          orderId={reviewModal.orderId}
          onClose={() => setReviewModal(null)}
          onSubmitted={() => {
            markReviewed(reviewModal.book.book_id);
            showToast("Review submitted! Thank you 🎉");
          }}
        />
      )}

      {/* RETURN MODAL */}
      {returnModal && (
        <ReturnModal
          order={returnModal}
          onClose={() => setReturnModal(null)}
          onSubmitted={async () => {
            await loadMyReturns();
            showToast("Return request submitted.");
          }}
        />
      )}

      {/* CANCEL ORDER MODAL */}
      <ConfirmModal
        open={!!cancelTarget}
        title="Cancel this order?"
        message={
          cancelTarget
            ? `Order #${cancelTarget.order_id} (R${Number(
                cancelTarget.total_amount
              ).toFixed(2)}) will be cancelled and the stock will be restored.`
            : ""
        }
        confirmText="Cancel Order"
        cancelText="Keep Order"
        variant="danger"
        processing={cancelling}
        onConfirm={confirmCancel}
        onCancel={() => setCancelTarget(null)}
      />

      <Toast
        open={toast.open}
        type={toast.type}
        message={toast.message}
        onClose={hideToast}
      />

      <NavDrawer open={drawerOpen} onClose={() => setDrawerOpen(false)} />
    </div>
  );
}

/* ============================================================
   PAGINATION
   ============================================================ */

function Pagination({ currentPage, totalPages, onPageChange }) {
  const MAX_VISIBLE = 9;

  let start = Math.max(1, currentPage - Math.floor(MAX_VISIBLE / 2));
  let end = start + MAX_VISIBLE - 1;
  if (end > totalPages) {
    end = totalPages;
    start = Math.max(1, end - MAX_VISIBLE + 1);
  }

  const pages = [];
  for (let i = start; i <= end; i++) pages.push(i);

  return (
    <div className="pagination">
      <button
        className="page-arrow"
        onClick={() => onPageChange(currentPage - 1)}
        disabled={currentPage === 1}
        aria-label="Previous page"
      >
        <ChevronLeft size={18} />
      </button>

      <div className="page-dots">
        {pages.map((p) => (
          <button
            key={p}
            className={`page-dot ${p === currentPage ? "active" : ""}`}
            onClick={() => onPageChange(p)}
            aria-label={`Go to page ${p}`}
          />
        ))}
      </div>

      <button
        className="page-arrow"
        onClick={() => onPageChange(currentPage + 1)}
        disabled={currentPage === totalPages}
        aria-label="Next page"
      >
        <ChevronRight size={18} />
      </button>
    </div>
  );
}

export default Orders;