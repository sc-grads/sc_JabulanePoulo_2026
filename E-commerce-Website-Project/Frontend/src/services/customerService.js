import { apiRequest } from './api'

export const customerService = {
  getCustomers: (page = 1, perPage = 10, search = '') => {
    const params = new URLSearchParams({ page, per_page: perPage })
    if (search) params.append('search', search)
    return apiRequest(`/api/admin/customers?${params.toString()}`)
  },

  deleteCustomer: (userId) =>
    apiRequest(`/api/admin/customers/${userId}`, { method: 'DELETE' }),
}