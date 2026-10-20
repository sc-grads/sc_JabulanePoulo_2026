from flask import Flask, jsonify, request, send_from_directory
from flask_cors import CORS
from flask_sqlalchemy import SQLAlchemy
from flask_mail import Mail, Message

from flask_jwt_extended import (
    JWTManager,
    create_access_token,
    jwt_required,
    get_jwt_identity
)

from dotenv import load_dotenv

from werkzeug.security import (
    generate_password_hash,
    check_password_hash
)

from werkzeug.utils import secure_filename
import uuid
import os
from datetime import timedelta

from functools import wraps

import stripe

import requests as http_requests


load_dotenv()
stripe.api_key = os.getenv("STRIPE_SECRET_KEY")

app = Flask(__name__)
CORS(app)

# ============================================================
# FILE UPLOAD CONFIG
# ============================================================

UPLOAD_FOLDER = os.path.join(
    os.path.dirname(os.path.abspath(__file__)),
    "uploads"
)
os.makedirs(UPLOAD_FOLDER, exist_ok=True)

app.config["UPLOAD_FOLDER"] = UPLOAD_FOLDER
app.config["MAX_CONTENT_LENGTH"] = 5 * 1024 * 1024

ALLOWED_EXTENSIONS = {"png", "jpg", "jpeg", "gif", "webp"}

def allowed_file(filename):
    return (
        "." in filename
        and filename.rsplit(".", 1)[1].lower() in ALLOWED_EXTENSIONS
    )


# ============================================================
# DATABASE
# ============================================================

app.config["SQLALCHEMY_DATABASE_URI"] = os.getenv("DATABASE_URL")
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
db = SQLAlchemy(app)

# ============================================================
# JWT
# ============================================================

app.config["JWT_SECRET_KEY"] = os.getenv("JWT_SECRET_KEY")
app.config["JWT_ACCESS_TOKEN_EXPIRES"] = timedelta(days=7)
jwt = JWTManager(app)

# ============================================================
# EMAIL CONFIGURATION
# ============================================================

app.config["MAIL_SERVER"] = os.getenv("MAIL_SERVER")
app.config["MAIL_PORT"] = int(os.getenv("MAIL_PORT", 587))
app.config["MAIL_USE_TLS"] = (
    os.getenv("MAIL_USE_TLS", "true").lower() == "true"
)
app.config["MAIL_USERNAME"] = os.getenv("MAIL_USERNAME")
app.config["MAIL_PASSWORD"] = os.getenv("MAIL_PASSWORD")

mail = Mail(app)

# ============================================================
# EMAIL HELPERS
# ============================================================

def send_email(to_email, subject, body_text, body_html=None):
    """
    Send an email. Prints to terminal if it fails (so dev still sees it).
    """
    try:
        msg = Message(
            subject=subject,
            sender=app.config["MAIL_USERNAME"],
            recipients=[to_email],
            body=body_text,
            html=body_html if body_html else None
        )
        mail.send(msg)
        print(f"[MAIL] Sent to {to_email}: {subject}")
        return True
    except Exception as e:
        print(f"[MAIL ERROR] Failed to send '{subject}' to {to_email}: {e}")
        return False


def build_email_html(
    title,
    intro,
    rows,
    cta_text=None,
    cta_url=None,
    subtitle=None,
    highlight=None,
):
    """
    Build a proper branded HTML email.
    rows       - list of (label, value) tuples
    highlight  - optional (label, value) shown in a colored banner
    subtitle   - optional subtitle under the title
    """
    subtitle_html = (
        f"<p style='margin:4px 0 0;color:#e0dcff;font-size:14px;'>{subtitle}</p>"
        if subtitle else ""
    )

    rows_html = "".join([
        f"""
        <tr>
          <td style="padding:10px 0;color:#6c6c80;font-size:13px;
                     border-bottom:1px solid #f0f0f5;">{label}</td>
          <td style="padding:10px 0;text-align:right;color:#1a1a2e;
                     font-weight:600;font-size:14px;
                     border-bottom:1px solid #f0f0f5;">{value}</td>
        </tr>
        """
        for label, value in rows
    ])

    highlight_html = ""
    if highlight:
        h_label, h_value = highlight
        highlight_html = f"""
        <div style="background:#f4f2ff;border-left:4px solid #5b4bdb;
                    padding:14px 18px;border-radius:8px;margin:20px 0;">
          <p style="margin:0;font-size:12px;color:#5b4bdb;
                    text-transform:uppercase;letter-spacing:1px;font-weight:700;">
            {h_label}
          </p>
          <p style="margin:6px 0 0;font-size:16px;color:#1a1a2e;font-weight:700;">
            {h_value}
          </p>
        </div>
        """

    cta_html = ""
    if cta_text and cta_url:
        cta_html = f"""
        <p style="text-align:center;margin:28px 0 8px;">
          <a href="{cta_url}"
             style="display:inline-block;padding:14px 32px;
                    background:#5b4bdb;color:#ffffff;text-decoration:none;
                    border-radius:10px;font-weight:700;font-size:14px;
                    letter-spacing:0.3px;">
            {cta_text}
          </a>
        </p>
        """

    return f"""
    <!DOCTYPE html>
    <html>
    <body style="margin:0;padding:0;background:#eef0f7;
                 font-family:-apple-system,'Segoe UI',Roboto,Helvetica,Arial,sans-serif;">
      <table role="presentation" width="100%" cellpadding="0" cellspacing="0"
             style="background:#eef0f7;padding:32px 16px;">
        <tr>
          <td align="center">
            <table role="presentation" width="560" cellpadding="0" cellspacing="0"
                   style="max-width:560px;background:#ffffff;border-radius:16px;
                          overflow:hidden;
                          box-shadow:0 8px 32px rgba(15,15,26,0.08);">

              <!-- HEADER -->
              <tr>
                <td style="background:linear-gradient(135deg,#5b4bdb 0%,#8a7cf5 100%);
                           padding:28px 32px;">
                  <p style="margin:0;color:#ffffff;font-size:20px;
                            font-weight:800;letter-spacing:-0.3px;">
                    Book Worm
                  </p>
                  <h1 style="margin:14px 0 0;color:#ffffff;font-size:24px;
                             font-weight:800;letter-spacing:-0.5px;">
                    {title}
                  </h1>
                  {subtitle_html}
                </td>
              </tr>

              <!-- BODY -->
              <tr>
                <td style="padding:32px;">
                  <p style="margin:0 0 20px;color:#1a1a2e;font-size:15px;
                            line-height:1.6;">
                    {intro}
                  </p>

                  {highlight_html}

                  <table role="presentation" width="100%" cellpadding="0"
                         cellspacing="0" style="margin-top:8px;">
                    {rows_html}
                  </table>

                  {cta_html}
                </td>
              </tr>

              <!-- FOOTER -->
              <tr>
                <td style="background:#faf9ff;padding:22px 32px;
                           text-align:center;border-top:1px solid #f0f0f5;">
                  <p style="margin:0;color:#9b9bb0;font-size:12px;
                            line-height:1.6;">
                    Thank you for shopping with Book Worm 💜<br>
                    © 2026 Book Worm. All rights reserved.
                  </p>
                </td>
              </tr>

            </table>
          </td>
        </tr>
      </table>
    </body>
    </html>
    """
def send_book_request_status_email(req, new_status, admin_note):
    user = db.session.get(User, req.user_id)
    if not user or not user.email:
        return

    titles = {
        "pending": "Book Request Received",
        "in_progress": "We're Looking for Your Book",
        "added": "Your Requested Book Is Now Available",
        "rejected": "Book Request Update"
    }
    intros = {
        "pending": "We've received your request and will look into it shortly.",
        "in_progress": "Good news — we're working on sourcing your requested book.",
        "added": "Great news! The book you requested is now in our catalog.",
        "rejected": "Unfortunately we couldn't source this title at the moment."
    }

    rows = [
        ("Book Title", req.title),
    ]
    if req.author:
        rows.append(("Author", req.author))
    rows.append(("Status", new_status.replace("_", " ").capitalize()))
    if admin_note:
        rows.append(("Note from our team", admin_note))

    cta_text = "Browse Books" if new_status == "added" else "View my requests"
    cta_url = (
        f"{os.getenv('FRONTEND_URL', 'http://localhost:5173')}/books"
        if new_status == "added"
        else f"{os.getenv('FRONTEND_URL', 'http://localhost:5173')}/request-book"
    )

    send_email(
        to_email=user.email,
        subject=f"{titles.get(new_status, 'Book Request Update')} — Book Worm",
        body_text=(
            f"Hi {user.name},\n\n"
            f"{intros.get(new_status, '')}\n\n"
            f"Book: {req.title}\n"
            f"Status: {new_status.replace('_', ' ').capitalize()}\n"
            + (f"Note: {admin_note}\n" if admin_note else "")
            + "\n— Book Worm"
        ),
        body_html=build_email_html(
            title=titles.get(new_status, "Book Request Update"),
            subtitle="",
            intro=f"Hi <strong>{user.name}</strong>, {intros.get(new_status, '')}",
            rows=rows,
            cta_text=cta_text,
            cta_url=cta_url,
        )
    )

# ============================================================
# MODELS
# ============================================================

class User(db.Model):
    __tablename__ = "users"
    user_id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    surname = db.Column(db.String(100), nullable=False)
    email = db.Column(db.String(150), nullable=False, unique=True)
    password_hash = db.Column(db.String(255), nullable=False)
    role = db.Column(
        db.Enum("customer", "admin"),
        nullable=False,
        default="customer"
    )

class Category(db.Model):
    __tablename__ = "categories"
    category_id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False, unique=True)

class Book(db.Model):
    __tablename__ = "books"
    book_id = db.Column(db.Integer, primary_key=True)
    category_id = db.Column(
        db.Integer,
        db.ForeignKey("categories.category_id"),
        nullable=False
    )
    title = db.Column(db.String(255), nullable=False)
    author = db.Column(db.String(150), nullable=False)
    description = db.Column(db.Text, nullable=True)
    price = db.Column(db.Numeric(10, 2), nullable=False)
    stock_quantity = db.Column(db.Integer, nullable=False, default=0)
    isbn = db.Column(db.String(20), nullable=True, unique=True)
    image_url = db.Column(db.String(500), nullable=True)
    sale_percent = db.Column(db.Integer, nullable=True)   # 1..99
    sale_start = db.Column(db.DateTime, nullable=True)
    sale_end = db.Column(db.DateTime, nullable=True)
    created_at = db.Column(
        db.DateTime,
        server_default=db.func.current_timestamp()
    )

class Information(db.Model):
    __tablename__ = "information"
    address_id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(
        db.Integer,
        db.ForeignKey("users.user_id"),
        nullable=False,
        unique=True
    )
    phone_num = db.Column(db.String(30), nullable=True)
    street = db.Column(db.String(255), nullable=True)
    city = db.Column(db.String(100), nullable=True)
    province = db.Column(db.String(100), nullable=True)
    postal_code = db.Column(db.String(20), nullable=True)
    country = db.Column(db.String(100), nullable=True)
    is_default = db.Column(db.Boolean, nullable=False, default=True)

class Cart(db.Model):
    __tablename__ = "carts"
    cart_id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(
        db.Integer,
        db.ForeignKey("users.user_id"),
        nullable=False,
        unique=True
    )

class CartItem(db.Model):
    __tablename__ = "cart_items"
    cart_item_id = db.Column(db.Integer, primary_key=True)
    cart_id = db.Column(
        db.Integer,
        db.ForeignKey("carts.cart_id"),
        nullable=False
    )
    book_id = db.Column(
        db.Integer,
        db.ForeignKey("books.book_id"),
        nullable=False
    )
    quantity = db.Column(db.Integer, nullable=False, default=1)

class Order(db.Model):
    __tablename__ = "orders"

    order_id = db.Column(db.Integer, primary_key=True)

    user_id = db.Column(
        db.Integer,
        db.ForeignKey("users.user_id"),
        nullable=True
    )

    order_date = db.Column(
        db.DateTime,
        server_default=db.func.current_timestamp()
    )

    status = db.Column(
        db.Enum(
            "pending",
            "paid",
            "processing",
            "shipped",
            "delivered",
            "cancelled",
            "returned"
        ),
        nullable=False,
        default="pending"
    )

    total_amount = db.Column(db.Numeric(10, 2), nullable=False)

    stripe_payment_intent_id = db.Column(db.String(255), nullable=True)

    # These two must exist
    delivery_method = db.Column(
        db.Enum("delivery", "pickup"),
        nullable=False,
        default="delivery"
    )

    delivery_fee = db.Column(
        db.Numeric(10, 2),
        nullable=False,
        default=0
    )

    confirmation_email_sent = db.Column(
        db.Boolean,
        nullable=False,
        default=False
    )

class OrderItem(db.Model):
    __tablename__ = "order_items"
    order_item_id = db.Column(db.Integer, primary_key=True)
    order_id = db.Column(
        db.Integer,
        db.ForeignKey("orders.order_id"),
        nullable=False
    )
    book_id = db.Column(
        db.Integer,
        db.ForeignKey("books.book_id"),
        nullable=False
    )
    quantity = db.Column(db.Integer, nullable=False)
    price_at_purchase = db.Column(db.Numeric(10, 2), nullable=False)

class Review(db.Model):
    __tablename__ = "reviews"
    review_id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(
        db.Integer,
        db.ForeignKey("users.user_id"),
        nullable=False
    )
    book_id = db.Column(
        db.Integer,
        db.ForeignKey("books.book_id"),
        nullable=False
    )
    order_id = db.Column(
        db.Integer,
        db.ForeignKey("orders.order_id"),
        nullable=False
    )
    rating = db.Column(db.Integer, nullable=False)
    comment = db.Column(db.Text, nullable=True)

    is_approved = db.Column(db.Boolean, nullable=False, default=False)
    approved_at = db.Column(db.DateTime, nullable=True)

    created_at = db.Column(
        db.DateTime,
        server_default=db.func.current_timestamp()
    )
    __table_args__ = (
        db.UniqueConstraint(
            "user_id",
            "book_id",
            name="unique_user_book_review"
        ),
    )

# ============================================================
# WISHLIST MODEL
# ============================================================

class Wishlist(db.Model):
    __tablename__ = "wishlists"

    wishlist_id = db.Column(db.Integer, primary_key=True)

    user_id = db.Column(
        db.Integer,
        db.ForeignKey("users.user_id"),
        nullable=False
    )

    book_id = db.Column(
        db.Integer,
        db.ForeignKey("books.book_id"),
        nullable=False
    )

    created_at = db.Column(
        db.DateTime,
        server_default=db.func.current_timestamp()
    )

    __table_args__ = (
        db.UniqueConstraint(
            "user_id",
            "book_id",
            name="unique_user_book_wishlist"
        ),
    )
# ============================================================
# RETURN MODEL
# ============================================================

class Return(db.Model):
    __tablename__ = "returns"

    return_id = db.Column(db.Integer, primary_key=True)

    order_id = db.Column(
        db.Integer,
        db.ForeignKey("orders.order_id"),
        nullable=False
    )

    user_id = db.Column(
        db.Integer,
        db.ForeignKey("users.user_id"),
        nullable=False
    )

    reason = db.Column(db.Text, nullable=False)

    status = db.Column(
        db.Enum("pending", "approved", "rejected"),
        nullable=False,
        default="pending"
    )

    admin_note = db.Column(db.Text, nullable=True)

    resolution = db.Column(
        db.Enum("refund", "replacement"),
        nullable=True
    )
    resolution_chosen_at = db.Column(db.DateTime, nullable=True)

    created_at = db.Column(
        db.DateTime,
        server_default=db.func.current_timestamp()
    )

    resolved_at = db.Column(db.DateTime, nullable=True)


# ============================================================
# APP FEEDBACK MODEL
# ============================================================

class AppFeedback(db.Model):
    __tablename__ = "app_feedback"

    feedback_id = db.Column(db.Integer, primary_key=True)

    user_id = db.Column(
        db.Integer,
        db.ForeignKey("users.user_id"),
        nullable=True          # allow anonymous feedback
    )

    name = db.Column(db.String(100), nullable=True)
    email = db.Column(db.String(150), nullable=True)

    rating = db.Column(db.Integer, nullable=False)   # 1..5
    comment = db.Column(db.Text, nullable=True)

    is_visible = db.Column(db.Boolean, nullable=False, default=True)

    created_at = db.Column(
        db.DateTime,
        server_default=db.func.current_timestamp()
    )


# ============================================================
# BOOK REQUEST MODEL
# ============================================================

class BookRequest(db.Model):
    __tablename__ = "book_requests"

    request_id = db.Column(db.Integer, primary_key=True)

    user_id = db.Column(
        db.Integer,
        db.ForeignKey("users.user_id"),
        nullable=False
    )

    title = db.Column(db.String(255), nullable=False)
    author = db.Column(db.String(150), nullable=True)
    isbn = db.Column(db.String(20), nullable=True)

    notes = db.Column(db.Text, nullable=True)

    status = db.Column(
        db.Enum("pending", "in_progress", "added", "rejected"),
        nullable=False,
        default="pending"
    )

    admin_note = db.Column(db.Text, nullable=True)

    created_at = db.Column(
        db.DateTime,
        server_default=db.func.current_timestamp()
    )

    resolved_at = db.Column(db.DateTime, nullable=True)
# ============================================================
# PASSWORD RESET MODEL
# ============================================================

class PasswordReset(db.Model):
    __tablename__ = "password_resets"

    reset_id = db.Column(db.Integer, primary_key=True)

    user_id = db.Column(
        db.Integer,
        db.ForeignKey("users.user_id"),
        nullable=False
    )

    token = db.Column(
        db.String(255),
        nullable=False,
        unique=True
    )

    expires_at = db.Column(
        db.DateTime,
        nullable=False
    )

    used = db.Column(
        db.Boolean,
        nullable=False,
        default=False
    )

    created_at = db.Column(
        db.DateTime,
        server_default=db.func.current_timestamp()
    )


# ============================================================
# ROLE CHECKER
# ============================================================

def role_required(required_role):
    def decorator(function):
        @wraps(function)
        @jwt_required()
        def wrapper(*args, **kwargs):
            user_id = get_jwt_identity()
            user = db.session.get(User, int(user_id))
            if not user:
                return jsonify({"message": "User not found"}), 404
            if user.role != required_role:
                return jsonify({
                    "message": f"{required_role} access required"
                }), 403
            return function(*args, **kwargs)
        return wrapper
    return decorator

# ============================================================
# FILE SERVING
# ============================================================

@app.route("/uploads/<path:filename>")
def uploaded_file(filename):
    return send_from_directory(app.config["UPLOAD_FOLDER"], filename)

@app.route("/")
def home():
    return jsonify({"message": "Bookworm API is running"})

@app.route("/api/test-db")
def test_db():
    try:
        db.session.execute(db.text("SELECT 1"))
        return jsonify({"message": "MySQL connection successful"})
    except Exception as e:
        return jsonify({
            "message": "Database connection failed",
            "error": str(e)
        }), 500

# ============================================================
# FORGOT PASSWORD — request reset link
# ============================================================

@app.route("/api/auth/forgot-password", methods=["POST"])
def forgot_password():

    import secrets
    from datetime import datetime, timedelta, timezone

    data = request.get_json() or {}
    email = (data.get("email") or "").strip().lower()

    if not email:
        return jsonify({"message": "Email is required"}), 400

    user = User.query.filter_by(email=email).first()

    # Always return success (don't reveal whether the email exists)
    if not user:
        return jsonify({
            "message": "If that email exists, a reset link has been sent"
        }), 200

    # Delete any old tokens for this user
    PasswordReset.query.filter_by(user_id=user.user_id).delete()

    token = secrets.token_urlsafe(48)
    expires_at = datetime.now(timezone.utc) + timedelta(minutes=30)

    reset = PasswordReset(
        user_id=user.user_id,
        token=token,
        expires_at=expires_at.replace(tzinfo=None),
        used=False
    )
    db.session.add(reset)
    db.session.commit()

    frontend_url = os.getenv("FRONTEND_URL", "http://localhost:5173")
    reset_link = f"{frontend_url}/reset-password/{token}"

    # -------- SEND EMAIL --------
    try:
        msg = Message(
            subject="Reset your Bookworm password",
            sender=app.config["MAIL_USERNAME"],
            recipients=[email],
            body=(
                f"Hi {user.name},\n\n"
                f"We received a request to reset your Bookworm password.\n\n"
                f"Click the link below to set a new password:\n\n"
                f"{reset_link}\n\n"
                f"This link expires in 30 minutes.\n\n"
                f"If you didn't request this, you can safely ignore this email."
            ),
            html=(
                f"<p>Hi <strong>{user.name}</strong>,</p>"
                f"<p>We received a request to reset your Bookworm password.</p>"
                f"<p><a href='{reset_link}' "
                f"style='display:inline-block;padding:12px 24px;"
                f"background:#5b4bdb;color:#fff;text-decoration:none;"
                f"border-radius:8px;font-weight:600;'>Reset Password</a></p>"
                f"<p>Or copy this link into your browser:</p>"
                f"<p style='word-break:break-all;color:#5b4bdb;'>{reset_link}</p>"
                f"<p style='color:#888;font-size:13px;'>"
                f"This link expires in 30 minutes.</p>"
                f"<p style='color:#888;font-size:13px;'>"
                f"If you didn't request this, ignore this email.</p>"
            )
        )
        mail.send(msg)
        print(f"[MAIL] Reset link sent to {email}")

    except Exception as e:
        print(f"[MAIL ERROR] {e}")
        return jsonify({
            "message": "Failed to send email. Please try again later."
        }), 500

    return jsonify({
        "message": "If that email exists, a reset link has been sent"
    }), 200


# ============================================================
# RESET PASSWORD — verify token & set new password
# ============================================================

@app.route("/api/auth/reset-password", methods=["POST"])
def reset_password():

    from datetime import datetime

    data = request.get_json() or {}
    token = data.get("token")
    new_password = data.get("new_password")

    if not token or not new_password:
        return jsonify({
            "message": "Token and new password are required"
        }), 400

    if len(new_password) < 8:
        return jsonify({
            "message": "New password must be at least 8 characters"
        }), 400

    reset = PasswordReset.query.filter_by(token=token).first()

    if not reset or reset.used:
        return jsonify({
            "message": "Invalid or already used reset link"
        }), 400

    if reset.expires_at < datetime.utcnow():
        return jsonify({
            "message": "Reset link has expired"
        }), 400

    user = db.session.get(User, reset.user_id)
    if not user:
        return jsonify({"message": "User not found"}), 404

    user.password_hash = generate_password_hash(new_password)
    reset.used = True
    db.session.commit()

    return jsonify({"message": "Password reset successfully"}), 200

# ============================================================
# AUTH — REGISTER
# ============================================================

@app.route("/api/auth/register", methods=["POST"])
def register():
    data = request.get_json()
    name = data.get("name")
    surname = data.get("surname")
    email = data.get("email")
    password = data.get("password")

    if not name or not surname or not email or not password:
        return jsonify({
            "message": "Name, surname, email and password are required"
        }), 400

    existing_user = User.query.filter_by(email=email).first()
    if existing_user:
        return jsonify({"message": "Email already registered"}), 409

    user = User(
        name=name,
        surname=surname,
        email=email,
        password_hash=generate_password_hash(password)
    )
    db.session.add(user)
    db.session.commit()

    return jsonify({
        "message": "Customer registered successfully",
        "user": {
            "user_id": user.user_id,
            "name": user.name,
            "email": user.email,
            "role": user.role
        }
    }), 201

# ============================================================
# AUTH — LOGIN
# ============================================================

@app.route("/api/auth/login", methods=["POST"])
def login():
    data = request.get_json()
    email = data.get("email")
    password = data.get("password")

    if not email or not password:
        return jsonify({
            "message": "Email and password are required"
        }), 400

    user = User.query.filter_by(email=email).first()
    if not user or not check_password_hash(user.password_hash, password):
        return jsonify({"message": "Invalid email or password"}), 401

    access_token = create_access_token(identity=str(user.user_id))

    return jsonify({
        "message": "Login successful",
        "access_token": access_token,
        "user": {
            "user_id": user.user_id,
            "name": user.name,
            "surname": user.surname,
            "email": user.email,
            "role": user.role
        }
    }), 200

# ============================================================
# AUTH — GET ME
# ============================================================

@app.route("/api/auth/me", methods=["GET"])
@jwt_required()
def current_user():
    user_id = get_jwt_identity()
    user = db.session.get(User, int(user_id))
    if not user:
        return jsonify({"message": "User not found"}), 404

    return jsonify({
        "user_id": user.user_id,
        "name": user.name,
        "surname": user.surname,
        "email": user.email,
        "role": user.role
    }), 200

# ============================================================
# AUTH — UPDATE ME
# ============================================================

@app.route("/api/auth/me", methods=["PUT"])
@jwt_required()
def update_current_user():
    user_id = get_jwt_identity()
    user = db.session.get(User, int(user_id))
    if not user:
        return jsonify({"message": "User not found"}), 404

    data = request.get_json() or {}

    if "name" in data:
        new_name = (data.get("name") or "").strip()
        if not new_name:
            return jsonify({"message": "First name cannot be empty"}), 400
        user.name = new_name

    if "surname" in data:
        new_surname = (data.get("surname") or "").strip()
        if not new_surname:
            return jsonify({"message": "Last name cannot be empty"}), 400
        user.surname = new_surname

    if "email" in data:
        new_email = (data.get("email") or "").strip().lower()
        if not new_email:
            return jsonify({"message": "Email cannot be empty"}), 400
        existing = User.query.filter(
            User.email == new_email,
            User.user_id != user.user_id
        ).first()
        if existing:
            return jsonify({"message": "Email already registered"}), 409
        user.email = new_email

    db.session.commit()

    return jsonify({
        "message": "Profile updated successfully",
        "user": {
            "user_id": user.user_id,
            "name": user.name,
            "surname": user.surname,
            "email": user.email,
            "role": user.role
        }
    }), 200

# ============================================================
# AUTH — CHANGE PASSWORD
# ============================================================

@app.route("/api/auth/change-password", methods=["PUT"])
@jwt_required()
def change_password():
    user_id = get_jwt_identity()
    user = db.session.get(User, int(user_id))
    if not user:
        return jsonify({"message": "User not found"}), 404

    data = request.get_json() or {}
    current_password = data.get("current_password")
    new_password = data.get("new_password")

    if not current_password or not new_password:
        return jsonify({
            "message": "Current password and new password are required"
        }), 400

    if not check_password_hash(user.password_hash, current_password):
        return jsonify({"message": "Current password is incorrect"}), 401

    if len(new_password) < 8:
        return jsonify({
            "message": "New password must be at least 8 characters"
        }), 400

    if new_password == current_password:
        return jsonify({
            "message": "New password must be different from the current one"
        }), 400

    user.password_hash = generate_password_hash(new_password)
    db.session.commit()

    return jsonify({"message": "Password changed successfully"}), 200

# ============================================================
# AUTH — CREATE ADMIN (DEV)
# ============================================================

@app.route("/api/auth/create-admin", methods=["POST"])
def create_admin():
    data = request.get_json()
    name = data.get("name")
    surname = data.get("surname")
    email = data.get("email")
    password = data.get("password")

    if not name or not email or not password:
        return jsonify({
            "message": "Name, email and password are required"
        }), 400

    existing_user = User.query.filter_by(email=email).first()
    if existing_user:
        return jsonify({"message": "Email already registered"}), 409

    admin = User(
        name=name,
        surname=surname,
        email=email,
        password_hash=generate_password_hash(password),
        role="admin"
    )
    db.session.add(admin)
    db.session.commit()

    return jsonify({
        "message": "Admin created successfully",
        "user": {
            "user_id": admin.user_id,
            "name": admin.name,
            "surname": admin.surname,
            "email": admin.email,
            "role": admin.role
        }
    }), 201

# ============================================================
# UPLOAD IMAGE (ADMIN)
# ============================================================

@app.route("/api/upload", methods=["POST"])
@role_required("admin")
def upload_image():
    if "file" not in request.files:
        return jsonify({"message": "No file provided"}), 400

    file = request.files["file"]
    if file.filename == "":
        return jsonify({"message": "No file selected"}), 400

    if not allowed_file(file.filename):
        return jsonify({
            "message": "Invalid file type. Allowed: png, jpg, jpeg, gif, webp"
        }), 400

    os.makedirs(app.config["UPLOAD_FOLDER"], exist_ok=True)
    safe_name = secure_filename(file.filename)
    unique_name = f"{uuid.uuid4().hex}_{safe_name}"
    save_path = os.path.join(app.config["UPLOAD_FOLDER"], unique_name)
    file.save(save_path)

    return jsonify({
        "message": "File uploaded successfully",
        "image_url": f"/uploads/{unique_name}"
    }), 201

# ============================================================
# BOOKS — GET ALL
# ============================================================

@app.route("/api/books", methods=["GET"])
def get_books():
    search = request.args.get("search")
    category_id = request.args.get("category_id", type=int)
    min_price = request.args.get("min_price", type=float)
    max_price = request.args.get("max_price", type=float)
    sort = request.args.get("sort", "newest")
    page = request.args.get("page", 1, type=int)
    per_page = request.args.get("per_page", 10, type=int)

    if page < 1:
        return jsonify({"message": "Page must be 1 or greater"}), 400

    if per_page < 1 or per_page > 100:
        return jsonify({
            "message": "per_page must be between 1 and 100"
        }), 400

    query = Book.query

    if search:
        search_pattern = f"%{search}%"
        query = query.filter(
            db.or_(
                Book.title.ilike(search_pattern),
                Book.author.ilike(search_pattern)
            )
        )

    if category_id:
        query = query.filter(Book.category_id == category_id)

    if min_price is not None:
        query = query.filter(Book.price >= min_price)

    if max_price is not None:
        query = query.filter(Book.price <= max_price)

    if sort == "price_asc":
        query = query.order_by(Book.price.asc())
    elif sort == "price_desc":
        query = query.order_by(Book.price.desc())
    elif sort == "title_asc":
        query = query.order_by(Book.title.asc())
    elif sort == "title_desc":
        query = query.order_by(Book.title.desc())
    else:
        query = query.order_by(Book.created_at.desc())

    pagination = query.paginate(page=page, per_page=per_page, error_out=False)

    book_list = []
    for book in pagination.items:
        book_list.append({
            "book_id": book.book_id,
            "category_id": book.category_id,
            "title": book.title,
            "author": book.author,
            "description": book.description,
            "price": float(book.price),
            "stock_quantity": book.stock_quantity,
            "isbn": book.isbn,
            "image_url": book.image_url,
            "created_at": (
                book.created_at.isoformat() if book.created_at else None
            )
        })

    return jsonify({
        "books": book_list,
        "pagination": {
            "page": pagination.page,
            "per_page": pagination.per_page,
            "total_books": pagination.total,
            "total_pages": pagination.pages,
            "has_next": pagination.has_next,
            "has_previous": pagination.has_prev
        }
    }), 200

# ============================================================
# BOOKS — CREATE
# ============================================================

@app.route("/api/books", methods=["POST"])
@role_required("admin")
def create_book():
    data = request.get_json()
    category_id = data.get("category_id")
    title = data.get("title")
    author = data.get("author")
    description = data.get("description")
    price = data.get("price")
    stock_quantity = data.get("stock_quantity")
    isbn = data.get("isbn")
    image_url = data.get("image_url")

    if not category_id:
        return jsonify({"message": "Category ID is required"}), 400
    if not title:
        return jsonify({"message": "Title is required"}), 400
    if not author:
        return jsonify({"message": "Author is required"}), 400
    if price is None:
        return jsonify({"message": "Price is required"}), 400

    category = db.session.get(Category, category_id)
    if not category:
        return jsonify({"message": "Category not found"}), 404

    if isbn:
        existing_book = Book.query.filter_by(isbn=isbn).first()
        if existing_book:
            return jsonify({"message": "ISBN already exists"}), 409

    book = Book(
        category_id=category_id,
        title=title,
        author=author,
        description=description,
        price=price,
        stock_quantity=stock_quantity if stock_quantity is not None else 0,
        isbn=isbn,
        image_url=image_url
    )
    db.session.add(book)
    db.session.commit()

    return jsonify({
        "message": "Book created successfully",
        "book": {
            "book_id": book.book_id,
            "category_id": book.category_id,
            "title": book.title,
            "author": book.author,
            "description": book.description,
            "price": float(book.price),
            "stock_quantity": book.stock_quantity,
            "isbn": book.isbn,
            "image_url": book.image_url
        }
    }), 201

# ============================================================
# BOOKS — UPDATE
# ============================================================

@app.route("/api/books/<int:book_id>", methods=["PUT"])
@role_required("admin")
def update_book(book_id):
    book = db.session.get(Book, book_id)
    if not book:
        return jsonify({"message": "Book not found"}), 404

    data = request.get_json()

    if "category_id" in data:
        category = db.session.get(Category, data["category_id"])
        if not category:
            return jsonify({"message": "Category not found"}), 404
        book.category_id = data["category_id"]

    if "title" in data:
        book.title = data["title"]
    if "author" in data:
        book.author = data["author"]
    if "description" in data:
        book.description = data["description"]
    if "price" in data:
        book.price = data["price"]
    if "stock_quantity" in data:
        book.stock_quantity = data["stock_quantity"]

    if "isbn" in data:
        if data["isbn"] != book.isbn:
            existing_book = Book.query.filter_by(isbn=data["isbn"]).first()
            if existing_book:
                return jsonify({"message": "ISBN already exists"}), 409
        book.isbn = data["isbn"]

    if "image_url" in data:
        book.image_url = data["image_url"]

    db.session.commit()

    return jsonify({
        "message": "Book updated successfully",
        "book": {
            "book_id": book.book_id,
            "category_id": book.category_id,
            "title": book.title,
            "author": book.author,
            "description": book.description,
            "price": float(book.price),
            "stock_quantity": book.stock_quantity,
            "isbn": book.isbn,
            "image_url": book.image_url
        }
    }), 200

# ============================================================
# BOOKS — DELETE
# ============================================================

@app.route("/api/books/<int:book_id>", methods=["DELETE"])
@role_required("admin")
def delete_book(book_id):
    book = db.session.get(Book, book_id)
    if not book:
        return jsonify({"message": "Book not found"}), 404

    db.session.delete(book)
    db.session.commit()
    return jsonify({"message": "Book deleted successfully"}), 200

# ============================================================
# CATEGORIES
# ============================================================

@app.route("/api/categories", methods=["GET"])
def get_categories():
    # Allow ?all=true to fetch every category (used by book dropdown)
    fetch_all = request.args.get("all", "false").lower() == "true"

    if fetch_all:
        categories = Category.query.order_by(Category.category_id.asc()).all()
        return jsonify({
            "categories": [
                {"category_id": c.category_id, "name": c.name}
                for c in categories
            ]
        }), 200

    page = request.args.get("page", 1, type=int)
    per_page = request.args.get("per_page", 8, type=int)

    if page < 1:
        return jsonify({"message": "Page must be 1 or greater"}), 400
    if per_page < 1 or per_page > 100:
        return jsonify({
            "message": "per_page must be between 1 and 100"
        }), 400

    pagination = (
        Category.query
        .order_by(Category.category_id.asc())
        .paginate(page=page, per_page=per_page, error_out=False)
    )

    return jsonify({
        "categories": [
            {"category_id": c.category_id, "name": c.name}
            for c in pagination.items
        ],
        "pagination": {
            "page": pagination.page,
            "per_page": pagination.per_page,
            "total_categories": pagination.total,
            "total_pages": pagination.pages,
            "has_next": pagination.has_next,
            "has_previous": pagination.has_prev
        }
    }), 200

@app.route("/api/categories/<int:category_id>", methods=["GET"])
def get_category(category_id):
    category = db.session.get(Category, category_id)
    if not category:
        return jsonify({"message": "Category not found"}), 404
    return jsonify({
        "category": {
            "category_id": category.category_id,
            "name": category.name
        }
    }), 200

@app.route("/api/categories", methods=["POST"])
@role_required("admin")
def create_category():
    data = request.get_json()
    if not data:
        return jsonify({"message": "Request body is required"}), 400

    name = data.get("name")
    if not name:
        return jsonify({"message": "Category name is required"}), 400

    existing = Category.query.filter_by(name=name).first()
    if existing:
        return jsonify({"message": "Category already exists"}), 409

    category = Category(name=name)
    db.session.add(category)
    db.session.commit()

    return jsonify({
        "message": "Category created successfully",
        "category": {
            "category_id": category.category_id,
            "name": category.name
        }
    }), 201

@app.route("/api/categories/<int:category_id>", methods=["PUT"])
@role_required("admin")
def update_category(category_id):
    category = db.session.get(Category, category_id)
    if not category:
        return jsonify({"message": "Category not found"}), 404

    data = request.get_json()
    if not data:
        return jsonify({"message": "Request body is required"}), 400

    name = data.get("name")
    if not name:
        return jsonify({"message": "Category name is required"}), 400

    existing = Category.query.filter(
        Category.name == name,
        Category.category_id != category_id
    ).first()
    if existing:
        return jsonify({"message": "Category already exists"}), 409

    category.name = name
    db.session.commit()

    return jsonify({
        "message": "Category updated successfully",
        "category": {
            "category_id": category.category_id,
            "name": category.name
        }
    }), 200

@app.route("/api/categories/<int:category_id>", methods=["DELETE"])
@role_required("admin")
def delete_category(category_id):
    category = db.session.get(Category, category_id)
    if not category:
        return jsonify({"message": "Category not found"}), 404

    books_using = Book.query.filter_by(category_id=category_id).first()
    if books_using:
        return jsonify({
            "message": "Cannot delete category because books are using it"
        }), 409

    db.session.delete(category)
    db.session.commit()
    return jsonify({"message": "Category deleted successfully"}), 200

# ============================================================
# CART
# ============================================================

@app.route("/api/cart", methods=["GET"])
@role_required("customer")
def get_cart():
    user_id = get_jwt_identity()
    cart = Cart.query.filter_by(user_id=int(user_id)).first()
    if not cart:
        cart = Cart(user_id=int(user_id))
        db.session.add(cart)
        db.session.commit()

    items = []
    total = 0
    for item in CartItem.query.filter_by(cart_id=cart.cart_id).all():
        book = db.session.get(Book, item.book_id)
        if not book:
            continue
        item_total = float(book.price) * item.quantity
        total += item_total
        items.append({
            "cart_item_id": item.cart_item_id,
            "book": {
                "book_id": book.book_id,
                "title": book.title,
                "author": book.author,
                "price": float(book.price),
                "image_url": book.image_url
            },
            "quantity": item.quantity,
            "item_total": item_total
        })

    return jsonify({
        "cart_id": cart.cart_id,
        "items": items,
        "total": total
    }), 200

@app.route("/api/cart/items", methods=["POST"])
@role_required("customer")
def add_to_cart():
    user_id = get_jwt_identity()
    data = request.get_json()
    if not data:
        return jsonify({"message": "Request body is required"}), 400

    book_id = data.get("book_id")
    quantity = data.get("quantity", 1)

    if not book_id:
        return jsonify({"message": "Book ID is required"}), 400
    if quantity < 1:
        return jsonify({"message": "Quantity must be at least 1"}), 400

    book = db.session.get(Book, book_id)
    if not book:
        return jsonify({"message": "Book not found"}), 404
    if book.stock_quantity < quantity:
        return jsonify({
            "message": "Not enough stock available",
            "available_stock": book.stock_quantity
        }), 409

    cart = Cart.query.filter_by(user_id=int(user_id)).first()
    if not cart:
        cart = Cart(user_id=int(user_id))
        db.session.add(cart)
        db.session.commit()

    cart_item = CartItem.query.filter_by(
        cart_id=cart.cart_id,
        book_id=book_id
    ).first()

    if cart_item:
        new_quantity = cart_item.quantity + quantity
        if new_quantity > book.stock_quantity:
            return jsonify({
                "message": "Requested quantity exceeds available stock",
                "available_stock": book.stock_quantity
            }), 409
        cart_item.quantity = new_quantity
    else:
        cart_item = CartItem(
            cart_id=cart.cart_id,
            book_id=book_id,
            quantity=quantity
        )
        db.session.add(cart_item)

    db.session.commit()
    return jsonify({
        "message": "Book added to cart successfully",
        "cart_item": {
            "cart_item_id": cart_item.cart_item_id,
            "book_id": cart_item.book_id,
            "quantity": cart_item.quantity
        }
    }), 201

@app.route("/api/cart/items/<int:cart_item_id>", methods=["PUT"])
@role_required("customer")
def update_cart_item(cart_item_id):
    user_id = get_jwt_identity()
    data = request.get_json()
    if not data:
        return jsonify({"message": "Request body is required"}), 400

    quantity = data.get("quantity")
    if quantity is None:
        return jsonify({"message": "Quantity is required"}), 400
    if quantity < 1:
        return jsonify({"message": "Quantity must be at least 1"}), 400

    cart = Cart.query.filter_by(user_id=int(user_id)).first()
    if not cart:
        return jsonify({"message": "Cart not found"}), 404

    cart_item = CartItem.query.filter_by(
        cart_id=cart.cart_id,
        cart_item_id=cart_item_id
    ).first()
    if not cart_item:
        return jsonify({"message": "Cart item not found"}), 404

    book = db.session.get(Book, cart_item.book_id)
    if not book:
        return jsonify({"message": "Book not found"}), 404
    if quantity > book.stock_quantity:
        return jsonify({
            "message": "Requested quantity exceeds available stock",
            "available_stock": book.stock_quantity
        }), 409

    cart_item.quantity = quantity
    db.session.commit()
    return jsonify({
        "message": "Cart item updated successfully",
        "cart_item": {
            "cart_item_id": cart_item.cart_item_id,
            "book_id": cart_item.book_id,
            "quantity": cart_item.quantity
        }
    }), 200

@app.route("/api/cart/items/<int:cart_item_id>", methods=["DELETE"])
@role_required("customer")
def delete_cart_item(cart_item_id):
    user_id = get_jwt_identity()
    cart = Cart.query.filter_by(user_id=int(user_id)).first()
    if not cart:
        return jsonify({"message": "Cart not found"}), 404

    cart_item = CartItem.query.filter_by(
        cart_id=cart.cart_id,
        cart_item_id=cart_item_id
    ).first()
    if not cart_item:
        return jsonify({"message": "Cart item not found"}), 404

    db.session.delete(cart_item)
    db.session.commit()
    return jsonify({"message": "Cart item removed successfully"}), 200

@app.route("/api/cart", methods=["DELETE"])
@role_required("customer")
def clear_cart():
    user_id = get_jwt_identity()
    cart = Cart.query.filter_by(user_id=int(user_id)).first()
    if not cart:
        return jsonify({"message": "Cart not found"}), 404

    CartItem.query.filter_by(cart_id=cart.cart_id).delete()
    db.session.commit()
    return jsonify({"message": "Cart cleared successfully"}), 200

# ============================================================
# ORDERS — CREATE
# ============================================================
@app.route("/api/orders", methods=["POST"])
@role_required("customer")
def create_order():

    user_id = get_jwt_identity()
    data = request.get_json() or {}

    delivery_method = (data.get("delivery_method") or "delivery").lower()
    if delivery_method not in ("delivery", "pickup"):
        return jsonify({
            "message": "delivery_method must be 'delivery' or 'pickup'"
        }), 400

    DELIVERY_FEE = 70.00
    delivery_fee = DELIVERY_FEE if delivery_method == "delivery" else 0.0

    cart = Cart.query.filter_by(user_id=int(user_id)).first()
    if not cart:
        return jsonify({"message": "Cart not found"}), 404

    cart_items = CartItem.query.filter_by(cart_id=cart.cart_id).all()
    if not cart_items:
        return jsonify({"message": "Cart is empty"}), 400

    total_amount = 0
    order_items_data = []

    for cart_item in cart_items:
        book = db.session.get(Book, cart_item.book_id)
        if not book:
            return jsonify({
                "message": f"Book with ID {cart_item.book_id} not found"
            }), 404

        if book.stock_quantity < cart_item.quantity:
            return jsonify({
                "message": f"Not enough stock for '{book.title}'",
                "available_stock": book.stock_quantity,
                "requested_quantity": cart_item.quantity
            }), 409

        item_total = float(book.price) * cart_item.quantity
        total_amount += item_total

        order_items_data.append({
            "book": book,
            "quantity": cart_item.quantity,
            "price_at_purchase": book.price
        })

    # Add the delivery fee
    total_amount += delivery_fee

    order = Order(
        user_id=int(user_id),
        status="pending",
        total_amount=total_amount,
        delivery_method=delivery_method,
        delivery_fee=delivery_fee
    )
    db.session.add(order)
    db.session.flush()

    for item_data in order_items_data:
        order_item = OrderItem(
            order_id=order.order_id,
            book_id=item_data["book"].book_id,
            quantity=item_data["quantity"],
            price_at_purchase=item_data["price_at_purchase"]
        )
        db.session.add(order_item)
        item_data["book"].stock_quantity -= item_data["quantity"]

    CartItem.query.filter_by(cart_id=cart.cart_id).delete()
    db.session.commit()

    return jsonify({
        "message": "Order created successfully",
        "order": {
            "order_id": order.order_id,
            "status": order.status,
            "delivery_method": order.delivery_method,
            "delivery_fee": float(order.delivery_fee),
            "total_amount": float(order.total_amount),
            "items": [
                {
                    "book_id": item_data["book"].book_id,
                    "title": item_data["book"].title,
                    "quantity": item_data["quantity"],
                    "price_at_purchase": float(item_data["price_at_purchase"]),
                    "item_total": float(item_data["price_at_purchase"]) * item_data["quantity"]
                }
                for item_data in order_items_data
            ]
        }
    }), 201

# ============================================================
# REQUEST A RETURN (CUSTOMER)
# ============================================================

@app.route("/api/returns", methods=["POST"])
@role_required("customer")
def request_return():

    user_id = get_jwt_identity()
    data = request.get_json() or {}

    order_id = data.get("order_id")
    reason = (data.get("reason") or "").strip()

    if not order_id:
        return jsonify({"message": "order_id is required"}), 400

    if not reason or len(reason) < 10:
        return jsonify({
            "message": "Please provide a reason (at least 10 characters)"
        }), 400

    # Find the order and verify ownership
    order = Order.query.filter_by(
        order_id=order_id,
        user_id=int(user_id)
    ).first()

    if not order:
        return jsonify({"message": "Order not found"}), 404

    if order.status != "delivered":
        return jsonify({
            "message": "You can only return delivered orders"
        }), 403

    # Block duplicate requests
    existing = Return.query.filter_by(
        order_id=order_id,
        user_id=int(user_id)
    ).filter(
        Return.status.in_(["pending", "approved"])
    ).first()

    if existing:
        return jsonify({
            "message": "A return request is already open for this order"
        }), 409

    ret = Return(
        order_id=order_id,
        user_id=int(user_id),
        reason=reason,
        status="pending"
    )
    db.session.add(ret)
    db.session.commit()

    return jsonify({
        "message": "Return request submitted",
        "return": {
            "return_id": ret.return_id,
            "order_id": ret.order_id,
            "status": ret.status,
            "reason": ret.reason,
            "created_at": ret.created_at.isoformat() if ret.created_at else None
        }
    }), 201


# ============================================================
# GET MY RETURNS (CUSTOMER)
# ============================================================

@app.route("/api/returns", methods=["GET"])
@role_required("customer")
def get_my_returns():

    user_id = get_jwt_identity()

    returns = (
        Return.query
        .filter_by(user_id=int(user_id))
        .order_by(Return.created_at.desc())
        .all()
    )

    result = []
    for r in returns:
        order = db.session.get(Order, r.order_id)
        result.append({
            "return_id": r.return_id,
            "order_id": r.order_id,
            "order_total": float(order.total_amount) if order else 0,
            "reason": r.reason,
            "status": r.status,
            "admin_note": r.admin_note,
            "resolution": r.resolution,                                 # NEW
            "resolution_chosen_at": (                                   # NEW
                r.resolution_chosen_at.isoformat()
                if r.resolution_chosen_at else None
            ),
            "created_at": r.created_at.isoformat() if r.created_at else None,
            "resolved_at": r.resolved_at.isoformat() if r.resolved_at else None
        })

    return jsonify({"returns": result}), 200

# ============================================================
# GET MY WISHLIST (CUSTOMER) — paginated
# ============================================================

@app.route("/api/wishlist", methods=["GET"])
@role_required("customer")
def get_wishlist():

    user_id = get_jwt_identity()

    page = request.args.get("page", 1, type=int)
    per_page = request.args.get("per_page", 8, type=int)

    if page < 1:
        return jsonify({"message": "Page must be 1 or greater"}), 400
    if per_page < 1 or per_page > 100:
        return jsonify({
            "message": "per_page must be between 1 and 100"
        }), 400

    pagination = (
        Wishlist.query
        .filter_by(user_id=int(user_id))
        .order_by(Wishlist.created_at.desc())
        .paginate(page=page, per_page=per_page, error_out=False)
    )

    wishlist = []
    for w in pagination.items:
        book = db.session.get(Book, w.book_id)
        if not book:
            continue

        wishlist.append({
            "wishlist_id": w.wishlist_id,
            "book": {
                "book_id": book.book_id,
                "title": book.title,
                "author": book.author,
                "price": float(book.price),
                "image_url": book.image_url,
                "stock_quantity": book.stock_quantity,
            },
            "created_at": w.created_at.isoformat() if w.created_at else None
        })

    total = Wishlist.query.filter_by(user_id=int(user_id)).count()

    return jsonify({
        "wishlist": wishlist,
        "total": total,
        "pagination": {
            "page": pagination.page,
            "per_page": pagination.per_page,
            "total_items": pagination.total,
            "total_pages": pagination.pages,
            "has_next": pagination.has_next,
            "has_previous": pagination.has_prev
        }
    }), 200


# ============================================================
# ADD TO WISHLIST (CUSTOMER)
# ============================================================

@app.route("/api/wishlist", methods=["POST"])
@role_required("customer")
def add_to_wishlist():

    user_id = get_jwt_identity()
    data = request.get_json() or {}
    book_id = data.get("book_id")

    if not book_id:
        return jsonify({"message": "book_id is required"}), 400

    book = db.session.get(Book, book_id)
    if not book:
        return jsonify({"message": "Book not found"}), 404

    existing = Wishlist.query.filter_by(
        user_id=int(user_id),
        book_id=book_id
    ).first()

    if existing:
        return jsonify({
            "message": "Already in wishlist",
            "wishlist_id": existing.wishlist_id
        }), 200

    w = Wishlist(user_id=int(user_id), book_id=book_id)
    db.session.add(w)
    db.session.commit()

    return jsonify({
        "message": "Added to wishlist",
        "wishlist_id": w.wishlist_id
    }), 201


# ============================================================
# REMOVE FROM WISHLIST (CUSTOMER)
# ============================================================

@app.route("/api/wishlist/<int:book_id>", methods=["DELETE"])
@role_required("customer")
def remove_from_wishlist(book_id):

    user_id = get_jwt_identity()

    w = Wishlist.query.filter_by(
        user_id=int(user_id),
        book_id=book_id
    ).first()

    if not w:
        return jsonify({"message": "Not in wishlist"}), 404

    db.session.delete(w)
    db.session.commit()

    return jsonify({"message": "Removed from wishlist"}), 200


# ============================================================
# GET WISHLIST BOOK IDs (for heart icons)
# ============================================================

@app.route("/api/wishlist/ids", methods=["GET"])
@role_required("customer")
def get_wishlist_ids():

    user_id = get_jwt_identity()

    rows = Wishlist.query.filter_by(user_id=int(user_id)).all()
    ids = [w.book_id for w in rows]

    return jsonify({"book_ids": ids}), 200
# ============================================================
# ORDERS — GET MY (paginated)
# ============================================================

@app.route("/api/orders", methods=["GET"])
@role_required("customer")
def get_orders():
    user_id = get_jwt_identity()

    page = request.args.get("page", 1, type=int)
    per_page = request.args.get("per_page", 5, type=int)

    if page < 1:
        return jsonify({"message": "Page must be 1 or greater"}), 400
    if per_page < 1 or per_page > 100:
        return jsonify({
            "message": "per_page must be between 1 and 100"
        }), 400

    pagination = (
        Order.query
        .filter_by(user_id=int(user_id))
        .order_by(Order.order_date.desc())
        .paginate(page=page, per_page=per_page, error_out=False)
    )

    order_list = []
    for order in pagination.items:
        order_items = OrderItem.query.filter_by(order_id=order.order_id).all()
        items = []
        for item in order_items:
            book = db.session.get(Book, item.book_id)
            if not book:
                continue

            existing_review = Review.query.filter_by(
                user_id=int(user_id),
                book_id=book.book_id
            ).first()

            items.append({
                "order_item_id": item.order_item_id,
                "book_id": book.book_id,
                "title": book.title,
                "author": book.author,
                "quantity": item.quantity,
                "price_at_purchase": float(item.price_at_purchase),
                "item_total": float(item.price_at_purchase) * item.quantity,
                "reviewed": existing_review is not None
            })

        order_list.append({
            "order_id": order.order_id,
            "order_date": order.order_date.isoformat() if order.order_date else None,
            "status": order.status,
            "delivery_method": order.delivery_method,   # NEW
            "delivery_fee": float(order.delivery_fee),  # NEW
            "total_amount": float(order.total_amount),
            "items": items
        })

    return jsonify({
        "orders": order_list,
        "pagination": {
            "page": pagination.page,
            "per_page": pagination.per_page,
            "total_orders": pagination.total,
            "total_pages": pagination.pages,
            "has_next": pagination.has_next,
            "has_previous": pagination.has_prev
        }
    }), 200

# ============================================================
# CANCEL MY ORDER (CUSTOMER)
# Only allowed before it ships (pending or paid)
# ============================================================

@app.route("/api/orders/<int:order_id>/cancel", methods=["POST"])
@role_required("customer")
def cancel_order(order_id):

    user_id = get_jwt_identity()

    order = Order.query.filter_by(
        order_id=order_id,
        user_id=int(user_id)
    ).first()

    if not order:
        return jsonify({"message": "Order not found"}), 404

    if order.status not in ("pending", "paid"):
        return jsonify({
            "message": f"You cannot cancel an order that is {order.status}"
        }), 403

    open_return = Return.query.filter_by(
        order_id=order_id,
        user_id=int(user_id)
    ).filter(Return.status.in_(["pending", "approved"])).first()

    if open_return:
        return jsonify({
            "message": "This order has an open return request"
        }), 409

    try:
        for item in OrderItem.query.filter_by(order_id=order_id).all():
            book = db.session.get(Book, item.book_id)
            if book:
                book.stock_quantity += item.quantity

        order.status = "cancelled"
        db.session.commit()

        # Send cancellation email
        send_order_cancellation_email(order, cancelled_by="customer")

        return jsonify({
            "message": "Order cancelled",
            "order": {
                "order_id": order.order_id,
                "status": order.status
            }
        }), 200

    except Exception as e:
        db.session.rollback()
        return jsonify({"message": str(e)}), 500
# ============================================================
# STRIPE PAYMENT INTENT
# ============================================================

@app.route("/api/orders/<int:order_id>/create-payment-intent", methods=["POST"])
@role_required("customer")
def create_payment_intent(order_id):
    user_id = get_jwt_identity()
    order = Order.query.filter_by(
        order_id=order_id,
        user_id=int(user_id)
    ).first()
    if not order:
        return jsonify({"message": "Order not found"}), 404

    if order.status != "pending":
        return jsonify({"message": f"Order is already {order.status}"}), 400

    try:
        amount_in_cents = int(float(order.total_amount) * 100)
        intent = stripe.PaymentIntent.create(
            amount=amount_in_cents,
            currency="zar",
            metadata={
                "order_id": order.order_id,
                "user_id": user_id
            },
            automatic_payment_methods={"enabled": True},
        )
        order.stripe_payment_intent_id = intent.id
        db.session.commit()

        return jsonify({
            "clientSecret": intent.client_secret,
            "order_id": order.order_id,
            "amount": amount_in_cents,
        }), 200
    except stripe.error.StripeError as e:
        return jsonify({"message": str(e)}), 500


# ============================================================
# EMAIL HELPERS FOR ORDERS  (no decorators — plain functions)
# ============================================================

def _format_delivery_estimate(order):
    """Returns a friendly delivery estimate string."""
    from datetime import datetime, timedelta

    created = order.order_date or datetime.utcnow()

    if order.delivery_method == "pickup":
        eta_days = 1
        method = "Pickup"
    else:
        eta_days = 5
        method = "Delivery"

    eta = created + timedelta(days=eta_days)
    eta_str = eta.strftime("%A, %d %B %Y")

    return method, eta_str


def send_order_confirmation_email(order):
    """Order confirmation email sent right after payment."""
    user = db.session.get(User, order.user_id)
    if not user or not user.email:
        return

    method, eta = _format_delivery_estimate(order)

    items = OrderItem.query.filter_by(order_id=order.order_id).all()
    rows = [
        ("Order Number", f"#{order.order_id}"),
        ("Status", "Paid "),
        ("Method", method),
        ("Estimated " + method, eta),
    ]
    for it in items:
        book = db.session.get(Book, it.book_id)
        if book:
            rows.append((
                f"{book.title} × {it.quantity}",
                f"R{float(it.price_at_purchase) * it.quantity:.2f}"
            ))
    rows.append(("Total Paid", f"R{float(order.total_amount):.2f}"))

    send_email(
        to_email=user.email,
        subject=f" Order #{order.order_id} confirmed — Book Worm",
        body_text=(
            f"Hi {user.name},\n\n"
            f"Your order #{order.order_id} has been confirmed and paid.\n\n"
            f"{method}: {eta}\n"
            f"Total: R{float(order.total_amount):.2f}\n\n"
            f"Thanks for shopping with Book Worm!\n"
        ),
        body_html=build_email_html(
            title="Order Confirmed",
            subtitle="Thank you for your purchase!",
            intro=(
                f"Hi <strong>{user.name}</strong>, we've received your "
                f"payment and your order is now being prepared."
            ),
            rows=rows,
            highlight=("Estimated " + method, eta),
            cta_text="View my orders",
            cta_url=f"{os.getenv('FRONTEND_URL', 'http://localhost:5173')}/orders",
        )
    )


def send_order_status_email(order, new_status):
    """Sends a status-update email for shipped/delivered."""
    if new_status not in ("shipped", "delivered"):
        return

    user = db.session.get(User, order.user_id)
    if not user or not user.email:
        return

    method, eta = _format_delivery_estimate(order)

    if new_status == "shipped":
        title = "Your Order Has Shipped"
        subtitle = "Your books are on the way "
        subject = f" Order #{order.order_id} shipped — Book Worm"
        intro = (
            f"Hi <strong>{user.name}</strong>, great news — "
            f"order #{order.order_id} has been shipped."
        )
        highlight = (
            ("Estimated " + method, eta)
            if method == "Delivery"
            else ("Ready for " + method, eta)
        )
    else:
        title = "Your Order Was Delivered"
        subtitle = "Enjoy your books! "
        subject = f" Order #{order.order_id} delivered — Book Worm"
        intro = (
            f"Hi <strong>{user.name}</strong>, order #{order.order_id} "
            f"has been delivered. We hope you enjoy your books!"
        )
        highlight = ("Delivered", order.order_date.strftime("%A, %d %B %Y")
                     if order.order_date else "Just now")

    items = OrderItem.query.filter_by(order_id=order.order_id).all()
    rows = [
        ("Order Number", f"#{order.order_id}"),
        ("Status", new_status.capitalize()),
        ("Method", method),
    ]
    for it in items:
        book = db.session.get(Book, it.book_id)
        if book:
            rows.append((f"{book.title} × {it.quantity}", ""))
    rows.append(("Total", f"R{float(order.total_amount):.2f}"))

    send_email(
        to_email=user.email,
        subject=subject,
        body_text=(
            f"Hi {user.name},\n\n"
            f"Order #{order.order_id} — {new_status.capitalize()}\n\n"
            f"Thanks for shopping with Book Worm!\n"
        ),
        body_html=build_email_html(
            title=title,
            subtitle=subtitle,
            intro=intro,
            rows=rows,
            highlight=highlight,
            cta_text="View my orders",
            cta_url=f"{os.getenv('FRONTEND_URL', 'http://localhost:5173')}/orders",
        )
    )


def send_order_cancellation_email(order, cancelled_by="customer"):
    """Sends a cancellation email. cancelled_by: 'customer' or 'admin'."""
    user = db.session.get(User, order.user_id)
    if not user or not user.email:
        return

    method, _ = _format_delivery_estimate(order)

    if cancelled_by == "admin":
        reason = (
            "Your order was cancelled by our team. "
            "If you were charged, a refund will be issued within 5–7 business days."
        )
    else:
        reason = (
            "Your order has been cancelled as requested. "
            "If you were charged, a refund will be issued within 5–7 business days."
        )

    items = OrderItem.query.filter_by(order_id=order.order_id).all()
    rows = [
        ("Order Number", f"#{order.order_id}"),
        ("Status", "Cancelled"),
        ("Method", method),
    ]
    for it in items:
        book = db.session.get(Book, it.book_id)
        if book:
            rows.append((f"{book.title} × {it.quantity}", ""))
    rows.append(("Refund Amount", f"R{float(order.total_amount):.2f}"))

    send_email(
        to_email=user.email,
        subject=f"Order #{order.order_id} cancelled — Book Worm",
        body_text=(
            f"Hi {user.name},\n\n"
            f"Your order #{order.order_id} has been cancelled.\n"
            f"{reason}\n\n"
            f"— Book Worm"
        ),
        body_html=build_email_html(
            title="Order Cancelled",
            subtitle="We're sorry to see this order go",
            intro=f"Hi <strong>{user.name}</strong>, {reason}",
            rows=rows,
            highlight=("Refund Amount", f"R{float(order.total_amount):.2f}"),
            cta_text="Browse books",
            cta_url=f"{os.getenv('FRONTEND_URL', 'http://localhost:5173')}/books",
        )
    )
# ============================================================
# RETURN EMAILS
# ============================================================

def send_return_approved_email(ret, order, pickup_date):
    """Sent when the admin approves a return."""
    user = db.session.get(User, order.user_id)
    if not user or not user.email:
        return

    pickup_str = pickup_date.strftime("%A, %d %B %Y")
    pickup_time = "between 09:00 and 17:00"

    items = OrderItem.query.filter_by(order_id=order.order_id).all()
    rows = [
        ("Order Number", f"#{order.order_id}"),
        ("Return Status", "Approved "),
    ]
    for it in items:
        book = db.session.get(Book, it.book_id)
        if book:
            rows.append((f"{book.title} × {it.quantity}", ""))

    send_email(
        to_email=user.email,
        subject=f"Return approved — Order #{order.order_id}",
        body_text=(
            f"Hi {user.name},\n\n"
            f"Your return request for order #{order.order_id} has been approved.\n\n"
            f"We will collect the book on: {pickup_str} {pickup_time}\n\n"
            f"Please choose your resolution on our website:\n"
            f"{os.getenv('FRONTEND_URL', 'http://localhost:5173')}/orders\n\n"
            f"— Book Worm"
        ),
        body_html=build_email_html(
            title="Return Approved",
            subtitle="We'll pick up your book soon ",
            intro=(
                f"Hi <strong>{user.name}</strong>, your return request for "
                f"order #{order.order_id} has been approved. Our courier "
                f"will collect the book from your delivery address."
            ),
            rows=rows,
            highlight=(
                "Pickup scheduled for",
                f"{pickup_str}, {pickup_time}"
            ),
            cta_text="Choose refund or replacement",
            cta_url=f"{os.getenv('FRONTEND_URL', 'http://localhost:5173')}/orders",
        )
    )


def send_return_rejected_email(ret, order, note):
    """Sent when the admin rejects a return."""
    user = db.session.get(User, order.user_id)
    if not user or not user.email:
        return

    rows = [
        ("Order Number", f"#{order.order_id}"),
        ("Return Status", "Rejected"),
    ]
    if note:
        rows.append(("Admin note", note))

    send_email(
        to_email=user.email,
        subject=f"Return update — Order #{order.order_id}",
        body_text=(
            f"Hi {user.name},\n\n"
            f"Unfortunately your return request for order #{order.order_id} "
            f"was not approved.\n"
            f"{'Reason: ' + note if note else ''}\n\n"
            f"If you have questions, please reply to this email.\n\n"
            f"— Book Worm"
        ),
        body_html=build_email_html(
            title="Return Not Approved",
            subtitle="",
            intro=(
                f"Hi <strong>{user.name}</strong>, we've reviewed your "
                f"return request for order #{order.order_id}. Unfortunately "
                f"we're unable to process this return."
            ),
            rows=rows,
            cta_text="Contact support",
            cta_url=f"{os.getenv('FRONTEND_URL', 'http://localhost:5173')}/profile",
        )
    )


def send_return_resolution_email(ret, order):
    """Sent when the customer picks refund or replacement."""
    user = db.session.get(User, order.user_id)
    if not user or not user.email:
        return

    if ret.resolution == "refund":
        title = "Refund Confirmed"
        subtitle = "Your refund is on its way "
        intro = (
            f"Hi <strong>{user.name}</strong>, we've received your choice. "
            f"A refund of <strong>R{float(order.total_amount):.2f}</strong> "
            f"will be issued within 5–7 business days."
        )
        highlight = ("Refund Amount", f"R{float(order.total_amount):.2f}")
        subject = f"Refund confirmed — Order #{order.order_id}"
    else:
        title = "Replacement Confirmed"
        subtitle = "We'll send a new copy "
        intro = (
            f"Hi <strong>{user.name}</strong>, we've received your choice. "
            f"A replacement copy of your book will be shipped shortly."
        )
        highlight = ("Replacement for", f"Order #{order.order_id}")
        subject = f"Replacement confirmed — Order #{order.order_id}"

    items = OrderItem.query.filter_by(order_id=order.order_id).all()
    rows = [
        ("Order Number", f"#{order.order_id}"),
        ("Resolution", ret.resolution.capitalize()),
    ]
    for it in items:
        book = db.session.get(Book, it.book_id)
        if book:
            rows.append((f"{book.title} × {it.quantity}", ""))

    send_email(
        to_email=user.email,
        subject=subject,
        body_text=(
            f"Hi {user.name},\n\n"
            f"Order #{order.order_id}\n"
            f"Resolution: {ret.resolution.capitalize()}\n\n"
            f"— Book Worm"
        ),
        body_html=build_email_html(
            title=title,
            subtitle=subtitle,
            intro=intro,
            rows=rows,
            highlight=highlight,
            cta_text="View my orders",
            cta_url=f"{os.getenv('FRONTEND_URL', 'http://localhost:5173')}/orders",
        )
    )

# ============================================================
# MARK ORDER AS PAID  (ROUTE)
# ============================================================
@app.route("/api/orders/<int:order_id>/mark-paid", methods=["POST"])
@role_required("customer")
def mark_order_paid(order_id):

    user_id = get_jwt_identity()

    order = Order.query.filter_by(
        order_id=order_id,
        user_id=int(user_id)
    ).first()

    if not order:
        return jsonify({"message": "Order not found"}), 404

    # Flip to paid if still pending
    if order.status == "pending":
        order.status = "paid"

    # Send the email only once per order
    if not order.confirmation_email_sent:
        order.confirmation_email_sent = True
        db.session.commit()
        send_order_confirmation_email(order)
    else:
        db.session.commit()

    return jsonify({
        "message": "Order marked as paid",
        "status": order.status
    }), 200

# ============================================================
# STRIPE WEBHOOK
# Called by Stripe when payment succeeds.
# NO JWT — Stripe cannot send our token.
# ============================================================

@app.route("/api/webhooks/stripe", methods=["POST"])
def stripe_webhook():

    payload = request.get_data(as_text=True)
    sig_header = request.headers.get("Stripe-Signature")
    webhook_secret = os.getenv("STRIPE_WEBHOOK_SECRET")

    try:
        event = stripe.Webhook.construct_event(
            payload, sig_header, webhook_secret
        )
    except ValueError:
        return jsonify({"message": "Invalid payload"}), 400
    except stripe.error.SignatureVerificationError:
        return jsonify({"message": "Invalid signature"}), 400

    if event["type"] == "payment_intent.succeeded":
        intent = event["data"]["object"]
        order_id = intent["metadata"].get("order_id")

        if order_id:
            order = db.session.get(Order, int(order_id))

            if order:
                # Flip to paid if still pending
                if order.status == "pending":
                    order.status = "paid"

                # Send the email only once per order
                if not order.confirmation_email_sent:
                    order.confirmation_email_sent = True
                    db.session.commit()
                    print(f"[STRIPE] Order #{order_id} marked as PAID")
                    send_order_confirmation_email(order)
                else:
                    db.session.commit()

    elif event["type"] == "payment_intent.payment_failed":
        intent = event["data"]["object"]
        order_id = intent["metadata"].get("order_id")
        print(f"[STRIPE] Payment failed for order #{order_id}")

    return jsonify({"received": True}), 200

# ============================================================
# ADMIN ORDERS (paginated)
# ============================================================

@app.route("/api/admin/orders", methods=["GET"])
@role_required("admin")
def get_all_orders():
    page = request.args.get("page", 1, type=int)
    per_page = request.args.get("per_page", 5, type=int)

    if page < 1:
        return jsonify({"message": "Page must be 1 or greater"}), 400
    if per_page < 1 or per_page > 100:
        return jsonify({
            "message": "per_page must be between 1 and 100"
        }), 400

    pagination = (
        Order.query
        .order_by(Order.order_date.desc())
        .paginate(page=page, per_page=per_page, error_out=False)
    )

    order_list = []
    for order in pagination.items:
        customer = db.session.get(User, order.user_id)
        order_items = OrderItem.query.filter_by(order_id=order.order_id).all()

        items = []
        for item in order_items:
            book = db.session.get(Book, item.book_id)
            if not book:
                continue
            items.append({
                "order_item_id": item.order_item_id,
                "book_id": book.book_id,
                "title": book.title,
                "author": book.author,
                "quantity": item.quantity,
                "price_at_purchase": float(item.price_at_purchase),
                "item_total": float(item.price_at_purchase) * item.quantity
            })

        order_list.append({
            "order_id": order.order_id,
            "user_id": order.user_id,
            "customer_name": (
                f"{customer.name} {customer.surname}"
                if customer else "Unknown"
            ),
            "customer_email": customer.email if customer else "",
            "order_date": order.order_date.isoformat() if order.order_date else None,
            "status": order.status,
            "total_amount": float(order.total_amount),
            "items": items
        })

    return jsonify({
        "orders": order_list,
        "pagination": {
            "page": pagination.page,
            "per_page": pagination.per_page,
            "total_orders": pagination.total,
            "total_pages": pagination.pages,
            "has_next": pagination.has_next,
            "has_previous": pagination.has_prev
        }
    }), 200

# ============================================================
# ADMIN ANALYTICS / SALES DASHBOARD
# Query params:
#   days=30  (7, 30, 90, 365)
# ============================================================

@app.route("/api/admin/analytics", methods=["GET"])
@role_required("admin")
def get_analytics():

    from datetime import datetime, timedelta
    from sqlalchemy import func

    days = request.args.get("days", 30, type=int)
    if days not in (7, 30, 90, 365):
        days = 30

    now = datetime.utcnow()
    since = now - timedelta(days=days)

    # ---- 1. REVENUE + ORDER STATS ----
    # Count only paid orders (exclude pending, cancelled, returned)
    paid_statuses = ("paid", "processing", "shipped", "delivered")

    orders_in_range = (
        Order.query
        .filter(
            Order.order_date >= since,
            Order.status.in_(paid_statuses)
        )
        .all()
    )

    total_revenue = sum(float(o.total_amount) for o in orders_in_range)
    total_orders = len(orders_in_range)
    total_units = (
        db.session.query(func.sum(OrderItem.quantity))
        .join(Order, Order.order_id == OrderItem.order_id)
        .filter(
            Order.order_date >= since,
            Order.status.in_(paid_statuses)
        )
        .scalar()
    ) or 0

    avg_order_value = (
        round(total_revenue / total_orders, 2)
        if total_orders else 0
    )

    # ---- 2. REVENUE OVER TIME (daily buckets) ----
    revenue_by_day = {}
    for o in orders_in_range:
        day = o.order_date.strftime("%Y-%m-%d")
        revenue_by_day[day] = revenue_by_day.get(day, 0) + float(o.total_amount)

    # Fill in missing days with 0 so the chart is continuous
    daily_series = []
    cursor = since
    end = now + timedelta(days=1)
    while cursor <= end:
        key = cursor.strftime("%Y-%m-%d")
        daily_series.append({
            "date": key,
            "revenue": round(revenue_by_day.get(key, 0), 2)
        })
        cursor += timedelta(days=1)

    # ---- 3. ORDERS BY STATUS ----
    status_counts = {}
    for s in ("pending", "paid", "processing",
              "shipped", "delivered", "cancelled", "returned"):
        status_counts[s] = (
            Order.query
            .filter(
                Order.order_date >= since,
                Order.status == s
            )
            .count()
        )

    # ---- 4. TOP 5 SELLING BOOKS ----
    top_books_raw = (
        db.session.query(
            Book.book_id,
            Book.title,
            Book.author,
            Book.image_url,
            func.sum(OrderItem.quantity).label("units_sold"),
            func.sum(OrderItem.quantity * OrderItem.price_at_purchase)
                .label("revenue")
        )
        .join(OrderItem, OrderItem.book_id == Book.book_id)
        .join(Order, Order.order_id == OrderItem.order_id)
        .filter(
            Order.order_date >= since,
            Order.status.in_(paid_statuses)
        )
        .group_by(Book.book_id)
        .order_by(func.sum(OrderItem.quantity).desc())
        .limit(5)
        .all()
    )

    top_books = []
    for b in top_books_raw:
        top_books.append({
            "book_id": b.book_id,
            "title": b.title,
            "author": b.author,
            "image_url": b.image_url,
            "units_sold": int(b.units_sold or 0),
            "revenue": round(float(b.revenue or 0), 2)
        })

    # ---- 5. REVENUE BY CATEGORY ----
    cat_rows = (
        db.session.query(
            Category.name,
            func.sum(OrderItem.quantity * OrderItem.price_at_purchase)
                .label("revenue"),
            func.sum(OrderItem.quantity).label("units")
        )
        .select_from(OrderItem)
        .join(Order, Order.order_id == OrderItem.order_id)
        .join(Book, Book.book_id == OrderItem.book_id)
        .join(Category, Category.category_id == Book.category_id)
        .filter(
            Order.order_date >= since,
            Order.status.in_(paid_statuses)
        )
        .group_by(Category.category_id)
        .order_by(func.sum(OrderItem.quantity * OrderItem.price_at_purchase).desc())
        .all()
    )

    categories = [
        {
            "name": r.name,
            "revenue": round(float(r.revenue or 0), 2),
            "units": int(r.units or 0)
        }
        for r in cat_rows
    ]

    # ---- 6. TOP 5 CUSTOMERS ----
    top_customers_raw = (
        db.session.query(
            User.user_id,
            User.name,
            User.surname,
            User.email,
            func.count(Order.order_id).label("orders_count"),
            func.sum(Order.total_amount).label("total_spent")
        )
        .join(Order, Order.user_id == User.user_id)
        .filter(
            Order.order_date >= since,
            Order.status.in_(paid_statuses)
        )
        .group_by(User.user_id)
        .order_by(func.sum(Order.total_amount).desc())
        .limit(5)
        .all()
    )

    top_customers = [
        {
            "user_id": c.user_id,
            "name": f"{c.name} {c.surname}",
            "email": c.email,
            "orders_count": int(c.orders_count or 0),
            "total_spent": round(float(c.total_spent or 0), 2)
        }
        for c in top_customers_raw
    ]

    # ---- 7. DELIVERY METHOD BREAKDOWN ----
    delivery_count = (
        Order.query
        .filter(
            Order.order_date >= since,
            Order.status.in_(paid_statuses),
            Order.delivery_method == "delivery"
        )
        .count()
    )
    pickup_count = (
        Order.query
        .filter(
            Order.order_date >= since,
            Order.status.in_(paid_statuses),
            Order.delivery_method == "pickup"
        )
        .count()
    )

    # ---- 8. LOW STOCK WARNINGS ----
    low_stock = (
        Book.query
        .filter(Book.stock_quantity <= 3)
        .order_by(Book.stock_quantity.asc())
        .limit(10)
        .all()
    )

    low_stock_list = [
        {
            "book_id": b.book_id,
            "title": b.title,
            "stock_quantity": b.stock_quantity
        }
        for b in low_stock
    ]

    return jsonify({
        "range_days": days,
        "summary": {
            "total_revenue": round(total_revenue, 2),
            "total_orders": total_orders,
            "total_units": int(total_units),
            "avg_order_value": avg_order_value
        },
        "daily_revenue": daily_series,
        "orders_by_status": status_counts,
        "top_books": top_books,
        "categories": categories,
        "top_customers": top_customers,
        "delivery_breakdown": {
            "delivery": delivery_count,
            "pickup": pickup_count
        },
        "low_stock": low_stock_list
    }), 200

# ============================================================
# GET ALL CUSTOMERS (ADMIN)
# ============================================================

@app.route("/api/admin/customers", methods=["GET"])
@role_required("admin")
def get_all_customers():

    page = request.args.get("page", 1, type=int)
    per_page = request.args.get("per_page", 10, type=int)
    search = request.args.get("search", "").strip()

    if page < 1:
        return jsonify({"message": "Page must be 1 or greater"}), 400
    if per_page < 1 or per_page > 100:
        return jsonify({
            "message": "per_page must be between 1 and 100"
        }), 400

    query = User.query.filter(User.role == "customer")

    if search:
        pattern = f"%{search}%"
        query = query.filter(
            db.or_(
                User.name.ilike(pattern),
                User.surname.ilike(pattern),
                User.email.ilike(pattern)
            )
        )

    pagination = (
        query
        .order_by(User.user_id.desc())
        .paginate(page=page, per_page=per_page, error_out=False)
    )

    customers = []
    for u in pagination.items:
        # Count orders and reviews for context
        order_count = Order.query.filter_by(user_id=u.user_id).count()
        review_count = Review.query.filter_by(user_id=u.user_id).count()

        customers.append({
            "user_id": u.user_id,
            "name": u.name,
            "surname": u.surname,
            "email": u.email,
            "role": u.role,
            "order_count": order_count,
            "review_count": review_count
        })

    total_customers = User.query.filter(User.role == "customer").count()

    return jsonify({
        "customers": customers,
        "pagination": {
            "page": pagination.page,
            "per_page": pagination.per_page,
            "total_customers": pagination.total,
            "total_pages": pagination.pages,
            "has_next": pagination.has_next,
            "has_previous": pagination.has_prev
        },
        "total": total_customers
    }), 200

# ============================================================
# DELETE A CUSTOMER (ADMIN)
# Detaches their orders, then removes their cart, reviews,
# information, and password resets, then the user.
# ============================================================

@app.route("/api/admin/customers/<int:user_id>", methods=["DELETE"])
@role_required("admin")
def delete_customer(user_id):

    current_admin_id = int(get_jwt_identity())

    if user_id == current_admin_id:
        return jsonify({
            "message": "You cannot delete your own account"
        }), 400

    user = db.session.get(User, user_id)
    if not user:
        return jsonify({"message": "Customer not found"}), 404

    if user.role != "customer":
        return jsonify({
            "message": "Only customer accounts can be deleted here"
        }), 403

    try:
        # 1. Detach their orders (keep for accounting, remove user link)
        #    This sets orders.user_id = NULL
        for order in Order.query.filter_by(user_id=user.user_id).all():
            order.user_id = None
        db.session.flush()

        # 2. Delete cart items + cart
        cart = Cart.query.filter_by(user_id=user.user_id).first()
        if cart:
            CartItem.query.filter_by(cart_id=cart.cart_id).delete()
            db.session.delete(cart)
            db.session.flush()

        # 3. Delete reviews
        Review.query.filter_by(user_id=user.user_id).delete()
        db.session.flush()

        # 4. Delete information (address)
        Information.query.filter_by(user_id=user.user_id).delete()
        db.session.flush()

        # 5. Delete password resets
        PasswordReset.query.filter_by(user_id=user.user_id).delete()
        db.session.flush()

        # 6. Delete the user
        db.session.delete(user)
        db.session.commit()

        return jsonify({
            "message": f"Customer {user.name} {user.surname} deleted"
        }), 200

    except Exception as e:
        db.session.rollback()
        import traceback
        traceback.print_exc()
        return jsonify({
            "message": f"Failed to delete customer: {str(e)}"
        }), 500

# ============================================================
# DELETE MY OWN ACCOUNT (CUSTOMER)
# ============================================================

@app.route("/api/profile/delete-account", methods=["DELETE"])
@jwt_required()
def delete_my_account():

    user_id = get_jwt_identity()
    user = db.session.get(User, int(user_id))

    if not user:
        return jsonify({"message": "User not found"}), 404

    # Admins should not use this endpoint
    if user.role != "customer":
        return jsonify({
            "message": "Admins cannot delete their account here"
        }), 403

    try:
        # Detach their orders (keep for accounting)
        for order in Order.query.filter_by(user_id=user.user_id).all():
            order.user_id = None
        db.session.flush()

        # Delete cart items + cart
        cart = Cart.query.filter_by(user_id=user.user_id).first()
        if cart:
            CartItem.query.filter_by(cart_id=cart.cart_id).delete()
            db.session.delete(cart)
            db.session.flush()

        # Delete reviews
        Review.query.filter_by(user_id=user.user_id).delete()
        db.session.flush()

        # Delete wishlist
        Wishlist.query.filter_by(user_id=user.user_id).delete()
        db.session.flush()

        # Delete information
        Information.query.filter_by(user_id=user.user_id).delete()
        db.session.flush()

        # Delete password resets
        PasswordReset.query.filter_by(user_id=user.user_id).delete()
        db.session.flush()

        # Delete the user
        db.session.delete(user)
        db.session.commit()

        return jsonify({
            "message": "Your account has been deleted"
        }), 200

    except Exception as e:
        db.session.rollback()
        import traceback
        traceback.print_exc()
        return jsonify({
            "message": f"Failed to delete account: {str(e)}"
        }), 500

# ============================================================
# UPDATE ORDER STATUS (ADMIN) + send email for shipped/delivered
# ============================================================

@app.route("/api/admin/orders/<int:order_id>/status", methods=["PUT"])
@role_required("admin")
def update_order_status(order_id):

    order = db.session.get(Order, order_id)
    if not order:
        return jsonify({"message": "Order not found"}), 404

    data = request.get_json() or {}
    new_status = data.get("status")

    allowed_statuses = [
        "pending", "paid", "processing",
        "shipped", "delivered", "cancelled"
    ]

    if new_status not in allowed_statuses:
        return jsonify({
            "message": f"Status must be one of: {', '.join(allowed_statuses)}"
        }), 400

    old_status = order.status
    order.status = new_status
    db.session.commit()

    if new_status != old_status:
        if new_status in ("shipped", "delivered"):
            send_order_status_email(order, new_status)
        elif new_status == "cancelled":
            send_order_cancellation_email(order, cancelled_by="admin")

    return jsonify({
        "message": "Order status updated",
        "order": {
            "order_id": order.order_id,
            "status": order.status
        }
    }), 200
# ============================================================
# GET ALL REVIEWS (ADMIN)
# ?status=pending | approved | rejected | all  (default: pending)
# ============================================================

@app.route("/api/admin/reviews", methods=["GET"])
@role_required("admin")
def get_all_reviews():

    status = request.args.get("status", "pending")
    page = request.args.get("page", 1, type=int)
    per_page = request.args.get("per_page", 10, type=int)

    if page < 1:
        return jsonify({"message": "Page must be 1 or greater"}), 400
    if per_page < 1 or per_page > 100:
        return jsonify({
            "message": "per_page must be between 1 and 100"
        }), 400

    query = Review.query

    # Filter by status
    if status == "pending":
        # Pending = not yet approved. We don't have a rejected column,
        # so we use "is_approved=False" as pending/rejected combined.
        query = query.filter(Review.is_approved == False)

    elif status == "approved":
        query = query.filter(Review.is_approved == True)

    # For "all" we don't filter

    pagination = (
        query
        .order_by(Review.created_at.desc())
        .paginate(page=page, per_page=per_page, error_out=False)
    )

    review_list = []

    for r in pagination.items:
        reviewer = db.session.get(User, r.user_id)
        book = db.session.get(Book, r.book_id)

        review_list.append({
            "review_id": r.review_id,
            "rating": r.rating,
            "comment": r.comment,
            "is_approved": r.is_approved,
            "created_at": r.created_at.isoformat() if r.created_at else None,
            "approved_at": r.approved_at.isoformat() if r.approved_at else None,
            "reviewer_name": (
                f"{reviewer.name} {reviewer.surname}"
                if reviewer else "Anonymous"
            ),
            "reviewer_email": reviewer.email if reviewer else "",
            "book_id": r.book_id,
            "book_title": book.title if book else "(deleted)",
            "book_author": book.author if book else ""
        })

    # Also return counts across all statuses for the tabs
    total_pending = Review.query.filter(Review.is_approved == False).count()
    total_approved = Review.query.filter(Review.is_approved == True).count()
    total_all = Review.query.count()

    return jsonify({
        "reviews": review_list,
        "pagination": {
            "page": pagination.page,
            "per_page": pagination.per_page,
            "total_reviews": pagination.total,
            "total_pages": pagination.pages,
            "has_next": pagination.has_next,
            "has_previous": pagination.has_prev
        },
        "counts": {
            "pending": total_pending,
            "approved": total_approved,
            "all": total_all
        }
    }), 200


# ============================================================
# APPROVE A REVIEW (ADMIN)
# ============================================================

@app.route("/api/admin/reviews/<int:review_id>/approve", methods=["PUT"])
@role_required("admin")
def approve_review(review_id):

    from datetime import datetime

    review = db.session.get(Review, review_id)
    if not review:
        return jsonify({"message": "Review not found"}), 404

    review.is_approved = True
    review.approved_at = datetime.utcnow()
    db.session.commit()

    return jsonify({
        "message": "Review approved",
        "review": {
            "review_id": review.review_id,
            "is_approved": True,
            "approved_at": review.approved_at.isoformat()
        }
    }), 200


# ============================================================
# REJECT / UNAPPROVE A REVIEW (ADMIN)
# ============================================================

@app.route("/api/admin/reviews/<int:review_id>/reject", methods=["PUT"])
@role_required("admin")
def reject_review(review_id):

    review = db.session.get(Review, review_id)
    if not review:
        return jsonify({"message": "Review not found"}), 404

    review.is_approved = False
    review.approved_at = None
    db.session.commit()

    return jsonify({
        "message": "Review rejected",
        "review": {
            "review_id": review.review_id,
            "is_approved": False
        }
    }), 200


# ============================================================
# DELETE A REVIEW (ADMIN)
# ============================================================

@app.route("/api/admin/reviews/<int:review_id>", methods=["DELETE"])
@role_required("admin")
def delete_review_admin(review_id):

    review = db.session.get(Review, review_id)
    if not review:
        return jsonify({"message": "Review not found"}), 404

    db.session.delete(review)
    db.session.commit()

    return jsonify({"message": "Review deleted"}), 200

# ============================================================
# SUBMIT APP FEEDBACK (PUBLIC — logged-in or not)
# ============================================================

@app.route("/api/feedback", methods=["POST"])
def submit_feedback():

    data = request.get_json() or {}

    rating = data.get("rating")
    comment = (data.get("comment") or "").strip()
    name = (data.get("name") or "").strip()
    email = (data.get("email") or "").strip().lower()

    if rating is None or not isinstance(rating, int) or rating < 1 or rating > 5:
        return jsonify({"message": "Rating must be an integer 1..5"}), 400

    # Optionally associate with the logged-in user
    user_id = None
    try:
        from flask_jwt_extended import verify_jwt_in_request
        verify_jwt_in_request(optional=True)
        identity = get_jwt_identity()
        if identity:
            user_id = int(identity)
    except Exception:
        pass  # anonymous feedback is fine

    fb = AppFeedback(
        user_id=user_id,
        name=name or None,
        email=email or None,
        rating=rating,
        comment=comment or None,
        is_visible=True
    )
    db.session.add(fb)
    db.session.commit()

    return jsonify({
        "message": "Thank you for your feedback!",
        "feedback_id": fb.feedback_id
    }), 201


# ============================================================
# GET PUBLIC FEEDBACK STATS (no comments — only aggregate)
# ============================================================

@app.route("/api/feedback", methods=["GET"])
def get_feedback():

    rows = AppFeedback.query.filter_by(is_visible=True).all()
    total = len(rows)
    avg = sum(r.rating for r in rows) / total if total else 0

    # Count per star rating
    counts = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0}
    for r in rows:
        counts[r.rating] = counts.get(r.rating, 0) + 1

    return jsonify({
        "total": total,
        "average_rating": round(avg, 2),
        "counts": counts
    }), 200


# ============================================================
# GET ALL FEEDBACK (ADMIN)
# ============================================================

@app.route("/api/admin/feedback", methods=["GET"])
@role_required("admin")
def get_all_feedback():

    page = request.args.get("page", 1, type=int)
    per_page = request.args.get("per_page", 10, type=int)
    rating_filter = request.args.get("rating", type=int)

    if page < 1:
        return jsonify({"message": "Page must be 1 or greater"}), 400
    if per_page < 1 or per_page > 100:
        return jsonify({
            "message": "per_page must be between 1 and 100"
        }), 400

    query = AppFeedback.query

    if rating_filter and rating_filter in (1, 2, 3, 4, 5):
        query = query.filter(AppFeedback.rating == rating_filter)

    pagination = (
        query
        .order_by(AppFeedback.created_at.desc())
        .paginate(page=page, per_page=per_page, error_out=False)
    )

    feedback_list = []
    for f in pagination.items:
        # If registered user, use their name; else use the submitted name
        user = db.session.get(User, f.user_id) if f.user_id else None

        feedback_list.append({
            "feedback_id": f.feedback_id,
            "rating": f.rating,
            "comment": f.comment,
            "name": f.name or (f"{user.name} {user.surname}" if user else "Anonymous"),
            "email": f.email or (user.email if user else ""),
            "user_id": f.user_id,
            "is_visible": f.is_visible,
            "created_at": f.created_at.isoformat() if f.created_at else None
        })

    # Overall stats
    all_rows = AppFeedback.query.all()
    total = len(all_rows)
    avg = sum(r.rating for r in all_rows) / total if total else 0

    counts = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0}
    for r in all_rows:
        counts[r.rating] = counts.get(r.rating, 0) + 1

    return jsonify({
        "feedback": feedback_list,
        "pagination": {
            "page": pagination.page,
            "per_page": pagination.per_page,
            "total_feedback": pagination.total,
            "total_pages": pagination.pages,
            "has_next": pagination.has_next,
            "has_previous": pagination.has_prev
        },
        "stats": {
            "total": total,
            "average_rating": round(avg, 2),
            "counts": counts
        }
    }), 200


# ============================================================
# DELETE FEEDBACK (ADMIN)
# ============================================================

@app.route("/api/admin/feedback/<int:feedback_id>", methods=["DELETE"])
@role_required("admin")
def delete_feedback(feedback_id):

    fb = db.session.get(AppFeedback, feedback_id)
    if not fb:
        return jsonify({"message": "Feedback not found"}), 404

    db.session.delete(fb)
    db.session.commit()
    return jsonify({"message": "Feedback deleted"}), 200


# ============================================================
# TOGGLE FEEDBACK VISIBILITY (ADMIN)
# ============================================================

@app.route("/api/admin/feedback/<int:feedback_id>/visibility", methods=["PUT"])
@role_required("admin")
def toggle_feedback_visibility(feedback_id):

    fb = db.session.get(AppFeedback, feedback_id)
    if not fb:
        return jsonify({"message": "Feedback not found"}), 404

    fb.is_visible = not fb.is_visible
    db.session.commit()

    return jsonify({
        "message": f"Feedback {'visible' if fb.is_visible else 'hidden'}",
        "is_visible": fb.is_visible
    }), 200

# ============================================================
# REQUEST A BOOK NOT IN CATALOG (CUSTOMER)
# ============================================================

@app.route("/api/book-requests", methods=["POST"])
@role_required("customer")
def create_book_request():

    user_id = get_jwt_identity()
    data = request.get_json() or {}

    title = (data.get("title") or "").strip()
    author = (data.get("author") or "").strip()
    isbn = (data.get("isbn") or "").strip()
    notes = (data.get("notes") or "").strip()

    if not title:
        return jsonify({"message": "Book title is required"}), 400

    # Prevent duplicate open requests from the same user
    existing = BookRequest.query.filter_by(
        user_id=int(user_id),
        title=title
    ).filter(
        BookRequest.status.in_(["pending", "in_progress"])
    ).first()

    if existing:
        return jsonify({
            "message": "You already requested this book"
        }), 409

    req = BookRequest(
        user_id=int(user_id),
        title=title,
        author=author or None,
        isbn=isbn or None,
        notes=notes or None,
        status="pending"
    )
    db.session.add(req)
    db.session.commit()

    return jsonify({
        "message": "Book request submitted. We'll let you know!",
        "request": {
            "request_id": req.request_id,
            "title": req.title,
            "status": req.status
        }
    }), 201


# ============================================================
# GET MY BOOK REQUESTS (CUSTOMER)
# ============================================================

@app.route("/api/book-requests", methods=["GET"])
@role_required("customer")
def get_my_book_requests():

    user_id = get_jwt_identity()

    rows = (
        BookRequest.query
        .filter_by(user_id=int(user_id))
        .order_by(BookRequest.created_at.desc())
        .all()
    )

    out = [{
        "request_id": r.request_id,
        "title": r.title,
        "author": r.author,
        "status": r.status,
        "admin_note": r.admin_note,
        "created_at": r.created_at.isoformat() if r.created_at else None,
        "resolved_at": r.resolved_at.isoformat() if r.resolved_at else None
    } for r in rows]

    return jsonify({"requests": out}), 200


# ============================================================
# GET ALL BOOK REQUESTS (ADMIN)
# ============================================================

@app.route("/api/admin/book-requests", methods=["GET"])
@role_required("admin")
def get_all_book_requests():

    status = request.args.get("status", "pending")
    page = request.args.get("page", 1, type=int)
    per_page = request.args.get("per_page", 10, type=int)

    if page < 1:
        return jsonify({"message": "Page must be 1 or greater"}), 400
    if per_page < 1 or per_page > 100:
        return jsonify({
            "message": "per_page must be between 1 and 100"
        }), 400

    query = BookRequest.query
    if status in ("pending", "in_progress", "added", "rejected"):
        query = query.filter(BookRequest.status == status)

    pagination = (
        query
        .order_by(BookRequest.created_at.desc())
        .paginate(page=page, per_page=per_page, error_out=False)
    )

    requests_out = []
    for r in pagination.items:
        customer = db.session.get(User, r.user_id)
        requests_out.append({
            "request_id": r.request_id,
            "title": r.title,
            "author": r.author,
            "isbn": r.isbn,
            "notes": r.notes,
            "status": r.status,
            "admin_note": r.admin_note,
            "created_at": r.created_at.isoformat() if r.created_at else None,
            "resolved_at": r.resolved_at.isoformat() if r.resolved_at else None,
            "customer_name": (
                f"{customer.name} {customer.surname}"
                if customer else "Unknown"
            ),
            "customer_email": customer.email if customer else ""
        })

    counts = {
        "pending": BookRequest.query.filter_by(status="pending").count(),
        "in_progress": BookRequest.query.filter_by(status="in_progress").count(),
        "added": BookRequest.query.filter_by(status="added").count(),
        "rejected": BookRequest.query.filter_by(status="rejected").count(),
        "all": BookRequest.query.count()
    }

    return jsonify({
        "requests": requests_out,
        "pagination": {
            "page": pagination.page,
            "per_page": pagination.per_page,
            "total_requests": pagination.total,
            "total_pages": pagination.pages,
            "has_next": pagination.has_next,
            "has_previous": pagination.has_prev
        },
        "counts": counts
    }), 200


# ============================================================
# UPDATE BOOK REQUEST STATUS (ADMIN)
# ============================================================

@app.route("/api/admin/book-requests/<int:request_id>", methods=["PUT"])
@role_required("admin")
def update_book_request(request_id):

    from datetime import datetime

    req = db.session.get(BookRequest, request_id)
    if not req:
        return jsonify({"message": "Request not found"}), 404

    data = request.get_json() or {}
    new_status = data.get("status")
    admin_note = (data.get("admin_note") or "").strip()

    allowed = ["pending", "in_progress", "added", "rejected"]
    if new_status not in allowed:
        return jsonify({
            "message": f"Status must be one of: {', '.join(allowed)}"
        }), 400

    req.status = new_status
    req.admin_note = admin_note or None

    if new_status in ("added", "rejected"):
        req.resolved_at = datetime.utcnow()

    db.session.commit()

    # Send email to the customer
    try:
        send_book_request_status_email(req, new_status, admin_note)
    except Exception as e:
        print(f"[MAIL ERROR] Book request email failed: {e}")

    return jsonify({
        "message": "Request updated",
        "request": {
            "request_id": req.request_id,
            "status": req.status
        }
    }), 200

# ============================================================
# PROFILE INFORMATION
# ============================================================

@app.route("/api/profile/information", methods=["GET"])
@jwt_required()
def get_information():
    user_id = get_jwt_identity()
    info = Information.query.filter_by(user_id=int(user_id)).first()

    if not info:
        return jsonify({
            "address_id": None,
            "user_id": int(user_id),
            "phone_num": "",
            "street": "",
            "city": "",
            "province": "",
            "postal_code": "",
            "country": "",
            "is_default": True
        }), 200

    return jsonify({
        "address_id": info.address_id,
        "user_id": info.user_id,
        "phone_num": info.phone_num,
        "street": info.street,
        "city": info.city,
        "province": info.province,
        "postal_code": info.postal_code,
        "country": info.country,
        "is_default": info.is_default
    }), 200

@app.route("/api/profile/information", methods=["PUT"])
@jwt_required()
def upsert_information():
    user_id = get_jwt_identity()
    data = request.get_json() or {}

    info = Information.query.filter_by(user_id=int(user_id)).first()
    if not info:
        info = Information(user_id=int(user_id))
        db.session.add(info)

    if "phone_num" in data:
        info.phone_num = data["phone_num"]
    if "street" in data:
        info.street = data["street"]
    if "city" in data:
        info.city = data["city"]
    if "province" in data:
        info.province = data["province"]
    if "postal_code" in data:
        info.postal_code = data["postal_code"]
    if "country" in data:
        info.country = data["country"]
    if "is_default" in data:
        info.is_default = bool(data["is_default"])

    db.session.commit()

    return jsonify({
        "message": "Information saved successfully",
        "information": {
            "address_id": info.address_id,
            "user_id": info.user_id,
            "phone_num": info.phone_num,
            "street": info.street,
            "city": info.city,
            "province": info.province,
            "postal_code": info.postal_code,
            "country": info.country,
            "is_default": info.is_default
        }
    }), 200

# ============================================================
# REVIEWS
# ============================================================

@app.route("/api/reviews", methods=["POST"])
@role_required("customer")
def create_review():
    user_id = get_jwt_identity()
    data = request.get_json() or {}

    book_id = data.get("book_id")
    order_id = data.get("order_id")
    rating = data.get("rating")
    comment = (data.get("comment") or "").strip()

    if not book_id or not order_id or rating is None:
        return jsonify({
            "message": "book_id, order_id and rating are required"
        }), 400

    if not isinstance(rating, int) or rating < 1 or rating > 5:
        return jsonify({
            "message": "Rating must be an integer between 1 and 5"
        }), 400

    order = Order.query.filter_by(
        order_id=order_id,
        user_id=int(user_id)
    ).first()
    if not order:
        return jsonify({"message": "Order not found"}), 404

    if order.status != "delivered":
        return jsonify({
            "message": "You can only review books from delivered orders"
        }), 403

    order_item = OrderItem.query.filter_by(
        order_id=order_id,
        book_id=book_id
    ).first()
    if not order_item:
        return jsonify({"message": "This book is not in that order"}), 400

    existing = Review.query.filter_by(
        user_id=int(user_id),
        book_id=book_id
    ).first()
    if existing:
        return jsonify({"message": "You already reviewed this book"}), 409

    review = Review(
        user_id=int(user_id),
        book_id=book_id,
        order_id=order_id,
        rating=rating,
        comment=comment
    )
    db.session.add(review)
    db.session.commit()

    return jsonify({
        "message": "Review submitted successfully",
        "review": {
            "review_id": review.review_id,
            "book_id": review.book_id,
            "rating": review.rating,
            "comment": review.comment,
            "created_at": review.created_at.isoformat() if review.created_at else None
        }
    }), 201

@app.route("/api/books/<int:book_id>/reviews", methods=["GET"])
def get_book_reviews(book_id):
    book = db.session.get(Book, book_id)
    if not book:
        return jsonify({"message": "Book not found"}), 404

    reviews = Review.query.filter_by(
    book_id=book_id,
    is_approved=True
    ).order_by(Review.approved_at.desc()).all()

    review_list = []
    for r in reviews:
        reviewer = db.session.get(User, r.user_id)
        review_list.append({
            "review_id": r.review_id,
            "rating": r.rating,
            "comment": r.comment,
            "created_at": r.created_at.isoformat() if r.created_at else None,
            "reviewer_name": (
                f"{reviewer.name} {reviewer.surname[0]}."
                if reviewer else "Anonymous"
            )
        })

    avg = (
        sum(r["rating"] for r in review_list) / len(review_list)
        if review_list else 0
    )

    return jsonify({
        "book_id": book_id,
        "average_rating": round(avg, 2),
        "total_reviews": len(review_list),
        "reviews": review_list
    }), 200

@app.route("/api/books/<int:book_id>/can-review", methods=["GET"])
@role_required("customer")
def can_review_book(book_id):
    user_id = get_jwt_identity()

    existing = Review.query.filter_by(
        user_id=int(user_id),
        book_id=book_id
    ).first()
    if existing:
        return jsonify({
            "can_review": False,
            "reason": "already_reviewed",
            "review_id": existing.review_id
        }), 200

    delivered_order = (
        db.session.query(OrderItem, Order)
        .join(Order, Order.order_id == OrderItem.order_id)
        .filter(
            Order.user_id == int(user_id),
            Order.status == "delivered",
            OrderItem.book_id == book_id
        )
        .first()
    )
    if not delivered_order:
        return jsonify({
            "can_review": False,
            "reason": "no_delivered_order"
        }), 200

    order_item, order = delivered_order
    return jsonify({"can_review": True, "order_id": order.order_id}), 200

# ============================================================
# GOOGLE SIGN-IN
# ============================================================

@app.route("/api/auth/google", methods=["POST"])
def google_login():

    data = request.get_json() or {}
    credential = data.get("credential")

    if not credential:
        return jsonify({"message": "Google credential is required"}), 400

    # Verify the ID token with Google
    try:
        resp = http_requests.get(
            "https://oauth2.googleapis.com/tokeninfo",
            params={"id_token": credential},
            timeout=5
        )
    except Exception as e:
        return jsonify({"message": f"Google verification failed: {e}"}), 500

    if resp.status_code != 200:
        return jsonify({"message": "Invalid Google token"}), 401

    info = resp.json()
    email = info.get("email")
    given_name = info.get("given_name", "")
    family_name = info.get("family_name", "")
    email_verified = info.get("email_verified", "false")

    if not email or email_verified != "true":
        return jsonify({"message": "Google email not verified"}), 401

    # Find or create the user
    user = User.query.filter_by(email=email.lower()).first()

    if not user:
        user = User(
            name=given_name or email.split("@")[0],
            surname=family_name or "",
            email=email.lower(),
            password_hash=generate_password_hash(str(uuid.uuid4())),
            role="customer"
        )
        db.session.add(user)
        db.session.commit()

    access_token = create_access_token(identity=str(user.user_id))

    return jsonify({
        "message": "Google login successful",
        "access_token": access_token,
        "user": {
            "user_id": user.user_id,
            "name": user.name,
            "surname": user.surname,
            "email": user.email,
            "role": user.role
        }
    }), 200


# ============================================================
# GET ALL RETURNS (ADMIN)
# ?status=pending | approved | rejected | all
# ============================================================

@app.route("/api/admin/returns", methods=["GET"])
@role_required("admin")
def get_all_returns():

    status = request.args.get("status", "pending")
    page = request.args.get("page", 1, type=int)
    per_page = request.args.get("per_page", 10, type=int)

    if page < 1:
        return jsonify({"message": "Page must be 1 or greater"}), 400
    if per_page < 1 or per_page > 100:
        return jsonify({
            "message": "per_page must be between 1 and 100"
        }), 400

    query = Return.query

    if status in ("pending", "approved", "rejected"):
        query = query.filter(Return.status == status)

    pagination = (
        query
        .order_by(Return.created_at.desc())
        .paginate(page=page, per_page=per_page, error_out=False)
    )

    returns = []
    for r in pagination.items:
        customer = db.session.get(User, r.user_id)
        order = db.session.get(Order, r.order_id)

        returns.append({
            "return_id": r.return_id,
            "order_id": r.order_id,
            "order_total": float(order.total_amount) if order else 0,
            "order_date": order.order_date.isoformat() if order and order.order_date else None,
            "reason": r.reason,
            "status": r.status,
            "admin_note": r.admin_note,
            "resolution": r.resolution,                                 # NEW
            "resolution_chosen_at": (                                   # NEW
                 r.resolution_chosen_at.isoformat()
                 if r.resolution_chosen_at else None
            ),
            "created_at": r.created_at.isoformat() if r.created_at else None,
            "resolved_at": r.resolved_at.isoformat() if r.resolved_at else None,
            "customer_name": (
                f"{customer.name} {customer.surname}"
                if customer else "Unknown"
            ),
            "customer_email": customer.email if customer else ""
        })

    counts = {
        "pending": Return.query.filter_by(status="pending").count(),
        "approved": Return.query.filter_by(status="approved").count(),
        "rejected": Return.query.filter_by(status="rejected").count(),
        "all": Return.query.count(),
    }

    return jsonify({
        "returns": returns,
        "pagination": {
            "page": pagination.page,
            "per_page": pagination.per_page,
            "total_returns": pagination.total,
            "total_pages": pagination.pages,
            "has_next": pagination.has_next,
            "has_previous": pagination.has_prev
        },
        "counts": counts
    }), 200


# ============================================================
# RESOLVE A RETURN (ADMIN)
# ============================================================
@app.route("/api/admin/returns/<int:return_id>/resolve", methods=["PUT"])
@role_required("admin")
def resolve_return(return_id):

    from datetime import datetime, timedelta

    ret = db.session.get(Return, return_id)
    if not ret:
        return jsonify({"message": "Return not found"}), 404

    if ret.status != "pending":
        return jsonify({
            "message": f"This return is already {ret.status}"
        }), 400

    data = request.get_json() or {}
    action = data.get("action")
    note = (data.get("admin_note") or "").strip()

    if action not in ("approve", "reject"):
        return jsonify({
            "message": "action must be 'approve' or 'reject'"
        }), 400

    try:
        ret.status = "approved" if action == "approve" else "rejected"
        ret.admin_note = note or None
        ret.resolved_at = datetime.utcnow()

        order = db.session.get(Order, ret.order_id)

        if action == "approve" and order:
            order.status = "returned"
            pickup_date = datetime.utcnow() + timedelta(days=2)

            db.session.commit()

            # ---- send return-approved email ----
            send_return_approved_email(ret, order, pickup_date)

        else:
            db.session.commit()

            if order:
                send_return_rejected_email(ret, order, note)

        return jsonify({
            "message": f"Return {ret.status}",
            "return": {
                "return_id": ret.return_id,
                "status": ret.status,
                "admin_note": ret.admin_note
            }
        }), 200

    except Exception as e:
        db.session.rollback()
        import traceback
        traceback.print_exc()
        return jsonify({"message": str(e)}), 500

# ============================================================
# CHOOSE RESOLUTION: REFUND OR REPLACEMENT (CUSTOMER)
# ============================================================

@app.route("/api/returns/<int:return_id>/resolution", methods=["PUT"])
@role_required("customer")
def choose_return_resolution(return_id):

    from datetime import datetime

    user_id = get_jwt_identity()

    ret = Return.query.filter_by(
        return_id=return_id,
        user_id=int(user_id)
    ).first()

    if not ret:
        return jsonify({"message": "Return not found"}), 404

    if ret.status != "approved":
        return jsonify({
            "message": "You can only choose a resolution for approved returns"
        }), 403

    if ret.resolution:
        return jsonify({
            "message": f"You already chose '{ret.resolution}'"
        }), 400

    data = request.get_json() or {}
    resolution = data.get("resolution")

    if resolution not in ("refund", "replacement"):
        return jsonify({
            "message": "resolution must be 'refund' or 'replacement'"
        }), 400

    ret.resolution = resolution
    ret.resolution_chosen_at = datetime.utcnow()
    db.session.commit()

    # ---- send confirmation email ----
    order = db.session.get(Order, ret.order_id)
    if order:
        send_return_resolution_email(ret, order)

    return jsonify({
        "message": f"Chose {resolution}",
        "return": {
            "return_id": ret.return_id,
            "resolution": ret.resolution
        }
    }), 200

# ============================================================
# START
# ============================================================

if __name__ == "__main__":
    app.run(debug=True)