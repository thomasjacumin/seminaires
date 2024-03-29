# build stage
FROM node:current-alpine AS build-stage
WORKDIR . 
COPY package.json ./
RUN npm install
COPY . .
ENV NODE_ENV=production
RUN npm run build

# production stage
FROM nginx AS production-stage
COPY --from=build-stage ./dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
