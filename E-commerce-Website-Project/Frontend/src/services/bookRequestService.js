import { apiRequest } from './api'

export const bookRequestService = {
  submit: ({ title, author, isbn, notes }) =>
    apiRequest('/api/book-requests', {
      method: 'POST',
      body: JSON.stringify({ title, author, isbn, notes }),
    }),

  getMine: () => apiRequest('/api/book-requests'),

  // Admin
  getAll: (status = 'pending', page = 1, perPage = 10) =>
    apiRequest(
      `/api/admin/book-requests?status=${status}&page=${page}&per_page=${perPage}`
    ),

  updateStatus: (requestId, status, adminNote = '') =>
    apiRequest(`/api/admin/book-requests/${requestId}`, {
      method: 'PUT',
      body: JSON.stringify({ status, admin_note: adminNote }),
    }),
}