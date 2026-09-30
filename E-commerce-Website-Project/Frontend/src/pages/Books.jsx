import { useEffect, useState } from "react";
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
import "../styles/Books.css";

const PER_PAGE = 5;

function Books() {
  const navigate = useNavigate();
  const { isAuthenticated, isCustomer } = useAuth();

  const [books, setBooks] = useState([]);
  const [categories, setCategories] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");
  const [drawerOpen, setDrawerOpen] = useState(false);

  const [search, setSearch] = useState("");
  const [categoryId, setCategoryId] = useState("");
  const [sort, setSort] = useState("newest");
  const [minPrice, setMinPrice] = useState("");
  const [maxPrice, setMaxPrice] = useState("");

  const [page, setPage] = useState(1);
  const [totalPages, setTotalPages] = useState(1);
  const [totalBooks, setTotalBooks] = useState(0);

  const loadBooks = async (targetPage = 1) => {
    try {
      setLoading(true);
      setError("");
      const params = { page: targetPage, per_page: PER_PAGE };
      if (search) params.search = search;
      if (categoryId) params.category_id = categoryId;
      if (minPrice) params.min_price = minPrice;
      if (maxPrice) params.max_price = maxPrice;
      if (sort) params.sort = sort;

      const data = await bookService.getBooks(params);
      setBooks(data.books || []);
      setTotalPages(data.pagination?.total_pages || 1);
      setTotalBooks(data.pagination?.total_books || 0);
      setPage(targetPage);
      window.scrollTo({ top: 0, behavior: "smooth" });
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    (async () => {
      try {
        const cats = await bookService.getCategories();
        setCategories(cats.categories || []);
      } catch (err) {
        console.warn("Categories fetch failed:", err.message);
      }
    })();
  }, []);

  useEffect(() => {
    loadBooks(1);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  const handleFilter = (e) => {
    e.preventDefault();
    loadBooks(1);
  };

  const handleReset = () => {
    setSearch("");
    setCategoryId("");
    setSort("newest");
    setMinPrice("");
    setMaxPrice("");
    setTimeout(() => loadBooks(1), 0);
  };

  return (
    <div className="books-page">
      <Navbar onOpenDrawer={() => setDrawerOpen(true)} />

      <div className="books-page-content">
        <h1>Explore Books</h1>
        <p className="subtitle">
          {totalBooks > 0
            ? `${totalBooks} book${totalBooks === 1 ? "" : "s"} available`
            : "Find your next favourite read"}
        </p>

        <form className="filter-bar" onSubmit={handleFilter}>
          <input
            type="text"
            placeholder="Search by title or author…"
            value={search}
            onChange={(e) => setSearch(e.target.value)}
          />
          <select value={categoryId} onChange={(e) => setCategoryId(e.target.value)}>
            <option value="">All categories</option>
            {categories.map((c) => (
              <option key={c.category_id} value={c.category_id}>{c.name}</option>
            ))}
          </select>
          <select value={sort} onChange={(e) => setSort(e.target.value)}>
          
            <option value="newest">Newest</option>
            <option value="price_asc">Price: Low to High</option>
            <option value="price_desc">Price: High to Low</option>
            <option value="title_asc">Title: A to Z</option>
            <option value="title_desc">Title: Z to A</option>
          </select>
          <input
            type="number"
            placeholder="Min R"
            value={minPrice}
            onChange={(e) => setMinPrice(e.target.value)}
          />
          <input
            type="number"
            placeholder="Max R"
            value={maxPrice}
            onChange={(e) => setMaxPrice(e.target.value)}
          />
          <button type="submit">Apply</button>
          <button type="button" className="reset" onClick={handleReset}>Reset</button>
        </form>

        {loading && <p className="loading-text">Loading books…</p>}
        {error && <p className="form-error">{error}</p>}

        {!loading && !error && books.length === 0 && (
          <p className="no-results">No books match your filters.</p>
        )}

        {!loading && !error && books.length > 0 && (
          <div className="books-grid">
            {books.map((book) => (
              <BookGridCard
                key={book.book_id}
                book={book}
                isAuthenticated={isAuthenticated}
                isCustomer={isCustomer}
                navigate={navigate}
              />
            ))}
          </div>
        )}

        {!loading && !error && totalPages > 1 && (
          <Pagination
            currentPage={page}
            totalPages={totalPages}
            onPageChange={loadBooks}
          />
        )}
      </div>

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
          <button
            key={p}
            className={`page-dot ${p === currentPage ? "active" : ""}`}
            onClick={() => onPageChange(p)}
          />
        ))}
      </div>
      <button className="page-arrow" onClick={() => onPageChange(currentPage + 1)} disabled={currentPage === totalPages}>
        <ChevronRight size={18} />
      </button>
    </div>
  );
}

function BookGridCard({ book, isAuthenticated, isCustomer, navigate }) {
  const [adding, setAdding] = useState(false);
  const [toast, setToast] = useState("");
  const [rating, setRating] = useState({ avg: 0, total: 0 });

  useEffect(() => {
    (async () => {
      try {
        const data = await reviewService.getBookReviews(book.book_id);
        setRating({ avg: data.average_rating, total: data.total_reviews });
      } catch {}
    })();
  }, [book.book_id]);

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
    } finally {
      setAdding(false);
    }
  };

  return (
    <div className="book-card clickable-card" onClick={() => navigate(`/books/${book.book_id}`)}>
      <div className="book-image">
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

      <p className="description">{book.description || "A wonderful book waiting to be discovered."}</p>

      <button
        onClick={(e) => { e.stopPropagation(); handleAddToCart(); }}
        disabled={adding}
      >
        {adding ? "Adding…" : " Add To Cart"}
      </button>

      {toast && <p className="cart-toast">{toast}</p>}
    </div>
  );
}

export default Books;