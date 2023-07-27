# Basisimage für Arm64-Geräte
FROM arm64v8/debian:stable-slim

# Signal-cli Version (hier gegebenenfalls die neueste Version angeben)
ENV SIGNAL_CLI_VERSION=0.11.11-Linux

# Verzeichnis erstellen, um Schlüssel und Nachrichten zu speichern
RUN mkdir /signal_data
VOLUME /signal_data

# Installiere Abhängigkeiten
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    dirmngr \
    gnupg \
    openjdk-11-jre-headless

# Signal-cli herunterladen und installieren
RUN wget --quiet --output-document /tmp/signal-cli-${SIGNAL_CLI_VERSION}.tar.gz https://github.com/AsamK/signal-cli/releases/download/v${SIGNAL_CLI_VERSION}/signal-cli-${SIGNAL_CLI_VERSION}.tar.gz && \
    tar -xzf /tmp/signal-cli-${SIGNAL_CLI_VERSION}.tar.gz -C /tmp && \
    mv /tmp/signal-cli-${SIGNAL_CLI_VERSION}/bin/signal-cli /usr/local/bin/ && \
    rm -rf /tmp/signal-cli-${SIGNAL_CLI_VERSION}

# Arbeitsverzeichnis festlegen
WORKDIR /signal_data

# Standardmäßig die Signal-cli-Version ausgeben, um zu überprüfen, ob die Installation erfolgreich war
CMD ["signal-cli", "--version"]
