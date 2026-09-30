import { useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import { GoogleLogin } from "@react-oauth/google";
import AuthLayout from "../components/AuthLayout";
import FormInput from "../components/FormInput";
import { useAuth } from "../context/AuthContext";
import { apiRequest } from "../services/api";
import "../styles/Auth.css";
import "../styles/Login.css";

function Login() {
  const navigate = useNavigate();
  const { login } = useAuth();

  const [form, setForm] = useState({ email: "", password: "" });
  const [remember, setRemember] = useState(false);
  const [error, setError] = useState("");
  const [loading, setLoading] = useState(false);

  const handleChange = (e) => {
    setForm({ ...form, [e.target.name]: e.target.value });
    setError("");
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError("");
    setLoading(true);

    try {
      const user = await login({
        email: form.email,
        password: form.password,
      });

      if (user.role === "admin") {
        navigate("/admin/dashboard");
      } else {
        navigate("/books");
      }
    } catch (err) {
      setError(err.message || "Login failed");
    } finally {
      setLoading(false);
    }
  };

  const handleGoogleSuccess = async (credentialResponse) => {
    setError("");
    setLoading(true);

    try {
      const data = await apiRequest("/api/auth/google", {
        method: "POST",
        body: JSON.stringify({
          credential: credentialResponse.credential,
        }),
      });

      localStorage.setItem("token", data.access_token);
      localStorage.setItem("user", JSON.stringify(data.user));
      window.location.href = "/books";
    } catch (err) {
      setError(err.message || "Google login failed");
      setLoading(false);
    }
  };

  return (
    <AuthLayout>
      <h1 className="auth-title">Welcome back to Book Worm!</h1>
      <h3 className="auth-subtitle">
        Where Every Page Takes You Somewhere.
      </h3>

      <form onSubmit={handleSubmit}>
        <FormInput
          label="Email address:"
          type="email"
          name="email"
          placeholder="Enter your email"
          value={form.email}
          onChange={handleChange}
        />
        <FormInput
          label="Password:"
          type="password"
          name="password"
          placeholder="Password"
          value={form.password}
          onChange={handleChange}
        />

        {error && <p className="form-error">{error}</p>}

        <div className="form-row-between">
          
          <Link to="/forgot-password" className="forgot-link">
            Forgot password
          </Link>
        </div>

        <button
          type="submit"
          className="primary-btn"
          disabled={loading}
        >
          {loading ? "Logging in…" : "Login"}
        </button>
      </form>

      <div className="divider">
        <span>Or</span>
      </div>

      <div className="google-login-wrapper">
        <GoogleLogin
          onSuccess={handleGoogleSuccess}
          onError={() => setError("Google login failed")}
          shape="rectangular"
          size="large"
          text="signin_with"
          width="320"
        />
      </div>

      <p className="auth-footer">
        Don't have an account? <Link to="/signup">Sign up</Link>
      </p>
    </AuthLayout>
  );
}

export default Login;