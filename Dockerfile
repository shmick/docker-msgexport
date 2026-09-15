FROM public.ecr.aws/docker/library/rust:1-slim

RUN apt-get update && apt-get install -y \
    pkg-config \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

RUN cargo install imessage-exporter

ENV TZ=America/Toronto

# Base executable and default flags
ENTRYPOINT ["imessage-exporter"]
