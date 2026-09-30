import { apiRequest } from './api'

export const bookService = {
  getBooks: (params = {}) => {
    const query = new URLSearchParams(params).toString()
    return apiRequest(`/api/books${query ? `?${query}` : ''}`)
  },

  /** All categories (used by dropdowns) */
  getCategories: () => apiRequest('/api/categories?all=true'),

  /** Paginated categories (used by admin page) */
  getCategoriesPaginated: (page = 1, perPage = 8) =>
    apiRequest(`/api/categories?page=${page}&per_page=${perPage}`),

  getBook: (id) => apiRequest(`/api/books/${id}`),
}