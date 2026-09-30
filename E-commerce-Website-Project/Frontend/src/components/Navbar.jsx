import { useEffect, useState } from "react";
import { useNavigate, useLocation } from "react-router-dom";
import { Heart, ShoppingCart, Menu, LogOut } from "lucide-react";
import { useAuth } from "../context/AuthContext";
import { cartService } from "../services/cartService";
import { wishlistService } from "../services/wishlistService";
import "../styles/Navbar.css";

function Navbar({ onOpenDrawer }) {
  const navigate = useNavigate();
  const location = useLocation();
  const { user, isAuthenticated, isCustomer, isAdmin, logout } = useAuth();

  const [cartCount, setCartCount] = useState(0);
  const [wishlistCount, setWishlistCount] = useState(0);

  // Load counts + listen for updates
  useEffect(() => {
    if (!isCustomer) {
      setCartCount(0);
      setWishlistCount(0);
      return;
    }

    const loadCart = async () => {
      try {
        const data = await cartService.getCart();
        const total = (data.items || []).reduce(
          (sum, i) => sum + i.quantity,
          0
        );
        setCartCount(total);
      } catch {}
    };

    const loadWishlist = async () => {
      try {
        const data = await wishlistService.getWishlistIds();
        setWishlistCount((data.book_ids || []).length);
      } catch {}
    };

    loadCart();
    loadWishlist();

    const cartHandler = () => loadCart();
    const wishHandler = () => loadWishlist();

    window.addEventListener("cart-updated", cartHandler);
    window.addEventListener("wishlist-updated", wishHandler);

    return () => {
      window.removeEventListener("cart-updated", cartHandler);
      window.removeEventListener("wishlist-updated", wishHandler);
    };
  }, [isCustomer]);

  const getInitials = () => {
    if (!user) return "?";
    if (user.name && user.surname) {
      return (user.name[0] + user.surname[0]).toUpperCase();
    }
    return user.email ? user.email[0].toUpperCase() : "U";
  };

  const handleLogout = () => {
    logout();
    window.location.href = "/login";
  };

  const isActive = (path) =>
    location.pathname === path || location.pathname.startsWith(path + "/");

  return (
    <nav className="global-navbar">
      <h2 className="global-logo" onClick={() => navigate("/home")}>
        Book Worm
        {isAdmin && <span className="admin-tag">Admin</span>}
      </h2>

      {/* CENTER LINKS */}
      <div className="global-nav-links">
        <button
          className={isActive("/home") ? "nav-link active" : "nav-link"}
          onClick={() => navigate("/home")}
        >
          Home
        </button>

        <button
          className={isActive("/books") ? "nav-link active" : "nav-link"}
          onClick={() => navigate("/books")}
        >
          Books
        </button>

        {isCustomer && (
          <>
            <button
              className={isActive("/orders") ? "nav-link active" : "nav-link"}
              onClick={() => navigate("/orders")}
            >
              Orders
            </button>

            <button
              className={isActive("/wishlist") ? "nav-link active" : "nav-link"}
              onClick={() => navigate("/wishlist")}
            >
              Wishlist
            </button>
          </>
        )}

        {isAdmin && (
          <>
            <button
              className={
                isActive("/admin/dashboard") ? "nav-link active" : "nav-link"
              }
              onClick={() => navigate("/admin/dashboard")}
            >
              Dashboard
            </button>

            <button
              className={
                isActive("/admin/orders") ? "nav-link active" : "nav-link"
              }
              onClick={() => navigate("/admin/orders")}
            >
              Orders
            </button>

            <button
              className={
                isActive("/admin/returns") ? "nav-link active" : "nav-link"
              }
              onClick={() => navigate("/admin/returns")}
            >
              Returns
            </button>
          </>
        )}
      </div>

      {/* RIGHT ACTIONS */}
      <div className="global-nav-actions">
        {isCustomer && (
          <>
            <button
              className="nav-icon-btn"
              onClick={() => navigate("/wishlist")}
              title="Wishlist"
            >
              <Heart size={20} />
              {wishlistCount > 0 && (
                <span className="nav-badge">{wishlistCount}</span>
              )}
            </button>

            <button
              className="nav-icon-btn"
              onClick={() => navigate("/cart")}
              title="Cart"
            >
              <ShoppingCart size={20} />
              {cartCount > 0 && (
                <span className="nav-badge">{cartCount}</span>
              )}
            </button>
          </>
        )}

        {isAuthenticated ? (
          <>
            <button
              className="nav-avatar"
              onClick={() => navigate("/profile")}
              title="Profile"
            >
              {getInitials()}
            </button>

            {/* LOGOUT BUTTON */}
            <button
              className="nav-logout-btn"
              onClick={handleLogout}
              title="Logout"
            >
              <LogOut size={16} />
              <span>Logout</span>
            </button>
          </>
        ) : (
          <>
            <button
              className="nav-login-btn"
              onClick={() => navigate("/login")}
            >
              Login
            </button>
            <button
              className="nav-signup-btn"
              onClick={() => navigate("/signup")}
            >
              Sign Up
            </button>
          </>
        )}

        {/* HAMBURGER (opens drawer) */}
        <button
          className="nav-hamburger"
          onClick={onOpenDrawer}
          aria-label="Open menu"
        >
          <Menu size={22} />
        </button>
      </div>
    </nav>
  );
}

export default Navbar;