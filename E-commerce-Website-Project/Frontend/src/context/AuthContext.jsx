import { createContext, useContext, useEffect, useState } from 'react'
import { authService } from '../services/authService'

const AuthContext = createContext(null)

export function AuthProvider({ children }) {
  const [user, setUser] = useState(null)
  const [token, setToken] = useState(null)
  const [loading, setLoading] = useState(true)

  // On mount: restore session from localStorage
  useEffect(() => {
    const storedToken = localStorage.getItem('token')
    const storedUser = localStorage.getItem('user')

    if (storedToken && storedUser) {
      setToken(storedToken)
      setUser(JSON.parse(storedUser))
    }
    setLoading(false)
  }, [])

  /** LOGIN */
  const login = async ({ email, password }) => {
    const data = await authService.login({ email, password })

    localStorage.setItem('token', data.access_token)
    localStorage.setItem('user', JSON.stringify(data.user))

    setToken(data.access_token)
    setUser(data.user)

    return data.user
  }

  /** REGISTER */
  const register = async ({ name, surname, email, password }) => {
    return authService.register({ name, surname, email, password })
  }

  /** LOGOUT */
  const logout = () => {
    localStorage.removeItem('token')
    localStorage.removeItem('user')
    setToken(null)
    setUser(null)
  }

  const updateUser = (nextUser) => {
  setUser(nextUser);
  localStorage.setItem('user', JSON.stringify(nextUser));
};

  const value = {
    user,
    token,
    loading,
    isAuthenticated: !!token,
    isCustomer: user?.role === 'customer',
    isAdmin: user?.role === 'admin',
    login,
    register,
    logout,
    updateUser, 
  }

  return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>
}

export function useAuth() {
  const ctx = useContext(AuthContext)
  if (!ctx) throw new Error('useAuth must be used inside <AuthProvider>')
  return ctx
}