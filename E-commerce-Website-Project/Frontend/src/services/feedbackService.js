import { apiRequest } from './api'

export const feedbackService = {
  submit: ({ rating, comment, name, email }) =>
    apiRequest('/api/feedback', {
      method: 'POST',
      body: JSON.stringify({ rating, comment, name, email }),
    }),

  /** Public stats only (no individual comments) */
  getStats: () => apiRequest('/api/feedback'),

  /** Admin: full list */
  getAll: (page = 1, perPage = 10, rating = null) => {
    const params = new URLSearchParams({ page, per_page: perPage })
    if (rating) params.append('rating', rating)
    return apiRequest(`/api/admin/feedback?${params.toString()}`)
  },

  /** Admin: delete feedback */
  delete: (feedbackId) =>
    apiRequest(`/api/admin/feedback/${feedbackId}`, { method: 'DELETE' }),

  /** Admin: toggle visibility */
  toggleVisibility: (feedbackId) =>
    apiRequest(`/api/admin/feedback/${feedbackId}/visibility`, {
      method: 'PUT',
    }),
}