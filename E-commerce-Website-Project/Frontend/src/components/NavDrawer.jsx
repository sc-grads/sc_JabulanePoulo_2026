import { X } from "lucide-react";
import { useNavigate, Link } from "react-router-dom";
import { useAuth } from "../context/AuthContext";
import "../styles/NavDrawer.css";

function NavDrawer({ open, onClose }) {
  const navigate = useNavigate();
  const { user, isAuthenticated, isCustomer, isAdmin, logout } = useAuth();

  const handleNavigate = (path) => {
    onClose();
    navigate(path);
  };

  const handleLogout = () => {
    onClose();
    logout();
    navigate("/login");
  };

  return (
    <>
      {/* Dark overlay */}
      <div
        className={`drawer-overlay ${open ? "open" : ""}`}
        onClick={onClose}
      />

      {/* Drawer panel */}
      <aside className={`nav-drawer ${open ? "open" : ""}`}>
        <div className="drawer-header">
          <h2>Menu</h2>
          <button className="drawer-close" onClick={onClose} aria-label="Close menu">
            <X size={22} />
          </button>
        </div>

        {isAuthenticated && (
          <div className="drawer-user">
            <div className="drawer-avatar">
              {user?.name
                ? (user.name[0] + (user.surname?.[0] || "")).toUpperCase()
                : user?.email?.[0]?.toUpperCase()}
            </div>
            <div>
              <p className="drawer-user-name">
                {user?.name ? `${user.name} ${user.surname}` : user?.email}
              </p>
              <p className="drawer-user-role">{user?.role}</p>
            </div>
          </div>
        )}

        <nav className="drawer-nav">
          <p className="drawer-section-label">Shop</p>
          <p onClick={() => handleNavigate("/home")}>Home</p>
          <p onClick={() => handleNavigate("/books")}>All Books</p>

          {isCustomer && (
            <>
              <p className="drawer-section-label">My Account</p>
              <p onClick={() => handleNavigate("/profile")}>My Profile</p>
              <p onClick={() => handleNavigate("/cart")}>My Cart</p>
              <p onClick={() => handleNavigate("/orders")}>My Orders</p>
              <p onClick={() => handleNavigate("/wishlist")}>My Wishlist</p>  
              
            </>
          )}

          {isAdmin && (
            <>
              <p className="drawer-section-label">Admin</p>
              <p onClick={() => handleNavigate("/admin/dashboard")}>Dashboard</p>
              <p onClick={() => handleNavigate("/admin/categories")}>Categories</p>
              <p onClick={() => handleNavigate("/admin/orders")}>All Orders</p>
              <p onClick={() => handleNavigate("/admin/reviews")}>Reviews</p>
              <p onClick={() => handleNavigate("/admin/returns")}>Returns</p>
              <p onClick={() => handleNavigate("/admin/customers")}>Customers</p>
            </>
          )}

          
        </nav>

        <div className="drawer-footer">
          {isAuthenticated ? (
            <button className="drawer-logout" onClick={handleLogout}>
              Logout
            </button>
          ) : (
            <>
              <button
                className="drawer-login"
                onClick={() => handleNavigate("/login")}
              >
                Login
              </button>
              <button
                className="drawer-signup"
                onClick={() => handleNavigate("/signup")}
              >
                Sign Up
              </button>
            </>
          )}
        </div>
      </aside>
    </>
  );
}

export default NavDrawer;