FROM node:12-alpine

# Copy files
COPY entrypoint.sh /entrypoint.sh
RUN ["chmod", "+x", "/entrypoint.sh"]

# Copy and install plugins
COPY ninjakatt /app
RUN cd /app && npm install 

COPY ninjakatt-plugin-files /plugins/ninjakatt-plugin-files
RUN cd /plugins/ninjakatt-plugin-files && npm install 

COPY ninjakatt-plugin-logger /plugins/ninjakatt-plugin-logger
RUN cd /plugins/ninjakatt-plugin-logger && npm install 

COPY ninjakatt-plugin-movies /plugins/ninjakatt-plugin-movies
RUN cd /plugins/ninjakatt-plugin-movies && npm install 

COPY ninjakatt-plugin-qbittorrent /plugins/ninjakatt-plugin-qbittorrent
RUN cd /plugins/ninjakatt-plugin-qbittorrent && npm install 

COPY ninjakatt-plugin-torrentrss /plugins/ninjakatt-plugin-torrentrss
RUN cd /plugins/ninjakatt-plugin-torrentrss && npm install 

COPY ninjakatt-plugin-webserver /plugins/ninjakatt-plugin-webserver
RUN cd /plugins/ninjakatt-plugin-webserver && npm install

ENV APPDATA=/config
ENV PLUGINDIR=/plugins
ENV PLUGINS='["files", "logger", "qbittorrent", "movies", "webserver", "torrentrss"]'

EXPOSE 8585

ENTRYPOINT [ "/entrypoint.sh" ]