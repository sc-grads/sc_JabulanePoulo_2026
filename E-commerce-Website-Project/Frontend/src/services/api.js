const API_URL = import.meta.env.VITE_API_URL || 'http://127.0.0.1:5000'

/**
 * Generic fetch wrapper.
 * - Automatically attaches the JWT token if it exists.
 * - Parses JSON and throws errors on non-2xx responses.
 */
export async function apiRequest(endpoint, options = {}) {
  const token = localStorage.getItem('token')

  const headers = {
    'Content-Type': 'application/json',
    ...(options.headers || {}),
  }

  if (token) {
    headers['Authorization'] = `Bearer ${token}`
  }

  const response = await fetch(`${API_URL}${endpoint}`, {
    ...options,
    headers,
  })

  let data = null
  try {
    data = await response.json()
  } catch {
    // some responses (like 204) may not have JSON
  }

  if (!response.ok) {
    // If token expired / invalid, clear it and redirect
    if (response.status === 401) {
      localStorage.removeItem('token')
      localStorage.removeItem('user')
    }
    const message = data?.message || `Request failed (${response.status})`
    throw new Error(message)
  }

  return data
}

/**
 * Upload a file (multipart/form-data).
 * Does NOT set Content-Type — the browser sets it with the boundary.
 */
export async function apiUpload(endpoint, formData) {
  const token = localStorage.getItem("token");

  const headers = {};
  if (token) {
    headers["Authorization"] = `Bearer ${token}`;
  }

  const response = await fetch(
    `${import.meta.env.VITE_API_URL}${endpoint}`,
    {
      method: "POST",
      headers,
      body: formData,
    }
  );

  let data = null;
  try {
    data = await response.json();
  } catch {
    // ignore empty responses
  }

  if (!response.ok) {
    throw new Error(data?.message || `Upload failed (${response.status})`);
  }

  return data;
}