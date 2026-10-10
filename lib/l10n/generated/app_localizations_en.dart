// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'PowerLeft';

  @override
  String get homeRuntimeTitle => 'How long will it last?';

  @override
  String get homeRuntimeSubtitle => 'Battery + devices → runtime';

  @override
  String get homeRuntimeCta => 'Calculate Runtime';

  @override
  String get homeNeededTitle => 'How much battery do I need?';

  @override
  String get homeNeededSubtitle => 'Devices + hours → required capacity';

  @override
  String get homeNeededCta => 'Size My Battery';

  @override
  String get homeSavedTitle => 'Saved Setups';

  @override
  String get commonSeeAll => 'See All';

  @override
  String get commonAdd => 'Add';

  @override
  String get commonSave => 'Save';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonDone => 'Done';

  @override
  String get commonDelete => 'Delete';

  @override
  String get commonEdit => 'Edit';

  @override
  String get commonReset => 'Reset';

  @override
  String get commonHours => 'hours';

  @override
  String get commonMinutes => 'min';

  @override
  String get commonDays => 'days';

  @override
  String get onboarding1Title => 'Know how long your power will last.';

  @override
  String get onboarding1Body =>
      'Add your battery and devices to get a practical runtime estimate.';

  @override
  String get onboardingNext => 'Next';

  @override
  String get onboardingSkip => 'Skip';

  @override
  String get onboarding2Title => 'Plan before you buy.';

  @override
  String get onboarding2Body =>
      'Estimate the battery capacity you need. No account required — your saved setups stay on this device.';

  @override
  String get onboardingStart => 'Get Started';

  @override
  String get runtimeTitle => 'Runtime';

  @override
  String get runtimeBattery => 'Battery';

  @override
  String get runtimeCapacity => 'Capacity';

  @override
  String get runtimeCharge => 'Current Charge';

  @override
  String get runtimeConnection => 'Connection';

  @override
  String get runtimeDevices => 'Devices';

  @override
  String get runtimeAddDevice => 'Add Device';

  @override
  String get runtimeTotalLoad => 'Total average load';

  @override
  String get runtimeCalculate => 'Calculate Runtime';

  @override
  String get runtimeAdvanced => 'Advanced Settings';

  @override
  String get runtimeReserve => 'Reserve floor';

  @override
  String get runtimeEfficiency => 'Efficiency';

  @override
  String get runtimeAutomatic => 'Automatic';

  @override
  String get runtimeMaxOutput => 'Max continuous output';

  @override
  String get resultRuntimeTitle => 'Estimated Runtime';

  @override
  String get resultRuntimeTypical => 'Typical estimate';

  @override
  String get resultConservative => 'Conservative';

  @override
  String get resultTypical => 'Typical';

  @override
  String get resultBest => 'Best case';

  @override
  String get resultAvailableEnergy => 'Effective energy';

  @override
  String get resultAverageLoad => 'Average load';

  @override
  String get resultAssumptions => 'About this estimate';

  @override
  String get resultSaveSetup => 'Save Setup';

  @override
  String get resultUpdateSetup => 'Update Setup';

  @override
  String get resultAdjust => 'Adjust Devices';

  @override
  String get neededTitle => 'Battery Needed';

  @override
  String get neededDesiredRuntime => 'Desired Runtime';

  @override
  String get neededCalculate => 'Calculate Capacity';

  @override
  String get neededResultTitle => 'Recommended Capacity';

  @override
  String get neededMinimum => 'Minimum calculated';

  @override
  String get neededRecommended => 'Recommended';

  @override
  String get neededComfortable => 'Comfortable reserve';

  @override
  String get neededEnergyDemand => 'Energy demand';

  @override
  String get deviceSearch => 'Search devices';

  @override
  String get deviceCustom => 'Add Custom Device';

  @override
  String get deviceName => 'Device name';

  @override
  String get deviceWattage => 'Wattage';

  @override
  String get deviceUsage => 'Usage';

  @override
  String get deviceUsageAlways => 'Always on';

  @override
  String get deviceUsageUsually => 'Usually on';

  @override
  String get deviceUsageCycles => 'Cycles';

  @override
  String get deviceUsageOccasional => 'Occasional';

  @override
  String get deviceUsageCustom => 'Custom';

  @override
  String get deviceConnectionDefault => 'Use calculator default';

  @override
  String get deviceStartupSurge => 'Has startup surge';

  @override
  String get deviceLabelHint =>
      'Check the product label or a watt meter when possible.';

  @override
  String get deviceFridgeHint =>
      'Compressor devices cycle on and off. Rated watts are not the same as average watts.';

  @override
  String get deviceCpapHint =>
      'Humidifier and heated tubing can significantly change power use. Use the wattage for your exact setup.';

  @override
  String get savedEmptyTitle => 'No saved setups yet';

  @override
  String get savedEmptyBody =>
      'Save a camping or backup setup to reuse it anytime.';

  @override
  String get appliancesTitle => 'My Appliances';

  @override
  String get appliancesEmptyTitle => 'No saved devices yet';

  @override
  String get appliancesEmptyBody =>
      'Save devices you use often to calculate faster next time.';

  @override
  String get toolsTitle => 'Tools';

  @override
  String get toolsConverter => 'Wh ↔ Ah Converter';

  @override
  String get converterWhToAh => 'Wh → Ah';

  @override
  String get converterAhToWh => 'Ah → Wh';

  @override
  String get converterVoltage => 'Voltage';

  @override
  String get converterResult => 'Result';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsTheme => 'Theme';

  @override
  String get settingsThemeSystem => 'System';

  @override
  String get settingsThemeLight => 'Light';

  @override
  String get settingsThemeDark => 'Dark';

  @override
  String get settingsDefaults => 'Defaults';

  @override
  String get settingsDefaultConnection => 'Default connection';

  @override
  String get settingsResetDefaults => 'Reset defaults';

  @override
  String get settingsPrivacy => 'Privacy';

  @override
  String get settingsPrivacyOptions => 'Privacy Options';

  @override
  String get settingsPrivacyPolicy => 'Privacy Policy';

  @override
  String get settingsAbout => 'About';

  @override
  String get aboutCalculation => 'Calculation Notes';

  @override
  String get aboutDisclaimer => 'Disclaimer';

  @override
  String get errorInvalidCapacity => 'Enter a capacity greater than 0 Wh.';

  @override
  String get errorInvalidWattage => 'Enter a wattage greater than 0 W.';

  @override
  String get errorNoDevices => 'Add at least one device.';

  @override
  String get errorInvalidRuntime => 'Enter a runtime greater than 0.';

  @override
  String get errorChargeRange => 'Charge must be between 0% and 100%.';

  @override
  String get errorReserveNoEnergy =>
      'The reserve floor leaves no usable charge.';

  @override
  String get warningSurgeTitle => 'Check startup surge';

  @override
  String get warningSurgeBody =>
      'Some motors and compressors briefly need much more power when they start. Make sure your power station can handle the device\'s surge.';

  @override
  String get warningOutputTitle => 'Output limit may be exceeded';

  @override
  String get warningOutputBody =>
      'The combined rated load is higher than the max continuous output you entered.';

  @override
  String get warningLowLoadTitle => 'Low-load estimate';

  @override
  String get warningLowLoadBody =>
      'Low AC loads can be less efficient because the power station uses some energy just to keep the inverter running.';

  @override
  String get warningCpapTitle => 'Critical equipment';

  @override
  String get warningCpapBody =>
      'Do not rely on this estimate as your only backup plan for medically necessary equipment. Follow the equipment and power-station manufacturer guidance and test your exact setup.';

  @override
  String get disclaimerShort =>
      'Actual runtime varies with appliance behavior, conversion losses, temperature, battery condition, and power-station overhead.';

  @override
  String get disclaimerFull =>
      'PowerLeft provides planning estimates only. It does not guarantee runtime, startup compatibility, or electrical safety. Verify manufacturer limits and test critical setups before relying on them.';

  @override
  String get privacyLocal =>
      'Your saved batteries and setups stay on this device.';

  @override
  String get privacyNoAccount => 'No account required.';

  @override
  String get adPrivacyNote =>
      'Ads are provided by Google AdMob and may process device, advertising, usage, and diagnostic data according to your consent choices and applicable law.';

  @override
  String get homeQuickTools => 'Quick Tools';

  @override
  String get categoryAll => 'All';

  @override
  String get categoryCamping => 'Camping';

  @override
  String get categoryHomeBackup => 'Home Backup';

  @override
  String get categoryOutdoor => 'Outdoor';

  @override
  String get categoryHighDraw => 'High Draw';

  @override
  String get devicePortableFridge => 'Portable fridge';

  @override
  String get deviceElectricBlanket => 'Electric blanket';

  @override
  String get deviceLedLight => 'LED light';

  @override
  String get deviceFan => 'Fan';

  @override
  String get devicePhoneCharger => 'Phone charger';

  @override
  String get deviceLaptop => 'Laptop';

  @override
  String get deviceCpap => 'CPAP';

  @override
  String get deviceRefrigerator => 'Refrigerator';

  @override
  String get deviceFreezer => 'Freezer';

  @override
  String get deviceWifiRouter => 'Wi-Fi router';

  @override
  String get deviceModem => 'Modem';

  @override
  String get deviceTv => 'TV';

  @override
  String get deviceDesktopPc => 'Desktop PC';

  @override
  String get deviceProjector => 'Projector';

  @override
  String get deviceSpeaker => 'Speaker';

  @override
  String get deviceCameraCharger => 'Camera charger';

  @override
  String get deviceDroneCharger => 'Drone charger';

  @override
  String get deviceCoffeeMaker => 'Coffee maker';

  @override
  String get deviceMicrowave => 'Microwave';

  @override
  String get deviceInductionCooktop => 'Induction cooktop';

  @override
  String get deviceHairDryer => 'Hair dryer';

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
  String get fieldOptional => 'Optional';

  @override
  String get saveSetupName => 'Setup name';

  @override
  String get saveSetupDefaultRuntime => 'Runtime setup';

  @override
  String get saveSetupDefaultBattery => 'Battery plan';

  @override
  String get dialogSaveSetupTitle => 'Save this setup';

  @override
  String get dialogDeleteTitle => 'Delete setup?';

  @override
  String get dialogDeleteBody => 'This cannot be undone.';

  @override
  String get commonClose => 'Close';

  @override
  String get commonBackHome => 'Back to Home';

  @override
  String get resultRange => 'Estimated range';

  @override
  String get resultInputLoad => 'Rated load';

  @override
  String get neededRoundedPlan => 'Planning threshold';

  @override
  String get settingsReserveHelp =>
      'Percentage of charge intentionally left unused.';

  @override
  String get settingsPrivacyOptionsUnavailable =>
      'Privacy options are not required for your current region or consent state.';

  @override
  String get aboutTitle => 'About PowerLeft';

  @override
  String get aboutLocalDataTitle => 'Your data';

  @override
  String get aboutLocalDataBody =>
      'Saved batteries, devices, and setups are stored on this device.';

  @override
  String get aboutEstimateTitle => 'Planning estimates';

  @override
  String get aboutEstimateBody =>
      'Runtime can change with temperature, battery health, inverter overhead, appliance cycling, and startup surge.';

  @override
  String get aboutMedicalTitle => 'Critical equipment';

  @override
  String get aboutMedicalBody =>
      'Do not use PowerLeft as the only backup-planning method for medically necessary equipment.';

  @override
  String get converterEnergy => 'Energy';

  @override
  String get converterCapacity => 'Capacity';

  @override
  String get converterFormula => 'Formula';

  @override
  String get converterEnterValues => 'Enter valid positive values.';

  @override
  String get customPercentLabel => 'On-time %';

  @override
  String get deviceSaveToMyDevices => 'Save to My Appliances';

  @override
  String get deviceTypicalRange => 'Typical range';

  @override
  String get deviceConfirmValue => 'Confirm or edit the wattage before adding.';

  @override
  String get savedUpdated => 'Updated';

  @override
  String get setupModeRuntime => 'Runtime';

  @override
  String get setupModeBattery => 'Battery needed';

  @override
  String get setupRecalculate => 'Recalculate';

  @override
  String get myAppliancesAdd => 'Add Custom Device';

  @override
  String get myAppliancesDeleteTitle => 'Delete device?';

  @override
  String get myAppliancesDeleteBody =>
      'Saved setups keep their existing snapshot.';

  @override
  String get settingsVersion => 'Version 1.0.0';

  @override
  String get commonNotAvailable => 'Not available';

  @override
  String get homeSubtitle => 'Battery runtime, without the guesswork.';

  @override
  String get batteryChargeValue => 'Charge';

  @override
  String get capacityUnit => 'Capacity unit';

  @override
  String get runtimeNoUsableEnergy =>
      'No energy remains above your reserve floor.';

  @override
  String get runtimeCapacityUnit => 'Capacity unit';

  @override
  String get runtimeReserveHelp => 'Leave this percentage of charge unused.';

  @override
  String get runtimeEfficiencyPercent => 'Efficiency %';

  @override
  String get runtimeEfficiencyHelp =>
      'Leave blank to use the connection default.';

  @override
  String get runtimeMaxOutputHelp =>
      'Optional. Used only to warn when rated load is too high.';

  @override
  String get runtimeBatteryEmpty => 'Battery is empty.';

  @override
  String get runtimeResultSaved => 'Setup saved.';

  @override
  String get runtimeSaveFailed => 'Could not save the setup.';

  @override
  String get resultTypicalEnergy => 'Typical effective energy';

  @override
  String get resultRatedLoad => 'Combined rated load';

  @override
  String get resultAboutEstimate =>
      'Actual runtime can change with appliance cycling, temperature, battery condition, conversion losses, and power-station overhead.';

  @override
  String get neededHoursHint => 'Enter hours';

  @override
  String get neededQuick => 'Quick select';

  @override
  String get neededResultSaved => 'Battery plan saved.';

  @override
  String get saveSetupNameRequired => 'Enter a setup name.';

  @override
  String get savedTitle => 'Saved Setups';

  @override
  String get savedDelete => 'Delete setup';

  @override
  String get savedEmptyAction =>
      'Create a calculation and save it to reuse later.';

  @override
  String get setupDetails => 'Setup Details';

  @override
  String get setupDevices => 'Devices';

  @override
  String get setupBattery => 'Battery';

  @override
  String get setupDesired => 'Desired runtime';

  @override
  String get setupConnection => 'Connection';

  @override
  String get setupNotFound => 'This setup could not be found.';

  @override
  String get settingsDefaultReserve => 'Default reserve floor';

  @override
  String get settingsResetDone => 'Defaults restored.';

  @override
  String get settingsPrivacyExplanation =>
      'Privacy choices are managed by Google UMP when required. Core calculations work without an account.';

  @override
  String get aboutPrivacyTitle => 'Ads & privacy';

  @override
  String get aboutPrivacyBody =>
      'PowerLeft stores your calculator data locally. Google AdMob may process device, advertising, usage, and diagnostic data according to your consent choices and applicable law.';

  @override
  String get aboutNoGuarantee =>
      'PowerLeft is an estimation tool. It does not guarantee runtime, startup compatibility, or electrical safety.';

  @override
  String get converterWh => 'Watt-hours (Wh)';

  @override
  String get converterAh => 'Amp-hours (Ah)';

  @override
  String get converterVoltageV => 'Voltage (V)';

  @override
  String get converterWhToAhFormula => 'Ah = Wh ÷ V';

  @override
  String get converterAhToWhFormula => 'Wh = Ah × V';

  @override
  String get commonHoursShort => 'h';

  @override
  String get commonSaveSetup => 'Save Setup';

  @override
  String get commonUpdateSetup => 'Update Setup';

  @override
  String get commonRecalculate => 'Recalculate';

  @override
  String get commonRemove => 'Remove';

  @override
  String get commonContinue => 'Continue';

  @override
  String get adNoImpact => 'Ads never block your calculation result.';

  @override
  String get commonMinutesShort => 'm';

  @override
  String get commonDaysShort => 'd';

  @override
  String get batteryProfilesTitle => 'Saved Batteries';

  @override
  String get batteryProfileChoose => 'Choose Saved Battery';

  @override
  String get batteryProfileAdd => 'Add Battery';

  @override
  String get batteryProfileName => 'Battery name';

  @override
  String get batteryProfileCapacity => 'Capacity';

  @override
  String get batteryProfileMaxOutput => 'Max continuous output';

  @override
  String get batteryProfileEmpty => 'No saved batteries yet';

  @override
  String get batteryProfileEmptyBody =>
      'Save a power station or battery you use often.';

  @override
  String get batteryProfileApplied => 'Saved battery applied.';

  @override
  String get batteryProfileCharge => 'Default charge';

  @override
  String get batteryProfileDelete => 'Delete battery';

  @override
  String get errorReserveRange => 'Reserve floor must be between 0% and 50%.';

  @override
  String get errorEfficiencyRange => 'Efficiency must be between 50% and 99%.';

  @override
  String get errorLoadData => 'Could not load saved data.';

  @override
  String get errorSaveData => 'Could not save your changes.';

  @override
  String get privacyPolicyTitle => 'Privacy Policy';

  @override
  String get privacyPolicyLocalTitle => 'Calculator data';

  @override
  String get privacyPolicyLocalBody =>
      'Battery profiles, custom devices, and saved setups are stored locally on this device. PowerLeft does not require an account or send these calculator records to a PowerLeft server.';

  @override
  String get privacyPolicyAdsTitle => 'Advertising';

  @override
  String get privacyPolicyAdsBody =>
      'PowerLeft uses Google AdMob interstitial ads. Depending on your region, consent choices, device settings, and Google Mobile Ads configuration, Google and its partners may process device identifiers, IP-derived general location, ad interactions, usage, and diagnostic information.';

  @override
  String get privacyPolicyConsentTitle => 'Privacy choices';

  @override
  String get privacyPolicyConsentBody =>
      'Where required, PowerLeft uses Google User Messaging Platform (UMP) to request or manage privacy choices before requesting ads. Core calculator features continue to work regardless of ad availability.';

  @override
  String get privacyPolicyTrackingTitle => 'Tracking permission';

  @override
  String get privacyPolicyTrackingBody =>
      'The MVP does not intentionally request Apple App Tracking Transparency permission. If a future release begins tracking as defined by Apple, the app and this policy must be updated before release.';

  @override
  String get privacyPolicyRetentionTitle => 'Retention';

  @override
  String get privacyPolicyRetentionBody =>
      'Calculator records remain on your device until you delete them or remove/reset the app. Advertising-data retention follows Google and its partners\' policies.';

  @override
  String get privacyPolicyChildrenTitle => 'Children';

  @override
  String get privacyPolicyChildrenBody =>
      'PowerLeft is not designed or marketed as a children\'s app.';

  @override
  String get privacyPolicyContactTitle => 'Contact';

  @override
  String get privacyPolicyContactBody =>
      'For privacy or support questions, use the public Support link on PowerLeft’s App Store product page.';

  @override
  String get errorCapacityRange =>
      'Enter a capacity greater than 0 and no more than 100,000 Wh.';

  @override
  String get errorWattageRange =>
      'Enter a wattage greater than 0 and no more than 10,000 W.';

  @override
  String get errorRuntimeRange =>
      'Enter a runtime greater than 0 and no more than 336 hours.';

  @override
  String get errorMaxOutputRange =>
      'Max continuous output must be greater than 0 W.';

  @override
  String get errorNameRequired => 'Enter a name.';

  @override
  String get settingsDataTitle => 'Saved Data';

  @override
  String get settingsDeleteLocalData => 'Delete Saved Data';

  @override
  String get settingsDeleteLocalDataBody =>
      'Delete all saved batteries, custom devices, and setups from this device. App settings and privacy choices are not deleted.';

  @override
  String get settingsDeleteLocalDataConfirm => 'Delete saved data?';

  @override
  String get settingsDeleteLocalDataDone => 'Saved data deleted.';

  @override
  String get categoryOther => 'Other';

  @override
  String get setupRenameTitle => 'Rename Setup';

  @override
  String get setupRenameDone => 'Setup renamed.';

  @override
  String get categoryWork => 'Work';

  @override
  String get deviceCategory => 'Category';

  @override
  String get devicePortableMonitor => 'Portable monitor';

  @override
  String get deviceWorkLight => 'Work light';

  @override
  String get devicePowerToolCharger => 'Power-tool charger';

  @override
  String get deviceSolderingIron => 'Soldering iron';

  @override
  String get aboutOpenSourceLicenses => 'Open Source Licenses';

  @override
  String get aboutOpenSourceBody =>
      'View licenses for Flutter and third-party packages used by PowerLeft.';

  @override
  String get converterCaveat =>
      'Ah depends on voltage. Battery chemistry, conversion losses, reserve, and device behavior can reduce usable energy, so this conversion is not a runtime guarantee.';

  @override
  String get errorCalculation =>
      'Could not calculate with these values. Check your inputs and try again.';

  @override
  String get warningReserveTitle => 'No usable charge';

  @override
  String get designTagline => 'Plan Power. Live Further.';

  @override
  String get designRuntimeQuestion => 'How long\nwill it last?';

  @override
  String get designNeededQuestion => 'How much\ndo I need?';

  @override
  String get designCampTitle => 'More power for what matters.';

  @override
  String get designCampBody => 'CAMP · EXPLORE · PREPARE';

  @override
  String get designRuntimeHelp =>
      'Enter your battery and the devices you plan to run.';

  @override
  String get designNeededHelp =>
      'Choose your devices and how long you need them.';

  @override
  String get designCompareHint => 'Compare three realistic conditions.';

  @override
  String get designDetails => 'Calculation details';

  @override
  String get designSavedHint => 'Reuse your favorite calculations.';

  @override
  String get designAppliancesHint => 'Your everyday gear, ready to add.';

  @override
  String get designBatteriesHint => 'Keep your battery specs close.';

  @override
  String get designToolsHint => 'Quick conversions and references.';

  @override
  String get designRuntimeBody =>
      'Estimate runtime for your battery and devices.';

  @override
  String get designNeededBody => 'Find a battery size for your plans.';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsLanguageSystem => 'Use device language';
}
