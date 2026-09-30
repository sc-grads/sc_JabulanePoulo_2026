import { AlertTriangle, X } from "lucide-react";
import "../styles/ConfirmModal.css";

function ConfirmModal({
  open,
  title = "Are you sure?",
  message = "",
  confirmText = "Confirm",
  cancelText = "Cancel",
  variant = "danger",
  onConfirm,
  onCancel,
  processing = false,
}) {
  if (!open) return null;

  return (
    <div className="confirm2-overlay" onClick={onCancel}>
      <div className="confirm2-modal" onClick={(e) => e.stopPropagation()}>
        <button className="confirm2-close" onClick={onCancel}>
          <X size={18} />
        </button>

        <div className={`confirm2-icon ${variant}`}>
          <AlertTriangle size={28} />
        </div>

        <h2 className="confirm2-title">{title}</h2>
        {message && <p className="confirm2-message">{message}</p>}

        <div className="confirm2-actions">
          <button
            className="confirm2-cancel"
            onClick={onCancel}
            disabled={processing}
          >
            {cancelText}
          </button>
          <button
            className={`confirm2-confirm ${variant}`}
            onClick={onConfirm}
            disabled={processing}
          >
            {processing ? "Working…" : confirmText}
          </button>
        </div>
      </div>
    </div>
  );
}

export default ConfirmModal;