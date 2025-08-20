# Stage 1: Build the React app
FROM node:18-alpine AS builder

WORKDIR /app
COPY package*.json ./
RUN npm ci --silent
COPY . .
RUN npm run build

# Stage 2: Serve the built app with a lightweight server
FROM node:18-alpine AS production

# Install 'serve' to run the built app
RUN npm install -g serve

WORKDIR /app
COPY --from=builder /app/build ./build

# Copy entrypoint
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

EXPOSE 3000

CMD ["/entrypoint.sh"]