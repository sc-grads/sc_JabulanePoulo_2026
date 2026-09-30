import { useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import AuthLayout from "../components/AuthLayout";
import FormInput from "../components/FormInput";

import Toast from "../components/Toast";
import { useAuth } from "../context/AuthContext";
import "../styles/Auth.css";
import "../styles/Login.css";

function Signup() {
  const navigate = useNavigate();
  const { register } = useAuth();

  const [form, setForm] = useState({
    firstName: "",
    lastName: "",
    email: "",
    password: "",
  });
  const [agree, setAgree] = useState(false);
  const [error, setError] = useState("");
  const [loading, setLoading] = useState(false);

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
    setError("");

    if (!agree) {
      showToast("Please agree to the terms & policy", "error");
      return;
    }

    setLoading(true);

    try {
      await register({
        name: form.firstName,
        lastName: form.lastName,
        surname: form.lastName,
        email: form.email,
        password: form.password,
      });

      showToast("Account created! Redirecting to login…");

      // Give the toast a moment to appear before navigating
      setTimeout(() => {
        navigate("/login");
      }, 1200);
    } catch (err) {
      setError(err.message || "Signup failed");
      showToast(err.message || "Signup failed", "error");
    } finally {
      setLoading(false);
    }
  };

  return (
    <AuthLayout>
      <h1 className="auth-title">Get Started Now</h1>

      <form onSubmit={handleSubmit}>
        <FormInput
          label="First Name:"
          name="firstName"
          placeholder="Enter your first name"
          value={form.firstName}
          onChange={handleChange}
        />
        <FormInput
          label="Last Name:"
          name="lastName"
          placeholder="Enter your last name"
          value={form.lastName}
          onChange={handleChange}
        />
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

        <label className="checkbox-row">
          <input
            type="checkbox"
            checked={agree}
            onChange={(e) => setAgree(e.target.checked)}
          />
          <span>I agree to the terms & policy</span>
        </label>

        <button
          type="submit"
          className="primary-btn"
          disabled={loading}
        >
          {loading ? "Creating account…" : "Sign up"}
        </button>
      </form>

      

      <p className="auth-footer">
        Have an account? <Link to="/login">Sign in</Link>
      </p>

      <Toast
        open={toast.open}
        type={toast.type}
        message={toast.message}
        onClose={hideToast}
        duration={3500}
      />
    </AuthLayout>
  );
}

export default Signup;