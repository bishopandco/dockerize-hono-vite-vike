FROM node:18-alpine AS builder
RUN apk add --no-cache bash
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci
COPY . .
RUN npm run build

FROM node:18-alpine
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci --only=production
COPY --from=builder /app .
RUN chown -R appuser:appgroup /app
USER appuser
EXPOSE 8080

ENV NODE_ENV=production
CMD ["tail", "-f", "/dev/null"]
#CMD ["npm", "run", "preview"]