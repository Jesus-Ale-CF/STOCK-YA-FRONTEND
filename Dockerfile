# Etapa 1: compilar el sitio
FROM node:22-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# Etapa 2: servir los archivos con nginx
FROM nginx:alpine
# nginx sustituye las variables de entorno de las plantillas al arrancar
ENV BACKEND_URL=https://stockya-vys0.onrender.com
COPY nginx.conf /etc/nginx/templates/default.conf.template
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
