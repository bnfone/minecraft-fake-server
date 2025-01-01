# Build-Stage
FROM golang:1.20-alpine AS builder

# Installiere Git (falls benötigt für Abhängigkeiten)
RUN apk update && apk add --no-cache git

# Setze das Arbeitsverzeichnis
WORKDIR /app

# Kopiere die go.mod und go.sum Dateien
COPY go.mod go.sum ./

# Lade die Abhängigkeiten herunter
RUN go mod download

# Kopiere den Quellcode
COPY src ./src

# Kopiere die Beispielkonfigurationsdatei und benenne sie um
COPY config.example.yml ./config.yml

# Baue die Go-Anwendung
RUN go build -o minecraft-fake-server src/main.go

# Runtime-Stage
FROM alpine:latest

# Setze das Arbeitsverzeichnis
WORKDIR /app

# Kopiere die gebaute Binärdatei aus der Build-Stage
COPY --from=builder /app/minecraft-fake-server .

# Kopiere die Konfigurationsdatei aus der Build-Stage
COPY --from=builder /app/config.yml .

# Exponiere die benötigten Ports
EXPOSE 25565/tcp        
EXPOSE 19132/udp        
EXPOSE 8192/tcp        

# Starte die Anwendung
CMD ["./minecraft-fake-server"]
