import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import {
  Menu,
  TrendingUp,
  ShoppingBag,
  DollarSign,
  Package,
  Star,
  Truck,
  Store,
  AlertTriangle,
} from "lucide-react";
import { useAuth } from "../context/AuthContext";
import { analyticsService } from "../services/analyticsService";
import Navbar from "../components/Navbar";
import NavDrawer from "../components/NavDrawer";
import "../styles/Home.css";
import "../styles/AdminAnalytics.css";

const RANGES = [
  { key: 7, label: "7 days" },
  { key: 30, label: "30 days" },
  { key: 90, label: "90 days" },
  { key: 365, label: "1 year" },
];

const STATUS_COLORS = {
  pending: "#ffb400",
  paid: "#5b4bdb",
  processing: "#8a7cf5",
  shipped: "#0099cc",
  delivered: "#2fa55a",
  cancelled: "#eb001b",
  returned: "#888",
};

function AdminAnalytics() {
  const navigate = useNavigate();
  const { isAdmin } = useAuth();

  const [days, setDays] = useState(30);
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");
  const [drawerOpen, setDrawerOpen] = useState(false);

  const load = async (range = days) => {
    try {
      setLoading(true);
      setError("");
      const res = await analyticsService.getAnalytics(range);
      setData(res);
      setDays(range);
      window.scrollTo({ top: 0, behavior: "smooth" });
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    if (!isAdmin) {
      navigate("/home");
      return;
    }
    load(30);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [isAdmin, navigate]);

  if (loading && !data) {
    return (
      <div className="admin-page">
        <Navbar onOpenDrawer={() => setDrawerOpen(true)} />
        <p className="loading-text">Loading analytics…</p>
        <NavDrawer open={drawerOpen} onClose={() => setDrawerOpen(false)} />
      </div>
    );
  }

  if (error) {
    return (
      <div className="admin-page">
        <Navbar onOpenDrawer={() => setDrawerOpen(true)} />
        <p className="form-error">{error}</p>
        <NavDrawer open={drawerOpen} onClose={() => setDrawerOpen(false)} />
      </div>
    );
  }

  const { summary, daily_revenue, orders_by_status, top_books, categories, top_customers, delivery_breakdown, low_stock } = data;

  // Max for scaling the revenue chart
  const maxDaily = Math.max(...daily_revenue.map((d) => d.revenue), 1);

  // Max units for scaling top books
  const maxBookUnits = Math.max(...top_books.map((b) => b.units_sold), 1);

  // Max revenue for scaling categories
  const maxCatRevenue = Math.max(...categories.map((c) => c.revenue), 1);

  // Max spent for top customers
  const maxCustSpent = Math.max(...top_customers.map((c) => c.total_spent), 1);

  // Status totals
  const totalStatusCount = Object.values(orders_by_status).reduce((a, b) => a + b, 0) || 1;

  // Delivery pie
  const totalDeliveries = (delivery_breakdown.delivery || 0) + (delivery_breakdown.pickup || 0) || 1;

  return (
    <div className="admin-page">
      <Navbar onOpenDrawer={() => setDrawerOpen(true)} />

      <div className="admin-content">
        {/* HEADER */}
        <header className="admin-page-header">
          <div>
            <h1>Sales Analytics</h1>
            <p className="welcome">
              Performance overview for the last {days} days
            </p>
          </div>

          <div className="range-tabs">
            {RANGES.map((r) => (
              <button
                key={r.key}
                className={`range-tab ${days === r.key ? "active" : ""}`}
                onClick={() => load(r.key)}
              >
                {r.label}
              </button>
            ))}
          </div>
        </header>

        {/* SUMMARY CARDS */}
        <div className="summary-grid">
          <div className="summary-card revenue">
            <div className="summary-icon">
              <DollarSign size={20} />
            </div>
            <div>
              <p className="summary-label">Total Revenue</p>
              <h2>R{Number(summary.total_revenue).toFixed(2)}</h2>
            </div>
          </div>

          <div className="summary-card orders">
            <div className="summary-icon">
              <ShoppingBag size={20} />
            </div>
            <div>
              <p className="summary-label">Orders</p>
              <h2>{summary.total_orders}</h2>
            </div>
          </div>

          <div className="summary-card avg">
            <div className="summary-icon">
              <TrendingUp size={20} />
            </div>
            <div>
              <p className="summary-label">Avg. Order Value</p>
              <h2>R{Number(summary.avg_order_value).toFixed(2)}</h2>
            </div>
          </div>

          <div className="summary-card units">
            <div className="summary-icon">
              <Package size={20} />
            </div>
            <div>
              <p className="summary-label">Books Sold</p>
              <h2>{summary.total_units}</h2>
            </div>
          </div>
        </div>

        {/* REVENUE OVER TIME */}
        <section className="analytics-card">
          <div className="card-header-row">
            <h2>Revenue over time</h2>
            <span className="card-count">Last {days} days</span>
          </div>

          <div className="revenue-chart">
            {daily_revenue.map((d) => {
              const pct = (d.revenue / maxDaily) * 100;
              return (
                <div
                  key={d.date}
                  className="bar-col"
                  title={`${d.date}: R${d.revenue.toFixed(2)}`}
                >
                  <div
                    className="bar-fill"
                    style={{ height: `${pct}%` }}
                  />
                </div>
              );
            })}
          </div>

          <div className="chart-axis">
            <span>{daily_revenue[0]?.date}</span>
            <span>{daily_revenue[daily_revenue.length - 1]?.date}</span>
          </div>
        </section>

        {/* 2-COLUMN ROW: STATUS + DELIVERY */}
        <div className="analytics-row">
          {/* Orders by status */}
          <section className="analytics-card">
            <h2>Orders by status</h2>

            <div className="status-list">
              {Object.entries(orders_by_status).map(([status, count]) => {
                const pct = (count / totalStatusCount) * 100;
                return (
                  <div key={status} className="status-row">
                    <span
                      className="status-dot"
                      style={{ background: STATUS_COLORS[status] || "#ccc" }}
                    />
                    <span className="status-name">
                      {status.charAt(0).toUpperCase() + status.slice(1)}
                    </span>
                    <div className="status-bar">
                      <div
                        className="status-fill"
                        style={{
                          width: `${pct}%`,
                          background: STATUS_COLORS[status] || "#ccc",
                        }}
                      />
                    </div>
                    <span className="status-count">{count}</span>
                  </div>
                );
              })}
            </div>
          </section>

          {/* Delivery method */}
          <section className="analytics-card">
            <h2>Delivery method</h2>

            <div className="delivery-donut">
              <svg viewBox="0 0 36 36" className="donut">
                <circle cx="18" cy="18" r="15.9155" fill="#f0f0f5" />
                <circle
                  cx="18"
                  cy="18"
                  r="15.9155"
                  fill="transparent"
                  stroke="#5b4bdb"
                  strokeWidth="3.8"
                  strokeDasharray={`${
                    (delivery_breakdown.delivery / totalDeliveries) * 100
                  } 100`}
                  strokeDashoffset="25"
                />
                <text
                  x="18"
                  y="19"
                  textAnchor="middle"
                  fontSize="6"
                  fill="#1a1a2e"
                  fontWeight="800"
                >
                  {Math.round(
                    (delivery_breakdown.delivery / totalDeliveries) * 100
                  )}
                  %
                </text>
              </svg>
              <div className="donut-legend">
                <div className="legend-row">
                  <Truck size={14} color="#5b4bdb" />
                  <span>Delivery</span>
                  <strong>{delivery_breakdown.delivery}</strong>
                </div>
                <div className="legend-row">
                  <Store size={14} color="#2fa55a" />
                  <span>Pickup</span>
                  <strong>{delivery_breakdown.pickup}</strong>
                </div>
              </div>
            </div>
          </section>
        </div>

        {/* TOP BOOKS */}
        <section className="analytics-card">
          <div className="card-header-row">
            <h2>Top 5 selling books</h2>
            <span className="card-count">By units sold</span>
          </div>

          {top_books.length === 0 ? (
            <p className="no-results">No sales in this period.</p>
          ) : (
            <div className="top-books-list">
              {top_books.map((b, idx) => (
                <div key={b.book_id} className="top-book-row">
                  <span className="rank">#{idx + 1}</span>

                  <div className="top-book-cover">
                    {b.image_url ? (
                      <img
                        src={
                          b.image_url.startsWith("http")
                            ? b.image_url
                            : `${import.meta.env.VITE_API_URL}${b.image_url}`
                        }
                        alt={b.title}
                      />
                    ) : (
                      <div className="book-cover">BOOK</div>
                    )}
                  </div>

                  <div className="top-book-info">
                    <h3>{b.title}</h3>
                    <p>{b.author}</p>
                  </div>

                  <div className="top-book-stats">
                    <div className="stat-row">
                      <span className="stat-label">Units</span>
                      <strong>{b.units_sold}</strong>
                    </div>
                    <div className="stat-row">
                      <span className="stat-label">Revenue</span>
                      <strong>R{b.revenue.toFixed(2)}</strong>
                    </div>
                    <div className="top-book-bar">
                      <div
                        style={{
                          width: `${(b.units_sold / maxBookUnits) * 100}%`,
                        }}
                      />
                    </div>
                  </div>
                </div>
              ))}
            </div>
          )}
        </section>

        {/* CATEGORIES + CUSTOMERS */}
        <div className="analytics-row">
          <section className="analytics-card">
            <h2>Revenue by category</h2>

            {categories.length === 0 ? (
              <p className="no-results">No data yet.</p>
            ) : (
              <div className="category-list">
                {categories.map((c) => (
                  <div key={c.name} className="category-row">
                    <span className="cat-name">{c.name}</span>
                    <div className="cat-bar">
                      <div
                        style={{
                          width: `${(c.revenue / maxCatRevenue) * 100}%`,
                        }}
                      />
                    </div>
                    <strong className="cat-revenue">
                      R{c.revenue.toFixed(2)}
                    </strong>
                  </div>
                ))}
              </div>
            )}
          </section>

          <section className="analytics-card">
            <h2>Top customers</h2>

            {top_customers.length === 0 ? (
              <p className="no-results">No data yet.</p>
            ) : (
              <div className="top-customers-list">
                {top_customers.map((c, idx) => (
                  <div key={c.user_id} className="customer-row">
                    <span className="cust-rank">#{idx + 1}</span>

                    <div className="cust-avatar">
                      {c.name.charAt(0).toUpperCase()}
                    </div>

                    <div className="cust-info">
                      <h3>{c.name}</h3>
                      <p>{c.email}</p>
                    </div>

                    <div className="cust-stats">
                      <span>{c.orders_count} orders</span>
                      <strong>R{c.total_spent.toFixed(2)}</strong>
                    </div>

                    <div className="cust-bar">
                      <div
                        style={{
                          width: `${(c.total_spent / maxCustSpent) * 100}%`,
                        }}
                      />
                    </div>
                  </div>
                ))}
              </div>
            )}
          </section>
        </div>

        {/* LOW STOCK WARNINGS */}
        {low_stock.length > 0 && (
          <section className="analytics-card low-stock-card">
            <div className="card-header-row">
              <h2>
                <AlertTriangle size={18} color="#a06a00" /> Low stock
                warnings
              </h2>
              <span className="card-count">
                {low_stock.length} book{low_stock.length === 1 ? "" : "s"} with
                ≤ 3 in stock
              </span>
            </div>

            <div className="low-stock-list">
              {low_stock.map((b) => (
                <div key={b.book_id} className="low-stock-row">
                  <span className="stock-title">{b.title}</span>
                  <span
                    className={`stock-pill ${
                      b.stock_quantity === 0 ? "out" : "low"
                    }`}
                  >
                    {b.stock_quantity === 0
                      ? "Out of stock"
                      : `${b.stock_quantity} left`}
                  </span>
                  <button
                    className="restock-btn"
                    onClick={() => navigate("/admin/dashboard")}
                  >
                    Restock 
                  </button>
                </div>
              ))}
            </div>
          </section>
        )}
      </div>

      <NavDrawer open={drawerOpen} onClose={() => setDrawerOpen(false)} />
    </div>
  );
}

export default AdminAnalytics;