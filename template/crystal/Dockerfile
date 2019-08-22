FROM crystallang/crystal:0.30.1 as builder

RUN apt update \
    && apt install -y curl \
    && echo "Pulling watchdog binary from Github." \
    && curl -sSL https://github.com/openfaas/faas/releases/download/0.9.6/fwatchdog > /usr/bin/fwatchdog \
    && chmod +x /usr/bin/fwatchdog

WORKDIR /home/app
COPY . .

COPY function/shard.yml shard.yml
RUN shards install
RUN crystal build main.cr -o handler --release

FROM crystallang/crystal:0.30.1
RUN apt install ca-certificates

# Add non root user
RUN adduser app
RUN mkdir -p /home/app

WORKDIR /home/app

COPY --from=builder /usr/bin/fwatchdog   .
COPY --from=builder /home/app/function/  .
COPY --from=builder /home/app/handler    .

RUN chown -R app /home/app

USER app

ENV fprocess="./handler"
EXPOSE 8080

HEALTHCHECK --interval=2s CMD [ -e /tmp/.lock ] || exit 1

CMD ["./fwatchdog"]
