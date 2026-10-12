FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates libasound2 libfontconfig1 libgl1 libpulse0 libx11-6 libxcursor1 libxi6 libxinerama1 libxrandr2 && rm -rf /var/lib/apt/lists/*
WORKDIR /srv/hyperball
COPY hyperball-race-server.x86_64 ./hyperball-race-server.x86_64
COPY hyperball-race-server.pck ./hyperball-race-server.pck
RUN chmod 0555 ./hyperball-race-server.x86_64 && mkdir -p /tmp/hyperball/.cache/fontconfig /tmp/hyperball/.local/share /tmp/hyperball/.config && chown -R 10001:10001 /srv/hyperball /tmp/hyperball
USER 10001:10001
ENV PORT=10000 HOME=/tmp/hyperball XDG_CACHE_HOME=/tmp/hyperball/.cache XDG_DATA_HOME=/tmp/hyperball/.local/share XDG_CONFIG_HOME=/tmp/hyperball/.config
EXPOSE 10000
CMD ["/bin/sh", "-c", "exec ./hyperball-race-server.x86_64 --headless --max-fps 60 -- --race-server --bind=0.0.0.0 --port=${PORT:-10000}"]
