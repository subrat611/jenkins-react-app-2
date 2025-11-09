FROM node:22-alpine AS builder-admin

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

# Stage 2: The Runtime/Production Stage
FROM nginx:alpine

# Copy the built React app from the 'builder' stage into Nginx's serving directory
COPY --from=builder-admin /app/dist /usr/share/nginx/html

# Expose port 80 and start Nginx (default command in Nginx image handles this)
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]