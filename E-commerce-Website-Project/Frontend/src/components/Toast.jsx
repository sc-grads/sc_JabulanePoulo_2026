import { useEffect } from "react";
import { CheckCircle, XCircle, X } from "lucide-react";
import "../styles/Toast.css";

function Toast({ open, type = "success", message, onClose, duration = 2500 }) {
  useEffect(() => {
    if (!open) return;
    const t = setTimeout(onClose, duration);
    return () => clearTimeout(t);
  }, [open, duration, onClose]);

  if (!open) return null;

  return (
    <div className={`toast toast-${type}`}>
      <div className="toast-icon">
        {type === "success" ? (
          <CheckCircle size={20} />
        ) : (
          <XCircle size={20} />
        )}
      </div>
      <p className="toast-msg">{message}</p>
      <button className="toast-close" onClick={onClose}>
        <X size={16} />
      </button>
    </div>
  );
}

export default Toast;