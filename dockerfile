FROM node:12-alpine

# Copy files
COPY ninjakatt /app
COPY docker/entrypoint.sh /entrypoint.sh

RUN cd /app && npm install 

ENV APPDATA=/config

EXPOSE 8080

ENTRYPOINT [ "/entrypoint.sh" ]