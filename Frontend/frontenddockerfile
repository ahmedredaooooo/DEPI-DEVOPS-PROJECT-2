FROM node:18-alpine AS build

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install --legacy-peer-deps

# Install Angular CLI (needed for `ng build`)
RUN npm install -g @angular/cli

# Copy source code
COPY . .

# Build Angular app
RUN ng build --configuration production

FROM nginx:alpine

# Remove default page
RUN rm -rf /usr/share/nginx/html/*

# Copy build artifacts
COPY --from=build /app/dist/frontend/ /usr/share/nginx/html/

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
