FROM node:18-alpine as build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

FROM node:18-alpine
WORKDIR /app
RUN npm install -g serve
COPY --from=build /app/dist /app
ENV PORT=5001
ENV NODE_ENV=production
ENV VITE_API_BASE_URL=http://a699e140f6d9a49eea43e5034ef11cde-2019581216.us-east-1.elb.amazonaws.com:5000/api
EXPOSE 5001
CMD ["serve", "-s", ".", "-l", "5001"]

