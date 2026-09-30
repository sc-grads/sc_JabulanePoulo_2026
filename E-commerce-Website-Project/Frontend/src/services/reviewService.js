import { apiRequest } from './api'

export const reviewService = {
  createReview: ({ book_id, order_id, rating, comment }) =>
    apiRequest('/api/reviews', {
      method: 'POST',
      body: JSON.stringify({ book_id, order_id, rating, comment }),
    }),

  getBookReviews: (bookId) =>
    apiRequest(`/api/books/${bookId}/reviews`),

  canReview: (bookId) =>
    apiRequest(`/api/books/${bookId}/can-review`),

  // ============ ADMIN ============
  getAdminReviews: (status = 'pending', page = 1, perPage = 10) =>
    apiRequest(
      `/api/admin/reviews?status=${status}&page=${page}&per_page=${perPage}`
    ),

  approveReview: (reviewId) =>
    apiRequest(`/api/admin/reviews/${reviewId}/approve`, {
      method: 'PUT',
    }),

  rejectReview: (reviewId) =>
    apiRequest(`/api/admin/reviews/${reviewId}/reject`, {
      method: 'PUT',
    }),

  deleteReview: (reviewId) =>
    apiRequest(`/api/admin/reviews/${reviewId}`, {
      method: 'DELETE',
    }),
}