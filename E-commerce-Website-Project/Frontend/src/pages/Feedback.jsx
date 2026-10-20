import { useState, useEffect } from "react";
import { Star, CheckCircle } from "lucide-react";
import { feedbackService } from "../services/feedbackService";
import { useAuth } from "../context/AuthContext";
import Navbar from "../components/Navbar";
import NavDrawer from "../components/NavDrawer";
import "../styles/Home.css";
import "../styles/Feedback.css";

function Feedback() {
  const { user, isAuthenticated } = useAuth();
  const [drawerOpen, setDrawerOpen] = useState(false);

  const [rating, setRating] = useState(0);
  const [hoverRating, setHoverRating] = useState(0);
  const [comment, setComment] = useState("");
  const [name, setName] = useState("");
  const [email, setEmail] = useState("");

  const [submitting, setSubmitting] = useState(false);
  const [success, setSuccess] = useState(false);
  const [error, setError] = useState("");

  const [stats, setStats] = useState({
    total: 0,
    average_rating: 0,
    counts: { 1: 0, 2: 0, 3: 0, 4: 0, 5: 0 },
  });

  const loadStats = async () => {
    try {
      const data = await feedbackService.getStats();
      setStats({
        total: data.total || 0,
        average_rating: data.average_rating || 0,
        counts: data.counts || { 1: 0, 2: 0, 3: 0, 4: 0, 5: 0 },
      });
    } catch (err) {
      console.warn(err.message);
    }
  };

  useEffect(() => {
    if (isAuthenticated && user) {
      setName(`${user.name} ${user.surname || ""}`.trim());
      setEmail(user.email || "");
    }
    loadStats();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [isAuthenticated]);

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError("");
    setSuccess(false);

    if (rating < 1) {
      setError("Please choose a star rating");
      return;
    }

    setSubmitting(true);

    try {
      await feedbackService.submit({
        rating,
        comment: comment.trim(),
        name: name.trim(),
        email: email.trim(),
      });
      setSuccess(true);
      setRating(0);
      setComment("");
      setTimeout(() => setSuccess(false), 5000);
      await loadStats();
    } catch (err) {
      setError(err.message);
    } finally {
      setSubmitting(false);
    }
  };

  const maxCount = Math.max(...Object.values(stats.counts), 1);

  return (
    <div className="feedback-page">
      <Navbar onOpenDrawer={() => setDrawerOpen(true)} />

      <div className="feedback-content">
        <header className="feedback-header">
          <h1>Share your experience</h1>
          <p>Tell us what you think about the Book Worm Website.</p>
        </header>

        <div className="feedback-grid">

          {/* LEFT: Form */}
          <section className="feedback-card">
            <h2>Rate us</h2>

            <form onSubmit={handleSubmit}>
              <div className="rating-stars-big">
                {[1, 2, 3, 4, 5].map((s) => (
                  <button
                    key={s}
                    type="button"
                    className="star-btn-big"
                    onMouseEnter={() => setHoverRating(s)}
                    onMouseLeave={() => setHoverRating(0)}
                    onClick={() => setRating(s)}
                  >
                    <Star
                      size={36}
                      fill={(hoverRating || rating) >= s ? "#ffb400" : "none"}
                      stroke="#ffb400"
                      strokeWidth={2}
                    />
                  </button>
                ))}
              </div>
              {rating > 0 && (
                <p className="rating-caption">
                  {["Poor", "Fair", "Good", "Great", "Excellent"][rating - 1]}
                </p>
              )}

              {!isAuthenticated && (
                <div className="form-row-2col">
                  <div className="form-group">
                    <label>Your name (optional)</label>
                    <input
                      type="text"
                      value={name}
                      onChange={(e) => setName(e.target.value)}
                      placeholder="Anonymous"
                    />
                  </div>
                  <div className="form-group">
                    <label>Email (optional)</label>
                    <input
                      type="email"
                      value={email}
                      onChange={(e) => setEmail(e.target.value)}
                      placeholder="you@example.com"
                    />
                  </div>
                </div>
              )}

              <div className="form-group">
                <label>Your feedback</label>
                <textarea
                  value={comment}
                  onChange={(e) => setComment(e.target.value)}
                  placeholder="What did you like? What could we improve?"
                  rows={4}
                  maxLength={500}
                />
              </div>

              {error && <p className="form-error">{error}</p>}

              {success && (
                <div className="feedback-success">
                  <CheckCircle size={18} /> Thank you! Your feedback has been
                  sent to our team.
                </div>
              )}

              <button
                type="submit"
                className="feedback-submit"
                disabled={submitting || rating < 1}
              >
                {submitting ? "Sending…" : "Submit Feedback"}
              </button>

              <p className="feedback-privacy">
                Your feedback is private and will only be viewed by the Book
                Worm team.
              </p>
            </form>
          </section>

          {/* RIGHT: Public stats only */}
          <section className="feedback-card feedback-public">
            <div className="feedback-public-header">
              <h2>Overall rating</h2>
            </div>

            {stats.total === 0 ? (
              <p className="no-feedback">
                No feedback yet. Be the first to share your thoughts!
              </p>
            ) : (
              <>
                <div className="feedback-avg-big">
                  <div className="avg-score">
                    <strong>{stats.average_rating.toFixed(1)}</strong>
                    <div className="avg-stars">
                      {[1, 2, 3, 4, 5].map((s) => (
                        <Star
                          key={s}
                          size={20}
                          fill={s <= Math.round(stats.average_rating) ? "#ffb400" : "none"}
                          stroke="#ffb400"
                        />
                      ))}
                    </div>
                    <p>
                      Based on {stats.total} review
                      {stats.total === 1 ? "" : "s"}
                    </p>
                  </div>
                </div>

                {/* Distribution bars */}
                <div className="rating-distribution">
                  {[5, 4, 3, 2, 1].map((s) => {
                    const count = stats.counts[s] || 0;
                    const pct = (count / maxCount) * 100;
                    return (
                      <div key={s} className="dist-row">
                        <span className="dist-label">
                          {s} <Star size={12} fill="#ffb400" stroke="#ffb400" />
                        </span>
                        <div className="dist-bar">
                          <div
                            className="dist-fill"
                            style={{ width: `${pct}%` }}
                          />
                        </div>
                        <span className="dist-count">{count}</span>
                      </div>
                    );
                  })}
                </div>
              </>
            )}
          </section>

        </div>
      </div>

      <NavDrawer open={drawerOpen} onClose={() => setDrawerOpen(false)} />
    </div>
  );
}

export default Feedback;