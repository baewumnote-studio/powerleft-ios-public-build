import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('ja'),
    Locale('ko'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'PowerLeft'**
  String get appName;

  /// No description provided for @homeRuntimeTitle.
  ///
  /// In en, this message translates to:
  /// **'How long will it last?'**
  String get homeRuntimeTitle;

  /// No description provided for @homeRuntimeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Battery + devices → runtime'**
  String get homeRuntimeSubtitle;

  /// No description provided for @homeRuntimeCta.
  ///
  /// In en, this message translates to:
  /// **'Calculate Runtime'**
  String get homeRuntimeCta;

  /// No description provided for @homeNeededTitle.
  ///
  /// In en, this message translates to:
  /// **'How much battery do I need?'**
  String get homeNeededTitle;

  /// No description provided for @homeNeededSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Devices + hours → required capacity'**
  String get homeNeededSubtitle;

  /// No description provided for @homeNeededCta.
  ///
  /// In en, this message translates to:
  /// **'Size My Battery'**
  String get homeNeededCta;

  /// No description provided for @homeSavedTitle.
  ///
  /// In en, this message translates to:
  /// **'Saved Setups'**
  String get homeSavedTitle;

  /// No description provided for @commonSeeAll.
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get commonSeeAll;

  /// No description provided for @commonAdd.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get commonAdd;

  /// No description provided for @commonSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get commonSave;

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// No description provided for @commonDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get commonDone;

  /// No description provided for @commonDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get commonDelete;

  /// No description provided for @commonEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get commonEdit;

  /// No description provided for @commonReset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get commonReset;

  /// No description provided for @commonHours.
  ///
  /// In en, this message translates to:
  /// **'hours'**
  String get commonHours;

  /// No description provided for @commonMinutes.
  ///
  /// In en, this message translates to:
  /// **'min'**
  String get commonMinutes;

  /// No description provided for @commonDays.
  ///
  /// In en, this message translates to:
  /// **'days'**
  String get commonDays;

  /// No description provided for @onboarding1Title.
  ///
  /// In en, this message translates to:
  /// **'Know how long your power will last.'**
  String get onboarding1Title;

  /// No description provided for @onboarding1Body.
  ///
  /// In en, this message translates to:
  /// **'Add your battery and devices to get a practical runtime estimate.'**
  String get onboarding1Body;

  /// No description provided for @onboardingNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get onboardingNext;

  /// No description provided for @onboardingSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get onboardingSkip;

  /// No description provided for @onboarding2Title.
  ///
  /// In en, this message translates to:
  /// **'Plan before you buy.'**
  String get onboarding2Title;

  /// No description provided for @onboarding2Body.
  ///
  /// In en, this message translates to:
  /// **'Estimate the battery capacity you need. No account required — your saved setups stay on this device.'**
  String get onboarding2Body;

  /// No description provided for @onboardingStart.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get onboardingStart;

  /// No description provided for @runtimeTitle.
  ///
  /// In en, this message translates to:
  /// **'Runtime'**
  String get runtimeTitle;

  /// No description provided for @runtimeBattery.
  ///
  /// In en, this message translates to:
  /// **'Battery'**
  String get runtimeBattery;

  /// No description provided for @runtimeCapacity.
  ///
  /// In en, this message translates to:
  /// **'Capacity'**
  String get runtimeCapacity;

  /// No description provided for @runtimeCharge.
  ///
  /// In en, this message translates to:
  /// **'Current Charge'**
  String get runtimeCharge;

  /// No description provided for @runtimeConnection.
  ///
  /// In en, this message translates to:
  /// **'Connection'**
  String get runtimeConnection;

  /// No description provided for @runtimeDevices.
  ///
  /// In en, this message translates to:
  /// **'Devices'**
  String get runtimeDevices;

  /// No description provided for @runtimeAddDevice.
  ///
  /// In en, this message translates to:
  /// **'Add Device'**
  String get runtimeAddDevice;

  /// No description provided for @runtimeTotalLoad.
  ///
  /// In en, this message translates to:
  /// **'Total average load'**
  String get runtimeTotalLoad;

  /// No description provided for @runtimeCalculate.
  ///
  /// In en, this message translates to:
  /// **'Calculate Runtime'**
  String get runtimeCalculate;

  /// No description provided for @runtimeAdvanced.
  ///
  /// In en, this message translates to:
  /// **'Advanced Settings'**
  String get runtimeAdvanced;

  /// No description provided for @runtimeReserve.
  ///
  /// In en, this message translates to:
  /// **'Reserve floor'**
  String get runtimeReserve;

  /// No description provided for @runtimeEfficiency.
  ///
  /// In en, this message translates to:
  /// **'Efficiency'**
  String get runtimeEfficiency;

  /// No description provided for @runtimeAutomatic.
  ///
  /// In en, this message translates to:
  /// **'Automatic'**
  String get runtimeAutomatic;

  /// No description provided for @runtimeMaxOutput.
  ///
  /// In en, this message translates to:
  /// **'Max continuous output'**
  String get runtimeMaxOutput;

  /// No description provided for @resultRuntimeTitle.
  ///
  /// In en, this message translates to:
  /// **'Estimated Runtime'**
  String get resultRuntimeTitle;

  /// No description provided for @resultRuntimeTypical.
  ///
  /// In en, this message translates to:
  /// **'Typical estimate'**
  String get resultRuntimeTypical;

  /// No description provided for @resultConservative.
  ///
  /// In en, this message translates to:
  /// **'Conservative'**
  String get resultConservative;

  /// No description provided for @resultTypical.
  ///
  /// In en, this message translates to:
  /// **'Typical'**
  String get resultTypical;

  /// No description provided for @resultBest.
  ///
  /// In en, this message translates to:
  /// **'Best case'**
  String get resultBest;

  /// No description provided for @resultAvailableEnergy.
  ///
  /// In en, this message translates to:
  /// **'Effective energy'**
  String get resultAvailableEnergy;

  /// No description provided for @resultAverageLoad.
  ///
  /// In en, this message translates to:
  /// **'Average load'**
  String get resultAverageLoad;

  /// No description provided for @resultAssumptions.
  ///
  /// In en, this message translates to:
  /// **'About this estimate'**
  String get resultAssumptions;

  /// No description provided for @resultSaveSetup.
  ///
  /// In en, this message translates to:
  /// **'Save Setup'**
  String get resultSaveSetup;

  /// No description provided for @resultUpdateSetup.
  ///
  /// In en, this message translates to:
  /// **'Update Setup'**
  String get resultUpdateSetup;

  /// No description provided for @resultAdjust.
  ///
  /// In en, this message translates to:
  /// **'Adjust Devices'**
  String get resultAdjust;

  /// No description provided for @neededTitle.
  ///
  /// In en, this message translates to:
  /// **'Battery Needed'**
  String get neededTitle;

  /// No description provided for @neededDesiredRuntime.
  ///
  /// In en, this message translates to:
  /// **'Desired Runtime'**
  String get neededDesiredRuntime;

  /// No description provided for @neededCalculate.
  ///
  /// In en, this message translates to:
  /// **'Calculate Capacity'**
  String get neededCalculate;

  /// No description provided for @neededResultTitle.
  ///
  /// In en, this message translates to:
  /// **'Recommended Capacity'**
  String get neededResultTitle;

  /// No description provided for @neededMinimum.
  ///
  /// In en, this message translates to:
  /// **'Minimum calculated'**
  String get neededMinimum;

  /// No description provided for @neededRecommended.
  ///
  /// In en, this message translates to:
  /// **'Recommended'**
  String get neededRecommended;

  /// No description provided for @neededComfortable.
  ///
  /// In en, this message translates to:
  /// **'Comfortable reserve'**
  String get neededComfortable;

  /// No description provided for @neededEnergyDemand.
  ///
  /// In en, this message translates to:
  /// **'Energy demand'**
  String get neededEnergyDemand;

  /// No description provided for @deviceSearch.
  ///
  /// In en, this message translates to:
  /// **'Search devices'**
  String get deviceSearch;

  /// No description provided for @deviceCustom.
  ///
  /// In en, this message translates to:
  /// **'Add Custom Device'**
  String get deviceCustom;

  /// No description provided for @deviceName.
  ///
  /// In en, this message translates to:
  /// **'Device name'**
  String get deviceName;

  /// No description provided for @deviceWattage.
  ///
  /// In en, this message translates to:
  /// **'Wattage'**
  String get deviceWattage;

  /// No description provided for @deviceUsage.
  ///
  /// In en, this message translates to:
  /// **'Usage'**
  String get deviceUsage;

  /// No description provided for @deviceUsageAlways.
  ///
  /// In en, this message translates to:
  /// **'Always on'**
  String get deviceUsageAlways;

  /// No description provided for @deviceUsageUsually.
  ///
  /// In en, this message translates to:
  /// **'Usually on'**
  String get deviceUsageUsually;

  /// No description provided for @deviceUsageCycles.
  ///
  /// In en, this message translates to:
  /// **'Cycles'**
  String get deviceUsageCycles;

  /// No description provided for @deviceUsageOccasional.
  ///
  /// In en, this message translates to:
  /// **'Occasional'**
  String get deviceUsageOccasional;

  /// No description provided for @deviceUsageCustom.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get deviceUsageCustom;

  /// No description provided for @deviceConnectionDefault.
  ///
  /// In en, this message translates to:
  /// **'Use calculator default'**
  String get deviceConnectionDefault;

  /// No description provided for @deviceStartupSurge.
  ///
  /// In en, this message translates to:
  /// **'Has startup surge'**
  String get deviceStartupSurge;

  /// No description provided for @deviceLabelHint.
  ///
  /// In en, this message translates to:
  /// **'Check the product label or a watt meter when possible.'**
  String get deviceLabelHint;

  /// No description provided for @deviceFridgeHint.
  ///
  /// In en, this message translates to:
  /// **'Compressor devices cycle on and off. Rated watts are not the same as average watts.'**
  String get deviceFridgeHint;

  /// No description provided for @deviceCpapHint.
  ///
  /// In en, this message translates to:
  /// **'Humidifier and heated tubing can significantly change power use. Use the wattage for your exact setup.'**
  String get deviceCpapHint;

  /// No description provided for @savedEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No saved setups yet'**
  String get savedEmptyTitle;

  /// No description provided for @savedEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Save a camping or backup setup to reuse it anytime.'**
  String get savedEmptyBody;

  /// No description provided for @appliancesTitle.
  ///
  /// In en, this message translates to:
  /// **'My Appliances'**
  String get appliancesTitle;

  /// No description provided for @appliancesEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No saved devices yet'**
  String get appliancesEmptyTitle;

  /// No description provided for @appliancesEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Save devices you use often to calculate faster next time.'**
  String get appliancesEmptyBody;

  /// No description provided for @toolsTitle.
  ///
  /// In en, this message translates to:
  /// **'Tools'**
  String get toolsTitle;

  /// No description provided for @toolsConverter.
  ///
  /// In en, this message translates to:
  /// **'Wh ↔ Ah Converter'**
  String get toolsConverter;

  /// No description provided for @converterWhToAh.
  ///
  /// In en, this message translates to:
  /// **'Wh → Ah'**
  String get converterWhToAh;

  /// No description provided for @converterAhToWh.
  ///
  /// In en, this message translates to:
  /// **'Ah → Wh'**
  String get converterAhToWh;

  /// No description provided for @converterVoltage.
  ///
  /// In en, this message translates to:
  /// **'Voltage'**
  String get converterVoltage;

  /// No description provided for @converterResult.
  ///
  /// In en, this message translates to:
  /// **'Result'**
  String get converterResult;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsTheme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settingsTheme;

  /// No description provided for @settingsThemeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get settingsThemeSystem;

  /// No description provided for @settingsThemeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get settingsThemeLight;

  /// No description provided for @settingsThemeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get settingsThemeDark;

  /// No description provided for @settingsDefaults.
  ///
  /// In en, this message translates to:
  /// **'Defaults'**
  String get settingsDefaults;

  /// No description provided for @settingsDefaultConnection.
  ///
  /// In en, this message translates to:
  /// **'Default connection'**
  String get settingsDefaultConnection;

  /// No description provided for @settingsResetDefaults.
  ///
  /// In en, this message translates to:
  /// **'Reset defaults'**
  String get settingsResetDefaults;

  /// No description provided for @settingsPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get settingsPrivacy;

  /// No description provided for @settingsPrivacyOptions.
  ///
  /// In en, this message translates to:
  /// **'Privacy Options'**
  String get settingsPrivacyOptions;

  /// No description provided for @settingsPrivacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get settingsPrivacyPolicy;

  /// No description provided for @settingsAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settingsAbout;

  /// No description provided for @aboutCalculation.
  ///
  /// In en, this message translates to:
  /// **'Calculation Notes'**
  String get aboutCalculation;

  /// No description provided for @aboutDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'Disclaimer'**
  String get aboutDisclaimer;

  /// No description provided for @errorInvalidCapacity.
  ///
  /// In en, this message translates to:
  /// **'Enter a capacity greater than 0 Wh.'**
  String get errorInvalidCapacity;

  /// No description provided for @errorInvalidWattage.
  ///
  /// In en, this message translates to:
  /// **'Enter a wattage greater than 0 W.'**
  String get errorInvalidWattage;

  /// No description provided for @errorNoDevices.
  ///
  /// In en, this message translates to:
  /// **'Add at least one device.'**
  String get errorNoDevices;

  /// No description provided for @errorInvalidRuntime.
  ///
  /// In en, this message translates to:
  /// **'Enter a runtime greater than 0.'**
  String get errorInvalidRuntime;

  /// No description provided for @errorChargeRange.
  ///
  /// In en, this message translates to:
  /// **'Charge must be between 0% and 100%.'**
  String get errorChargeRange;

  /// No description provided for @errorReserveNoEnergy.
  ///
  /// In en, this message translates to:
  /// **'The reserve floor leaves no usable charge.'**
  String get errorReserveNoEnergy;

  /// No description provided for @warningSurgeTitle.
  ///
  /// In en, this message translates to:
  /// **'Check startup surge'**
  String get warningSurgeTitle;

  /// No description provided for @warningSurgeBody.
  ///
  /// In en, this message translates to:
  /// **'Some motors and compressors briefly need much more power when they start. Make sure your power station can handle the device\'s surge.'**
  String get warningSurgeBody;

  /// No description provided for @warningOutputTitle.
  ///
  /// In en, this message translates to:
  /// **'Output limit may be exceeded'**
  String get warningOutputTitle;

  /// No description provided for @warningOutputBody.
  ///
  /// In en, this message translates to:
  /// **'The combined rated load is higher than the max continuous output you entered.'**
  String get warningOutputBody;

  /// No description provided for @warningLowLoadTitle.
  ///
  /// In en, this message translates to:
  /// **'Low-load estimate'**
  String get warningLowLoadTitle;

  /// No description provided for @warningLowLoadBody.
  ///
  /// In en, this message translates to:
  /// **'Low AC loads can be less efficient because the power station uses some energy just to keep the inverter running.'**
  String get warningLowLoadBody;

  /// No description provided for @warningCpapTitle.
  ///
  /// In en, this message translates to:
  /// **'Critical equipment'**
  String get warningCpapTitle;

  /// No description provided for @warningCpapBody.
  ///
  /// In en, this message translates to:
  /// **'Do not rely on this estimate as your only backup plan for medically necessary equipment. Follow the equipment and power-station manufacturer guidance and test your exact setup.'**
  String get warningCpapBody;

  /// No description provided for @disclaimerShort.
  ///
  /// In en, this message translates to:
  /// **'Actual runtime varies with appliance behavior, conversion losses, temperature, battery condition, and power-station overhead.'**
  String get disclaimerShort;

  /// No description provided for @disclaimerFull.
  ///
  /// In en, this message translates to:
  /// **'PowerLeft provides planning estimates only. It does not guarantee runtime, startup compatibility, or electrical safety. Verify manufacturer limits and test critical setups before relying on them.'**
  String get disclaimerFull;

  /// No description provided for @privacyLocal.
  ///
  /// In en, this message translates to:
  /// **'Your saved batteries and setups stay on this device.'**
  String get privacyLocal;

  /// No description provided for @privacyNoAccount.
  ///
  /// In en, this message translates to:
  /// **'No account required.'**
  String get privacyNoAccount;

  /// No description provided for @adPrivacyNote.
  ///
  /// In en, this message translates to:
  /// **'Ads are provided by Google AdMob and may process device, advertising, usage, and diagnostic data according to your consent choices and applicable law.'**
  String get adPrivacyNote;

  /// No description provided for @homeQuickTools.
  ///
  /// In en, this message translates to:
  /// **'Quick Tools'**
  String get homeQuickTools;

  /// No description provided for @categoryAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get categoryAll;

  /// No description provided for @categoryCamping.
  ///
  /// In en, this message translates to:
  /// **'Camping'**
  String get categoryCamping;

  /// No description provided for @categoryHomeBackup.
  ///
  /// In en, this message translates to:
  /// **'Home Backup'**
  String get categoryHomeBackup;

  /// No description provided for @categoryOutdoor.
  ///
  /// In en, this message translates to:
  /// **'Outdoor'**
  String get categoryOutdoor;

  /// No description provided for @categoryHighDraw.
  ///
  /// In en, this message translates to:
  /// **'High Draw'**
  String get categoryHighDraw;

  /// No description provided for @devicePortableFridge.
  ///
  /// In en, this message translates to:
  /// **'Portable fridge'**
  String get devicePortableFridge;

  /// No description provided for @deviceElectricBlanket.
  ///
  /// In en, this message translates to:
  /// **'Electric blanket'**
  String get deviceElectricBlanket;

  /// No description provided for @deviceLedLight.
  ///
  /// In en, this message translates to:
  /// **'LED light'**
  String get deviceLedLight;

  /// No description provided for @deviceFan.
  ///
  /// In en, this message translates to:
  /// **'Fan'**
  String get deviceFan;

  /// No description provided for @devicePhoneCharger.
  ///
  /// In en, this message translates to:
  /// **'Phone charger'**
  String get devicePhoneCharger;

  /// No description provided for @deviceLaptop.
  ///
  /// In en, this message translates to:
  /// **'Laptop'**
  String get deviceLaptop;

  /// No description provided for @deviceCpap.
  ///
  /// In en, this message translates to:
  /// **'CPAP'**
  String get deviceCpap;

  /// No description provided for @deviceRefrigerator.
  ///
  /// In en, this message translates to:
  /// **'Refrigerator'**
  String get deviceRefrigerator;

  /// No description provided for @deviceFreezer.
  ///
  /// In en, this message translates to:
  /// **'Freezer'**
  String get deviceFreezer;

  /// No description provided for @deviceWifiRouter.
  ///
  /// In en, this message translates to:
  /// **'Wi-Fi router'**
  String get deviceWifiRouter;

  /// No description provided for @deviceModem.
  ///
  /// In en, this message translates to:
  /// **'Modem'**
  String get deviceModem;

  /// No description provided for @deviceTv.
  ///
  /// In en, this message translates to:
  /// **'TV'**
  String get deviceTv;

  /// No description provided for @deviceDesktopPc.
  ///
  /// In en, this message translates to:
  /// **'Desktop PC'**
  String get deviceDesktopPc;

  /// No description provided for @deviceProjector.
  ///
  /// In en, this message translates to:
  /// **'Projector'**
  String get deviceProjector;

  /// No description provided for @deviceSpeaker.
  ///
  /// In en, this message translates to:
  /// **'Speaker'**
  String get deviceSpeaker;

  /// No description provided for @deviceCameraCharger.
  ///
  /// In en, this message translates to:
  /// **'Camera charger'**
  String get deviceCameraCharger;

  /// No description provided for @deviceDroneCharger.
  ///
  /// In en, this message translates to:
  /// **'Drone charger'**
  String get deviceDroneCharger;

  /// No description provided for @deviceCoffeeMaker.
  ///
  /// In en, this message translates to:
  /// **'Coffee maker'**
  String get deviceCoffeeMaker;

  /// No description provided for @deviceMicrowave.
  ///
  /// In en, this message translates to:
  /// **'Microwave'**
  String get deviceMicrowave;

  /// No description provided for @deviceInductionCooktop.
  ///
  /// In en, this message translates to:
  /// **'Induction cooktop'**
  String get deviceInductionCooktop;

  /// No description provided for @deviceHairDryer.
  ///
  /// In en, this message translates to:
  /// **'Hair dryer'**
  String get deviceHairDryer;

  /// No description provided for @commonWh.
  ///
  /// In en, this message translates to:
  /// **'Wh'**
  String get commonWh;

  /// No description provided for @commonKwh.
  ///
  /// In en, this message translates to:
  /// **'kWh'**
  String get commonKwh;

  /// No description provided for @commonWatts.
  ///
  /// In en, this message translates to:
  /// **'W'**
  String get commonWatts;

  /// No description provided for @commonPercent.
  ///
  /// In en, this message translates to:
  /// **'%'**
  String get commonPercent;

  /// No description provided for @connectionAc.
  ///
  /// In en, this message translates to:
  /// **'AC'**
  String get connectionAc;

  /// No description provided for @connectionDc.
  ///
  /// In en, this message translates to:
  /// **'12V DC'**
  String get connectionDc;

  /// No description provided for @connectionUsbC.
  ///
  /// In en, this message translates to:
  /// **'USB-C'**
  String get connectionUsbC;

  /// No description provided for @fieldOptional.
  ///
  /// In en, this message translates to:
  /// **'Optional'**
  String get fieldOptional;

  /// No description provided for @saveSetupName.
  ///
  /// In en, this message translates to:
  /// **'Setup name'**
  String get saveSetupName;

  /// No description provided for @saveSetupDefaultRuntime.
  ///
  /// In en, this message translates to:
  /// **'Runtime setup'**
  String get saveSetupDefaultRuntime;

  /// No description provided for @saveSetupDefaultBattery.
  ///
  /// In en, this message translates to:
  /// **'Battery plan'**
  String get saveSetupDefaultBattery;

  /// No description provided for @dialogSaveSetupTitle.
  ///
  /// In en, this message translates to:
  /// **'Save this setup'**
  String get dialogSaveSetupTitle;

  /// No description provided for @dialogDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete setup?'**
  String get dialogDeleteTitle;

  /// No description provided for @dialogDeleteBody.
  ///
  /// In en, this message translates to:
  /// **'This cannot be undone.'**
  String get dialogDeleteBody;

  /// No description provided for @commonClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get commonClose;

  /// No description provided for @commonBackHome.
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get commonBackHome;

  /// No description provided for @resultRange.
  ///
  /// In en, this message translates to:
  /// **'Estimated range'**
  String get resultRange;

  /// No description provided for @resultInputLoad.
  ///
  /// In en, this message translates to:
  /// **'Rated load'**
  String get resultInputLoad;

  /// No description provided for @neededRoundedPlan.
  ///
  /// In en, this message translates to:
  /// **'Planning threshold'**
  String get neededRoundedPlan;

  /// No description provided for @settingsReserveHelp.
  ///
  /// In en, this message translates to:
  /// **'Percentage of charge intentionally left unused.'**
  String get settingsReserveHelp;

  /// No description provided for @settingsPrivacyOptionsUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Privacy options are not required for your current region or consent state.'**
  String get settingsPrivacyOptionsUnavailable;

  /// No description provided for @aboutTitle.
  ///
  /// In en, this message translates to:
  /// **'About PowerLeft'**
  String get aboutTitle;

  /// No description provided for @aboutLocalDataTitle.
  ///
  /// In en, this message translates to:
  /// **'Your data'**
  String get aboutLocalDataTitle;

  /// No description provided for @aboutLocalDataBody.
  ///
  /// In en, this message translates to:
  /// **'Saved batteries, devices, and setups are stored on this device.'**
  String get aboutLocalDataBody;

  /// No description provided for @aboutEstimateTitle.
  ///
  /// In en, this message translates to:
  /// **'Planning estimates'**
  String get aboutEstimateTitle;

  /// No description provided for @aboutEstimateBody.
  ///
  /// In en, this message translates to:
  /// **'Runtime can change with temperature, battery health, inverter overhead, appliance cycling, and startup surge.'**
  String get aboutEstimateBody;

  /// No description provided for @aboutMedicalTitle.
  ///
  /// In en, this message translates to:
  /// **'Critical equipment'**
  String get aboutMedicalTitle;

  /// No description provided for @aboutMedicalBody.
  ///
  /// In en, this message translates to:
  /// **'Do not use PowerLeft as the only backup-planning method for medically necessary equipment.'**
  String get aboutMedicalBody;

  /// No description provided for @converterEnergy.
  ///
  /// In en, this message translates to:
  /// **'Energy'**
  String get converterEnergy;

  /// No description provided for @converterCapacity.
  ///
  /// In en, this message translates to:
  /// **'Capacity'**
  String get converterCapacity;

  /// No description provided for @converterFormula.
  ///
  /// In en, this message translates to:
  /// **'Formula'**
  String get converterFormula;

  /// No description provided for @converterEnterValues.
  ///
  /// In en, this message translates to:
  /// **'Enter valid positive values.'**
  String get converterEnterValues;

  /// No description provided for @customPercentLabel.
  ///
  /// In en, this message translates to:
  /// **'On-time %'**
  String get customPercentLabel;

  /// No description provided for @deviceSaveToMyDevices.
  ///
  /// In en, this message translates to:
  /// **'Save to My Appliances'**
  String get deviceSaveToMyDevices;

  /// No description provided for @deviceTypicalRange.
  ///
  /// In en, this message translates to:
  /// **'Typical range'**
  String get deviceTypicalRange;

  /// No description provided for @deviceConfirmValue.
  ///
  /// In en, this message translates to:
  /// **'Confirm or edit the wattage before adding.'**
  String get deviceConfirmValue;

  /// No description provided for @savedUpdated.
  ///
  /// In en, this message translates to:
  /// **'Updated'**
  String get savedUpdated;

  /// No description provided for @setupModeRuntime.
  ///
  /// In en, this message translates to:
  /// **'Runtime'**
  String get setupModeRuntime;

  /// No description provided for @setupModeBattery.
  ///
  /// In en, this message translates to:
  /// **'Battery needed'**
  String get setupModeBattery;

  /// No description provided for @setupRecalculate.
  ///
  /// In en, this message translates to:
  /// **'Recalculate'**
  String get setupRecalculate;

  /// No description provided for @myAppliancesAdd.
  ///
  /// In en, this message translates to:
  /// **'Add Custom Device'**
  String get myAppliancesAdd;

  /// No description provided for @myAppliancesDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete device?'**
  String get myAppliancesDeleteTitle;

  /// No description provided for @myAppliancesDeleteBody.
  ///
  /// In en, this message translates to:
  /// **'Saved setups keep their existing snapshot.'**
  String get myAppliancesDeleteBody;

  /// No description provided for @settingsVersion.
  ///
  /// In en, this message translates to:
  /// **'Version 1.0.0'**
  String get settingsVersion;

  /// No description provided for @commonNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Not available'**
  String get commonNotAvailable;

  /// No description provided for @homeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Battery runtime, without the guesswork.'**
  String get homeSubtitle;

  /// No description provided for @batteryChargeValue.
  ///
  /// In en, this message translates to:
  /// **'Charge'**
  String get batteryChargeValue;

  /// No description provided for @capacityUnit.
  ///
  /// In en, this message translates to:
  /// **'Capacity unit'**
  String get capacityUnit;

  /// No description provided for @runtimeNoUsableEnergy.
  ///
  /// In en, this message translates to:
  /// **'No energy remains above your reserve floor.'**
  String get runtimeNoUsableEnergy;

  /// No description provided for @runtimeCapacityUnit.
  ///
  /// In en, this message translates to:
  /// **'Capacity unit'**
  String get runtimeCapacityUnit;

  /// No description provided for @runtimeReserveHelp.
  ///
  /// In en, this message translates to:
  /// **'Leave this percentage of charge unused.'**
  String get runtimeReserveHelp;

  /// No description provided for @runtimeEfficiencyPercent.
  ///
  /// In en, this message translates to:
  /// **'Efficiency %'**
  String get runtimeEfficiencyPercent;

  /// No description provided for @runtimeEfficiencyHelp.
  ///
  /// In en, this message translates to:
  /// **'Leave blank to use the connection default.'**
  String get runtimeEfficiencyHelp;

  /// No description provided for @runtimeMaxOutputHelp.
  ///
  /// In en, this message translates to:
  /// **'Optional. Used only to warn when rated load is too high.'**
  String get runtimeMaxOutputHelp;

  /// No description provided for @runtimeBatteryEmpty.
  ///
  /// In en, this message translates to:
  /// **'Battery is empty.'**
  String get runtimeBatteryEmpty;

  /// No description provided for @runtimeResultSaved.
  ///
  /// In en, this message translates to:
  /// **'Setup saved.'**
  String get runtimeResultSaved;

  /// No description provided for @runtimeSaveFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not save the setup.'**
  String get runtimeSaveFailed;

  /// No description provided for @resultTypicalEnergy.
  ///
  /// In en, this message translates to:
  /// **'Typical effective energy'**
  String get resultTypicalEnergy;

  /// No description provided for @resultRatedLoad.
  ///
  /// In en, this message translates to:
  /// **'Combined rated load'**
  String get resultRatedLoad;

  /// No description provided for @resultAboutEstimate.
  ///
  /// In en, this message translates to:
  /// **'Actual runtime can change with appliance cycling, temperature, battery condition, conversion losses, and power-station overhead.'**
  String get resultAboutEstimate;

  /// No description provided for @neededHoursHint.
  ///
  /// In en, this message translates to:
  /// **'Enter hours'**
  String get neededHoursHint;

  /// No description provided for @neededQuick.
  ///
  /// In en, this message translates to:
  /// **'Quick select'**
  String get neededQuick;

  /// No description provided for @neededResultSaved.
  ///
  /// In en, this message translates to:
  /// **'Battery plan saved.'**
  String get neededResultSaved;

  /// No description provided for @saveSetupNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter a setup name.'**
  String get saveSetupNameRequired;

  /// No description provided for @savedTitle.
  ///
  /// In en, this message translates to:
  /// **'Saved Setups'**
  String get savedTitle;

  /// No description provided for @savedDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete setup'**
  String get savedDelete;

  /// No description provided for @savedEmptyAction.
  ///
  /// In en, this message translates to:
  /// **'Create a calculation and save it to reuse later.'**
  String get savedEmptyAction;

  /// No description provided for @setupDetails.
  ///
  /// In en, this message translates to:
  /// **'Setup Details'**
  String get setupDetails;

  /// No description provided for @setupDevices.
  ///
  /// In en, this message translates to:
  /// **'Devices'**
  String get setupDevices;

  /// No description provided for @setupBattery.
  ///
  /// In en, this message translates to:
  /// **'Battery'**
  String get setupBattery;

  /// No description provided for @setupDesired.
  ///
  /// In en, this message translates to:
  /// **'Desired runtime'**
  String get setupDesired;

  /// No description provided for @setupConnection.
  ///
  /// In en, this message translates to:
  /// **'Connection'**
  String get setupConnection;

  /// No description provided for @setupNotFound.
  ///
  /// In en, this message translates to:
  /// **'This setup could not be found.'**
  String get setupNotFound;

  /// No description provided for @settingsDefaultReserve.
  ///
  /// In en, this message translates to:
  /// **'Default reserve floor'**
  String get settingsDefaultReserve;

  /// No description provided for @settingsResetDone.
  ///
  /// In en, this message translates to:
  /// **'Defaults restored.'**
  String get settingsResetDone;

  /// No description provided for @settingsPrivacyExplanation.
  ///
  /// In en, this message translates to:
  /// **'Privacy choices are managed by Google UMP when required. Core calculations work without an account.'**
  String get settingsPrivacyExplanation;

  /// No description provided for @aboutPrivacyTitle.
  ///
  /// In en, this message translates to:
  /// **'Ads & privacy'**
  String get aboutPrivacyTitle;

  /// No description provided for @aboutPrivacyBody.
  ///
  /// In en, this message translates to:
  /// **'PowerLeft stores your calculator data locally. Google AdMob may process device, advertising, usage, and diagnostic data according to your consent choices and applicable law.'**
  String get aboutPrivacyBody;

  /// No description provided for @aboutNoGuarantee.
  ///
  /// In en, this message translates to:
  /// **'PowerLeft is an estimation tool. It does not guarantee runtime, startup compatibility, or electrical safety.'**
  String get aboutNoGuarantee;

  /// No description provided for @converterWh.
  ///
  /// In en, this message translates to:
  /// **'Watt-hours (Wh)'**
  String get converterWh;

  /// No description provided for @converterAh.
  ///
  /// In en, this message translates to:
  /// **'Amp-hours (Ah)'**
  String get converterAh;

  /// No description provided for @converterVoltageV.
  ///
  /// In en, this message translates to:
  /// **'Voltage (V)'**
  String get converterVoltageV;

  /// No description provided for @converterWhToAhFormula.
  ///
  /// In en, this message translates to:
  /// **'Ah = Wh ÷ V'**
  String get converterWhToAhFormula;

  /// No description provided for @converterAhToWhFormula.
  ///
  /// In en, this message translates to:
  /// **'Wh = Ah × V'**
  String get converterAhToWhFormula;

  /// No description provided for @commonHoursShort.
  ///
  /// In en, this message translates to:
  /// **'h'**
  String get commonHoursShort;

  /// No description provided for @commonSaveSetup.
  ///
  /// In en, this message translates to:
  /// **'Save Setup'**
  String get commonSaveSetup;

  /// No description provided for @commonUpdateSetup.
  ///
  /// In en, this message translates to:
  /// **'Update Setup'**
  String get commonUpdateSetup;

  /// No description provided for @commonRecalculate.
  ///
  /// In en, this message translates to:
  /// **'Recalculate'**
  String get commonRecalculate;

  /// No description provided for @commonRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get commonRemove;

  /// No description provided for @commonContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get commonContinue;

  /// No description provided for @adNoImpact.
  ///
  /// In en, this message translates to:
  /// **'Ads never block your calculation result.'**
  String get adNoImpact;

  /// No description provided for @commonMinutesShort.
  ///
  /// In en, this message translates to:
  /// **'m'**
  String get commonMinutesShort;

  /// No description provided for @commonDaysShort.
  ///
  /// In en, this message translates to:
  /// **'d'**
  String get commonDaysShort;

  /// No description provided for @batteryProfilesTitle.
  ///
  /// In en, this message translates to:
  /// **'Saved Batteries'**
  String get batteryProfilesTitle;

  /// No description provided for @batteryProfileChoose.
  ///
  /// In en, this message translates to:
  /// **'Choose Saved Battery'**
  String get batteryProfileChoose;

  /// No description provided for @batteryProfileAdd.
  ///
  /// In en, this message translates to:
  /// **'Add Battery'**
  String get batteryProfileAdd;

  /// No description provided for @batteryProfileName.
  ///
  /// In en, this message translates to:
  /// **'Battery name'**
  String get batteryProfileName;

  /// No description provided for @batteryProfileCapacity.
  ///
  /// In en, this message translates to:
  /// **'Capacity'**
  String get batteryProfileCapacity;

  /// No description provided for @batteryProfileMaxOutput.
  ///
  /// In en, this message translates to:
  /// **'Max continuous output'**
  String get batteryProfileMaxOutput;

  /// No description provided for @batteryProfileEmpty.
  ///
  /// In en, this message translates to:
  /// **'No saved batteries yet'**
  String get batteryProfileEmpty;

  /// No description provided for @batteryProfileEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Save a power station or battery you use often.'**
  String get batteryProfileEmptyBody;

  /// No description provided for @batteryProfileApplied.
  ///
  /// In en, this message translates to:
  /// **'Saved battery applied.'**
  String get batteryProfileApplied;

  /// No description provided for @batteryProfileCharge.
  ///
  /// In en, this message translates to:
  /// **'Default charge'**
  String get batteryProfileCharge;

  /// No description provided for @batteryProfileDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete battery'**
  String get batteryProfileDelete;

  /// No description provided for @errorReserveRange.
  ///
  /// In en, this message translates to:
  /// **'Reserve floor must be between 0% and 50%.'**
  String get errorReserveRange;

  /// No description provided for @errorEfficiencyRange.
  ///
  /// In en, this message translates to:
  /// **'Efficiency must be between 50% and 99%.'**
  String get errorEfficiencyRange;

  /// No description provided for @errorLoadData.
  ///
  /// In en, this message translates to:
  /// **'Could not load saved data.'**
  String get errorLoadData;

  /// No description provided for @errorSaveData.
  ///
  /// In en, this message translates to:
  /// **'Could not save your changes.'**
  String get errorSaveData;

  /// No description provided for @privacyPolicyTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicyTitle;

  /// No description provided for @privacyPolicyLocalTitle.
  ///
  /// In en, this message translates to:
  /// **'Calculator data'**
  String get privacyPolicyLocalTitle;

  /// No description provided for @privacyPolicyLocalBody.
  ///
  /// In en, this message translates to:
  /// **'Battery profiles, custom devices, and saved setups are stored locally on this device. PowerLeft does not require an account or send these calculator records to a PowerLeft server.'**
  String get privacyPolicyLocalBody;

  /// No description provided for @privacyPolicyAdsTitle.
  ///
  /// In en, this message translates to:
  /// **'Advertising'**
  String get privacyPolicyAdsTitle;

  /// No description provided for @privacyPolicyAdsBody.
  ///
  /// In en, this message translates to:
  /// **'PowerLeft uses Google AdMob interstitial ads. Depending on your region, consent choices, device settings, and Google Mobile Ads configuration, Google and its partners may process device identifiers, IP-derived general location, ad interactions, usage, and diagnostic information.'**
  String get privacyPolicyAdsBody;

  /// No description provided for @privacyPolicyConsentTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy choices'**
  String get privacyPolicyConsentTitle;

  /// No description provided for @privacyPolicyConsentBody.
  ///
  /// In en, this message translates to:
  /// **'Where required, PowerLeft uses Google User Messaging Platform (UMP) to request or manage privacy choices before requesting ads. Core calculator features continue to work regardless of ad availability.'**
  String get privacyPolicyConsentBody;

  /// No description provided for @privacyPolicyTrackingTitle.
  ///
  /// In en, this message translates to:
  /// **'Tracking permission'**
  String get privacyPolicyTrackingTitle;

  /// No description provided for @privacyPolicyTrackingBody.
  ///
  /// In en, this message translates to:
  /// **'The MVP does not intentionally request Apple App Tracking Transparency permission. If a future release begins tracking as defined by Apple, the app and this policy must be updated before release.'**
  String get privacyPolicyTrackingBody;

  /// No description provided for @privacyPolicyRetentionTitle.
  ///
  /// In en, this message translates to:
  /// **'Retention'**
  String get privacyPolicyRetentionTitle;

  /// No description provided for @privacyPolicyRetentionBody.
  ///
  /// In en, this message translates to:
  /// **'Calculator records remain on your device until you delete them or remove/reset the app. Advertising-data retention follows Google and its partners\' policies.'**
  String get privacyPolicyRetentionBody;

  /// No description provided for @privacyPolicyChildrenTitle.
  ///
  /// In en, this message translates to:
  /// **'Children'**
  String get privacyPolicyChildrenTitle;

  /// No description provided for @privacyPolicyChildrenBody.
  ///
  /// In en, this message translates to:
  /// **'PowerLeft is not designed or marketed as a children\'s app.'**
  String get privacyPolicyChildrenBody;

  /// No description provided for @privacyPolicyContactTitle.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get privacyPolicyContactTitle;

  /// No description provided for @privacyPolicyContactBody.
  ///
  /// In en, this message translates to:
  /// **'For privacy or support questions, use the public Support link on PowerLeft’s App Store product page.'**
  String get privacyPolicyContactBody;

  /// No description provided for @errorCapacityRange.
  ///
  /// In en, this message translates to:
  /// **'Enter a capacity greater than 0 and no more than 100,000 Wh.'**
  String get errorCapacityRange;

  /// No description provided for @errorWattageRange.
  ///
  /// In en, this message translates to:
  /// **'Enter a wattage greater than 0 and no more than 10,000 W.'**
  String get errorWattageRange;

  /// No description provided for @errorRuntimeRange.
  ///
  /// In en, this message translates to:
  /// **'Enter a runtime greater than 0 and no more than 336 hours.'**
  String get errorRuntimeRange;

  /// No description provided for @errorMaxOutputRange.
  ///
  /// In en, this message translates to:
  /// **'Max continuous output must be greater than 0 W.'**
  String get errorMaxOutputRange;

  /// No description provided for @errorNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter a name.'**
  String get errorNameRequired;

  /// No description provided for @settingsDataTitle.
  ///
  /// In en, this message translates to:
  /// **'Saved Data'**
  String get settingsDataTitle;

  /// No description provided for @settingsDeleteLocalData.
  ///
  /// In en, this message translates to:
  /// **'Delete Saved Data'**
  String get settingsDeleteLocalData;

  /// No description provided for @settingsDeleteLocalDataBody.
  ///
  /// In en, this message translates to:
  /// **'Delete all saved batteries, custom devices, and setups from this device. App settings and privacy choices are not deleted.'**
  String get settingsDeleteLocalDataBody;

  /// No description provided for @settingsDeleteLocalDataConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete saved data?'**
  String get settingsDeleteLocalDataConfirm;

  /// No description provided for @settingsDeleteLocalDataDone.
  ///
  /// In en, this message translates to:
  /// **'Saved data deleted.'**
  String get settingsDeleteLocalDataDone;

  /// No description provided for @categoryOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get categoryOther;

  /// No description provided for @setupRenameTitle.
  ///
  /// In en, this message translates to:
  /// **'Rename Setup'**
  String get setupRenameTitle;

  /// No description provided for @setupRenameDone.
  ///
  /// In en, this message translates to:
  /// **'Setup renamed.'**
  String get setupRenameDone;

  /// No description provided for @categoryWork.
  ///
  /// In en, this message translates to:
  /// **'Work'**
  String get categoryWork;

  /// No description provided for @deviceCategory.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get deviceCategory;

  /// No description provided for @devicePortableMonitor.
  ///
  /// In en, this message translates to:
  /// **'Portable monitor'**
  String get devicePortableMonitor;

  /// No description provided for @deviceWorkLight.
  ///
  /// In en, this message translates to:
  /// **'Work light'**
  String get deviceWorkLight;

  /// No description provided for @devicePowerToolCharger.
  ///
  /// In en, this message translates to:
  /// **'Power-tool charger'**
  String get devicePowerToolCharger;

  /// No description provided for @deviceSolderingIron.
  ///
  /// In en, this message translates to:
  /// **'Soldering iron'**
  String get deviceSolderingIron;

  /// No description provided for @aboutOpenSourceLicenses.
  ///
  /// In en, this message translates to:
  /// **'Open Source Licenses'**
  String get aboutOpenSourceLicenses;

  /// No description provided for @aboutOpenSourceBody.
  ///
  /// In en, this message translates to:
  /// **'View licenses for Flutter and third-party packages used by PowerLeft.'**
  String get aboutOpenSourceBody;

  /// No description provided for @converterCaveat.
  ///
  /// In en, this message translates to:
  /// **'Ah depends on voltage. Battery chemistry, conversion losses, reserve, and device behavior can reduce usable energy, so this conversion is not a runtime guarantee.'**
  String get converterCaveat;

  /// No description provided for @errorCalculation.
  ///
  /// In en, this message translates to:
  /// **'Could not calculate with these values. Check your inputs and try again.'**
  String get errorCalculation;

  /// No description provided for @warningReserveTitle.
  ///
  /// In en, this message translates to:
  /// **'No usable charge'**
  String get warningReserveTitle;

  /// No description provided for @designTagline.
  ///
  /// In en, this message translates to:
  /// **'Plan Power. Live Further.'**
  String get designTagline;

  /// No description provided for @designRuntimeQuestion.
  ///
  /// In en, this message translates to:
  /// **'How long\nwill it last?'**
  String get designRuntimeQuestion;

  /// No description provided for @designNeededQuestion.
  ///
  /// In en, this message translates to:
  /// **'How much\ndo I need?'**
  String get designNeededQuestion;

  /// No description provided for @designCampTitle.
  ///
  /// In en, this message translates to:
  /// **'More power for what matters.'**
  String get designCampTitle;

  /// No description provided for @designCampBody.
  ///
  /// In en, this message translates to:
  /// **'CAMP · EXPLORE · PREPARE'**
  String get designCampBody;

  /// No description provided for @designRuntimeHelp.
  ///
  /// In en, this message translates to:
  /// **'Enter your battery and the devices you plan to run.'**
  String get designRuntimeHelp;

  /// No description provided for @designNeededHelp.
  ///
  /// In en, this message translates to:
  /// **'Choose your devices and how long you need them.'**
  String get designNeededHelp;

  /// No description provided for @designCompareHint.
  ///
  /// In en, this message translates to:
  /// **'Compare three realistic conditions.'**
  String get designCompareHint;

  /// No description provided for @designDetails.
  ///
  /// In en, this message translates to:
  /// **'Calculation details'**
  String get designDetails;

  /// No description provided for @designSavedHint.
  ///
  /// In en, this message translates to:
  /// **'Reuse your favorite calculations.'**
  String get designSavedHint;

  /// No description provided for @designAppliancesHint.
  ///
  /// In en, this message translates to:
  /// **'Your everyday gear, ready to add.'**
  String get designAppliancesHint;

  /// No description provided for @designBatteriesHint.
  ///
  /// In en, this message translates to:
  /// **'Keep your battery specs close.'**
  String get designBatteriesHint;

  /// No description provided for @designToolsHint.
  ///
  /// In en, this message translates to:
  /// **'Quick conversions and references.'**
  String get designToolsHint;

  /// No description provided for @designRuntimeBody.
  ///
  /// In en, this message translates to:
  /// **'Estimate runtime for your battery and devices.'**
  String get designRuntimeBody;

  /// No description provided for @designNeededBody.
  ///
  /// In en, this message translates to:
  /// **'Find a battery size for your plans.'**
  String get designNeededBody;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsLanguageSystem.
  ///
  /// In en, this message translates to:
  /// **'Use device language'**
  String get settingsLanguageSystem;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'de',
    'en',
    'es',
    'fr',
    'ja',
    'ko',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
