# --- Stage 1: Build Stage ---
FROM public.ecr.aws/docker/library/rust:1-slim AS builder

RUN apt-get update && apt-get install -y \
    pkg-config \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

RUN cargo install imessage-exporter

# --- Stage 2: Runtime Stage ---
FROM public.ecr.aws/docker/library/debian:bookworm-slim

# Install runtime SSL dependencies required by imessage-exporter
RUN apt-get update && apt-get install -y \
    ca-certificates \
    libssl3 \
    && rm -rf /var/lib/apt/lists/*

# Copy only the compiled binary from the builder stage
COPY --from=builder /usr/local/cargo/bin/imessage-exporter /usr/local/bin/imessage-exporter

ENV TZ=America/Toronto

ENTRYPOINT ["imessage-exporter"]
