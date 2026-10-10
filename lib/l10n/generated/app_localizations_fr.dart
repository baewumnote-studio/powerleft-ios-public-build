// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appName => 'PowerLeft';

  @override
  String get homeRuntimeTitle => 'Combien de temps tiendra la batterie ?';

  @override
  String get homeRuntimeSubtitle => 'Batterie + appareils → autonomie';

  @override
  String get homeRuntimeCta => 'Calculer l\'autonomie';

  @override
  String get homeNeededTitle => 'De quelle batterie ai-je besoin ?';

  @override
  String get homeNeededSubtitle => 'Appareils + heures → capacité';

  @override
  String get homeNeededCta => 'Dimensionner la batterie';

  @override
  String get homeSavedTitle => 'Configurations enregistrées';

  @override
  String get commonSeeAll => 'Tout voir';

  @override
  String get commonAdd => 'Ajouter';

  @override
  String get commonSave => 'Enregistrer';

  @override
  String get commonCancel => 'Annuler';

  @override
  String get commonDone => 'Terminé';

  @override
  String get commonDelete => 'Supprimer';

  @override
  String get commonEdit => 'Modifier';

  @override
  String get commonReset => 'Réinitialiser';

  @override
  String get commonHours => 'heures';

  @override
  String get commonMinutes => 'min';

  @override
  String get commonDays => 'jours';

  @override
  String get onboarding1Title =>
      'Sachez combien de temps votre énergie tiendra.';

  @override
  String get onboarding1Body =>
      'Ajoutez votre batterie et vos appareils pour estimer une autonomie réaliste.';

  @override
  String get onboardingNext => 'Suivant';

  @override
  String get onboardingSkip => 'Ignorer';

  @override
  String get onboarding2Title => 'Planifiez avant d\'acheter.';

  @override
  String get onboarding2Body =>
      'Estimez la capacité nécessaire. Aucun compte requis — vos configurations restent sur cet appareil.';

  @override
  String get onboardingStart => 'Commencer';

  @override
  String get runtimeTitle => 'Autonomie';

  @override
  String get runtimeBattery => 'Batterie';

  @override
  String get runtimeCapacity => 'Capacité';

  @override
  String get runtimeCharge => 'Charge actuelle';

  @override
  String get runtimeConnection => 'Connexion';

  @override
  String get runtimeDevices => 'Appareils';

  @override
  String get runtimeAddDevice => 'Ajouter un appareil';

  @override
  String get runtimeTotalLoad => 'Charge moyenne totale';

  @override
  String get runtimeCalculate => 'Calculer l\'autonomie';

  @override
  String get runtimeAdvanced => 'Réglages avancés';

  @override
  String get runtimeReserve => 'Réserve minimale';

  @override
  String get runtimeEfficiency => 'Rendement';

  @override
  String get runtimeAutomatic => 'Automatique';

  @override
  String get runtimeMaxOutput => 'Puissance continue max.';

  @override
  String get resultRuntimeTitle => 'Autonomie estimée';

  @override
  String get resultRuntimeTypical => 'Estimation typique';

  @override
  String get resultConservative => 'Prudente';

  @override
  String get resultTypical => 'Typique';

  @override
  String get resultBest => 'Meilleur cas';

  @override
  String get resultAvailableEnergy => 'Énergie effective';

  @override
  String get resultAverageLoad => 'Charge moyenne';

  @override
  String get resultAssumptions => 'À propos du calcul';

  @override
  String get resultSaveSetup => 'Enregistrer la configuration';

  @override
  String get resultUpdateSetup => 'Mettre à jour';

  @override
  String get resultAdjust => 'Ajuster les appareils';

  @override
  String get neededTitle => 'Batterie nécessaire';

  @override
  String get neededDesiredRuntime => 'Autonomie souhaitée';

  @override
  String get neededCalculate => 'Calculer la capacité';

  @override
  String get neededResultTitle => 'Capacité recommandée';

  @override
  String get neededMinimum => 'Minimum calculé';

  @override
  String get neededRecommended => 'Recommandée';

  @override
  String get neededComfortable => 'Avec marge';

  @override
  String get neededEnergyDemand => 'Besoin énergétique';

  @override
  String get deviceSearch => 'Rechercher des appareils';

  @override
  String get deviceCustom => 'Ajouter un appareil personnalisé';

  @override
  String get deviceName => 'Nom de l\'appareil';

  @override
  String get deviceWattage => 'Puissance';

  @override
  String get deviceUsage => 'Utilisation';

  @override
  String get deviceUsageAlways => 'Toujours allumé';

  @override
  String get deviceUsageUsually => 'Souvent allumé';

  @override
  String get deviceUsageCycles => 'Cyclique';

  @override
  String get deviceUsageOccasional => 'Occasionnel';

  @override
  String get deviceUsageCustom => 'Personnalisé';

  @override
  String get deviceConnectionDefault => 'Valeur par défaut du calculateur';

  @override
  String get deviceStartupSurge => 'Pic de démarrage';

  @override
  String get deviceLabelHint =>
      'Vérifiez si possible l\'étiquette du produit ou utilisez un wattmètre.';

  @override
  String get deviceFridgeHint =>
      'Les appareils à compresseur fonctionnent par cycles. La puissance nominale n\'est pas la même que la puissance moyenne.';

  @override
  String get deviceCpapHint =>
      'L\'humidificateur et le circuit chauffant peuvent modifier fortement la consommation. Utilisez la puissance de votre configuration réelle.';

  @override
  String get savedEmptyTitle => 'Aucune configuration enregistrée';

  @override
  String get savedEmptyBody =>
      'Enregistrez une configuration camping ou secours pour la réutiliser.';

  @override
  String get appliancesTitle => 'Mes appareils';

  @override
  String get appliancesEmptyTitle => 'Aucun appareil enregistré';

  @override
  String get appliancesEmptyBody =>
      'Enregistrez les appareils fréquents pour calculer plus vite.';

  @override
  String get toolsTitle => 'Outils';

  @override
  String get toolsConverter => 'Convertisseur Wh ↔ Ah';

  @override
  String get converterWhToAh => 'Wh → Ah';

  @override
  String get converterAhToWh => 'Ah → Wh';

  @override
  String get converterVoltage => 'Tension';

  @override
  String get converterResult => 'Résultat';

  @override
  String get settingsTitle => 'Réglages';

  @override
  String get settingsTheme => 'Thème';

  @override
  String get settingsThemeSystem => 'Système';

  @override
  String get settingsThemeLight => 'Clair';

  @override
  String get settingsThemeDark => 'Sombre';

  @override
  String get settingsDefaults => 'Valeurs par défaut';

  @override
  String get settingsDefaultConnection => 'Connexion par défaut';

  @override
  String get settingsResetDefaults => 'Réinitialiser les valeurs';

  @override
  String get settingsPrivacy => 'Confidentialité';

  @override
  String get settingsPrivacyOptions => 'Options de confidentialité';

  @override
  String get settingsPrivacyPolicy => 'Politique de confidentialité';

  @override
  String get settingsAbout => 'À propos';

  @override
  String get aboutCalculation => 'Notes de calcul';

  @override
  String get aboutDisclaimer => 'Avertissement';

  @override
  String get errorInvalidCapacity =>
      'Saisissez une capacité supérieure à 0 Wh.';

  @override
  String get errorInvalidWattage => 'Saisissez une puissance supérieure à 0 W.';

  @override
  String get errorNoDevices => 'Ajoutez au moins un appareil.';

  @override
  String get errorInvalidRuntime => 'Saisissez une durée supérieure à 0.';

  @override
  String get errorChargeRange =>
      'La charge doit être comprise entre 0% et 100%.';

  @override
  String get errorReserveNoEnergy =>
      'La réserve ne laisse aucune charge utilisable.';

  @override
  String get warningSurgeTitle => 'Vérifiez le pic de démarrage';

  @override
  String get warningSurgeBody =>
      'Certains moteurs et compresseurs demandent brièvement beaucoup plus de puissance au démarrage. Vérifiez que votre station peut supporter ce pic.';

  @override
  String get warningOutputTitle => 'La limite de sortie peut être dépassée';

  @override
  String get warningOutputBody =>
      'La somme des puissances nominales dépasse la puissance continue maximale saisie.';

  @override
  String get warningLowLoadTitle => 'Estimation à faible charge';

  @override
  String get warningLowLoadBody =>
      'À faible charge AC, le rendement peut être inférieur car la station consomme de l\'énergie simplement pour maintenir l\'onduleur actif.';

  @override
  String get warningCpapTitle => 'Équipement critique';

  @override
  String get warningCpapBody =>
      'Ne comptez pas uniquement sur cette estimation pour un équipement médicalement nécessaire. Suivez les consignes des fabricants et testez votre configuration réelle.';

  @override
  String get disclaimerShort =>
      'L\'autonomie réelle varie selon le comportement des appareils, les pertes de conversion, la température, l\'état de la batterie et la consommation propre de la station.';

  @override
  String get disclaimerFull =>
      'PowerLeft fournit uniquement des estimations de planification. L\'autonomie, la compatibilité au démarrage et la sécurité électrique ne sont pas garanties. Vérifiez les limites du fabricant et testez les configurations critiques.';

  @override
  String get privacyLocal =>
      'Vos batteries et configurations enregistrées restent sur cet appareil.';

  @override
  String get privacyNoAccount => 'Aucun compte requis.';

  @override
  String get adPrivacyNote =>
      'Les annonces sont fournies par Google AdMob, qui peut traiter des données d\'appareil, publicitaires, d\'utilisation et de diagnostic selon vos choix de consentement et la loi applicable.';

  @override
  String get homeQuickTools => 'Outils rapides';

  @override
  String get categoryAll => 'Tous';

  @override
  String get categoryCamping => 'Camping';

  @override
  String get categoryHomeBackup => 'Secours maison';

  @override
  String get categoryOutdoor => 'Extérieur';

  @override
  String get categoryHighDraw => 'Forte puissance';

  @override
  String get devicePortableFridge => 'Réfrigérateur portable';

  @override
  String get deviceElectricBlanket => 'Couverture chauffante';

  @override
  String get deviceLedLight => 'Lampe LED';

  @override
  String get deviceFan => 'Ventilateur';

  @override
  String get devicePhoneCharger => 'Chargeur de téléphone';

  @override
  String get deviceLaptop => 'Ordinateur portable';

  @override
  String get deviceCpap => 'CPAP';

  @override
  String get deviceRefrigerator => 'Réfrigérateur';

  @override
  String get deviceFreezer => 'Congélateur';

  @override
  String get deviceWifiRouter => 'Routeur Wi-Fi';

  @override
  String get deviceModem => 'Modem';

  @override
  String get deviceTv => 'TV';

  @override
  String get deviceDesktopPc => 'PC de bureau';

  @override
  String get deviceProjector => 'Projecteur';

  @override
  String get deviceSpeaker => 'Enceinte';

  @override
  String get deviceCameraCharger => 'Chargeur d\'appareil photo';

  @override
  String get deviceDroneCharger => 'Chargeur de drone';

  @override
  String get deviceCoffeeMaker => 'Cafetière';

  @override
  String get deviceMicrowave => 'Micro-ondes';

  @override
  String get deviceInductionCooktop => 'Plaque à induction';

  @override
  String get deviceHairDryer => 'Sèche-cheveux';

  @override
  String get commonWh => 'Wh';

  @override
  String get commonKwh => 'kWh';

  @override
  String get commonWatts => 'W';

  @override
  String get commonPercent => '%';

  @override
  String get connectionAc => 'AC';

  @override
  String get connectionDc => '12V DC';

  @override
  String get connectionUsbC => 'USB-C';

  @override
  String get fieldOptional => 'Facultatif';

  @override
  String get saveSetupName => 'Nom de la configuration';

  @override
  String get saveSetupDefaultRuntime => 'Configuration autonomie';

  @override
  String get saveSetupDefaultBattery => 'Plan batterie';

  @override
  String get dialogSaveSetupTitle => 'Enregistrer cette configuration';

  @override
  String get dialogDeleteTitle => 'Supprimer la configuration ?';

  @override
  String get dialogDeleteBody => 'Cette action est irréversible.';

  @override
  String get commonClose => 'Fermer';

  @override
  String get commonBackHome => 'Retour à l\'accueil';

  @override
  String get resultRange => 'Plage estimée';

  @override
  String get resultInputLoad => 'Charge nominale';

  @override
  String get neededRoundedPlan => 'Seuil de planification';

  @override
  String get settingsReserveHelp =>
      'Pourcentage de charge volontairement laissé inutilisé.';

  @override
  String get settingsPrivacyOptionsUnavailable =>
      'Aucune option de confidentialité n\'est requise pour votre région ou votre état de consentement.';

  @override
  String get aboutTitle => 'À propos de PowerLeft';

  @override
  String get aboutLocalDataTitle => 'Vos données';

  @override
  String get aboutLocalDataBody =>
      'Les batteries, appareils et configurations enregistrés restent sur cet appareil.';

  @override
  String get aboutEstimateTitle => 'Estimations de planification';

  @override
  String get aboutEstimateBody =>
      'L\'autonomie peut varier avec la température, l\'état de la batterie, la consommation de l\'onduleur, les cycles des appareils et les pics de démarrage.';

  @override
  String get aboutMedicalTitle => 'Équipement critique';

  @override
  String get aboutMedicalBody =>
      'N\'utilisez pas PowerLeft comme seule méthode de planification de secours pour un équipement médicalement nécessaire.';

  @override
  String get converterEnergy => 'Énergie';

  @override
  String get converterCapacity => 'Capacité';

  @override
  String get converterFormula => 'Formule';

  @override
  String get converterEnterValues => 'Saisissez des valeurs positives valides.';

  @override
  String get customPercentLabel => 'Taux d\'utilisation %';

  @override
  String get deviceSaveToMyDevices => 'Enregistrer dans Mes appareils';

  @override
  String get deviceTypicalRange => 'Plage typique';

  @override
  String get deviceConfirmValue =>
      'Vérifiez ou modifiez la puissance avant l\'ajout.';

  @override
  String get savedUpdated => 'Mis à jour';

  @override
  String get setupModeRuntime => 'Autonomie';

  @override
  String get setupModeBattery => 'Batterie nécessaire';

  @override
  String get setupRecalculate => 'Recalculer';

  @override
  String get myAppliancesAdd => 'Ajouter un appareil personnalisé';

  @override
  String get myAppliancesDeleteTitle => 'Supprimer l\'appareil ?';

  @override
  String get myAppliancesDeleteBody =>
      'Les configurations enregistrées conservent leur valeur actuelle.';

  @override
  String get settingsVersion => 'Version 1.0.0';

  @override
  String get commonNotAvailable => 'Indisponible';

  @override
  String get homeSubtitle =>
      'L\'autonomie de votre batterie, sans approximation hasardeuse.';

  @override
  String get batteryChargeValue => 'Charge';

  @override
  String get capacityUnit => 'Unité de capacité';

  @override
  String get runtimeNoUsableEnergy =>
      'Il ne reste aucune énergie utilisable au-dessus de votre réserve.';

  @override
  String get runtimeCapacityUnit => 'Unité de capacité';

  @override
  String get runtimeReserveHelp =>
      'Laissez ce pourcentage de charge inutilisé.';

  @override
  String get runtimeEfficiencyPercent => 'Rendement %';

  @override
  String get runtimeEfficiencyHelp =>
      'Laissez vide pour utiliser la valeur par défaut de la connexion.';

  @override
  String get runtimeMaxOutputHelp =>
      'Facultatif. Utilisé uniquement pour avertir si la charge nominale est trop élevée.';

  @override
  String get runtimeBatteryEmpty => 'La batterie est vide.';

  @override
  String get runtimeResultSaved => 'Configuration enregistrée.';

  @override
  String get runtimeSaveFailed => 'Impossible d\'enregistrer la configuration.';

  @override
  String get resultTypicalEnergy => 'Énergie effective typique';

  @override
  String get resultRatedLoad => 'Charge nominale combinée';

  @override
  String get resultAboutEstimate =>
      'L\'autonomie réelle peut varier selon les cycles des appareils, la température, l\'état de la batterie, les pertes de conversion et la consommation propre de la station.';

  @override
  String get neededHoursHint => 'Saisir les heures';

  @override
  String get neededQuick => 'Sélection rapide';

  @override
  String get neededResultSaved => 'Plan batterie enregistré.';

  @override
  String get saveSetupNameRequired => 'Saisissez un nom de configuration.';

  @override
  String get savedTitle => 'Configurations enregistrées';

  @override
  String get savedDelete => 'Supprimer la configuration';

  @override
  String get savedEmptyAction =>
      'Enregistrez un calcul pour le réutiliser plus tard.';

  @override
  String get setupDetails => 'Détails de la configuration';

  @override
  String get setupDevices => 'Appareils';

  @override
  String get setupBattery => 'Batterie';

  @override
  String get setupDesired => 'Autonomie souhaitée';

  @override
  String get setupConnection => 'Connexion';

  @override
  String get setupNotFound => 'Cette configuration est introuvable.';

  @override
  String get settingsDefaultReserve => 'Réserve par défaut';

  @override
  String get settingsResetDone => 'Valeurs par défaut restaurées.';

  @override
  String get settingsPrivacyExplanation =>
      'Les choix de confidentialité sont gérés par Google UMP lorsque nécessaire. Les calculs principaux fonctionnent sans compte.';

  @override
  String get aboutPrivacyTitle => 'Publicité et confidentialité';

  @override
  String get aboutPrivacyBody =>
      'PowerLeft stocke les données du calculateur localement. Google AdMob peut traiter des données d\'appareil, publicitaires, d\'utilisation et de diagnostic selon vos choix de consentement et la loi applicable.';

  @override
  String get aboutNoGuarantee =>
      'PowerLeft est un outil d\'estimation. Il ne garantit ni l\'autonomie, ni la compatibilité au démarrage, ni la sécurité électrique.';

  @override
  String get converterWh => 'Watt-heures (Wh)';

  @override
  String get converterAh => 'Ampère-heures (Ah)';

  @override
  String get converterVoltageV => 'Tension (V)';

  @override
  String get converterWhToAhFormula => 'Ah = Wh ÷ V';

  @override
  String get converterAhToWhFormula => 'Wh = Ah × V';

  @override
  String get commonHoursShort => 'h';

  @override
  String get commonSaveSetup => 'Enregistrer la configuration';

  @override
  String get commonUpdateSetup => 'Mettre à jour';

  @override
  String get commonRecalculate => 'Recalculer';

  @override
  String get commonRemove => 'Supprimer';

  @override
  String get commonContinue => 'Continuer';

  @override
  String get adNoImpact =>
      'Les annonces ne bloquent jamais l\'affichage de votre résultat.';

  @override
  String get commonMinutesShort => 'min';

  @override
  String get commonDaysShort => 'j';

  @override
  String get batteryProfilesTitle => 'Batteries enregistrées';

  @override
  String get batteryProfileChoose => 'Choisir une batterie enregistrée';

  @override
  String get batteryProfileAdd => 'Ajouter une batterie';

  @override
  String get batteryProfileName => 'Nom de la batterie';

  @override
  String get batteryProfileCapacity => 'Capacité';

  @override
  String get batteryProfileMaxOutput => 'Puissance continue max.';

  @override
  String get batteryProfileEmpty => 'Aucune batterie enregistrée';

  @override
  String get batteryProfileEmptyBody =>
      'Enregistrez une station ou une batterie que vous utilisez souvent.';

  @override
  String get batteryProfileApplied => 'Batterie enregistrée appliquée.';

  @override
  String get batteryProfileCharge => 'Charge par défaut';

  @override
  String get batteryProfileDelete => 'Supprimer la batterie';

  @override
  String get errorReserveRange =>
      'La réserve doit être comprise entre 0% et 50%.';

  @override
  String get errorEfficiencyRange =>
      'Le rendement doit être compris entre 50% et 99%.';

  @override
  String get errorLoadData => 'Impossible de charger les données enregistrées.';

  @override
  String get errorSaveData => 'Impossible d\'enregistrer les modifications.';

  @override
  String get privacyPolicyTitle => 'Politique de confidentialité';

  @override
  String get privacyPolicyLocalTitle => 'Données du calculateur';

  @override
  String get privacyPolicyLocalBody =>
      'Les profils de batterie, appareils personnalisés et configurations enregistrées sont stockés localement sur cet appareil. PowerLeft ne nécessite pas de compte et n\'envoie pas ces données vers un serveur PowerLeft.';

  @override
  String get privacyPolicyAdsTitle => 'Publicité';

  @override
  String get privacyPolicyAdsBody =>
      'PowerLeft utilise des annonces interstitielles Google AdMob. Selon votre région, vos choix de consentement, les réglages de l\'appareil et la configuration Google Mobile Ads, Google et ses partenaires peuvent traiter des identifiants d\'appareil, une localisation générale déduite de l\'adresse IP, les interactions publicitaires, l\'utilisation et les diagnostics.';

  @override
  String get privacyPolicyConsentTitle => 'Choix de confidentialité';

  @override
  String get privacyPolicyConsentBody =>
      'Lorsque cela est requis, PowerLeft utilise Google User Messaging Platform (UMP) pour recueillir ou gérer vos choix avant de demander des annonces. Les fonctions principales du calculateur continuent de fonctionner même si les annonces ne sont pas disponibles.';

  @override
  String get privacyPolicyTrackingTitle => 'Autorisation de suivi';

  @override
  String get privacyPolicyTrackingBody =>
      'Le MVP ne demande pas intentionnellement l\'autorisation App Tracking Transparency (ATT) d\'Apple. Si une future version commence un suivi au sens d\'Apple, l\'app et cette politique devront être mises à jour avant publication.';

  @override
  String get privacyPolicyRetentionTitle => 'Conservation';

  @override
  String get privacyPolicyRetentionBody =>
      'Les données du calculateur restent sur votre appareil jusqu\'à leur suppression ou la suppression/réinitialisation de l\'app. La conservation des données publicitaires suit les politiques de Google et de ses partenaires.';

  @override
  String get privacyPolicyChildrenTitle => 'Enfants';

  @override
  String get privacyPolicyChildrenBody =>
      'PowerLeft n\'est pas conçu ni commercialisé comme une application pour enfants.';

  @override
  String get privacyPolicyContactTitle => 'Contact';

  @override
  String get privacyPolicyContactBody =>
      'Pour toute question de confidentialité ou d’assistance, utilisez le lien d’assistance public sur la page App Store de PowerLeft.';

  @override
  String get errorCapacityRange =>
      'Saisissez une capacité supérieure à 0 et inférieure ou égale à 100 000 Wh.';

  @override
  String get errorWattageRange =>
      'Saisissez une puissance supérieure à 0 et inférieure ou égale à 10 000 W.';

  @override
  String get errorRuntimeRange =>
      'Saisissez une durée supérieure à 0 et inférieure ou égale à 336 heures.';

  @override
  String get errorMaxOutputRange =>
      'La puissance continue maximale doit être supérieure à 0 W.';

  @override
  String get errorNameRequired => 'Saisissez un nom.';

  @override
  String get settingsDataTitle => 'Données enregistrées';

  @override
  String get settingsDeleteLocalData => 'Supprimer les données enregistrées';

  @override
  String get settingsDeleteLocalDataBody =>
      'Supprime toutes les batteries, appareils personnalisés et configurations enregistrés sur cet appareil. Les réglages et choix de confidentialité sont conservés.';

  @override
  String get settingsDeleteLocalDataConfirm =>
      'Supprimer les données enregistrées ?';

  @override
  String get settingsDeleteLocalDataDone => 'Données enregistrées supprimées.';

  @override
  String get categoryOther => 'Autre';

  @override
  String get setupRenameTitle => 'Renommer la configuration';

  @override
  String get setupRenameDone => 'Configuration renommée.';

  @override
  String get categoryWork => 'Travail';

  @override
  String get deviceCategory => 'Catégorie';

  @override
  String get devicePortableMonitor => 'Écran portable';

  @override
  String get deviceWorkLight => 'Lampe de travail';

  @override
  String get devicePowerToolCharger => 'Chargeur d’outil électrique';

  @override
  String get deviceSolderingIron => 'Fer à souder';

  @override
  String get aboutOpenSourceLicenses => 'Licences open source';

  @override
  String get aboutOpenSourceBody =>
      'Afficher les licences de Flutter et des paquets tiers utilisés par PowerLeft.';

  @override
  String get converterCaveat =>
      'Les Ah dépendent de la tension. La chimie de la batterie, les pertes de conversion, la réserve et le comportement des appareils peuvent réduire l’énergie utilisable ; cette conversion ne garantit donc pas l’autonomie.';

  @override
  String get errorCalculation =>
      'Impossible de calculer avec ces valeurs. Vérifiez les données et réessayez.';

  @override
  String get warningReserveTitle => 'Aucune charge utilisable';

  @override
  String get designTagline => 'Prévoir l’énergie. Aller plus loin.';

  @override
  String get designRuntimeQuestion => 'Combien de\ntemps ?';

  @override
  String get designNeededQuestion => 'Quelle\ncapacité ?';

  @override
  String get designCampTitle => 'Plus d’énergie pour vos moments.';

  @override
  String get designCampBody => 'CAMPING · VOYAGE · SECOURS';

  @override
  String get designRuntimeHelp =>
      'Indiquez la batterie et les appareils à alimenter.';

  @override
  String get designNeededHelp =>
      'Choisissez les appareils et la durée souhaitée.';

  @override
  String get designCompareHint => 'Comparez trois conditions réalistes.';

  @override
  String get designDetails => 'Détails du calcul';

  @override
  String get designSavedHint => 'Retrouvez vos calculs favoris.';

  @override
  String get designAppliancesHint => 'Vos appareils prêts à ajouter.';

  @override
  String get designBatteriesHint => 'Gardez les données de vos batteries.';

  @override
  String get designToolsHint => 'Conversions et principes de calcul.';

  @override
  String get designRuntimeBody => 'Estimez l’autonomie de vos appareils.';

  @override
  String get designNeededBody => 'Trouvez la capacité adaptée à vos projets.';

  @override
  String get settingsLanguage => 'Langue';

  @override
  String get settingsLanguageSystem => 'Langue de l’appareil';
}
