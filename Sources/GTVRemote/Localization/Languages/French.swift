import Foundation

public struct FrenchStrings: LocalizableStrings {
    public init() {}

    // Connection Status
    public let connecting = "Connexion..."
    public let discovering = "Recherche de TVs..."
    public let pairingRequired = "Jumelage requis"
    public let disconnected = "Déconnecté"
    public let connectionError = "Erreur de connexion"
    public let online = "En ligne"
    public let selectTVPrompt = "Sélectionner TV"

    // Header & Menus
    public let selectDeviceTooltip = "Sélectionner le téléviseur et gérer la connexion"
    public let shortcutsTooltip = "Afficher les raccourcis clavier"
    public let languageTooltip = "Changer de langue"
    public let deviceList = "Appareils découverts"
    public let searching = "Recherche..."
    public let rescanDevices = "Rechercher à nouveau"
    public let disconnect = "Déconnecter"
    public let quitApp = "Quitter GTV Remote"

    // Remote Control Buttons
    public let powerTooltip = "Alimentation (P)"
    public let playPauseTooltip = "Lecture/Pause (Espace)"
    public let backTooltip = "Retour (Esc)"
    public let homeTooltip = "Accueil (H)"
    public let volumeDownTooltip = "Volume bas (-)"
    public let volumeUpTooltip = "Volume haut (+)"
    public let dpadSelectTooltip = "Sélectionner (Entrée)"
    public let dpadUpTooltip = "Haut (↑)"
    public let dpadDownTooltip = "Bas (↓)"
    public let dpadLeftTooltip = "Gauche (←)"
    public let dpadRightTooltip = "Droite (→)"
    public let assistantTooltip = "Assistant Google (A)"
    public let muteTooltip = "Couper le son (M)"
    public let inputTooltip = "Source d'entrée (I)"

    // Smart Input Bar
    public let inputPlaceholder = "Saisir du texte pour la TV..."
    public let send = "Envoyer"

    // Quick Apps
    public let quickApps = "Apps rapides"
    public let quickAppsSettingsTooltip = "Paramètres des apps rapides"
    public let noAppsSelected = "Sélectionnez des applications dans les paramètres"

    // Quick Apps Settings Sheet
    public let settingsTitle = "Paramètres des apps rapides"
    public let done = "Terminé"
    public func listVisibleCount(visible: Int, total: Int) -> String {
        "Liste (\(visible)/\(total) visibles)"
    }
    public let dragToReorder = "Glisser pour réorganiser"
    public let addCustomApp = "Ajouter une application"
    public let collapse = "Réduire"
    public let appNamePlaceholder = "Nom de l'app (ex: France.tv)"
    public let uriPlaceholder = "URI de lien profond (ex: https://...)"
    public let add = "Ajouter"
    public let editAppShortcut = "Modifier le raccourci d'application"
    public let appName = "Nom de l'application"
    public let deepLinkURI = "URI de lien profond"
    public let cancel = "Annuler"
    public let save = "Enregistrer"
    public let edit = "Modifier"
    public let delete = "Supprimer"

    // Pairing Sheet
    public let pairingTitle = "Associer à Google TV"
    public let pairingPrompt = "Entrez le code à 6 caractères affiché sur votre écran TV."
    public let pairingFailed = "Échec du jumelage. Veuillez vérifier le code et réessayer."
    public let pair = "Associer"

    // Keyboard Shortcuts Sheet
    public let shortcutsTitle = "Raccourcis clavier"
    public let shortcutsDesc = "Les raccourcis suivants fonctionnent lorsque la fenêtre est active."
    public let groupNav = "Navigation et sélection"
    public let groupMedia = "Médias et audio"
    public let groupSystem = "Système et applications"

    public let keyArrow = "Flèches (↑ ↓ ← →)"
    public let descArrow = "Navigation directionnelle"
    public let keyEnter = "Entrée"
    public let descEnter = "Sélectionner (OK)"
    public let keyEsc = "Échap"
    public let descEsc = "Retour"
    public let keyH = "H"
    public let descH = "Aller à l'accueil"
    public let keySpace = "Espace"
    public let descSpace = "Lecture / Pause"
    public let keyVolume = "+  /  -"
    public let descVolume = "Volume haut / bas"
    public let keyM = "M"
    public let descM = "Activer/désactiver muet"
    public let keyP = "P"
    public let descP = "Allumer / Éteindre"
    public let keyA = "A"
    public let descA = "Lancer Assistant Google"
    public let keyI = "I"
    public let descI = "Source d'entrée"
    public let keyNumbers = "1 ~ 9"
    public let descNumbers = "Lancer l'application rapide 1 à 9"
}
