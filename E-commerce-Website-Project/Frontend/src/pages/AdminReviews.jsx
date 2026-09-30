import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import { Star, CheckCircle, XCircle, Trash2, ChevronLeft, ChevronRight } from "lucide-react";
import { useAuth } from "../context/AuthContext";
import { reviewService } from "../services/reviewService";
import Navbar from "../components/Navbar";
import NavDrawer from "../components/NavDrawer";
import ConfirmModal from "../components/ConfirmModal";
import Toast from "../components/Toast";
import "../styles/Home.css";
import "../styles/AdminReviews.css";

const PER_PAGE = 10;

const TABS = [
  { key: "pending", label: "Pending" },
  { key: "approved", label: "Approved" },
  { key: "all", label: "All" },
];

function AdminReviews() {
  const navigate = useNavigate();
  const { isAdmin } = useAuth();

  const [reviews, setReviews] = useState([]);
  const [counts, setCounts] = useState({ pending: 0, approved: 0, all: 0 });
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");
  const [tab, setTab] = useState("pending");
  const [page, setPage] = useState(1);
  const [totalPages, setTotalPages] = useState(1);
  const [drawerOpen, setDrawerOpen] = useState(false);
  const [deleteTarget, setDeleteTarget] = useState(null);
  const [deleting, setDeleting] = useState(false);
  const [toast, setToast] = useState({ open: false, type: "success", message: "" });

  const showToast = (message, type = "success") => setToast({ open: true, type, message });
  const hideToast = () => setToast((t) => ({ ...t, open: false }));

  const loadReviews = async (status = tab, targetPage = 1) => {
    try {
      setLoading(true);
      const data = await reviewService.getAdminReviews(status, targetPage, PER_PAGE);
      setReviews(data.reviews || []);
      setTotalPages(data.pagination?.total_pages || 1);
      setCounts(data.counts || { pending: 0, approved: 0, all: 0 });
      setTab(status);
      setPage(targetPage);
      window.scrollTo({ top: 0, behavior: "smooth" });
    } catch (err) { setError(err.message); }
    finally { setLoading(false); }
  };

  useEffect(() => {
    if (!isAdmin) { navigate("/home"); return; }
    loadReviews("pending", 1);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [isAdmin, navigate]);

  const handleApprove = async (id) => {
    try {
      await reviewService.approveReview(id);
      showToast("Review approved ✓");
      loadReviews(tab, page);
    } catch (err) { showToast(err.message, "error"); }
  };

  const handleReject = async (id) => {
    try {
      await reviewService.rejectReview(id);
      showToast("Review rejected");
      loadReviews(tab, page);
    } catch (err) { showToast(err.message, "error"); }
  };

  const confirmDelete = async () => {
    if (!deleteTarget) return;
    setDeleting(true);
    try {
      await reviewService.deleteReview(deleteTarget);
      showToast("Review deleted");
      setDeleteTarget(null);
      loadReviews(tab, page);
    } catch (err) { showToast(err.message, "error"); }
    finally { setDeleting(false); }
  };

  return (
    <div className="admin-page">
      <Navbar onOpenDrawer={() => setDrawerOpen(true)} />

      <div className="admin-content">
        <header className="admin-page-header">
          <div>
            <h1>Reviews Moderation</h1>
            <p className="welcome">Approve or reject customer reviews</p>
          </div>
          <div className="admin-stat-card">
            <span className="stat-value">{counts.pending}</span>
            <span className="stat-label">Awaiting Approval</span>
          </div>
        </header>

        {error && <p className="form-error">{error}</p>}

        <div className="reviews-tabs">
          {TABS.map((t) => (
            <button
              key={t.key}
              className={`reviews-tab ${tab === t.key ? "active" : ""}`}
              onClick={() => loadReviews(t.key, 1)}
            >
              {t.label}
              <span className="tab-count">{counts[t.key] || 0}</span>
            </button>
          ))}
        </div>

        {loading ? (
          <p className="loading-text">Loading reviews…</p>
        ) : reviews.length === 0 ? (
          <p className="no-results">No reviews in this category.</p>
        ) : (
          <div className="reviews-list-admin">
            {reviews.map((r) => (
              <div key={r.review_id} className={`review-admin-card ${r.is_approved ? "approved" : "pending"}`}>
                <div className="review-admin-head">
                  <div>
                    <h3>{r.book_title}</h3>
                    <p className="review-admin-author">by {r.book_author}</p>
                  </div>
                  <span className={`review-status ${r.is_approved ? "approved" : "pending"}`}>
                    {r.is_approved ? "✓ Approved" : "Pending"}
                  </span>
                </div>

                <div className="review-admin-meta">
                  <div className="review-stars">
                    {[1, 2, 3, 4, 5].map((s) => (
                      <Star key={s} size={14} fill={s <= r.rating ? "#ffb400" : "none"} stroke="#ffb400" />
                    ))}
                  </div>
                  <span className="review-admin-date">{r.created_at ? new Date(r.created_at).toLocaleString() : ""}</span>
                </div>

                <p className="review-admin-reviewer">{r.reviewer_name} — {r.reviewer_email}</p>

                {r.comment ? (
                  <p className="review-admin-comment">"{r.comment}"</p>
                ) : (
                  <p className="review-admin-comment empty">(No comment — just a rating)</p>
                )}

                <div className="review-admin-actions">
                  {!r.is_approved ? (
                    <button className="approve-btn" onClick={() => handleApprove(r.review_id)}>
                      <CheckCircle size={16} /> Approve
                    </button>
                  ) : (
                    <button className="reject-btn" onClick={() => handleReject(r.review_id)}>
                      <XCircle size={16} /> Unapprove
                    </button>
                  )}

                  <button className="delete-btn" onClick={() => setDeleteTarget(r.review_id)}>
                    <Trash2 size={16} /> Delete
                  </button>
                </div>
              </div>
            ))}
          </div>
        )}

        {!loading && totalPages > 1 && (
          <Pagination currentPage={page} totalPages={totalPages} onPageChange={(p) => loadReviews(tab, p)} />
        )}
      </div>

      <ConfirmModal
        open={!!deleteTarget}
        title="Delete this review?"
        message="This will permanently remove the review from the system."
        confirmText="Delete" cancelText="Cancel" variant="danger"
        processing={deleting} onConfirm={confirmDelete}
        onCancel={() => setDeleteTarget(null)}
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

export default AdminReviews;