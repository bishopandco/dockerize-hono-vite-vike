FROM oven/bun:latest as builder
WORKDIR /app
COPY package.json ./
COPY . .
RUN bun install
CMD ["tail", "-f", "/dev/null"]