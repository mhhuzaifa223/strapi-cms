FROM node:20-alpine AS builder

RUN apk add --no-cache \
    build-base \
    gcc \
    autoconf \
    automake \
    zlib-dev \
    libpng-dev \
    vips-dev \
    git

WORKDIR /opt

RUN npx create-strapi-app@latest app --quickstart --no-run

WORKDIR /opt/app

RUN npm run build

FROM node:20-alpine

RUN apk add --no-cache vips-dev

WORKDIR /opt/app

COPY --from=builder /opt/app ./

EXPOSE 1337

CMD ["npm", "run", "start"]