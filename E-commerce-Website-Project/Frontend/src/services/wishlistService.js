import { apiRequest } from './api'

export const wishlistService = {
  getWishlist: (page = 1, perPage = 8) =>
    apiRequest(`/api/wishlist?page=${page}&per_page=${perPage}`),

  getWishlistIds: () => apiRequest('/api/wishlist/ids'),

  addToWishlist: (book_id) =>
    apiRequest('/api/wishlist', {
      method: 'POST',
      body: JSON.stringify({ book_id }),
    }),

  removeFromWishlist: (book_id) =>
    apiRequest(`/api/wishlist/${book_id}`, { method: 'DELETE' }),
}