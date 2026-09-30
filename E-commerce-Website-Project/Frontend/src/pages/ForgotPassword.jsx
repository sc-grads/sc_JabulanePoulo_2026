import { useState } from "react";
import { Link } from "react-router-dom";
import AuthLayout from "../components/AuthLayout";
import FormInput from "../components/FormInput";
import { authService } from "../services/authService";
import "../styles/Auth.css";

function ForgotPassword() {
  const [email, setEmail] = useState("");
  const [sent, setSent] = useState(false);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);
    setError("");

    try {
      await authService.forgotPassword(email);
      setSent(true);
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

 if (sent) {
  return (
    <AuthLayout>
      <h1 className="auth-title">Check your email </h1>
      <p className="auth-subtitle">
        If an account exists for <strong>{email}</strong>, you'll
        receive a reset link within a minute.
      </p>
      <p className="auth-subtitle" style={{ fontSize: "0.85rem", color: "#888" }}>
        Don't see it? Check your <strong>Spam</strong> or{" "}
        <strong>Promotions</strong> folder.
      </p>
      <p className="auth-footer">
        <Link to="/login">Back to login</Link>
      </p>
    </AuthLayout>
  );
}

  return (
    <AuthLayout>
      <h1 className="auth-title">Forgot your password?</h1>
      <p className="auth-subtitle">
        Enter your email and we'll generate a reset link.
      </p>

      <form onSubmit={handleSubmit}>
        <FormInput
          label="Email address:"
          type="email"
          name="email"
          placeholder="Enter your email"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
          required
        />

        {error && <p className="form-error">{error}</p>}

        <button
          type="submit"
          className="primary-btn"
          disabled={loading}
        >
          {loading ? "Sending…" : "Send reset link"}
        </button>
      </form>

      <p className="auth-footer">
        Remembered it? <Link to="/login">Sign in</Link>
      </p>
    </AuthLayout>
  );
}

export default ForgotPassword;