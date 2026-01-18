# Download Music from Spotify Playlists

Télécharge automatiquement les musiques de vos playlists Spotify via YouTube en utilisant yt-dlp et Docker.

## 📋 Prérequis

- Docker installé sur votre machine
- Un compte Spotify (gratuit ou premium)
- Accès à [Exportify.app](https://exportify.app)

## 🎵 Workflow complet

### 1. Créer vos playlists sur Spotify

Créez vos playlists directement sur Spotify (application ou web). Même un compte gratuit suffit ! 😉

### 2. Exporter vos playlists en CSV

1. Rendez-vous sur [Exportify.app](https://exportify.app)
2. Connectez-vous avec votre compte Spotify
3. Cliquez sur "Export" pour chaque playlist que vous souhaitez télécharger
4. Les fichiers CSV seront téléchargés automatiquement

### 3. Placer les fichiers CSV

Placez tous les fichiers CSV exportés dans le dossier `playlists/ToDo/`

### 4. Lancer le téléchargement

```bash
chmod +x Download-Music.sh
./Download-Music.sh
```

Le script va automatiquement :
- Parcourir tous les fichiers CSV dans `playlists/ToDo/`
- Créer un dossier `music/nom_de_la_playlist/` pour chaque playlist
- Télécharger toutes les musiques (titre + artiste) via YouTube en MP3
- Déplacer le fichier CSV dans `playlists/Done/` une fois terminé

## 📁 Structure des dossiers

```
.
├── Download-Music.sh          # Script principal
├── playlists/
│   ├── ToDo/                 # Déposez vos CSV ici
│   └── Done/                 # Les CSV traités sont déplacés ici
└── music/
    ├── nom_playlist_1/       # Musiques de la playlist 1
    └── nom_playlist_2/       # Musiques de la playlist 2
```

## 🔧 Fonctionnement technique

Le script utilise :
- **yt-dlp** (via Docker) pour télécharger depuis YouTube
- Format de sortie : MP3
- Recherche automatique : "Artiste + Titre"
- Organisation automatique par playlist

## 📝 Notes

- Le script traite automatiquement toutes les playlists présentes dans `ToDo/`
- Les fichiers CSV doivent être au format Exportify (colonnes standard Spotify)
- Chaque musique est recherchée via YouTube avec le nom de l'artiste et le titre
- Une fois traitée, la playlist est archivée dans `Done/` pour éviter les doublons