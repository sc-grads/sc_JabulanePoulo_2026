import { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import { Star, ChevronLeft, ChevronRight } from "lucide-react";
import { useAuth } from "../context/AuthContext";
import { bookService } from "../services/bookService";
import { cartService } from "../services/cartService";
import { reviewService } from "../services/reviewService";
import Navbar from "../components/Navbar";
import NavDrawer from "../components/NavDrawer";
import WishlistHeart from "../components/WishlistHeart";
import "../styles/Home.css";

const PER_PAGE = 5;

function Home() {
  const navigate = useNavigate();
  const { isAuthenticated, isCustomer } = useAuth();

  const [bestSellers, setBestSellers] = useState([]);
  const [bsPage, setBsPage] = useState(1);
  const [bsTotalPages, setBsTotalPages] = useState(1);
  const [bsLoading, setBsLoading] = useState(true);

  const [newReleases, setNewReleases] = useState([]);
  const [nrPage, setNrPage] = useState(1);
  const [nrTotalPages, setNrTotalPages] = useState(1);
  const [nrLoading, setNrLoading] = useState(true);

  const [error, setError] = useState("");
  const [drawerOpen, setDrawerOpen] = useState(false);

  // ================================
  // BEST SELLERS
  // ================================
  const loadBestSellers = async (targetPage = 1) => {
    try {
      setBsLoading(true);
      setError("");
      const data = await bookService.getBooks({
        page: targetPage,
        per_page: PER_PAGE,
        sort: "newest",
      });
      setBestSellers(data.books || []);
      setBsTotalPages(data.pagination?.total_pages || 1);
      setBsPage(targetPage);
    } catch (err) {
      setError(err.message || "Failed to load books");
    } finally {
      setBsLoading(false);
    }
  };

  // ================================
  // NEW RELEASES
  // ================================
  const loadNewReleases = async (targetPage = 1) => {
    try {
      setNrLoading(true);
      setError("");
      const data = await bookService.getBooks({
        page: targetPage,
        per_page: PER_PAGE,
        sort: "newest",
      });
      setNewReleases(data.books || []);
      setNrTotalPages(data.pagination?.total_pages || 1);
      setNrPage(targetPage);
    } catch (err) {
      setError(err.message || "Failed to load books");
    } finally {
      setNrLoading(false);
    }
  };

  useEffect(() => {
    loadBestSellers(1);
    loadNewReleases(1);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  return (
    <div className="home-page">

      {/* NAVBAR (with drawer trigger) */}
      <Navbar onOpenDrawer={() => setDrawerOpen(true)} />

      {/* HERO */}
      <section className="hero">
        <div className="hero-content">
          <h1>
            Buy your<br />
            books{" "}
            <span>for the best<br />prices</span>
          </h1>
          <p>
            Find and read more you'll love,
            and keep track of the books you want to read.
            <br />
            Be part of the world's largest community of book lovers.
          </p>
        </div>

        <div className="hero-book">
          <div className="book-placeholder">
            <img src="hero-book.jpg" alt="Featured book" />
          </div>
        </div>
      </section>

      {/* BEST SELLERS */}
      <section className="books-section">
        <h2>Best Seller Books</h2>

        {bsLoading && <p className="loading-text">Loading books…</p>}
        {error && <p className="form-error">{error}</p>}

        {!bsLoading && !error && bestSellers.length > 0 && (
          <div className="books-grid">
            {bestSellers.map((book) => (
              <BookCard key={book.book_id} book={book} />
            ))}
          </div>
        )}

        {!bsLoading && !error && bsTotalPages > 1 && (
          <Pagination
            currentPage={bsPage}
            totalPages={bsTotalPages}
            onPageChange={loadBestSellers}
          />
        )}
      </section>

      {/* FIND YOUR BOOK */}
      <section className="find-book">
        <div className="book-collage">
          <div className="collage-box">
            <img src="/src/assets/Book collage.jpg" alt="Book collage" />
          </div>
        </div>

        <div className="find-book-content">
          <h2>
            Find Your Favorite<br />
            <span>Book Here!</span>
          </h2>
          <p>
            Explore thousands of titles across every genre 
            from timeless classics to the newest releases.
          </p>
          
          <button onClick={() => navigate("/books")}>Explore Now</button>
        </div>
      </section>

      

      {/* NEW RELEASES */}
      <section className="books-section">
        <h2>New Releases</h2>

        {nrLoading && <p className="loading-text">Loading books…</p>}

        {!nrLoading && newReleases.length > 0 && (
          <div className="books-grid">
            {newReleases.map((book) => (
              <BookCard key={book.book_id} book={book} />
            ))}
          </div>
        )}

        {!nrLoading && nrTotalPages > 1 && (
          <Pagination
            currentPage={nrPage}
            totalPages={nrTotalPages}
            onPageChange={loadNewReleases}
          />
        )}
      </section>

      {/* FOOTER */}
      <footer>
        <div className="footer-column">
          <h3>Books</h3>
          <p>Books Delivered. Imagination Unlimited.</p>
        </div>
        <div className="footer-column">
          <h3>Quick Links</h3>
          <p>Home</p>
          <p>About Us</p>
          <p>Contact</p>
        </div>
        <div className="footer-column">
          <h3>Contact</h3>
          <p>Email: Jabulane@bookworm.com</p>
          <p>Phone: +27 75 138 7319</p>
          <p>South Africa</p>
        </div>
        <div className="footer-column">
          <h3>We Accept</h3>
          <div className="payment-icons">
            <strong className="visa">VISA</strong>
            <svg
              className="mastercard"
              width="38"
              height="24"
              viewBox="0 0 38 24"
              xmlns="http://www.w3.org/2000/svg"
              role="img"
              aria-label="Mastercard"
            >
              <rect width="38" height="24" rx="4" fill="#fff" />
              <circle cx="15" cy="12" r="7" fill="#EB001B" />
              <circle cx="23" cy="12" r="7" fill="#F79E1B" />
              <path d="M19 6.5a7 7 0 0 0 0 11a7 7 0 0 0 0-11z" fill="#FF5F00" />
            </svg>
          </div>
        </div>
        <div className="footer-bottom">
          © 2026 Books. All rights reserved. | Designed by Book Worm Team
        </div>
      </footer>

      <NavDrawer open={drawerOpen} onClose={() => setDrawerOpen(false)} />
    </div>
  );
}

/* ============================================================
   PAGINATION
   ============================================================ */

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
      <button
        className="page-arrow"
        onClick={() => onPageChange(currentPage - 1)}
        disabled={currentPage === 1}
        aria-label="Previous page"
      >
        <ChevronLeft size={18} />
      </button>

      <div className="page-dots">
        {pages.map((p) => (
          <button
            key={p}
            className={`page-dot ${p === currentPage ? "active" : ""}`}
            onClick={() => onPageChange(p)}
            aria-label={`Go to page ${p}`}
          />
        ))}
      </div>

      <button
        className="page-arrow"
        onClick={() => onPageChange(currentPage + 1)}
        disabled={currentPage === totalPages}
        aria-label="Next page"
      >
        <ChevronRight size={18} />
      </button>
    </div>
  );
}

/* ============================================================
   BOOK CARD
   ============================================================ */

function BookCard({ book }) {
  const navigate = useNavigate();
  const { isAuthenticated, isCustomer } = useAuth();
  const [adding, setAdding] = useState(false);
  const [toast, setToast] = useState("");
  const [rating, setRating] = useState({ avg: 0, total: 0 });

  useEffect(() => {
    (async () => {
      try {
        const data = await reviewService.getBookReviews(book.book_id);
        setRating({
          avg: data.average_rating,
          total: data.total_reviews,
        });
      } catch {
        // ignore
      }
    })();
  }, [book.book_id]);

  const handleAddToCart = async () => {
    if (!isAuthenticated) {
      navigate("/login");
      return;
    }
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
    } finally {
      setAdding(false);
    }
  };

  const imageSrc = book.image_url || null;

  return (
    <div
      className="book-card clickable-card"
      onClick={() => navigate(`/books/${book.book_id}`)}
    >
      <div className="book-image">
        {imageSrc ? (
          <img
            src={
              imageSrc.startsWith("http")
                ? imageSrc
                : `${import.meta.env.VITE_API_URL}${imageSrc}`
            }
            alt={book.title}
          />
        ) : (
          <div className="book-cover">BOOK</div>
        )}

        <WishlistHeart bookId={book.book_id} />
      </div>

      <div className="book-price">R{Number(book.price).toFixed(2)}</div>

      <h3>{book.title}</h3>
      <p className="author">{book.author}</p>

      <p className="rating">
        {rating.total > 0 ? (
          <>
            <Star size={14} fill="#ffb400" stroke="#ffb400" />
            <strong>{rating.avg.toFixed(1)}</strong>
            <span className="rating-count">({rating.total})</span>
          </>
        ) : (
          <span className="no-rating">No reviews yet</span>
        )}
      </p>

      <p className="description">
        {book.description || "A wonderful book waiting to be discovered."}
      </p>

      <button
        onClick={(e) => {
          e.stopPropagation();
          handleAddToCart();
        }}
        disabled={adding}
      >
        {adding ? "Adding…" : " Add To Cart"}
      </button>

      {toast && <p className="cart-toast">{toast}</p>}
    </div>
  );
}

export default Home;