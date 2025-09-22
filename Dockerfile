# Use the official Node.js 18 image as the base image
# The project requires Node >= 16.9.1, so we use Node 18 for better compatibility
FROM node:18-alpine AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and yarn.lock
COPY package.json yarn.lock ./

# Install dependencies (including dev dependencies needed for build)
RUN yarn install --frozen-lockfile

# Copy the rest of the application code
COPY . .

# Build the application with root base path for Docker
RUN yarn build --base=/

# Production stage
FROM nginx:alpine AS production

# Copy the built files from the builder stage
COPY --from=builder /app/dist /usr/share/nginx/html

# Copy custom nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]