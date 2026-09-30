import { apiRequest } from './api'

export const cartService = {
  /** GET /api/cart */
  getCart: () => apiRequest('/api/cart'),

  /** POST /api/cart/items */
  addItem: (book_id, quantity = 1) =>
    apiRequest('/api/cart/items', {
      method: 'POST',
      body: JSON.stringify({ book_id, quantity }),
    }),

  /** PUT /api/cart/items/:id */
  updateItem: (cart_item_id, quantity) =>
    apiRequest(`/api/cart/items/${cart_item_id}`, {
      method: 'PUT',
      body: JSON.stringify({ quantity }),
    }),

  /** DELETE /api/cart/items/:id */
  removeItem: (cart_item_id) =>
    apiRequest(`/api/cart/items/${cart_item_id}`, {
      method: 'DELETE',
    }),

  /** DELETE /api/cart */
  clearCart: () =>
    apiRequest('/api/cart', { method: 'DELETE' }),
}