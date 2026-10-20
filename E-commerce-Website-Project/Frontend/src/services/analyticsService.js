import { apiRequest } from './api'

export const analyticsService = {
  getAnalytics: (days = 30) =>
    apiRequest(`/api/admin/analytics?days=${days}`),
}