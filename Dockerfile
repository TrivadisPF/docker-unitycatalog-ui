# Use an official Node.js runtime as a parent image
FROM node:18-alpine

ARG UC_HOST="http://unity-catalog:8080"

# Set the working directory
WORKDIR /app

RUN wget https://github.com/unitycatalog/unitycatalog-ui/archive/refs/heads/main.zip \
    && unzip main.zip \
    && mv unitycatalog-ui-main unitycatalog-ui \
    && rm main.zip

WORKDIR /app/unitycatalog-ui

# Modify package.json to include the UC_HOST
RUN sed -i "s|\"proxy\": \".*\"|\"proxy\": \"$UC_HOST\"|" package.json

# Install dependencies
RUN yarn

# Expose the port the app runs on
EXPOSE 3000

# Define the command to run the app
CMD ["yarn", "start"]