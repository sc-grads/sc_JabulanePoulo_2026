import '../styles/AuthLayout.css'

function AuthLayout({ children }) {
  return (
    <div className="auth-layout">
      <div className="auth-form-side">
        <div className="auth-form-wrapper">
          {children}
        </div>
      </div>
      <div className="auth-image-side" />
    </div>
  )
}

export default AuthLayout