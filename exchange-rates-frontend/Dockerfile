FROM registry.access.redhat.com/ubi8/nodejs-18:latest AS base

WORKDIR /app

# --- RUN AS ROOT ---
USER root

# COPY .env ./

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build
# -------------------
USER 1001

FROM registry.access.redhat.com/ubi8/nodejs-18-minimal:latest AS final

WORKDIR /app

COPY --from=base /app/build ./build


RUN npm install -g serve

EXPOSE 5000

CMD ["serve", "-s", "build", "-l", "5000"]
