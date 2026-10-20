import { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import { BookOpen, CheckCircle, Clock, Package, XCircle } from "lucide-react";
import { useAuth } from "../context/AuthContext";
import { bookRequestService } from "../services/bookRequestService";
import Navbar from "../components/Navbar";
import NavDrawer from "../components/NavDrawer";
import Toast from "../components/Toast";
import "../styles/Home.css";
import "../styles/RequestBook.css";

const STATUS_INFO = {
  pending: { label: "Pending", icon: Clock, color: "pending" },
  in_progress: { label: "In Progress", icon: Package, color: "progress" },
  added: { label: "Added to Catalog", icon: CheckCircle, color: "added" },
  rejected: { label: "Rejected", icon: XCircle, color: "rejected" }
};

function RequestBook() {
  const navigate = useNavigate();
  const { isCustomer } = useAuth();

  const [drawerOpen, setDrawerOpen] = useState(false);
  const [form, setForm] = useState({
    title: "",
    author: "",
    isbn: "",
    notes: "",
  });
  const [submitting, setSubmitting] = useState(false);
  const [myRequests, setMyRequests] = useState([]);

  const [toast, setToast] = useState({
    open: false,
    type: "success",
    message: "",
  });

  const showToast = (message, type = "success") =>
    setToast({ open: true, type, message });

  const hideToast = () => setToast((t) => ({ ...t, open: false }));

  const loadRequests = async () => {
    try {
      const data = await bookRequestService.getMine();
      setMyRequests(data.requests || []);
    } catch (err) {
      console.warn(err.message);
    }
  };

  useEffect(() => {
    if (!isCustomer) {
      navigate("/login");
      return;
    }
    loadRequests();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [isCustomer, navigate]);

  const handleChange = (e) => {
    setForm({ ...form, [e.target.name]: e.target.value });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setSubmitting(true);

    try {
      await bookRequestService.submit({
        title: form.title.trim(),
        author: form.author.trim(),
        isbn: form.isbn.trim(),
        notes: form.notes.trim(),
      });
      showToast("Request submitted! We'll let you know when it's added.");
      setForm({ title: "", author: "", isbn: "", notes: "" });
      await loadRequests();
    } catch (err) {
      showToast(err.message, "error");
    } finally {
      setSubmitting(false);
    }
  };

  return (
    <div className="request-page">
      <Navbar onOpenDrawer={() => setDrawerOpen(true)} />

      <div className="request-content">
        <header className="request-header">
          <div className="request-icon">
            <BookOpen size={32} />
          </div>
          <h1>Can't find a book?</h1>
          <p>
            Let us know which book you'd like to see in our catalog and
            we'll do our best to add it.
          </p>
        </header>

        <div className="request-grid">
          {/* FORM */}
          <section className="request-card">
            <h2>Request a book</h2>
            <form onSubmit={handleSubmit}>
              <div className="form-group">
                <label>Book Title *</label>
                <input
                  type="text"
                  name="title"
                  value={form.title}
                  onChange={handleChange}
                  placeholder="e.g. The Midnight Library"
                  required
                />
              </div>

              <div className="form-row-2col">
                <div className="form-group">
                  <label>Author (optional)</label>
                  <input
                    type="text"
                    name="author"
                    value={form.author}
                    onChange={handleChange}
                    placeholder="e.g. Matt Haig"
                  />
                </div>
                <div className="form-group">
                  <label>ISBN (optional)</label>
                  <input
                    type="text"
                    name="isbn"
                    value={form.isbn}
                    onChange={handleChange}
                    placeholder="978-..."
                  />
                </div>
              </div>

              <div className="form-group">
                <label>Notes (optional)</label>
                <textarea
                  name="notes"
                  value={form.notes}
                  onChange={handleChange}
                  placeholder="Any additional details — edition, language, etc."
                  rows={3}
                />
              </div>

              <button
                type="submit"
                className="request-submit"
                disabled={submitting || !form.title.trim()}
              >
                {submitting ? "Sending…" : "Submit Request"}
              </button>
            </form>
          </section>

          {/* MY REQUESTS */}
          <section className="request-card">
            <h2>My requests</h2>
            {myRequests.length === 0 ? (
              <p className="no-requests">
                You haven't requested any books yet.
              </p>
            ) : (
              <div className="request-list">
                {myRequests.map((r) => {
                  const info = STATUS_INFO[r.status] || STATUS_INFO.pending;
                  const Icon = info.icon;

                  return (
                    <div key={r.request_id} className="request-item">
                      <div className="request-item-head">
                        <div>
                          <h3>{r.title}</h3>
                          {r.author && <p className="req-author">by {r.author}</p>}
                        </div>
                        <span className={`req-status req-status-${info.color}`}>
                          <Icon size={12} /> {info.label}
                        </span>
                      </div>
                      {r.admin_note && (
                        <p className="req-note">
                          <strong>Admin note:</strong> {r.admin_note}
                        </p>
                      )}
                      <p className="req-date">
                        Requested on{" "}
                        {new Date(r.created_at).toLocaleDateString()}
                      </p>
                    </div>
                  );
                })}
              </div>
            )}
          </section>
        </div>
      </div>

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

export default RequestBook;