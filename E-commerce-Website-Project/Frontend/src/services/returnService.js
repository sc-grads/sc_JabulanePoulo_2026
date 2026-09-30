import { apiRequest } from './api'

export const returnService = {
  requestReturn: ({ order_id, reason }) =>
    apiRequest('/api/returns', {
      method: 'POST',
      body: JSON.stringify({ order_id, reason }),
    }),

  getMyReturns: () => apiRequest('/api/returns'),

  getAdminReturns: (status = 'pending', page = 1, perPage = 10) =>
    apiRequest(
      `/api/admin/returns?status=${status}&page=${page}&per_page=${perPage}`
    ),

  resolveReturn: (returnId, action, admin_note = '') =>
    apiRequest(`/api/admin/returns/${returnId}/resolve`, {
      method: 'PUT',
      body: JSON.stringify({ action, admin_note }),
    }),
}