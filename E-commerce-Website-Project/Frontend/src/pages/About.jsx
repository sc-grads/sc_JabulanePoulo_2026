import { useNavigate } from "react-router-dom";
import { BookOpen, Users, Heart, Award, Mail, MapPin, Phone } from "lucide-react";
import Navbar from "../components/Navbar";
import NavDrawer from "../components/NavDrawer";
import { useState } from "react";
import "../styles/Home.css";
import "../styles/About.css";

function About() {
  const navigate = useNavigate();
  const [drawerOpen, setDrawerOpen] = useState(false);

  return (
    <div className="about-page">
      <Navbar onOpenDrawer={() => setDrawerOpen(true)} />

      <section className="about-hero">
        <h1>About Book Worm</h1>
        <p>
          Connecting readers with the books they love — and the books they
          didn't know they needed.
        </p>
      </section>

      <div className="about-content">

        

       

        <section className="about-section">
          <h2>Get in Touch</h2>
          <div className="contact-grid">
            <div className="contact-item">
              <Mail size={20} />
              <div>
                <strong>Email</strong>
                <p>contact@bookworm.com</p>
              </div>
            </div>
            <div className="contact-item">
              <Phone size={20} />
              <div>
                <strong>Phone</strong>
                <p>+27 75 138 7319</p>
              </div>
            </div>
            <div className="contact-item">
              <MapPin size={20} />
              <div>
                <strong>Address</strong>
                <p>123 Main Street, Johannesburg, 2001, South Africa</p>
              </div>
            </div>
          </div>
        </section>

        <section className="about-cta">
          <h2>Got feedback?</h2>
          <p>We'd love to hear how we can make Book Worm even better.</p>
          <button onClick={() => navigate("/feedback")}>
            Share your experience 
          </button>
        </section>

      </div>

      <NavDrawer open={drawerOpen} onClose={() => setDrawerOpen(false)} />
    </div>
  );
}

export default About;