import { useState } from "react";
import { X, RotateCcw } from "lucide-react";
import { returnService } from "../services/returnService";
import "../styles/ReturnModal.css";

function ReturnModal({ order, onClose, onSubmitted }) {
  const [reason, setReason] = useState("");
  const [submitting, setSubmitting] = useState(false);
  const [error, setError] = useState("");

  const handleSubmit = async (e) => {
    e.preventDefault();

    if (reason.trim().length < 10) {
      setError("Please describe why you're returning (10+ characters).");
      return;
    }

    setSubmitting(true);
    setError("");

    try {
      await returnService.requestReturn({
        order_id: order.order_id,
        reason: reason.trim(),
      });

      onSubmitted();
      onClose();
    } catch (err) {
      setError(err.message);
      setSubmitting(false);
    }
  };

  return (
    <div className="return-overlay" onClick={onClose}>
      <div className="return-modal" onClick={(e) => e.stopPropagation()}>
        <div className="return-header">
          <div className="return-icon">
            <RotateCcw size={20} />
          </div>
          <h2>Request a Return</h2>
          <button className="return-close" onClick={onClose}>
            <X size={20} />
          </button>
        </div>

        <p className="return-subtitle">
          Order <strong>#{order.order_id}</strong> — R
          {Number(order.total_amount).toFixed(2)}
        </p>

        <form onSubmit={handleSubmit} className="return-form">
          <label>Why are you returning this order?</label>
          <textarea
            value={reason}
            onChange={(e) => setReason(e.target.value)}
            placeholder="e.g. The book arrived damaged, or the wrong title was delivered…"
            rows={4}
            maxLength={500}
            disabled={submitting}
          />

          {error && <p className="form-error">{error}</p>}

          <div className="return-actions">
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
              disabled={submitting}
            >
              {submitting ? "Submitting…" : "Submit Return"}
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}

export default ReturnModal;