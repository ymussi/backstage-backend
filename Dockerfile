# This dockerfile builds an image for the backend package.
# It should be executed with the root of the repo as docker context.
#
# Before building this image, be sure to have run the following commands in the repo root:
#
# yarn install
# yarn tsc
# yarn build
#
# Once the commands have been run, you can build the image using `yarn build-image`

FROM node:14-buster-slim

# ENV POSTGRES_USER
# ENV POSTGRES_PASSWORD

WORKDIR /app

RUN yarn install --frozen-lockfile --production --network-timeout 300000 && rm -rf "$(yarn cache dir)"
RUN yarn tsc

# Then copy the rest of the backend bundle, along with any other files we might want.
COPY app-config.yaml ./

CMD ["node", "backend", "--config", "app-config.yaml"]
