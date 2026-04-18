/**
 * API utility for making AJAX requests to the Java Servlets.
 */
const API = {
    async fetch(endpoint, options = {}) {
        options.headers = {
            ...options.headers,
            'Accept': 'application/json',
        };
        
        if (options.body && !(options.body instanceof FormData)) {
            options.headers['Content-Type'] = 'application/json';
            options.body = JSON.stringify(options.body);
        }

        try {
            const response = await fetch(endpoint, options);
            if (!response.ok) {
                // Try to parse error message if available
                let errorMessage = 'Request failed';
                try {
                    const errorData = await response.json();
                    errorMessage = errorData.message || errorMessage;
                } catch (e) {
                   // Fallback
                   console.error("Could not parse error response", e);
                }
                throw new Error(errorMessage);
            }
            return await response.json();
        } catch (error) {
            console.error('API Error:', error);
            throw error;
        }
    },

    get(endpoint) {
        return this.fetch(endpoint);
    },

    post(endpoint, data) {
        return this.fetch(endpoint, {
            method: 'POST',
            body: data
        });
    }
};
