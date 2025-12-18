# Step 1: Use the ultra-slim Alpine-based Nginx image
FROM nginx:alpine

# Step 2: Copy the production build folder from your CI pipeline
COPY build/ /usr/share/nginx/html

# Step 3: Configure Nginx to support React Router (SPA fix)
RUN sed -i '10i \    location / { try_files $uri /index.html; }' /etc/nginx/conf.d/default.conf

# Step 4: Expose standard web port
EXPOSE 80

# Step 5: Start Nginx
CMD ["nginx", "-g", "daemon off;"]