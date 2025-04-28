FROM node:20-alpine

RUN apk --no-cache add openjdk21-jre
RUN npm i --no-update-notifier -g firebase-tools

WORKDIR /home/node
COPY firebase.json storage.rules firestore.* ./
RUN for name in ui storage firestore ; do firebase setup:emulators:${name} ; done

EXPOSE 9090 9099 9199 8080

ENTRYPOINT ["firebase"]
CMD ["emulators:start", "--import=/var/cache/firebase/data", "--export-on-exit"]
