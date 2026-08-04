FROM --platform=linux/amd64 debian:trixie-slim
ARG MAUDE_VERSION
ARG TAMARIN_VERSION

COPY setup.sh /tmp/setup.sh
RUN sh /tmp/setup.sh && rm -f /tmp/setup.sh

ENV MAUDE_LIB=/opt/maude \
    LC_ALL=C.UTF-8 \
    LANG=C.UTF-8

RUN tamarin-prover test

WORKDIR /workspace
ENTRYPOINT ["tamarin-prover"]
CMD ["--help"]
