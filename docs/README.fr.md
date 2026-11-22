# GTV Remote

<p align="center">
  <img src="../assets/app_icon.png" alt="GTV Remote Icon" width="128" height="128" />
</p>

<p align="center">
  <strong>Une télécommande macOS native et moderne avec lanceur d'apps rapides pour Google TV / Android TV.</strong><br>
  <em>Contrôle TLS bidirectionnel à faible latence, découverte automatique mDNS, saisie de texte instantanée, lanceurs d'apps rapides et raccourcis clavier directement depuis votre Mac.</em>
</p>

<p align="center">
  <a href="https://github.com/badugisoft/gtv-remote/releases/latest"><img src="https://img.shields.io/github/v/release/badugisoft/gtv-remote?style=flat-square" alt="Latest Release" /></a>
  <a href="https://github.com/badugisoft/gtv-remote/releases"><img src="https://img.shields.io/github/downloads/badugisoft/gtv-remote/total?style=flat-square" alt="Total Downloads" /></a>
  <a href="https://badugisoft.github.io/gtv-remote/"><img src="https://img.shields.io/badge/Website-GitHub%20Pages-2563eb?style=flat-square" alt="Project Website" /></a>
  <img src="https://img.shields.io/badge/macOS-14.0%2B-black?style=flat-square&logo=apple" alt="macOS 14+" />
  <img src="https://img.shields.io/badge/Swift-6.0%2B-orange?style=flat-square&logo=swift" alt="Swift 6.0+" />
  <img src="https://img.shields.io/badge/Architecture-Apple%20Silicon%20%7C%20Intel-blue?style=flat-square" alt="Apple Silicon & Intel" />
  <img src="https://img.shields.io/badge/100%25-Built%20with%20Antigravity-blue?style=flat-square" alt="100% Built with Antigravity" />
  <img src="https://img.shields.io/badge/License-MIT-green?style=flat-square" alt="MIT License" />
</p>

<p align="center">
  <a href="../README.md">English</a> ·
  <a href="README.ko.md">한국어</a> ·
  <a href="README.zh-Hans.md">简体中文</a> ·
  <a href="README.ja.md">日本語</a> ·
  <a href="README.de.md">Deutsch</a> ·
  <strong>Français</strong> ·
  <a href="README.es.md">Español</a>
</p>

<p align="center">
  <a href="https://badugisoft.github.io/gtv-remote/"><strong>🌐 Site du projet</strong></a> ·
  <a href="https://github.com/badugisoft/gtv-remote/releases/latest"><strong>⬇️ Télécharger la dernière version</strong></a> ·
  <a href="#captures-décran">Captures d'écran</a> ·
  <a href="#fonctionnalités">Fonctionnalités</a> ·
  <a href="#raccourcis-clavier">Raccourcis</a> ·
  <a href="#installation">Installation</a> ·
  <a href="#faq--dépannage">FAQ</a> ·
  <a href="#contribuer--sécurité">Contribuer</a>
</p>

---

> [!NOTE]
> **🤖 100 % conçu avec Google Antigravity**
>
> L'intégralité de cette application — incluant la communication par socket TLS, la sérialisation Protobuf, la découverte automatique mDNS, les vues SwiftUI, la surveillance des touches du clavier, la réorganisation par glisser-déposer des apps rapides, la localisation en 7 langues et l'automatisation du build — a été **100 % conçue, implémentée et vérifiée en programmation en binôme autonome avec Google Antigravity**.

---

## Captures d'écran

<p align="center">
  <img src="../assets/remote_main.png" alt="Fenêtre principale de GTV Remote" height="460" />
  <img src="../assets/quick_apps_settings.png" alt="Paramètres des apps rapides" height="460" />
  <img src="../assets/keyboard_shortcuts.png" alt="Raccourcis clavier" height="460" />
  <br>
  <em>GTV Remote : Interface native macOS en verre dépoli, gestionnaire d'apps rapides et raccourcis clavier</em>
</p>

---

## Fonctionnalités

- **Expérience macOS native** :
  - Développée à 100 % en Swift, SwiftUI et AppKit avec le matériau natif en verre dépoli `.sidebar` (`NSVisualEffectView`).
  - Icône de télécommande inclinée à 45 degrés dans la barre des menus macOS pour un accès ou un basculement en un clic.
  - La fenêtre reste résidente en arrière-plan une fois fermée ; sa réouverture via le Dock ou la barre des menus est instantanée sans redémarrer le processus.

- **Découverte réseau zéro-configuration et reconnexion instantanée** :
  - Découverte automatique Bonjour / mDNS de tous les appareils Google TV et Android TV sur votre réseau local (`_androidtvremote2._tcp`).
  - Suivi en temps réel des changements d'adresse IP et synchronisation automatique lors d'une réattribution DHCP.
  - Limite de sécurité sur les tentatives de reconnexion évitant les boucles infinies.
  - Résolution des noms d'appareils Unicode et internationaux.
  - Mémorise automatiquement le dernier téléviseur connecté et rétablit instantanément la connexion au lancement.

- **Connexion TLS rapide, sécurisée & confidentialité locale** :
  - Chiffrement TLS mutuel bidirectionnel conforme au protocole Android TV Remote v2.
  - Génération intégrée de certificats clients RSA-2048 temporaires via le framework `Security` d'Apple (aucun binaire `openssl` externe requis).
  - **100 % local et sans télémétrie** : tout le trafic reste sur votre réseau Wi-Fi/LAN sans aucune analyse ni serveur externe. Voir [SECURITY.md](../SECURITY.md).

- **Navigation complète au clavier et retour visuel** :
  - Naviguez dans les menus TV avec les flèches, `Entrée`, `Échap`, `H`, `Espace` et les touches de volume.
  - **Animations de retour de pression en temps réel (0,15 s)** mettant en surbrillance les boutons à l'écran lors d'une frappe clavier.

- **Saisie de texte intelligente et synchronisation du presse-papiers** :
  - Barre de saisie intelligente intégrée pour taper recherches, URL et mots de passe directement sur la TV.
  - Collage en un clic ou via `Cmd + V` pour envoyer le texte de votre presse-papiers Mac vers le champ de saisie de la TV.

- **Lanceur d'apps rapides personnalisable** :
  - Préréglages intégrés pour les plateformes populaires : **YouTube, Netflix, Disney+, Apple TV, Prime Video, Coupang Play, Max, Paramount+, YouTube TV, Tubi, Pluto TV, Google Play Store, Surfshark, Plex, Spotify, Twitch, Stremio**.
  - Gestionnaire unifié avec **réorganisation par glisser-déposer** et cases à cocher de visibilité.
  - Ajout, modification et suppression de liens profonds personnalisés (`https://` ou `app://`).
  - Grille fixe à 3 colonnes conservant des dimensions de boutons homogènes.
  - Raccourcis numériques directs (`1` à `9`) pour lancer instantanément vos apps rapides principales.

- **Localisation multilingue (7 langues)** :
  - Prend en charge **English**, **한국어 (coréen)**, **简体中文 (chinois simplifié)**, **日本語 (japonais)**, **Deutsch (allemand)**, **Français** et **Español (espagnol)**.
  - Respecte automatiquement la langue système de macOS au premier lancement.
  - Bouton globe dédié dans l'en-tête pour changer de langue à tout moment.

---

## Raccourcis clavier

Lorsque la fenêtre de la télécommande est active, les raccourcis suivants sont disponibles :

| Touche | Fonction télécommande | Description |
| :--- | :--- | :--- |
| **Flèches (↑ ↓ ← →)** | `DPAD_UP / DOWN / LEFT / RIGHT` | Navigation directionnelle |
| **Retour / Entrée** | `DPAD_CENTER` | Sélectionner / OK |
| **Échap / Retour arrière** | `BACK` | Retour / Quitter le menu |
| **H** | `HOME` | Aller à l'écran d'accueil TV |
| **Espace** | `MEDIA_PLAY_PAUSE` | Lecture / Pause |
| **+ / =** | `VOLUME_UP` | Augmenter le volume |
| **- / _** | `VOLUME_DOWN` | Baisser le volume |
| **M** | `VOLUME_MUTE` | Couper / Rétablir le son |
| **P** | `POWER` | Allumer / Éteindre |
| **A** | `ASSISTANT` | Lancer l'Assistant Google |
| **I** | `INPUT` | Changer la source d'entrée vidéo |
| **1 ~ 9** | App rapide 1–9 | Lancer directement l'app rapide 1 à 9 |
| **Cmd + V** | Synchro presse-papiers | Envoyer le texte du presse-papiers Mac à la TV |
| **Cmd + W** | Masquer la fenêtre | Masquer la fenêtre (reste active en arrière-plan) |

---

## Installation

### Option 1 : Télécharger une version précompilée (Recommandé)

1. Téléchargez la dernière archive `GTV-Remote-v*.dmg` ou `GTV-Remote-v*.zip` depuis [GitHub Releases](https://github.com/badugisoft/gtv-remote/releases/latest).
2. Ouvrez le `.dmg` (ou décompressez le `.zip`) et glissez **GTV Remote.app** dans votre dossier `/Applications`.
3. Lancez **GTV Remote** depuis `/Applications`.

> **Signé et notarié :** Les versions officielles (`v1.0.5+`) sont signées avec un certificat Apple Developer ID et notariées par Apple, ce qui permet de les ouvrir directement sans avertissement Gatekeeper.

---

### Option 2 : Compiler depuis les sources (via Makefile)

#### Prérequis
- macOS 14.0 (Sonoma) ou ultérieur
- Xcode 16+ ou outils en ligne de commande Swift 6.0+

#### Compilation et installation

Clonez le dépôt et exécutez :

```bash
# Compiler le binaire Release, créer /Applications/GTV Remote.app et lancer
make install

# Générer .app, .dmg et .zip dans dist/
make package
```

Pour nettoyer les fichiers de compilation :
```bash
make clean
```

Pour désinstaller :
```bash
make uninstall
```

---

## FAQ & Dépannage

<details>
<summary><strong>GTV Remote est-il signé et notarié par Apple ?</strong></summary>

Oui. Les versions officielles à partir de `v1.0.5` sont signées avec un Apple Developer ID et notariées par Apple, et s'ouvrent sans avertissement Gatekeeper. Si vous utilisez une version antérieure (`v1.0.4` ou précédente), veuillez mettre à jour vers la dernière version.

</details>

<details>
<summary><strong>Mon téléviseur Google TV / Android TV n'apparaît pas dans la liste</strong></summary>

1. Vérifiez que votre Mac et la TV sont sur le même sous-réseau Wi-Fi.
2. Autorisez **GTV Remote** dans **Réglages Système → Confidentialité et sécurité → Réseau local**.
3. Assurez-vous que **Android TV Remote Service** est activé sur la TV, puis relancez une recherche dans l'app.

</details>

<details>
<summary><strong>Comment fonctionnent les liens profonds personnalisés dans Quick Apps ?</strong></summary>

Ouvrez les **Paramètres des apps rapides** pour réorganiser par glisser-déposer ou ajouter des apps via `https://` ou `app://`. Les 9 premières apps visibles sont liées aux touches `1` à `9`.

</details>

<details>
<summary><strong>GTV Remote collecte-t-il des données ou contacte-t-il des serveurs externes ?</strong></summary>

Non. Toute communication reste strictement sur votre réseau local via TLS mutuel et un certificat RSA-2048 généré localement. Voir [SECURITY.md](../SECURITY.md).

</details>

<details>
<summary><strong>Quels téléviseurs et versions de macOS sont pris en charge ?</strong></summary>

Tout appareil compatible Google TV / Android TV Remote v2 (Chromecast avec Google TV, Sony Bravia, TCL, Hisense, Nvidia Shield, etc.) et Mac sous **macOS 14.0 (Sonoma)** ou ultérieur (Apple Silicon & Intel).

</details>

---

## Structure du projet

```
gtv-remote/
├── .github/
│   ├── ISSUE_TEMPLATE/               # Modèles de rapport de bug et de suggestion
│   ├── PULL_REQUEST_TEMPLATE.md      # Liste de contrôle pour les PR
│   └── workflows/
│       ├── pages.yml                 # Déploiement automatisé GitHub Pages
│       └── release.yml               # Workflow CI/CD de publication automatisée
├── AGENTS.md                         # Directives pour agents IA et développeurs
├── CONTRIBUTING.md                   # Guide de contribution et de compilation
├── LICENSE                           # Licence MIT
├── Makefile                          # Script d'empaquetage et de déploiement
├── Package.swift                     # Manifeste Swift Package Manager
├── README.md                         # Documentation principale (anglais)
├── SECURITY.md                       # Architecture de confidentialité & signalement
├── Resources/
│   ├── AppIcon.icns                  # Icône de l'application macOS
│   └── Info.plist                    # Configuration du bundle et autorisations
├── Sources/
│   └── GTVRemote/
│       ├── App/                      # Point d'entrée & moniteur clavier
│       │   ├── GTVRemote.swift
│       │   └── KeyboardMonitor.swift
│       ├── Core/
│       │   ├── Network/              # Découverte mDNS & pont socket TLS NIO
│       │   │   ├── BonjourResolver.swift
│       │   │   ├── DeviceDiscoveryService.swift
│       │   │   ├── TLSSocketBridge.swift
│       │   │   └── TVConnectionManager.swift
│       │   ├── Proto/                # Bindings Protobuf du protocole
│       │   │   ├── pairing.pb.swift
│       │   │   └── remote.pb.swift
│       │   └── Security/             # Génération de certificat RSA-2048
│       │       └── CertificateManager.swift
│       ├── Localization/             # Moteur de localisation en 7 langues
│       │   ├── Languages/            # Chaînes par langue
│       │   ├── L10n.swift
│       │   ├── LocalizableStrings.swift # Protocole des clés de traduction
│       │   └── LocalizationManager.swift
│       ├── Models/                   # Structures de données & catalogue d'apps
│       │   ├── AppShortcut.swift
│       │   ├── Models.swift
│       │   └── RemoteKey.swift
│       ├── ViewModels/               # Logique métier observable de la télécommande
│       │   └── RemoteViewModel.swift
│       └── Views/                    # Interfaces et feuilles SwiftUI
│           ├── Components/
│           │   ├── DPadView.swift
│           │   ├── RemoteButtonStyles.swift
│           │   └── SmartInputBar.swift
│           ├── Sheets/
│           │   ├── AppShortcutsSettingsView.swift
│           │   ├── PairingSheetView.swift
│           │   └── ShortcutsView.swift
│           └── RemoteControlView.swift
├── assets/                           # Captures d'écran et médias
│   ├── app_icon.png
│   ├── keyboard_shortcuts.png
│   ├── quick_apps_settings.png
│   └── remote_main.png
├── docs/                             # Documentation traduite
│   ├── README.de.md                  # Deutsch
│   ├── README.es.md                  # Español
│   ├── README.fr.md                  # Français
│   ├── README.ja.md                  # 日本語
│   ├── README.ko.md                  # 한국어
│   └── README.zh-Hans.md             # 简体中文
└── site/                             # Site promotionnel GitHub Pages
    ├── index.html
    ├── styles.css
    └── i18n.js
```

---

## Contribuer & Sécurité

- Les contributions sont les bienvenues ! Consultez [CONTRIBUTING.md](../CONTRIBUTING.md) pour la compilation locale, les règles de traduction en 7 langues et les Pull Requests.
- Pour en savoir plus sur la confidentialité locale ou signaler une faille, consultez [SECURITY.md](../SECURITY.md).

---

## Licence Open Source

Ce projet est distribué sous **licence MIT**. Consultez le fichier [LICENSE](../LICENSE) pour plus de détails.
