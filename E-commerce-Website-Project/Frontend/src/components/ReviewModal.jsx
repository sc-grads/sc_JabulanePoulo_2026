import { useState } from "react";
import { Star, X } from "lucide-react";
import { reviewService } from "../services/reviewService";
import "../styles/ReviewModal.css";

function ReviewModal({ book, orderId, onClose, onSubmitted }) {
  const [rating, setRating] = useState(0);
  const [hoverRating, setHoverRating] = useState(0);
  const [comment, setComment] = useState("");
  const [submitting, setSubmitting] = useState(false);
  const [error, setError] = useState("");

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (rating < 1) {
      setError("Please choose a star rating");
      return;
    }

    setSubmitting(true);
    setError("");

    try {
      await reviewService.createReview({
        book_id: book.book_id,
        order_id: orderId,
        rating,
        comment: comment.trim(),
      });

      // Tell parent to show a toast (no browser alert)
      onSubmitted();
      onClose();
    } catch (err) {
      setError(err.message);
      setSubmitting(false);
    }
  };

  return (
    <div className="review-overlay" onClick={onClose}>
      <div className="review-modal" onClick={(e) => e.stopPropagation()}>
        <div className="review-header">
          <h2>Review "{book.title}"</h2>
          <button className="review-close" onClick={onClose}>
            <X size={20} />
          </button>
        </div>

        <form onSubmit={handleSubmit} className="review-form">
          <div className="rating-stars">
            {[1, 2, 3, 4, 5].map((star) => (
              <button
                key={star}
                type="button"
                className="star-btn"
                onMouseEnter={() => setHoverRating(star)}
                onMouseLeave={() => setHoverRating(0)}
                onClick={() => setRating(star)}
              >
                <Star
                  size={32}
                  fill={(hoverRating || rating) >= star ? "#ffb400" : "none"}
                  stroke="#ffb400"
                  strokeWidth={2}
                />
              </button>
            ))}
            {rating > 0 && <span className="rating-label">{rating} / 5</span>}
          </div>

          <textarea
            placeholder="Share your thoughts about this book… (optional)"
            value={comment}
            onChange={(e) => setComment(e.target.value)}
            maxLength={500}
            rows={4}
          />

          {error && <p className="form-error">{error}</p>}

          <div className="review-actions">
            <button
              type="button"
              className="cancel-btn"
              onClick={onClose}
              disabled={submitting}
            >
              Cancel
            </button>
            <button
              type="submit"
              className="submit-btn"
              disabled={submitting || rating < 1}
            >
              {submitting ? "Submitting…" : "Submit Review"}
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}

export default ReviewModal;