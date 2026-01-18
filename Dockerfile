FROM python:3.11-slim

# Dépendances système
RUN apt-get update && apt-get install -y --no-install-recommends \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/*

# Installation de spotdl
# Bibliothèque permettant de télécharger les musiques Spotify via YouTube
RUN pip install --no-cache-dir spotdl

# Dossier de travail pour les téléchargements
WORKDIR /music

ENTRYPOINT ["spotdl"]