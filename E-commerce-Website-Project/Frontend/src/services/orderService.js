import { apiRequest } from './api'

export const orderService = {
  createOrder: (payload = {}) =>
    apiRequest('/api/orders', {
      method: 'POST',
      body: JSON.stringify(payload),
    }),

  getOrders: (page = 1, perPage = 5) =>
    apiRequest(`/api/orders?page=${page}&per_page=${perPage}`),

  getOrder: (id) => apiRequest(`/api/orders/${id}`),

  cancelOrder: (id) =>
    apiRequest(`/api/orders/${id}/cancel`, { method: 'POST' }),
}