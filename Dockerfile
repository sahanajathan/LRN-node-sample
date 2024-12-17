FROM --platform=linux/amd64 node:alpine
RUN mkdir -p /usr/src/calc
WORKDIR /usr/src/calc
COPY . .
RUN npm install
EXPOSE 3000
CMD [ "node", "app.js" ]


# package the application
RUN mvn package -Dmaven.test.skip=true

#~~~~~~~SNYK test~~~~~~~~~~~~
# download, configure and run snyk. Break build if vulns present, post results to `https://snyk.io/`
RUN curl -Lo ./snyk "https://github.com/snyk/snyk/releases/download/v1.210.0/snyk-linux"
RUN chmod -R +x ./snyk
#Auth set through environment variable
RUN ./snyk test --severity-threshold=medium
RUN ./snyk monitor
