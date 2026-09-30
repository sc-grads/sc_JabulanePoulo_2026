import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import { Menu, AlertTriangle } from "lucide-react";
import { useAuth } from "../context/AuthContext";
import { authService } from "../services/authService";
import NavDrawer from "../components/NavDrawer";
import Toast from "../components/Toast";
import "../styles/Home.css";
import "../styles/Profile.css";

function Profile() {
  const navigate = useNavigate();
  const {
    user,
    isAuthenticated,
    isCustomer,
    isAdmin,
    logout,
    updateUser,
  } = useAuth();

  const [profile, setProfile] = useState(user);

  const [accountForm, setAccountForm] = useState({
    name: "",
    surname: "",
    email: "",
  });
  const [editingAccount, setEditingAccount] = useState(false);
  const [savingAccount, setSavingAccount] = useState(false);
  const [accountError, setAccountError] = useState("");
  const [accountSuccess, setAccountSuccess] = useState("");

  const [info, setInfo] = useState({
    phone_num: "",
    street: "",
    city: "",
    province: "",
    postal_code: "",
    country: "",
    is_default: true,
  });
  const [editingInfo, setEditingInfo] = useState(false);
  const [savingInfo, setSavingInfo] = useState(false);
  const [infoError, setInfoError] = useState("");
  const [infoSuccess, setInfoSuccess] = useState("");

  const [loading, setLoading] = useState(true);
  const [drawerOpen, setDrawerOpen] = useState(false);

  // Delete-account flow
  const [showDeleteModal, setShowDeleteModal] = useState(false);
  const [confirmText, setConfirmText] = useState("");
  const [deleting, setDeleting] = useState(false);

  const [toast, setToast] = useState({
    open: false,
    type: "success",
    message: "",
  });

  const showToast = (message, type = "success") =>
    setToast({ open: true, type, message });

  const hideToast = () => setToast((t) => ({ ...t, open: false }));

  useEffect(() => {
    if (!isAuthenticated) {
      navigate("/login");
      return;
    }

    (async () => {
      try {
        const me = await authService.getMe();
        setProfile(me);
        setAccountForm({
          name: me.name || "",
          surname: me.surname || "",
          email: me.email || "",
        });

        if (me.role === "customer") {
          try {
            const data = await authService.getInformation();
            setInfo({
              phone_num: data.phone_num || "",
              street: data.street || "",
              city: data.city || "",
              province: data.province || "",
              postal_code: data.postal_code || "",
              country: data.country || "",
              is_default: data.is_default ?? true,
            });
          } catch (err) {
            console.warn("Information fetch failed:", err.message);
          }
        }
      } catch (err) {
        setInfoError(err.message);
      } finally {
        setLoading(false);
      }
    })();
  }, [isAuthenticated, navigate]);

  const handleAccountChange = (e) => {
    setAccountForm({ ...accountForm, [e.target.name]: e.target.value });
    setAccountError("");
    setAccountSuccess("");
  };

  const handleAccountSave = async (e) => {
    e.preventDefault();
    setSavingAccount(true);
    setAccountError("");
    setAccountSuccess("");

    try {
      const res = await authService.updateMe(accountForm);
      setProfile(res.user);
      localStorage.setItem("user", JSON.stringify(res.user));
      if (typeof updateUser === "function") updateUser(res.user);

      setAccountSuccess("Account updated successfully ✓");
      setEditingAccount(false);
      setTimeout(() => setAccountSuccess(""), 2500);
    } catch (err) {
      setAccountError(err.message);
    } finally {
      setSavingAccount(false);
    }
  };

  const handleInfoChange = (e) => {
    const { name, value, type, checked } = e.target;
    setInfo({
      ...info,
      [name]: type === "checkbox" ? checked : value,
    });
    setInfoError("");
    setInfoSuccess("");
  };

  const handleInfoSave = async (e) => {
    e.preventDefault();
    setSavingInfo(true);
    setInfoError("");
    setInfoSuccess("");

    try {
      await authService.saveInformation(info);
      setInfoSuccess("Information saved successfully ");
      setEditingInfo(false);
      setTimeout(() => setInfoSuccess(""), 2500);
    } catch (err) {
      setInfoError(err.message);
    } finally {
      setSavingInfo(false);
    }
  };

  const openDeleteModal = () => {
    setConfirmText("");
    setShowDeleteModal(true);
  };

  const handleDeleteAccount = async () => {
    // Require the user to type their exact email
    if (confirmText.trim().toLowerCase() !== profile.email.toLowerCase()) {
      showToast("Please type your email exactly to confirm", "error");
      return;
    }

    setDeleting(true);

    try {
      await authService.deleteMyAccount();

      // Clear session and redirect
      logout();
      navigate("/signup");
    } catch (err) {
      showToast(err.message, "error");
      setDeleting(false);
    }
  };

  const handleLogout = () => {
    logout();
    navigate("/login");
  };

  const getInitials = () => {
    if (!profile) return "?";
    if (profile.name && profile.surname) {
      return (profile.name[0] + profile.surname[0]).toUpperCase();
    }
    return profile.email ? profile.email[0].toUpperCase() : "U";
  };

  if (loading) {
    return (
      <div className="profile-page">
        <p className="loading-text">Loading profile…</p>
      </div>
    );
  }

  return (
    <div className="profile-page">
      <nav className="navbar">
        <h2 className="logo" onClick={() => navigate("/home")}>
          Book Worm
        </h2>
        <div className="nav-actions">
          <button
            className="back-btn"
            onClick={() => navigate(isAdmin ? "/admin/dashboard" : "/home")}
          >
             Back
          </button>
          <button
            className="hamburger-btn"
            onClick={() => setDrawerOpen(true)}
            aria-label="Open menu"
          >
            <Menu size={22} />
          </button>
        </div>
      </nav>

      <div className="profile-content">
        <div className="profile-header">
          <div className="profile-avatar-large">{getInitials()}</div>
          <div>
            <h1>
              {profile.name} {profile.surname}
            </h1>
            <p className="profile-email">{profile.email}</p>
            <span className={`role-badge role-${profile.role}`}>
              {profile.role}
            </span>
          </div>
        </div>

        {/* ACCOUNT DETAILS */}
        <div className="profile-card">
          <div className="card-header-row">
            <h2>Account Details</h2>
            {!editingAccount && (
              <button
                className="edit-info-btn"
                onClick={() => {
                  setEditingAccount(true);
                  setAccountForm({
                    name: profile.name || "",
                    surname: profile.surname || "",
                    email: profile.email || "",
                  });
                }}
              >
                ✎ Edit
              </button>
            )}
          </div>

          {accountError && <p className="form-error">{accountError}</p>}
          {accountSuccess && <p className="form-success">{accountSuccess}</p>}

          {editingAccount ? (
            <form className="info-form" onSubmit={handleAccountSave}>
              <div className="form-row-2col">
                <div className="form-group">
                  <label>First Name</label>
                  <input
                    type="text"
                    name="name"
                    value={accountForm.name}
                    onChange={handleAccountChange}
                    required
                  />
                </div>
                <div className="form-group">
                  <label>Last Name</label>
                  <input
                    type="text"
                    name="surname"
                    value={accountForm.surname}
                    onChange={handleAccountChange}
                    required
                  />
                </div>
              </div>

              <div className="form-group">
                <label>Email</label>
                <input
                  type="email"
                  name="email"
                  value={accountForm.email}
                  onChange={handleAccountChange}
                  required
                />
              </div>

              <div className="form-actions">
                <button type="submit" disabled={savingAccount}>
                  {savingAccount ? "Saving…" : "Save Changes"}
                </button>
                <button
                  type="button"
                  className="cancel-btn"
                  onClick={() => setEditingAccount(false)}
                >
                  Cancel
                </button>
              </div>
            </form>
          ) : (
            <>
              <div className="profile-row">
                <span className="label">User ID</span>
                <span className="value">{profile.user_id}</span>
              </div>
              <div className="profile-row">
                <span className="label">First Name</span>
                <span className="value">{profile.name}</span>
              </div>
              <div className="profile-row">
                <span className="label">Last Name</span>
                <span className="value">{profile.surname}</span>
              </div>
              <div className="profile-row">
                <span className="label">Email</span>
                <span className="value">{profile.email}</span>
              </div>
              
            </>
          )}
        </div>

        {/* CHANGE PASSWORD */}
        <div className="profile-card">
          <div className="card-header-row">
            <h2>Change Password</h2>
          </div>
          <ChangePasswordForm />
        </div>

        {/* MY INFORMATION */}
        {isCustomer && (
          <div className="profile-card">
            <div className="card-header-row">
              <h2>My Information</h2>
              {!editingInfo && (
                <button
                  className="edit-info-btn"
                  onClick={() => setEditingInfo(true)}
                >
                  ✎ Edit
                </button>
              )}
            </div>

            {infoError && <p className="form-error">{infoError}</p>}
            {infoSuccess && <p className="form-success">{infoSuccess}</p>}

            {editingInfo ? (
              <form className="info-form" onSubmit={handleInfoSave}>
                <div className="form-row-2col">
                  <div className="form-group">
                    <label>Phone Number</label>
                    <input
                      type="text"
                      name="phone_num"
                      value={info.phone_num}
                      onChange={handleInfoChange}
                    />
                  </div>
                  <div className="form-group">
                    <label>Street</label>
                    <input
                      type="text"
                      name="street"
                      value={info.street}
                      onChange={handleInfoChange}
                    />
                  </div>
                </div>

                <div className="form-row-2col">
                  <div className="form-group">
                    <label>City</label>
                    <input
                      type="text"
                      name="city"
                      value={info.city}
                      onChange={handleInfoChange}
                    />
                  </div>
                  <div className="form-group">
                    <label>Province</label>
                    <input
                      type="text"
                      name="province"
                      value={info.province}
                      onChange={handleInfoChange}
                    />
                  </div>
                </div>

                <div className="form-row-2col">
                  <div className="form-group">
                    <label>Postal Code</label>
                    <input
                      type="text"
                      name="postal_code"
                      value={info.postal_code}
                      onChange={handleInfoChange}
                    />
                  </div>
                  <div className="form-group">
                    <label>Country</label>
                    <input
                      type="text"
                      name="country"
                      value={info.country}
                      onChange={handleInfoChange}
                    />
                  </div>
                </div>

                <label className="checkbox-row">
                  <input
                    type="checkbox"
                    name="is_default"
                    checked={info.is_default}
                    onChange={handleInfoChange}
                  />
                  <span>Set as default address</span>
                </label>

                <div className="form-actions">
                  <button type="submit" disabled={savingInfo}>
                    {savingInfo ? "Saving…" : "Save Information"}
                  </button>
                  <button
                    type="button"
                    className="cancel-btn"
                    onClick={() => setEditingInfo(false)}
                  >
                    Cancel
                  </button>
                </div>
              </form>
            ) : (
              <>
                <div className="profile-row">
                  <span className="label">Phone Number</span>
                  <span className="value">{info.phone_num || "—"}</span>
                </div>
                <div className="profile-row">
                  <span className="label">Street</span>
                  <span className="value">{info.street || "—"}</span>
                </div>
                <div className="profile-row">
                  <span className="label">City</span>
                  <span className="value">{info.city || "—"}</span>
                </div>
                <div className="profile-row">
                  <span className="label">Province</span>
                  <span className="value">{info.province || "—"}</span>
                </div>
                <div className="profile-row">
                  <span className="label">Postal Code</span>
                  <span className="value">{info.postal_code || "—"}</span>
                </div>
                <div className="profile-row">
                  <span className="label">Country</span>
                  <span className="value">{info.country || "—"}</span>
                </div>
              </>
            )}
          </div>
        )}

        {/* DANGER ZONE — only for customers */}
        {isCustomer && (
          <div className="profile-card danger-zone">
            <div className="danger-header">
              <AlertTriangle size={20} />
              <h2>Danger Zone</h2>
            </div>
            <p className="danger-text">
              Deleting your account will permanently remove your profile,
              cart, wishlist, and reviews
            </p>
            <button className="delete-account-btn" onClick={openDeleteModal}>
              Delete My Account
            </button>
          </div>
        )}

        {/* QUICK ACTIONS */}
        
      </div>

      {/* DELETE ACCOUNT MODAL */}
      {showDeleteModal && (
        <div className="danger-overlay" onClick={() => !deleting && setShowDeleteModal(false)}>
          <div className="danger-modal" onClick={(e) => e.stopPropagation()}>
            <div className="danger-modal-icon">
              <AlertTriangle size={32} />
            </div>
            <h2>Delete your account?</h2>
            <p>
              This action <strong>cannot be undone</strong>. Type your email
              <strong> {profile.email} </strong>
              below to confirm.
            </p>

            <input
              type="text"
              placeholder="Type your email address"
              value={confirmText}
              onChange={(e) => setConfirmText(e.target.value)}
              disabled={deleting}
            />

            <div className="danger-modal-actions">
              <button
                className="cancel-btn"
                onClick={() => setShowDeleteModal(false)}
                disabled={deleting}
              >
                Cancel
              </button>
              <button
                className="confirm-delete-btn"
                onClick={handleDeleteAccount}
                disabled={
                  deleting ||
                  confirmText.trim().toLowerCase() !== profile.email.toLowerCase()
                }
              >
                {deleting ? "Deleting…" : "Permanently Delete"}
              </button>
            </div>
          </div>
        </div>
      )}

      <Toast
        open={toast.open}
        type={toast.type}
        message={toast.message}
        onClose={hideToast}
      />

      <NavDrawer open={drawerOpen} onClose={() => setDrawerOpen(false)} />
    </div>
  );
}

/* ============================================================
   CHANGE PASSWORD FORM
   ============================================================ */

function ChangePasswordForm() {
  const [form, setForm] = useState({
    current_password: "",
    new_password: "",
    confirm_password: "",
  });
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState("");
  const [success, setSuccess] = useState("");

  const handleChange = (e) => {
    setForm({ ...form, [e.target.name]: e.target.value });
    setError("");
    setSuccess("");
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError("");
    setSuccess("");

    if (form.new_password !== form.confirm_password) {
      setError("New passwords do not match");
      return;
    }

    if (form.new_password.length < 8) {
      setError("New password must be at least 8 characters");
      return;
    }

    if (form.new_password === form.current_password) {
      setError("New password must be different from current password");
      return;
    }

    setSaving(true);

    try {
      await authService.changePassword({
        current_password: form.current_password,
        new_password: form.new_password,
      });

      setSuccess("Password changed successfully ");
      setForm({
        current_password: "",
        new_password: "",
        confirm_password: "",
      });
      setTimeout(() => setSuccess(""), 3000);
    } catch (err) {
      setError(err.message);
    } finally {
      setSaving(false);
    }
  };

  return (
    <form className="info-form" onSubmit={handleSubmit}>
      <div className="form-group">
        <label>Current Password</label>
        <input
          type="password"
          name="current_password"
          value={form.current_password}
          onChange={handleChange}
          required
        />
      </div>

      <div className="form-row-2col">
        <div className="form-group">
          <label>New Password</label>
          <input
            type="password"
            name="new_password"
            value={form.new_password}
            onChange={handleChange}
            minLength={8}
            required
          />
        </div>
        <div className="form-group">
          <label>Confirm New Password</label>
          <input
            type="password"
            name="confirm_password"
            value={form.confirm_password}
            onChange={handleChange}
            minLength={8}
            required
          />
        </div>
      </div>

      {error && <p className="form-error">{error}</p>}
      {success && <p className="form-success">{success}</p>}

      <div className="form-actions">
        <button type="submit" disabled={saving}>
          {saving ? "Saving…" : "Change Password"}
        </button>
      </div>
    </form>
  );
}

export default Profile;