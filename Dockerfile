# STAGE 1:BUILD #
# Defining base image to be used
FROM docker.io/node:15-alpine AS build
# Creating working directory
WORKDIR /src/app
# Copying package.json and package-lock.json
COPY package*.json ./
# Installing dependencies
RUN npm install
# Copying all the project files to working directory
COPY . .
# Running the build command to generate build files
RUN npm run build --omit=dev
### STAGE 2:RUN ###
# Defining nginx image to be used
FROM docker.io/nginx:latest AS ngi
# Copying compiled code and nginx config to different folder
# NOTE: This path may change according to your project's output folder
COPY --from=build /dist/src/app/dist/domain-app-name /usr/share/nginx/html
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
# Exposing a port, here it means that inside the container
# the app will be using Port 80 while running
EXPOSE 80
