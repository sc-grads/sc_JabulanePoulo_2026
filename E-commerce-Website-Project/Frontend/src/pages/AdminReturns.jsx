import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import { CheckCircle, XCircle, ChevronLeft, ChevronRight } from "lucide-react";
import { useAuth } from "../context/AuthContext";
import { returnService } from "../services/returnService";
import Navbar from "../components/Navbar";
import NavDrawer from "../components/NavDrawer";
import ConfirmModal from "../components/ConfirmModal";
import Toast from "../components/Toast";
import "../styles/Home.css";
import "../styles/AdminReturns.css";

const PER_PAGE = 10;

const TABS = [
  { key: "pending", label: "Pending" },
  { key: "approved", label: "Approved" },
  { key: "rejected", label: "Rejected" },
  { key: "all", label: "All" },
];

function AdminReturns() {
  const navigate = useNavigate();
  const { isAdmin } = useAuth();

  const [returns, setReturns] = useState([]);
  const [counts, setCounts] = useState({ pending: 0, approved: 0, rejected: 0, all: 0 });
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");
  const [tab, setTab] = useState("pending");
  const [page, setPage] = useState(1);
  const [totalPages, setTotalPages] = useState(1);
  const [drawerOpen, setDrawerOpen] = useState(false);
  const [resolveTarget, setResolveTarget] = useState(null);
  const [resolving, setResolving] = useState(false);
  const [toast, setToast] = useState({ open: false, type: "success", message: "" });

  const showToast = (message, type = "success") => setToast({ open: true, type, message });
  const hideToast = () => setToast((t) => ({ ...t, open: false }));

  const loadReturns = async (status = tab, targetPage = 1) => {
    try {
      setLoading(true);
      const data = await returnService.getAdminReturns(status, targetPage, PER_PAGE);
      setReturns(data.returns || []);
      setTotalPages(data.pagination?.total_pages || 1);
      setCounts(data.counts || { pending: 0, approved: 0, rejected: 0, all: 0 });
      setTab(status);
      setPage(targetPage);
      window.scrollTo({ top: 0, behavior: "smooth" });
    } catch (err) { setError(err.message); }
    finally { setLoading(false); }
  };

  useEffect(() => {
    if (!isAdmin) { navigate("/home"); return; }
    loadReturns("pending", 1);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [isAdmin, navigate]);

  const confirmResolve = async () => {
    if (!resolveTarget) return;
    setResolving(true);
    try {
      await returnService.resolveReturn(resolveTarget.return_id, resolveTarget.action, "");
      showToast(resolveTarget.action === "approve" ? "Return approved ✓" : "Return rejected");
      setResolveTarget(null);
      loadReturns(tab, page);
    } catch (err) { showToast(err.message, "error"); }
    finally { setResolving(false); }
  };

  return (
    <div className="admin-page">
      <Navbar onOpenDrawer={() => setDrawerOpen(true)} />

      <div className="admin-content">
        <header className="admin-page-header">
          <div>
            <h1>Return Requests</h1>
            <p className="welcome">Approve or reject customer returns</p>
          </div>
          <div className="admin-stat-card">
            <span className="stat-value">{counts.pending}</span>
            <span className="stat-label">Awaiting Review</span>
          </div>
        </header>

        {error && <p className="form-error">{error}</p>}

        <div className="reviews-tabs">
          {TABS.map((t) => (
            <button key={t.key} className={`reviews-tab ${tab === t.key ? "active" : ""}`} onClick={() => loadReturns(t.key, 1)}>
              {t.label}
              <span className="tab-count">{counts[t.key] || 0}</span>
            </button>
          ))}
        </div>

        {loading && <p className="loading-text">Loading returns…</p>}
        {!loading && returns.length === 0 && <p className="no-results">No returns in this category.</p>}

        {!loading && returns.map((r) => (
          <div key={r.return_id} className={`return-admin-card ${r.status}`}>
            <div className="return-admin-head">
              <div>
                <h3>Order #{r.order_id}</h3>
                <p className="return-admin-customer">{r.customer_name} — {r.customer_email}</p>
                <p className="return-admin-date">Requested {new Date(r.created_at).toLocaleString()}</p>
              </div>
              <span className={`review-status ${r.status}`}>{r.status}</span>
            </div>

            <div className="return-admin-reason">
              <strong>Reason:</strong>
              <p>"{r.reason}"</p>
            </div>

            {r.admin_note && (
              <div className="return-admin-note">
                <strong>Admin note:</strong>
                <p>{r.admin_note}</p>
              </div>
            )}

            <div className="return-admin-total">Order total: <strong>R{Number(r.order_total).toFixed(2)}</strong></div>

            {r.status === "pending" && (
              <div className="return-admin-actions">
                <button className="approve-btn" onClick={() => setResolveTarget({ return_id: r.return_id, action: "approve" })}>
                  <CheckCircle size={16} /> Approve
                </button>
                <button className="reject-btn" onClick={() => setResolveTarget({ return_id: r.return_id, action: "reject" })}>
                  <XCircle size={16} /> Reject
                </button>
              </div>
            )}
          </div>
        ))}

        {!loading && totalPages > 1 && (
          <Pagination currentPage={page} totalPages={totalPages} onPageChange={(p) => loadReturns(tab, p)} />
        )}
      </div>

      <ConfirmModal
        open={!!resolveTarget}
        title={resolveTarget?.action === "approve" ? "Approve this return?" : "Reject this return?"}
        message={resolveTarget?.action === "approve"
          ? "The order will be marked as returned."
          : "The customer will be notified that their return was rejected."}
        confirmText={resolveTarget?.action === "approve" ? "Approve" : "Reject"}
        variant={resolveTarget?.action === "approve" ? "info" : "danger"}
        processing={resolving}
        onConfirm={confirmResolve}
        onCancel={() => setResolveTarget(null)}
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

export default AdminReturns;