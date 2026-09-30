import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import { ChevronLeft, ChevronRight } from "lucide-react";
import { useAuth } from "../context/AuthContext";
import { apiRequest, apiUpload } from "../services/api";
import { bookService } from "../services/bookService";
import Navbar from "../components/Navbar";
import NavDrawer from "../components/NavDrawer";
import ConfirmModal from "../components/ConfirmModal";
import Toast from "../components/Toast";
import "../styles/Home.css";
import "../styles/AdminDashboard.css";

const PER_PAGE = 8;

const EMPTY_FORM = {
  title: "", author: "", description: "", price: "",
  stock_quantity: "", category_id: "", image_url: "", isbn: "",
};

function AdminDashboard() {
  const navigate = useNavigate();
  const { user, isAdmin } = useAuth();

  const [books, setBooks] = useState([]);
  const [categories, setCategories] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");
  const [form, setForm] = useState(EMPTY_FORM);
  const [submitting, setSubmitting] = useState(false);
  const [imageFile, setImageFile] = useState(null);
  const [imagePreview, setImagePreview] = useState("");
  const [editingId, setEditingId] = useState(null);
  const [drawerOpen, setDrawerOpen] = useState(false);
  const [page, setPage] = useState(1);
  const [totalPages, setTotalPages] = useState(1);
  const [totalBooks, setTotalBooks] = useState(0);
  const [deleteTarget, setDeleteTarget] = useState(null);
  const [deleting, setDeleting] = useState(false);
  const [toast, setToast] = useState({ open: false, type: "success", message: "" });

  const showToast = (message, type = "success") => setToast({ open: true, type, message });
  const hideToast = () => setToast((t) => ({ ...t, open: false }));

  useEffect(() => {
    if (!isAdmin) { navigate("/home"); return; }
    loadData(1);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [isAdmin, navigate]);

  const loadData = async (targetPage = 1) => {
    try {
      setLoading(true);
      setError("");
      const [booksData, catsData] = await Promise.all([
        bookService.getBooks({ page: targetPage, per_page: PER_PAGE }),
        bookService.getCategories(),
      ]);
      setBooks(booksData.books || []);
      setTotalPages(booksData.pagination?.total_pages || 1);
      setTotalBooks(booksData.pagination?.total_books || 0);
      setPage(targetPage);
      setCategories(catsData.categories || []);
    } catch (err) { setError(err.message); }
    finally { setLoading(false); }
  };

  const handleChange = (e) => setForm({ ...form, [e.target.name]: e.target.value });

  const handleImageChange = (e) => {
    const file = e.target.files[0];
    if (!file) return;
    const allowed = ["image/png", "image/jpeg", "image/jpg", "image/gif", "image/webp"];
    if (!allowed.includes(file.type)) {
      showToast("Please pick a PNG, JPG, GIF or WEBP image.", "error");
      return;
    }
    if (file.size > 5 * 1024 * 1024) {
      showToast("Image is larger than 5 MB.", "error");
      return;
    }
    setImageFile(file);
    setImagePreview(URL.createObjectURL(file));
  };

  const handleStartEdit = (book) => {
    setEditingId(book.book_id);
    setForm({
      title: book.title ?? "", author: book.author ?? "", description: book.description ?? "",
      price: book.price ?? "", stock_quantity: book.stock_quantity ?? "",
      category_id: book.category_id ?? "", image_url: book.image_url ?? "", isbn: book.isbn ?? "",
    });
    setImageFile(null);
    setImagePreview("");
    window.scrollTo({ top: 0, behavior: "smooth" });
  };

  const handleCancelEdit = () => {
    setEditingId(null);
    setForm(EMPTY_FORM);
    setImageFile(null);
    setImagePreview("");
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setSubmitting(true);
    setError("");

    try {
      let finalImageUrl = form.image_url || null;
      if (imageFile) {
        const fd = new FormData();
        fd.append("file", imageFile);
        const uploadRes = await apiUpload("/api/upload", fd);
        finalImageUrl = uploadRes.image_url;
      }

      const payload = {
        title: form.title, author: form.author, description: form.description,
        price: parseFloat(form.price),
        stock_quantity: parseInt(form.stock_quantity || "0", 10),
        category_id: parseInt(form.category_id, 10),
        image_url: finalImageUrl, isbn: form.isbn || null,
      };

      if (editingId) {
        await apiRequest(`/api/books/${editingId}`, { method: "PUT", body: JSON.stringify(payload) });
        showToast("Book updated successfully!");
      } else {
        await apiRequest("/api/books", { method: "POST", body: JSON.stringify(payload) });
        showToast("Book created successfully!");
      }

      handleCancelEdit();
      loadData(page);
    } catch (err) {
      setError(err.message);
      showToast(err.message, "error");
    } finally { setSubmitting(false); }
  };

  const confirmDelete = async () => {
    if (!deleteTarget) return;
    setDeleting(true);
    try {
      await apiRequest(`/api/books/${deleteTarget.book_id}`, { method: "DELETE" });
      showToast(`"${deleteTarget.title}" deleted.`);
      const newPage = books.length === 1 && page > 1 ? page - 1 : page;
      setDeleteTarget(null);
      loadData(newPage);
    } catch (err) { showToast(err.message, "error"); }
    finally { setDeleting(false); }
  };

  return (
    <div className="admin-page">
      <Navbar onOpenDrawer={() => setDrawerOpen(true)} />

      <div className="admin-content">
        <header className="admin-page-header">
          <div>
            <h1>Admin Dashboard</h1>
            <p className="welcome">Welcome back, {user.name} </p>
          </div>
          <div className="admin-stat-card">
            <span className="stat-value">{totalBooks}</span>
            <span className="stat-label">Books in Store</span>
          </div>
        </header>

        {error && <p className="form-error">{error}</p>}

        <section className="admin-section">
          <div className="section-header">
            <h2>{editingId ? `Edit Book #${editingId}` : "Add a New Book"}</h2>
            {editingId && <span className="editing-badge">Editing</span>}
          </div>

          <form className="book-form" onSubmit={handleSubmit}>
            <div className="form-group">
              <label>Title</label>
              <input name="title" placeholder="e.g. Atomic Habits" value={form.title} onChange={handleChange} required />
            </div>
            <div className="form-group">
              <label>Author</label>
              <input name="author" placeholder="e.g. James Clear" value={form.author} onChange={handleChange} required />
            </div>
            <div className="form-group">
              <label>Price (R)</label>
              <input name="price" type="number" step="0.01" placeholder="0.00" value={form.price} onChange={handleChange} required />
            </div>
            <div className="form-group">
              <label>Stock Quantity</label>
              <input name="stock_quantity" type="number" placeholder="0" value={form.stock_quantity} onChange={handleChange} />
            </div>
            <div className="form-group">
              <label>ISBN (optional)</label>
              <input name="isbn" placeholder="978-..." value={form.isbn} onChange={handleChange} />
            </div>
            <div className="form-group">
              <label>Category</label>
              <select name="category_id" value={form.category_id} onChange={handleChange} required>
                <option value="">Select category</option>
                {categories.map((c) => (
                  <option key={c.category_id} value={c.category_id}>{c.name}</option>
                ))}
              </select>
            </div>

            <div className="form-group form-group-full">
              <label>Book Cover Image</label>
              <input type="file" accept="image/png, image/jpeg, image/jpg, image/gif, image/webp" onChange={handleImageChange} />
              {(imagePreview || form.image_url) && (
                <div className="image-preview">
                  <img
                    src={imagePreview || `${import.meta.env.VITE_API_URL}${form.image_url}`}
                    alt="Preview"
                  />
                  <button type="button" className="remove-image-btn" onClick={() => { setImageFile(null); setImagePreview(""); setForm({ ...form, image_url: "" }); }}>
                    ✕ Remove
                  </button>
                </div>
              )}
            </div>

            <div className="form-group form-group-full">
              <label>Description</label>
              <textarea name="description" placeholder="A short description of the book…" value={form.description} onChange={handleChange} rows={3} />
            </div>

            <div className="form-actions">
              <button type="submit" disabled={submitting}>
                {submitting ? "Saving…" : editingId ? "Update Book" : "Create Book"}
              </button>
              {editingId && (
                <button type="button" className="cancel-btn" onClick={handleCancelEdit}>Cancel</button>
              )}
            </div>
          </form>
        </section>

        <section className="admin-section">
          <div className="section-header">
            <h2>All Books</h2>
            <span className="section-count">{totalBooks} total</span>
          </div>

          {loading ? (
            <p className="loading-text">Loading books…</p>
          ) : books.length === 0 ? (
            <p className="no-results">No books yet.</p>
          ) : (
            <>
              <div className="table-wrapper">
                <table className="admin-table">
                  <thead>
                    <tr>
                      <th>ID</th><th>Title</th><th>Author</th><th>Price</th><th>Stock</th>
                      <th className="th-actions">Actions</th>
                    </tr>
                  </thead>
                  <tbody>
                    {books.map((b) => (
                      <tr key={b.book_id} className={editingId === b.book_id ? "editing-row" : ""}>
                        <td className="cell-id">#{b.book_id}</td>
                        <td className="cell-title">{b.title}</td>
                        <td>{b.author}</td>
                        <td className="cell-price">R{Number(b.price).toFixed(2)}</td>
                        <td>
                          <span className={`stock-pill ${b.stock_quantity > 0 ? "in" : "out"}`}>
                            {b.stock_quantity}
                          </span>
                        </td>
                        <td className="actions-cell">
                          <button className="edit" onClick={() => handleStartEdit(b)}>Edit</button>
                          <button className="danger" onClick={() => setDeleteTarget({ book_id: b.book_id, title: b.title })}>Delete</button>
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>

              {totalPages > 1 && (
                <Pagination currentPage={page} totalPages={totalPages} onPageChange={loadData} />
              )}
            </>
          )}
        </section>
      </div>

      <ConfirmModal
        open={!!deleteTarget}
        title="Delete this book?"
        message={deleteTarget ? `"${deleteTarget.title}" will be permanently removed.` : ""}
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

export default AdminDashboard;