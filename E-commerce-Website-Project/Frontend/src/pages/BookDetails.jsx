import { useEffect, useState } from "react";
import { useParams, useNavigate } from "react-router-dom";
import { Star, ArrowLeft } from "lucide-react";
import { useAuth } from "../context/AuthContext";
import { bookService } from "../services/bookService";
import { cartService } from "../services/cartService";
import { reviewService } from "../services/reviewService";
import Navbar from "../components/Navbar";
import NavDrawer from "../components/NavDrawer";
import WishlistHeart from "../components/WishlistHeart";
import "../styles/Home.css";
import "../styles/BookDetails.css";

function BookDetails() {
  const { bookId } = useParams();
  const navigate = useNavigate();
  const { isAuthenticated, isCustomer } = useAuth();

  const [book, setBook] = useState(null);
  const [reviews, setReviews] = useState([]);
  const [avgRating, setAvgRating] = useState(0);
  const [totalReviews, setTotalReviews] = useState(0);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");
  const [adding, setAdding] = useState(false);
  const [toast, setToast] = useState("");
  const [drawerOpen, setDrawerOpen] = useState(false);

  useEffect(() => {
    (async () => {
      try {
        setLoading(true);
        const [allBooks, reviewData] = await Promise.all([
          bookService.getBooks({ per_page: 100 }),
          reviewService.getBookReviews(bookId),
        ]);
        const found = (allBooks.books || []).find((b) => b.book_id === Number(bookId));
        if (!found) setError("Book not found");
        else setBook(found);
        setReviews(reviewData.reviews || []);
        setAvgRating(reviewData.average_rating || 0);
        setTotalReviews(reviewData.total_reviews || 0);
      } catch (err) { setError(err.message); }
      finally { setLoading(false); }
    })();
  }, [bookId]);

  const handleAddToCart = async () => {
    if (!isAuthenticated) { navigate("/login"); return; }
    if (!isCustomer) return;
    try {
      setAdding(true);
      await cartService.addItem(book.book_id, 1);
      setToast("Added to cart ");
      setTimeout(() => setToast(""), 1500);
      window.dispatchEvent(new Event("cart-updated"));
    } catch (err) {
      setToast(err.message);
      setTimeout(() => setToast(""), 2000);
    } finally { setAdding(false); }
  };

  if (loading) return <div className="book-details-page"><p className="loading-text">Loading…</p></div>;
  if (error || !book) return <div className="book-details-page"><p className="form-error">{error || "Book not found"}</p></div>;

  return (
    <div className="book-details-page">
      <Navbar onOpenDrawer={() => setDrawerOpen(true)} />

      <div className="book-details-content">
        <div className="book-details-top">
          <div className="book-details-image">
            {book.image_url ? (
              <img
                src={book.image_url.startsWith("http") ? book.image_url : `${import.meta.env.VITE_API_URL}${book.image_url}`}
                alt={book.title}
              />
            ) : (
              <div className="book-cover">BOOK</div>
            )}
            <WishlistHeart bookId={book.book_id} />
          </div>

          <div className="book-details-info">
            <h1>{book.title}</h1>
            <p className="book-details-author">by {book.author}</p>

            <div className="book-details-rating">
              {totalReviews > 0 ? (
                <>
                  <Star size={18} fill="#ffb400" stroke="#ffb400" />
                  <strong>{avgRating.toFixed(1)}</strong>
                  <span className="rating-count">({totalReviews} {totalReviews === 1 ? "review" : "reviews"})</span>
                </>
              ) : (
                <span className="no-rating">No reviews yet</span>
              )}
            </div>

            <p className="book-details-price">R{Number(book.price).toFixed(2)}</p>
            <p className="book-details-stock">
              {book.stock_quantity > 0 ? `In stock: ${book.stock_quantity}` : "Out of stock"}
            </p>
            <p className="book-details-description">{book.description || "No description available."}</p>

            <button
              className="add-to-cart-btn"
              onClick={handleAddToCart}
              disabled={adding || book.stock_quantity < 1}
            >
              {book.stock_quantity < 1 ? "Out of Stock" : adding ? "Adding…" : " Add To Cart"}
            </button>
            {toast && <p className="cart-toast">{toast}</p>}
          </div>
        </div>

        <div className="book-details-reviews">
          <h2>Customer Reviews {totalReviews > 0 && <span>({totalReviews})</span>}</h2>

          {reviews.length === 0 ? (
            <p className="no-reviews-msg">No reviews yet. Be the first to review this book after you receive your order!</p>
          ) : (
            <div className="reviews-list">
              {reviews.map((r) => (
                <div key={r.review_id} className="review-card">
                  <div className="review-card-header">
                    <div className="review-avatar">{r.reviewer_name?.[0]?.toUpperCase() || "?"}</div>
                    <div className="review-meta">
                      <p className="review-name">{r.reviewer_name}</p>
                      <p className="review-date">{r.created_at ? new Date(r.created_at).toLocaleDateString() : ""}</p>
                    </div>
                    <div className="review-stars">
                      {[1, 2, 3, 4, 5].map((s) => (
                        <Star key={s} size={14} fill={s <= r.rating ? "#ffb400" : "none"} stroke="#ffb400" />
                      ))}
                    </div>
                  </div>
                  {r.comment ? (
                    <p className="review-comment">{r.comment}</p>
                  ) : (
                    <p className="review-comment empty">(No comment — just a rating)</p>
                  )}
                </div>
              ))}
            </div>
          )}
        </div>
      </div>

      <NavDrawer open={drawerOpen} onClose={() => setDrawerOpen(false)} />
    </div>
  );
}

export default BookDetails;