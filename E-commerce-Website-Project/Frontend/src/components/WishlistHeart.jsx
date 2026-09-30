import { useEffect, useState } from "react";
import { Heart } from "lucide-react";
import { useNavigate } from "react-router-dom";
import { useAuth } from "../context/AuthContext";
import { wishlistService } from "../services/wishlistService";
import "../styles/WishlistHeart.css";

function WishlistHeart({ bookId, className = "" }) {
  const navigate = useNavigate();
  const { isAuthenticated, isCustomer } = useAuth();

  const [saved, setSaved] = useState(false);
  const [loading, setLoading] = useState(false);
  const [ready, setReady] = useState(false);

  useEffect(() => {
    if (!isCustomer) {
      setReady(true);
      return;
    }

    let cancelled = false;

    (async () => {
      try {
        const data = await wishlistService.getWishlistIds();
        if (!cancelled) {
          setSaved((data.book_ids || []).includes(bookId));
        }
      } catch (err) {
        // ignore
      } finally {
        if (!cancelled) setReady(true);
      }
    })();

    return () => {
      cancelled = true;
    };
  }, [bookId, isCustomer]);

  const handleClick = async (e) => {
    e.preventDefault();
    e.stopPropagation();

    if (!isAuthenticated) {
      navigate("/login");
      return;
    }
    if (!isCustomer) return;

    setLoading(true);
    try {
      if (saved) {
        await wishlistService.removeFromWishlist(bookId);
        setSaved(false);
        window.dispatchEvent(new Event("wishlist-updated"));
      } else {
        await wishlistService.addToWishlist(bookId);
        setSaved(true);
        window.dispatchEvent(new Event("wishlist-updated"));
      }
    } catch (err) {
      console.warn(err.message);
    } finally {
      setLoading(false);
    }
  };

  return (
    <button
      type="button"
      className={`wishlist-heart ${saved ? "saved" : ""} ${className}`}
      onClick={handleClick}
      disabled={loading || !ready}
      title={saved ? "Remove from wishlist" : "Add to wishlist"}
    >
      <Heart
        size={22}
        fill={saved ? "#eb001b" : "none"}
        stroke={saved ? "#eb001b" : "currentColor"}
        strokeWidth={2.2}
      />
    </button>
  );
}

export default WishlistHeart;