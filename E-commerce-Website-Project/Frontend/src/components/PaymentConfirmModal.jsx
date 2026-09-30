import { useState } from "react";
import { X, MapPin, Phone, AlertCircle, Truck, Store, User } from "lucide-react";
import { useNavigate } from "react-router-dom";
import "../styles/PaymentConfirmModal.css";

const DELIVERY_FEE = 70;

function PaymentConfirmModal({
  open,
  info,
  subtotal,
  onConfirm,
  onCancel,
  processing,
}) {
  const navigate = useNavigate();
  const [method, setMethod] = useState("delivery");

  if (!open) return null;

  const hasPhone = !!info?.phone_num && info.phone_num.trim() !== "";
  const hasAddress =
    !!(info?.street && info.street.trim() !== "") ||
    !!(info?.city && info.city.trim() !== "") ||
    !!(info?.province && info.province.trim() !== "") ||
    !!(info?.country && info.country.trim() !== "");

  const needsInfo = !hasPhone || !hasAddress;

  const fee = method === "delivery" ? DELIVERY_FEE : 0;
  const total = (subtotal || 0) + fee;

  return (
    <div className="confirm-overlay" onClick={onCancel}>
      <div className="confirm-modal" onClick={(e) => e.stopPropagation()}>
        <div className="confirm-header">
          <h2>Confirm your order</h2>
          <button className="confirm-close" onClick={onCancel}>
            <X size={20} />
          </button>
        </div>

        <p className="confirm-subtitle">
          Choose how you'd like to receive your books.
        </p>

        {/* DELIVERY METHOD CHOOSER */}
        <div className="delivery-method-tabs">
          <button
            type="button"
            className={`method-tab ${method === "delivery" ? "active" : ""}`}
            onClick={() => setMethod("delivery")}
            disabled={processing}
          >
            <Truck size={18} />
            <div>
              <strong>Delivery</strong>
              <span>R{DELIVERY_FEE.toFixed(2)} fee</span>
            </div>
          </button>

          <button
            type="button"
            className={`method-tab ${method === "pickup" ? "active" : ""}`}
            onClick={() => setMethod("pickup")}
            disabled={processing}
          >
            <Store size={18} />
            <div>
              <strong>Pickup</strong>
              <span>Free</span>
            </div>
          </button>
        </div>

        {/* DELIVERY DETAILS */}
        {method === "delivery" && (
          <>
            <div className="confirm-section">
              <div className="confirm-icon">
                <Phone size={18} />
              </div>
              <div>
                <p className="confirm-label">Phone Number</p>
                <p className="confirm-value">
                  {hasPhone ? (
                    info.phone_num
                  ) : (
                    <span className="missing">Not provided</span>
                  )}
                </p>
              </div>
            </div>

            <div className="confirm-section">
              <div className="confirm-icon">
                <MapPin size={18} />
              </div>
              <div>
                <p className="confirm-label">Delivery Address</p>
                {hasAddress ? (
                  <p className="confirm-value">
                    {info.street && <>{info.street}<br /></>}
                    {[info.city, info.province, info.postal_code]
                      .filter(Boolean)
                      .join(", ")}
                    {info.country && <><br />{info.country}</>}
                  </p>
                ) : (
                  <p className="confirm-value missing">Not provided</p>
                )}
              </div>
            </div>

            {/* WARNING + UPDATE BUTTON */}
            {needsInfo && (
              <div className="confirm-warning">
                <AlertCircle size={18} />
                <div className="warning-content">
                  <p>
                    Your delivery details are incomplete. Please update your
                    profile before paying.
                  </p>
                  <button
                    type="button"
                    className="update-profile-btn"
                    onClick={() => navigate("/profile")}
                  >
                    <User size={14} /> Update My Profile
                  </button>
                </div>
              </div>
            )}
          </>
        )}

        {/* PICKUP DETAILS */}
        {method === "pickup" && (
          <div className="confirm-section">
            <div className="confirm-icon">
              <Store size={18} />
            </div>
            <div>
              <p className="confirm-label">Pickup from</p>
              <p className="confirm-value">
                Book Worm Store<br />
                123 Main Street<br />
                Johannesburg, 2001
              </p>
            </div>
          </div>
        )}

        {/* SUMMARY */}
        <div className="confirm-summary">
          <div className="summary-row">
            <span>Subtotal</span>
            <span>R{(subtotal || 0).toFixed(2)}</span>
          </div>
          <div className="summary-row">
            <span>{method === "delivery" ? "Delivery fee" : "Pickup"}</span>
            <span>{fee === 0 ? "Free" : `R${fee.toFixed(2)}`}</span>
          </div>
          <div className="summary-row total">
            <span>Total</span>
            <strong>R{total.toFixed(2)}</strong>
          </div>
        </div>

        <div className="confirm-actions">
          <button
            className="cancel-btn"
            onClick={onCancel}
            disabled={processing}
          >
            Cancel
          </button>
          <button
            className="confirm-btn"
            onClick={() => onConfirm(method)}
            disabled={processing || (method === "delivery" && needsInfo)}
            title={
              method === "delivery" && needsInfo
                ? "Please update your profile first"
                : ""
            }
          >
            {processing ? "Processing…" : "Confirm & Pay"}
          </button>
        </div>
      </div>
    </div>
  );
}

export default PaymentConfirmModal;