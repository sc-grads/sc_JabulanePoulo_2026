import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import { Trash2, Search, ChevronLeft, ChevronRight } from "lucide-react";
import { useAuth } from "../context/AuthContext";
import { customerService } from "../services/customerService";
import Navbar from "../components/Navbar";
import NavDrawer from "../components/NavDrawer";
import ConfirmModal from "../components/ConfirmModal";
import Toast from "../components/Toast";
import "../styles/Home.css";
import "../styles/AdminCustomers.css";

const PER_PAGE = 10;

function AdminCustomers() {
  const navigate = useNavigate();
  const { isAdmin } = useAuth();

  const [customers, setCustomers] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");
  const [search, setSearch] = useState("");
  const [page, setPage] = useState(1);
  const [totalPages, setTotalPages] = useState(1);
  const [totalCustomers, setTotalCustomers] = useState(0);
  const [drawerOpen, setDrawerOpen] = useState(false);
  const [deleteTarget, setDeleteTarget] = useState(null);
  const [deleting, setDeleting] = useState(false);
  const [toast, setToast] = useState({ open: false, type: "success", message: "" });

  const showToast = (message, type = "success") => setToast({ open: true, type, message });
  const hideToast = () => setToast((t) => ({ ...t, open: false }));

  const loadCustomers = async (targetPage = 1, term = search) => {
    try {
      setLoading(true);
      const data = await customerService.getCustomers(targetPage, PER_PAGE, term);
      setCustomers(data.customers || []);
      setTotalPages(data.pagination?.total_pages || 1);
      setTotalCustomers(data.total || 0);
      setPage(targetPage);
      window.scrollTo({ top: 0, behavior: "smooth" });
    } catch (err) { setError(err.message); }
    finally { setLoading(false); }
  };

  useEffect(() => {
    if (!isAdmin) { navigate("/home"); return; }
    loadCustomers(1, "");
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [isAdmin, navigate]);

  const handleSearch = (e) => { e.preventDefault(); loadCustomers(1, search); };
  const handleClearSearch = () => { setSearch(""); loadCustomers(1, ""); };

  const confirmDelete = async () => {
    if (!deleteTarget) return;
    setDeleting(true);
    try {
      await customerService.deleteCustomer(deleteTarget.user_id);
      showToast(`${deleteTarget.name} ${deleteTarget.surname} deleted.`);
      const newPage = customers.length === 1 && page > 1 ? page - 1 : page;
      setDeleteTarget(null);
      loadCustomers(newPage, search);
    } catch (err) { showToast(err.message, "error"); }
    finally { setDeleting(false); }
  };

  return (
    <div className="admin-page">
      <Navbar onOpenDrawer={() => setDrawerOpen(true)} />

      <div className="admin-content">
        <header className="admin-page-header">
          <div>
            <h1>Customers</h1>
            <p className="welcome">Manage registered customers</p>
          </div>
          <div className="admin-stat-card">
            <span className="stat-value">{totalCustomers}</span>
            <span className="stat-label">Customers</span>
          </div>
        </header>

        {error && <p className="form-error">{error}</p>}

        <form className="customers-search" onSubmit={handleSearch}>
          <Search size={18} className="search-icon" />
          <input type="text" placeholder="Search by name or email…" value={search} onChange={(e) => setSearch(e.target.value)} />
          <button type="submit">Search</button>
          {search && (
            <button type="button" className="clear-btn" onClick={handleClearSearch}>Clear</button>
          )}
        </form>

        <section className="admin-section">
          <div className="section-header">
            <h2>All Customers</h2>
            <span className="section-count">{totalCustomers} total</span>
          </div>

          {loading ? (
            <p className="loading-text">Loading customers…</p>
          ) : customers.length === 0 ? (
            <p className="no-results">No customers found.</p>
          ) : (
            <>
              <div className="table-wrapper">
                <table className="admin-table">
                  <thead>
                    <tr>
                      <th>ID</th><th>Name</th><th>Email</th><th>Orders</th><th>Reviews</th>
                      <th className="th-actions">Actions</th>
                    </tr>
                  </thead>
                  <tbody>
                    {customers.map((c) => (
                      <tr key={c.user_id}>
                        <td className="cell-id">#{c.user_id}</td>
                        <td className="cell-title">{c.name} {c.surname}</td>
                        <td>{c.email}</td>
                        <td><span className="count-pill">{c.order_count}</span></td>
                        <td><span className="count-pill">{c.review_count}</span></td>
                        <td className="actions-cell">
                          <button
                            className="danger"
                            onClick={() => setDeleteTarget({ user_id: c.user_id, name: c.name, surname: c.surname, email: c.email })}
                          >
                            <Trash2 size={14} /> Delete
                          </button>
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>

              {totalPages > 1 && (
                <Pagination currentPage={page} totalPages={totalPages} onPageChange={(p) => loadCustomers(p, search)} />
              )}
            </>
          )}
        </section>
      </div>

      <ConfirmModal
        open={!!deleteTarget}
        title="Delete this customer?"
        message={deleteTarget ? `${deleteTarget.name} ${deleteTarget.surname} (${deleteTarget.email}) will be permanently removed. Their cart, reviews, and profile will be deleted. Their past orders will remain for accounting.` : ""}
        confirmText="Delete Customer" cancelText="Cancel" variant="danger"
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

export default AdminCustomers;