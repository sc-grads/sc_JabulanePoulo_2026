import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import { ChevronLeft, ChevronRight } from "lucide-react";
import { useAuth } from "../context/AuthContext";
import { apiRequest } from "../services/api";
import Navbar from "../components/Navbar";
import NavDrawer from "../components/NavDrawer";
import ConfirmModal from "../components/ConfirmModal";
import Toast from "../components/Toast";
import "../styles/Home.css";
import "../styles/AdminOrders.css";

const STATUSES = [
  "pending", "paid", "processing", "shipped", "delivered", "cancelled"
];
const PER_PAGE = 5;

const capitalize = (s) => (s ? s.charAt(0).toUpperCase() + s.slice(1) : "");

function AdminOrders() {
  const navigate = useNavigate();
  const { isAdmin } = useAuth();

  const [orders, setOrders] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");
  const [filter, setFilter] = useState("all");
  const [drawerOpen, setDrawerOpen] = useState(false);

  const [page, setPage] = useState(1);
  const [totalPages, setTotalPages] = useState(1);
  const [totalOrders, setTotalOrders] = useState(0);

  // Confirm modal state
  const [statusChange, setStatusChange] = useState(null);
  // { order_id, oldStatus, newStatus }
  const [saving, setSaving] = useState(false);

  const [toast, setToast] = useState({ open: false, type: "success", message: "" });
  const showToast = (message, type = "success") => setToast({ open: true, type, message });
  const hideToast = () => setToast((t) => ({ ...t, open: false }));

  const loadOrders = async (targetPage = 1) => {
    try {
      setLoading(true);
      setError("");
      const data = await apiRequest(
        `/api/admin/orders?page=${targetPage}&per_page=${PER_PAGE}`
      );
      setOrders(data.orders || []);
      setTotalPages(data.pagination?.total_pages || 1);
      setTotalOrders(data.pagination?.total_orders || 0);
      setPage(targetPage);
      window.scrollTo({ top: 0, behavior: "smooth" });
    } catch (err) { setError(err.message); }
    finally { setLoading(false); }
  };

  useEffect(() => {
    if (!isAdmin) { navigate("/home"); return; }
    loadOrders(1);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [isAdmin, navigate]);

  const requestStatusChange = (order, newStatus) => {
    if (order.status === newStatus) return;
    setStatusChange({
      order_id: order.order_id,
      oldStatus: order.status,
      newStatus,
    });
  };

  const confirmStatusChange = async () => {
    if (!statusChange) return;
    setSaving(true);

    try {
      await apiRequest(`/api/admin/orders/${statusChange.order_id}/status`, {
        method: "PUT",
        body: JSON.stringify({ status: statusChange.newStatus }),
      });

      setOrders((prev) =>
        prev.map((o) =>
          o.order_id === statusChange.order_id
            ? { ...o, status: statusChange.newStatus }
            : o
        )
      );

      showToast(
        `Order #${statusChange.order_id} → ${capitalize(statusChange.newStatus)}`
      );
      setStatusChange(null);
    } catch (err) {
      showToast(err.message, "error");
    } finally {
      setSaving(false);
    }
  };

  const filteredOrders =
    filter === "all" ? orders : orders.filter((o) => o.status === filter);

  return (
    <div className="admin-page">
      <Navbar onOpenDrawer={() => setDrawerOpen(true)} />

      <div className="admin-content">
        <div className="admin-page-header">
          <div>
            <h1>All Orders</h1>
            <p className="welcome">Manage customer orders</p>
          </div>
          <div className="admin-stat-card">
            <span className="stat-value">{totalOrders}</span>
            <span className="stat-label">Total Orders</span>
          </div>
        </div>

        {error && <p className="form-error">{error}</p>}

        <div className="orders-filter">
          <label>Filter by status:</label>
          <select value={filter} onChange={(e) => setFilter(e.target.value)}>
            <option value="all">All ({orders.length})</option>
            {STATUSES.map((s) => {
              const count = orders.filter((o) => o.status === s).length;
              return (
                <option key={s} value={s}>{capitalize(s)} ({count})</option>
              );
            })}
          </select>
        </div>

        {loading && <p className="loading-text">Loading orders…</p>}
        {!loading && filteredOrders.length === 0 && (
          <p className="no-results">No orders found.</p>
        )}

        {!loading && filteredOrders.map((order) => (
          <div key={order.order_id} className="order-card">
            <div className="order-header">
              <div>
                <h3>Order #{order.order_id}</h3>
                <p className="order-customer">
                  {order.customer_name} — {order.customer_email}
                </p>
                <p className="order-date">
                  {order.order_date ? new Date(order.order_date).toLocaleString() : "—"}
                </p>
                <p className="order-delivery">
                  {order.delivery_method === "delivery" ? " Delivery" : " Pickup"}
                  {order.delivery_fee > 0 && ` — R${Number(order.delivery_fee).toFixed(2)}`}
                </p>
              </div>

              <div className="order-header-right">
                <span className={`status status-${order.status}`}>
                  {capitalize(order.status)}
                </span>

                <select
                  className="status-select"
                  value={order.status}
                  onChange={(e) => requestStatusChange(order, e.target.value)}
                >
                  {STATUSES.map((s) => (
                    <option key={s} value={s}>{capitalize(s)}</option>
                  ))}
                </select>
              </div>
            </div>

            <div className="order-items">
              {order.items.map((item) => (
                <div key={item.order_item_id} className="order-item">
                  <span>{item.title} — {item.author}</span>
                  <span>{item.quantity} × R{Number(item.price_at_purchase).toFixed(2)}</span>
                  <strong>R{Number(item.item_total).toFixed(2)}</strong>
                </div>
              ))}
            </div>

            <div className="order-total">
              Total: <strong>R{Number(order.total_amount).toFixed(2)}</strong>
            </div>
          </div>
        ))}

        {!loading && totalPages > 1 && (
          <Pagination currentPage={page} totalPages={totalPages} onPageChange={loadOrders} />
        )}
      </div>

      {/* CONFIRM STATUS CHANGE MODAL */}
      <ConfirmModal
        open={!!statusChange}
        title={`Change status to "${capitalize(statusChange?.newStatus || "")}"?`}
        message={
          statusChange
            ? `Order #${statusChange.order_id} will move from "${capitalize(statusChange.oldStatus)}" to "${capitalize(statusChange.newStatus)}".${
                ["shipped", "delivered"].includes(statusChange.newStatus)
                  ? " The customer will be emailed automatically."
                  : ""
              }`
            : ""
        }
        confirmText="Confirm"
        cancelText="Cancel"
        variant="info"
        processing={saving}
        onConfirm={confirmStatusChange}
        onCancel={() => setStatusChange(null)}
      />

      <Toast open={toast.open} type={toast.type} message={toast.message} onClose={hideToast} />

      <NavDrawer open={drawerOpen} onClose={() => setDrawerOpen(false)} />
    </div>
  );
}

function Pagination({ currentPage, totalPages, onPageChange }) {
  const MAX_VISIBLE = 9;
  let start = Math.max(1, currentPage - Math.floor(MAX_VISIBLE / 2));
  let end = start + MAX_VISIBLE - 1;
  if (end > totalPages) { end = totalPages; start = Math.max(1, end - MAX_VISIBLE + 1); }
  const pages = [];
  for (let i = start; i <= end; i++) pages.push(i);
  return (
    <div className="pagination">
      <button className="page-arrow" onClick={() => onPageChange(currentPage - 1)} disabled={currentPage === 1}>
        <ChevronLeft size={18} />
      </button>
      <div className="page-dots">
        {pages.map((p) => (
          <button key={p} className={`page-dot ${p === currentPage ? "active" : ""}`} onClick={() => onPageChange(p)} />
        ))}
      </div>
      <button className="page-arrow" onClick={() => onPageChange(currentPage + 1)} disabled={currentPage === totalPages}>
        <ChevronRight size={18} />
      </button>
    </div>
  );
}

export default AdminOrders;