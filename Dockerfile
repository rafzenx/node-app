FROM node:16-alpine AS build

WORKDIR "/app"

COPY package.json .
RUN npm install
COPY . .
RUN mkdir node_modules/.cache && chmod -R 777 node_modules/.cache
RUN npm run build

FROM nginx
EXPOSE 80
COPY --from=build /app/build/ /usr/share/nginx/html
