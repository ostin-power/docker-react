#Sezione 1:
#Installazione delle dipendenze
#Generazione della build 
FROM node:16-alpine as builder
WORKDIR '/app' 
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

#/app/build/ -> conterrà tutto il codice che abbiamo bisogno 
#per eseguire l'applicazione in produzione

#Sezione 2:
#Installazione e configurazione NGINX
FROM nginx
EXPOSE 80
#copio tutto quello che è stato fatto nella "builder phase"
COPY --from=builder /app/build /usr/share/nginx/html
