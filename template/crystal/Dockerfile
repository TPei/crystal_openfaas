FROM --platform=${TARGETPLATFORM:-linux/amd64} ghcr.io/openfaas/of-watchdog:0.10.1 as watchdog
FROM --platform=${TARGETPLATFORM:-linux/amd64} alpine as build

RUN apk update && apk upgrade
RUN apk add crystal shards
RUN apk cache clean
WORKDIR /home/app
COPY . .

COPY function/shard.yml shard.yml
RUN shards install
RUN crystal build main.cr -o handler --release --static
RUN strip handler

FROM --platform=${TARGETPLATFORM:-linux/amd64} alpine as ship
RUN apk update && apk upgrade && apk cache clean
# Add non root user
# Add non root user
RUN addgroup -S app && adduser app -S -G app

WORKDIR /home/app
USER app

COPY --from=build /home/app/function/  .
COPY --from=build /home/app/handler    .
COPY --from=watchdog /fwatchdog /home/app/fwatchdog

ENV fprocess="./handler"
EXPOSE 8080

HEALTHCHECK --interval=2s CMD [ -e /tmp/.lock ] || exit 1

CMD ["./fwatchdog"]
