import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import { ChevronLeft, ChevronRight, Star, Trash2, Eye, EyeOff } from "lucide-react";
import { useAuth } from "../context/AuthContext";
import { feedbackService } from "../services/feedbackService";
import Navbar from "../components/Navbar";
import NavDrawer from "../components/NavDrawer";
import ConfirmModal from "../components/ConfirmModal";
import Toast from "../components/Toast";
import "../styles/Home.css";
import "../styles/AdminFeedback.css";

const PER_PAGE = 10;

function AdminFeedback() {
  const navigate = useNavigate();
  const { isAdmin } = useAuth();

  const [feedback, setFeedback] = useState([]);
  const [stats, setStats] = useState({
    total: 0,
    average_rating: 0,
    counts: { 1: 0, 2: 0, 3: 0, 4: 0, 5: 0 },
  });
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");

  const [ratingFilter, setRatingFilter] = useState(null);
  const [page, setPage] = useState(1);
  const [totalPages, setTotalPages] = useState(1);

  const [drawerOpen, setDrawerOpen] = useState(false);
  const [deleteTarget, setDeleteTarget] = useState(null);
  const [deleting, setDeleting] = useState(false);

  const [toast, setToast] = useState({ open: false, type: "success", message: "" });
  const showToast = (message, type = "success") => setToast({ open: true, type, message });
  const hideToast = () => setToast((t) => ({ ...t, open: false }));

  const loadFeedback = async (targetPage = 1, rating = ratingFilter) => {
    try {
      setLoading(true);
      setError("");
      const data = await feedbackService.getAll(targetPage, PER_PAGE, rating);
      setFeedback(data.feedback || []);
      setStats(data.stats || { total: 0, average_rating: 0, counts: {} });
      setTotalPages(data.pagination?.total_pages || 1);
      setPage(targetPage);
      setRatingFilter(rating);
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
    loadFeedback(1, null);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [isAdmin, navigate]);

  const confirmDelete = async () => {
    if (!deleteTarget) return;
    setDeleting(true);
    try {
      await feedbackService.delete(deleteTarget);
      showToast("Feedback deleted");
      setDeleteTarget(null);
      loadFeedback(page);
    } catch (err) {
      showToast(err.message, "error");
    } finally {
      setDeleting(false);
    }
  };

  const handleToggleVisibility = async (id) => {
    try {
      const res = await feedbackService.toggleVisibility(id);
      showToast(res.message || "Visibility updated");
      loadFeedback(page);
    } catch (err) {
      showToast(err.message, "error");
    }
  };

  const maxCount = Math.max(...Object.values(stats.counts), 1);

  return (
    <div className="admin-page">
      <Navbar onOpenDrawer={() => setDrawerOpen(true)} />

      <div className="admin-content">
        <header className="admin-page-header">
          <div>
            <h1>Customer Feedback</h1>
            <p className="welcome">See what customers think of the app</p>
          </div>
          <div className="admin-stat-card">
            <span className="stat-value">{stats.total}</span>
            <span className="stat-label">Total Reviews</span>
          </div>
        </header>

        {error && <p className="form-error">{error}</p>}

        {/* STATS SUMMARY */}
        {stats.total > 0 && (
          <section className="feedback-stats-card">
            <div className="stats-left">
              <strong className="stats-avg">
                {stats.average_rating.toFixed(1)}
              </strong>
              <div className="stats-stars">
                {[1, 2, 3, 4, 5].map((s) => (
                  <Star
                    key={s}
                    size={18}
                    fill={s <= Math.round(stats.average_rating) ? "#ffb400" : "none"}
                    stroke="#ffb400"
                  />
                ))}
              </div>
              <p>Average rating from {stats.total} review{stats.total === 1 ? "" : "s"}</p>
            </div>

            <div className="stats-right">
              {[5, 4, 3, 2, 1].map((s) => {
                const count = stats.counts[s] || 0;
                const pct = (count / maxCount) * 100;
                return (
                  <div key={s} className="stats-row">
                    <span className="stats-label">
                      {s} <Star size={11} fill="#ffb400" stroke="#ffb400" />
                    </span>
                    <div className="stats-bar">
                      <div className="stats-fill" style={{ width: `${pct}%` }} />
                    </div>
                    <span className="stats-count">{count}</span>
                  </div>
                );
              })}
            </div>
          </section>
        )}

        {/* FILTER */}
        <div className="feedback-filter">
          <label>Filter by rating:</label>
          <select
            value={ratingFilter || ""}
            onChange={(e) => {
              const val = e.target.value ? Number(e.target.value) : null;
              loadFeedback(1, val);
            }}
          >
            <option value="">All ratings</option>
            {[5, 4, 3, 2, 1].map((s) => (
              <option key={s} value={s}>
                {s} star{s === 1 ? "" : "s"} ({stats.counts[s] || 0})
              </option>
            ))}
          </select>
        </div>

        {/* LIST */}
        {loading ? (
          <p className="loading-text">Loading feedback…</p>
        ) : feedback.length === 0 ? (
          <p className="no-results">No feedback in this filter.</p>
        ) : (
          <div className="feedback-list-admin">
            {feedback.map((f) => (
              <div key={f.feedback_id} className={`feedback-admin-card ${!f.is_visible ? "hidden-fb" : ""}`}>
                <div className="fb-admin-head">
                  <div>
                    <h3>{f.name}</h3>
                    {f.email && <p className="fb-admin-email">{f.email}</p>}
                  </div>
                  <div className="fb-admin-stars">
                    {[1, 2, 3, 4, 5].map((s) => (
                      <Star
                        key={s}
                        size={14}
                        fill={s <= f.rating ? "#ffb400" : "none"}
                        stroke="#ffb400"
                      />
                    ))}
                  </div>
                </div>

                {f.comment ? (
                  <p className="fb-admin-comment">"{f.comment}"</p>
                ) : (
                  <p className="fb-admin-comment empty">(No comment — just a rating)</p>
                )}

                <p className="fb-admin-date">
                  {new Date(f.created_at).toLocaleString()}
                </p>

                <div className="fb-admin-actions">
                  <button
                    className="toggle-visibility-btn"
                    onClick={() => handleToggleVisibility(f.feedback_id)}
                  >
                    {f.is_visible ? (
                      <>
                        <Eye size={14} /> Visible
                      </>
                    ) : (
                      <>
                        <EyeOff size={14} /> Hidden
                      </>
                    )}
                  </button>

                  <button
                    className="delete-btn"
                    onClick={() => setDeleteTarget(f.feedback_id)}
                  >
                    <Trash2 size={14} /> Delete
                  </button>
                </div>
              </div>
            ))}
          </div>
        )}

        {!loading && totalPages > 1 && (
          <Pagination
            currentPage={page}
            totalPages={totalPages}
            onPageChange={(p) => loadFeedback(p)}
          />
        )}
      </div>

      <ConfirmModal
        open={!!deleteTarget}
        title="Delete this feedback?"
        message="This action cannot be undone."
        confirmText="Delete"
        cancelText="Cancel"
        variant="danger"
        processing={deleting}
        onConfirm={confirmDelete}
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

export default AdminFeedback;