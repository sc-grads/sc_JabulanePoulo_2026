import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import { ChevronLeft, ChevronRight, CheckCircle, XCircle, Package, Clock } from "lucide-react";
import { useAuth } from "../context/AuthContext";
import { bookRequestService } from "../services/bookRequestService";
import Navbar from "../components/Navbar";
import NavDrawer from "../components/NavDrawer";
import ConfirmModal from "../components/ConfirmModal";
import Toast from "../components/Toast";
import "../styles/Home.css";
import "../styles/AdminBookRequests.css";

const PER_PAGE = 10;

const TABS = [
  { key: "pending", label: "Pending" },
  { key: "in_progress", label: "In Progress" },
  { key: "added", label: "Added" },
  { key: "rejected", label: "Rejected" },
  { key: "all", label: "All" },
];

function AdminBookRequests() {
  const navigate = useNavigate();
  const { isAdmin } = useAuth();

  const [requests, setRequests] = useState([]);
  const [counts, setCounts] = useState({
    pending: 0, in_progress: 0, added: 0, rejected: 0, all: 0
  });
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");
  const [tab, setTab] = useState("pending");
  const [page, setPage] = useState(1);
  const [totalPages, setTotalPages] = useState(1);
  const [drawerOpen, setDrawerOpen] = useState(false);

  const [actionTarget, setActionTarget] = useState(null);
  const [adminNote, setAdminNote] = useState("");
  const [saving, setSaving] = useState(false);

  const [toast, setToast] = useState({ open: false, type: "success", message: "" });
  const showToast = (message, type = "success") => setToast({ open: true, type, message });
  const hideToast = () => setToast((t) => ({ ...t, open: false }));

  const loadRequests = async (status = tab, targetPage = 1) => {
    try {
      setLoading(true);
      setError("");
      const data = await bookRequestService.getAll(status, targetPage, PER_PAGE);
      setRequests(data.requests || []);
      setTotalPages(data.pagination?.total_pages || 1);
      setCounts(data.counts || {});
      setTab(status);
      setPage(targetPage);
      window.scrollTo({ top: 0, behavior: "smooth" });
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    if (!isAdmin) {
      navigate("/home");
      return;
    }
    loadRequests("pending", 1);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [isAdmin, navigate]);

  const openAction = (req, newStatus) => {
    setActionTarget({ ...req, newStatus });
    setAdminNote("");
  };

  const confirmAction = async () => {
    if (!actionTarget) return;
    setSaving(true);
    try {
      await bookRequestService.updateStatus(
        actionTarget.request_id,
        actionTarget.newStatus,
        adminNote.trim()
      );
      showToast(`Request marked as "${actionTarget.newStatus}"`);
      setActionTarget(null);
      loadRequests(tab, page);
    } catch (err) {
      showToast(err.message, "error");
    } finally {
      setSaving(false);
    }
  };

  return (
    <div className="admin-page">
      <Navbar onOpenDrawer={() => setDrawerOpen(true)} />

      <div className="admin-content">
        <header className="admin-page-header">
          <div>
            <h1>Book Requests</h1>
            <p className="welcome">Books customers want added to the catalog</p>
          </div>
          <div className="admin-stat-card">
            <span className="stat-value">{counts.pending || 0}</span>
            <span className="stat-label">Pending</span>
          </div>
        </header>

        {error && <p className="form-error">{error}</p>}

        <div className="reviews-tabs">
          {TABS.map((t) => (
            <button
              key={t.key}
              className={`reviews-tab ${tab === t.key ? "active" : ""}`}
              onClick={() => loadRequests(t.key, 1)}
            >
              {t.label}
              <span className="tab-count">{counts[t.key] || 0}</span>
            </button>
          ))}
        </div>

        {loading && <p className="loading-text">Loading requests…</p>}

        {!loading && requests.length === 0 && (
          <p className="no-results">No requests in this category.</p>
        )}

        {!loading && requests.map((r) => (
          <div key={r.request_id} className="req-admin-card">
            <div className="req-admin-head">
              <div>
                <h3>{r.title}</h3>
                {r.author && <p className="req-admin-author">by {r.author}</p>}
                {r.isbn && <p className="req-admin-isbn">ISBN: {r.isbn}</p>}
              </div>
              <span className={`req-status req-status-${r.status}`}>
                {r.status.replace("_", " ")}
              </span>
            </div>

            <p className="req-admin-customer">
              {r.customer_name} — {r.customer_email}
            </p>

            {r.notes && (
              <div className="req-admin-notes">
                <strong>Customer notes:</strong>
                <p>{r.notes}</p>
              </div>
            )}

            {r.admin_note && (
              <div className="req-admin-note">
                <strong>Admin note:</strong>
                <p>{r.admin_note}</p>
              </div>
            )}

            <p className="req-admin-date">
              Requested on {new Date(r.created_at).toLocaleDateString()}
            </p>

            <div className="req-admin-actions">
              {r.status === "pending" && (
                <>
                  <button className="approve-btn" onClick={() => openAction(r, "in_progress")}>
                    <Package size={16} /> Start Sourcing
                  </button>
                  <button className="add-btn" onClick={() => openAction(r, "added")}>
                    <CheckCircle size={16} /> Mark as Added
                  </button>
                  <button className="reject-btn" onClick={() => openAction(r, "rejected")}>
                    <XCircle size={16} /> Reject
                  </button>
                </>
              )}

              {r.status === "in_progress" && (
                <>
                  <button className="add-btn" onClick={() => openAction(r, "added")}>
                    <CheckCircle size={16} /> Mark as Added
                  </button>
                  <button className="reject-btn" onClick={() => openAction(r, "rejected")}>
                    <XCircle size={16} /> Reject
                  </button>
                </>
              )}
            </div>
          </div>
        ))}

        {!loading && totalPages > 1 && (
          <Pagination
            currentPage={page}
            totalPages={totalPages}
            onPageChange={(p) => loadRequests(tab, p)}
          />
        )}
      </div>

      <ConfirmModal
        open={!!actionTarget}
        title={`Mark request as "${actionTarget?.newStatus?.replace("_", " ")}"?`}
        message={
          actionTarget
            ? `"${actionTarget.title}" — customer will be emailed.`
            : ""
        }
        confirmText="Confirm"
        cancelText="Cancel"
        variant={actionTarget?.newStatus === "rejected" ? "danger" : "info"}
        processing={saving}
        onConfirm={confirmAction}
        onCancel={() => setActionTarget(null)}
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
  if (end > totalPages) {
    end = totalPages;
    start = Math.max(1, end - MAX_VISIBLE + 1);
  }
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

export default AdminBookRequests;