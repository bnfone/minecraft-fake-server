# Demo Server
This is a software used to emulate a Minecraft server for status/query only. This is not a playable server, and you will be disconnected if you attempt to connect. This software is meant to showcase the available features of mcstatus.io, a status retrieval site. This software can simulate a real server, running a Java Edition and Bedrock Edition status, as well as full query support.


## Docker Support
You still need a config.yml (see config.example.yml)!
```yml
services:
  minecraft-fake-server:
    image: ghcr.io/bnfone/minecraft-fake-server:latest
    container_name: minecraft-fake-server
    ports:
      - "25565:25565/tcp"    # Java Edition Status
      - "19132:19132/udp"    # Bedrock Edition Status
      - "8192:8192/tcp"      # Votifier
    volumes:
      - ./config.yml:/app/config.yml
    restart: always
```