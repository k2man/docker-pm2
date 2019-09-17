FROM node:10.16.3-alpine
LABEL maintainer="k2man <k2mani@gmail.com>"

# Install pm2
RUN npm install -g pm2 node-gyp

# Install package
RUN apk add --no-cache --update p7zip python docker curl openssh-client execline

ENV NODE_ENV production

EXPOSE 443

# change working directory
WORKDIR /app

# Start pm2.json process file
CMD ["pm2-runtime", "start", "pm2.json"]
