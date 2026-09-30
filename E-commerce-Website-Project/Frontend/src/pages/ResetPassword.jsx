import { useState } from "react";
import { useParams, useNavigate, Link } from "react-router-dom";
import AuthLayout from "../components/AuthLayout";
import FormInput from "../components/FormInput";
import Toast from "../components/Toast";
import { authService } from "../services/authService";
import "../styles/Auth.css";

function ResetPassword() {
  const { token } = useParams();
  const navigate = useNavigate();

  const [form, setForm] = useState({
    new_password: "",
    confirm_password: "",
  });
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");

  const [toast, setToast] = useState({
    open: false,
    type: "success",
    message: "",
  });

  const showToast = (message, type = "success") =>
    setToast({ open: true, type, message });

  const hideToast = () => setToast((t) => ({ ...t, open: false }));

  const handleChange = (e) => {
    setForm({ ...form, [e.target.name]: e.target.value });
    setError("");
  };

  const handleSubmit = async (e) => {
    e.preventDefault();

    if (form.new_password !== form.confirm_password) {
      showToast("Passwords do not match", "error");
      return;
    }

    if (form.new_password.length < 8) {
      showToast("Password must be at least 8 characters", "error");
      return;
    }

    setLoading(true);
    setError("");

    try {
      await authService.resetPassword({
        token,
        new_password: form.new_password,
      });

      showToast("Password reset successfully! Redirecting…");

      setTimeout(() => {
        navigate("/login");
      }, 1400);
    } catch (err) {
      setError(err.message);
      showToast(err.message, "error");
      setLoading(false);
    }
  };

  return (
    <AuthLayout>
      <h1 className="auth-title">Set a new password</h1>

      <form onSubmit={handleSubmit}>
        <FormInput
          label="New password:"
          type="password"
          name="new_password"
          placeholder="At least 8 characters"
          value={form.new_password}
          onChange={handleChange}
          required
        />
        <FormInput
          label="Confirm new password:"
          type="password"
          name="confirm_password"
          placeholder="Repeat new password"
          value={form.confirm_password}
          onChange={handleChange}
          required
        />

        {error && <p className="form-error">{error}</p>}

        <button
          type="submit"
          className="primary-btn"
          disabled={loading}
        >
          {loading ? "Saving…" : "Reset password"}
        </button>
      </form>

      <p className="auth-footer">
        <Link to="/login">Back to login</Link>
      </p>

      <Toast
        open={toast.open}
        type={toast.type}
        message={toast.message}
        onClose={hideToast}
        duration={3000}
      />
    </AuthLayout>
  );
}

export default ResetPassword;