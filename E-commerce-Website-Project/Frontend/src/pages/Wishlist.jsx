import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import { Heart, Trash2, Star, ChevronLeft, ChevronRight } from "lucide-react";
import { useAuth } from "../context/AuthContext";
import { wishlistService } from "../services/wishlistService";
import { cartService } from "../services/cartService";
import { reviewService } from "../services/reviewService";
import Navbar from "../components/Navbar";
import NavDrawer from "../components/NavDrawer";
import Toast from "../components/Toast";
import "../styles/Home.css";
import "../styles/Wishlist.css";

const PER_PAGE = 8;

function Wishlist() {
  const navigate = useNavigate();
  const { isCustomer } = useAuth();

  const [items, setItems] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");
  const [drawerOpen, setDrawerOpen] = useState(false);
  const [page, setPage] = useState(1);
  const [totalPages, setTotalPages] = useState(1);
  const [totalItems, setTotalItems] = useState(0);

  const [toast, setToast] = useState({ open: false, type: "success", message: "" });
  const showToast = (message, type = "success") => setToast({ open: true, type, message });
  const hideToast = () => setToast((t) => ({ ...t, open: false }));

  const loadWishlist = async (targetPage = 1) => {
    try {
      setLoading(true);
      const data = await wishlistService.getWishlist(targetPage, PER_PAGE);
      setItems(data.wishlist || []);
      setTotalPages(data.pagination?.total_pages || 1);
      setTotalItems(data.pagination?.total_items || 0);
      setPage(targetPage);
      window.scrollTo({ top: 0, behavior: "smooth" });
    } catch (err) { setError(err.message); }
    finally { setLoading(false); }
  };

  useEffect(() => {
    if (!isCustomer) { navigate("/login"); return; }
    loadWishlist(1);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [isCustomer, navigate]);

  const handleRemove = async (bookId) => {
    try {
      await wishlistService.removeFromWishlist(bookId);
      showToast("Removed from wishlist");
      window.dispatchEvent(new Event("wishlist-updated"));
      const newPage = items.length === 1 && page > 1 ? page - 1 : page;
      loadWishlist(newPage);
    } catch (err) { showToast(err.message, "error"); }
  };

  const handleAddToCart = async (book) => {
    try {
      await cartService.addItem(book.book_id, 1);
      showToast(`"${book.title}" added to cart ✓`);
      window.dispatchEvent(new Event("cart-updated"));
    } catch (err) { showToast(err.message, "error"); }
  };

  return (
    <div className="wishlist-page-wrapper">
      <Navbar onOpenDrawer={() => setDrawerOpen(true)} />

      <div className="wishlist-page">
        <header className="wishlist-header">
          <h1>My Wishlist <Heart size={22} fill="#eb001b" stroke="#eb001b" /></h1>
          {totalItems > 0 && (
            <span className="wishlist-count">{totalItems} book{totalItems === 1 ? "" : "s"}</span>
          )}
        </header>

        {loading && <p className="loading-text">Loading wishlist…</p>}
        {error && <p className="form-error">{error}</p>}

        {!loading && !error && items.length === 0 && (
          <div className="empty-wishlist">
            <Heart size={56} color="#d6d3f0" />
            <p>Your wishlist is empty.</p>
            <button onClick={() => navigate("/books")}>Browse Books</button>
          </div>
        )}

        {!loading && !error && items.length > 0 && (
          <>
            <div className="wishlist-grid">
              {items.map((w) => (
                <WishlistCard
                  key={w.wishlist_id}
                  book={w.book}
                  onRemove={() => handleRemove(w.book.book_id)}
                  onAddToCart={() => handleAddToCart(w.book)}
                  navigate={navigate}
                />
              ))}
            </div>

            {totalPages > 1 && (
              <Pagination
                currentPage={page}
                totalPages={totalPages}
                onPageChange={loadWishlist}
              />
            )}
          </>
        )}
      </div>

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

function WishlistCard({ book, onRemove, onAddToCart, navigate }) {
  const [rating, setRating] = useState({ avg: 0, total: 0 });

  useEffect(() => {
    (async () => {
      try {
        const data = await reviewService.getBookReviews(book.book_id);
        setRating({ avg: data.average_rating, total: data.total_reviews });
      } catch {}
    })();
  }, [book.book_id]);

  const inStock = book.stock_quantity > 0;

  return (
    <div className="wishlist-card">
      <div className="wishlist-image" onClick={() => navigate(`/books/${book.book_id}`)}>
        {book.image_url ? (
          <img
            src={book.image_url.startsWith("http") ? book.image_url : `${import.meta.env.VITE_API_URL}${book.image_url}`}
            alt={book.title}
          />
        ) : (
          <div className="book-cover">BOOK</div>
        )}
      </div>

      <div className="wishlist-info">
        <h3 onClick={() => navigate(`/books/${book.book_id}`)} style={{ cursor: "pointer" }}>
          {book.title}
        </h3>
        <p className="wishlist-author">{book.author}</p>

        <p className="wishlist-rating">
          {rating.total > 0 ? (
            <>
              <Star size={13} fill="#ffb400" stroke="#ffb400" />
              <strong>{rating.avg.toFixed(1)}</strong>
              <span className="rating-count">({rating.total})</span>
            </>
          ) : (
            <span className="no-rating">No reviews yet</span>
          )}
        </p>

        <p className="wishlist-price">R{Number(book.price).toFixed(2)}</p>

        <div className="wishlist-actions">
          <button className="wishlist-add" onClick={onAddToCart} disabled={!inStock}>
            {inStock ? "Add to Cart" : "Out of Stock"}
          </button>
          <button className="wishlist-remove" onClick={onRemove}>
            <Trash2 size={16} />
          </button>
        </div>
      </div>
    </div>
  );
}

export default Wishlist;