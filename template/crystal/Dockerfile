FROM --platform=${TARGETPLATFORM:-linux/amd64} ghcr.io/openfaas/of-watchdog:0.9.10 as watchdog
FROM --platform=${TARGETPLATFORM:-linux/amd64} alpine as build

RUN apk update && apk upgrade
RUN apk add crystal shards
WORKDIR /home/app
COPY . .

COPY function/shard.yml shard.yml
RUN shards install
RUN crystal build main.cr -o handler --release --static
RUN strip handler

FROM --platform=${TARGETPLATFORM:-linux/amd64} alpine as ship
RUN apk update && apk upgrade

# Add non root user
RUN addgroup -S app && adduser app -S -G app

WORKDIR /home/app

COPY --from=build /home/app/function/  .
COPY --from=build /home/app/handler    .
COPY --from=watchdog /fwatchdog        .
RUN chmod +x /home/app/fwatchdog
RUN chown app /home/app

USER app

ENV fprocess="./handler"
EXPOSE 8080

HEALTHCHECK --interval=2s CMD [ -e /tmp/.lock ] || exit 1

CMD ["./fwatchdog"]
