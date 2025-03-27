# Stage 1: Build Stage
FROM node:18 AS builder
WORKDIR /app

# Copy package files separately to leverage Docker caching
COPY package.json package-lock.json ./
RUN npm ci --only=production  # Faster and more reliable than npm install

# Copy the rest of the source code
COPY . .  


# Stage 2: Production Stage
FROM node:18-alpine AS runner
WORKDIR /app

# Set a non-root user for security
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

# Copy only necessary files from the builder stage
COPY --from=builder /app/server.js ./server.js
COPY --from=builder /app/node_modules ./node_modules

# Expose the required port (if applicable)
EXPOSE 3000  

CMD ["node", "server.js"]
