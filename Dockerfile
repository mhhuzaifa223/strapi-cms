FROM node:18-alpine AS builder

RUN apk add --no-cache \
    build-base \
    gcc \
    autoconf \
    automake \
    zlib-dev \
    libpng-dev \
    vips-dev \
    git

WORKDIR /opt/app

RUN npx create-strapi-app@latest . --quickstart --no-run

RUN npm run build

FROM node:18-alpine

RUN apk add --no-cache vips-dev

WORKDIR /opt/app

COPY --from=builder /opt/app ./

EXPOSE 1337

CMD ["npm", "run", "start"]