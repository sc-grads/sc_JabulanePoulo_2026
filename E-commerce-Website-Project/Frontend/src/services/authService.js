import { apiRequest } from './api'

export const authService = {
  register: ({ name, surname, email, password }) =>
    apiRequest('/api/auth/register', {
      method: 'POST',
      body: JSON.stringify({ name, surname, email, password }),
    }),

  login: ({ email, password }) =>
    apiRequest('/api/auth/login', {
      method: 'POST',
      body: JSON.stringify({ email, password }),
    }),

  getMe: () => apiRequest('/api/auth/me'),

  updateMe: (payload) =>
    apiRequest('/api/auth/me', {
      method: 'PUT',
      body: JSON.stringify(payload),
    }),

  changePassword: ({ current_password, new_password }) =>
    apiRequest('/api/auth/change-password', {
      method: 'PUT',
      body: JSON.stringify({ current_password, new_password }),
    }),

  forgotPassword: (email) =>
    apiRequest('/api/auth/forgot-password', {
      method: 'POST',
      body: JSON.stringify({ email }),
    }),

  resetPassword: ({ token, new_password }) =>
    apiRequest('/api/auth/reset-password', {
      method: 'POST',
      body: JSON.stringify({ token, new_password }),
    }),

  getInformation: () => apiRequest('/api/profile/information'),

  saveInformation: (info) =>
    apiRequest('/api/profile/information', {
      method: 'PUT',
      body: JSON.stringify(info),
    }),

  deleteMyAccount: () =>
    apiRequest('/api/profile/delete-account', {
      method: 'DELETE',
    }),

  createAdmin: ({ name, surname, email, password }) =>
    apiRequest('/api/auth/create-admin', {
      method: 'POST',
      body: JSON.stringify({ name, surname, email, password }),
    }),
}