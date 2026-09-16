# ⛽ Fuel Price App

Application Flutter permettant de rechercher les prix des carburants en France, ville par ville, à partir des données publiques du gouvernement français.

Projet personnel réalisé pour apprendre Flutter en profondeur, en consommant une vraie API REST publique.

## 📱 Fonctionnalités

- Recherche des stations-service par ville
- Filtrage par type de carburant (Gazole, SP95, SP95-E10, SP98, E85, GPLc)
- Tri des résultats par prix croissant
- Gestion des ruptures de stock : distinction entre "station qui ne possède pas cette pompe" (masquée) et "rupture temporaire/définitive" (affichée avec le prix en N/A)
- Recherche insensible à la casse et aux accents

## 🛠️ Stack technique

- **Flutter** / **Dart**
- Package [`http`](https://pub.dev/packages/http) pour les appels réseau
- Source de données : [API officielle des prix des carburants](https://data.economie.gouv.fr) (data.economie.gouv.fr), format Opendatasoft v2.1

## 🏗️ Architecture

```
lib/
├── main.dart                  # Point d'entrée, MaterialApp
├── models/
│   └── station.dart           # Classe Station + parsing JSON (fromJson)
├── services/
│   └── fuel_api.dart          # Appel réseau vers l'API gouvernementale
└── screens/
    └── home_screen.dart       # Formulaire de recherche + affichage des résultats
```

## 🚀 Lancer le projet

```bash
flutter pub get
flutter run
```

## 📄 Source des données

Les données proviennent de l'[API prix des carburants](https://data.economie.gouv.fr/explore/dataset/prix-des-carburants-en-france-flux-instantane-v2/), mise à disposition en open data par le gouvernement français.