import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import { ChevronLeft, ChevronRight } from "lucide-react";
import { useAuth } from "../context/AuthContext";
import { apiRequest } from "../services/api";
import { bookService } from "../services/bookService";
import Navbar from "../components/Navbar";
import NavDrawer from "../components/NavDrawer";
import ConfirmModal from "../components/ConfirmModal";
import Toast from "../components/Toast";
import "../styles/Home.css";
import "../styles/AdminCategories.css";

const PER_PAGE = 8;

function AdminCategories() {
  const navigate = useNavigate();
  const { isAdmin } = useAuth();

  const [categories, setCategories] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");
  const [name, setName] = useState("");
  const [submitting, setSubmitting] = useState(false);
  const [editingId, setEditingId] = useState(null);
  const [deleteTarget, setDeleteTarget] = useState(null);
  const [deleting, setDeleting] = useState(false);
  const [drawerOpen, setDrawerOpen] = useState(false);
  const [page, setPage] = useState(1);
  const [totalPages, setTotalPages] = useState(1);
  const [totalCategories, setTotalCategories] = useState(0);
  const [toast, setToast] = useState({ open: false, type: "success", message: "" });

  const showToast = (message, type = "success") => setToast({ open: true, type, message });
  const hideToast = () => setToast((t) => ({ ...t, open: false }));

  useEffect(() => {
    if (!isAdmin) { navigate("/home"); return; }
    loadCategories(1);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [isAdmin, navigate]);

  const loadCategories = async (targetPage = 1) => {
    try {
      setLoading(true);
      setError("");
      const data = await bookService.getCategoriesPaginated(targetPage, PER_PAGE);
      setCategories(data.categories || []);
      setTotalPages(data.pagination?.total_pages || 1);
      setTotalCategories(data.pagination?.total_categories || 0);
      setPage(targetPage);
      window.scrollTo({ top: 0, behavior: "smooth" });
    } catch (err) { setError(err.message); }
    finally { setLoading(false); }
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!name.trim()) return;
    setSubmitting(true);
    try {
      if (editingId) {
        await apiRequest(`/api/categories/${editingId}`, { method: "PUT", body: JSON.stringify({ name: name.trim() }) });
        showToast("Category updated successfully!");
      } else {
        await apiRequest("/api/categories", { method: "POST", body: JSON.stringify({ name: name.trim() }) });
        showToast("Category created successfully!");
      }
      setName("");
      setEditingId(null);
      loadCategories(page);
    } catch (err) { showToast(err.message, "error"); }
    finally { setSubmitting(false); }
  };

  const handleStartEdit = (cat) => {
    setEditingId(cat.category_id);
    setName(cat.name);
    window.scrollTo({ top: 0, behavior: "smooth" });
  };

  const handleCancelEdit = () => {
    setEditingId(null);
    setName("");
  };

  const confirmDelete = async () => {
    if (!deleteTarget) return;
    setDeleting(true);
    try {
      await apiRequest(`/api/categories/${deleteTarget}`, { method: "DELETE" });
      showToast("Category deleted.");
      const newPage = categories.length === 1 && page > 1 ? page - 1 : page;
      setDeleteTarget(null);
      loadCategories(newPage);
    } catch (err) { showToast(err.message, "error"); }
    finally { setDeleting(false); }
  };

  return (
    <div className="admin-page">
      <Navbar onOpenDrawer={() => setDrawerOpen(true)} />

      <div className="admin-content">
        <header className="admin-page-header">
          <div>
            <h1>Categories</h1>
            <p className="welcome">Manage the book categories</p>
          </div>
          <div className="admin-stat-card">
            <span className="stat-value">{totalCategories}</span>
            <span className="stat-label">Categories</span>
          </div>
        </header>

        {error && <p className="form-error">{error}</p>}

        <section className="admin-section">
          <div className="section-header">
            <h2>{editingId ? `Edit Category #${editingId}` : "Add a New Category"}</h2>
            {editingId && <span className="editing-badge">Editing</span>}
          </div>
          <form className="category-form" onSubmit={handleSubmit}>
            <input type="text" placeholder="Category name (e.g. Fiction)" value={name} onChange={(e) => setName(e.target.value)} required />
            <button type="submit" disabled={submitting}>
              {submitting ? "Saving…" : editingId ? "Update Category" : "Create Category"}
            </button>
            {editingId && (
              <button type="button" className="cancel-btn" onClick={handleCancelEdit}>Cancel</button>
            )}
          </form>
        </section>

        <section className="admin-section">
          <div className="section-header">
            <h2>All Categories</h2>
            <span className="section-count">{totalCategories} total</span>
          </div>

          {loading ? (
            <p className="loading-text">Loading…</p>
          ) : categories.length === 0 ? (
            <p className="no-results">No categories yet.</p>
          ) : (
            <>
              <div className="table-wrapper">
                <table className="admin-table">
                  <thead>
                    <tr><th>ID</th><th>Name</th><th className="th-actions">Actions</th></tr>
                  </thead>
                  <tbody>
                    {categories.map((c) => (
                      <tr key={c.category_id} className={editingId === c.category_id ? "editing-row" : ""}>
                        <td className="cell-id">#{c.category_id}</td>
                        <td className="cell-title">{c.name}</td>
                        <td className="actions-cell">
                          <button className="edit" onClick={() => handleStartEdit(c)}>Edit</button>
                          <button className="danger" onClick={() => setDeleteTarget(c.category_id)}>Delete</button>
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
              {totalPages > 1 && (
                <Pagination currentPage={page} totalPages={totalPages} onPageChange={loadCategories} />
              )}
            </>
          )}
        </section>
      </div>

      <ConfirmModal
        open={!!deleteTarget}
        title="Delete this category?"
        message="Books using this category will keep their category_id, but the category name will disappear."
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

export default AdminCategories;