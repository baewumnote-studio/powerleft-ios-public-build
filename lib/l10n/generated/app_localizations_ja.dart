// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appName => 'PowerLeft';

  @override
  String get homeRuntimeTitle => 'このバッテリーで何時間使える？';

  @override
  String get homeRuntimeSubtitle => 'バッテリー + 機器 → 使用時間';

  @override
  String get homeRuntimeCta => '使用時間を計算';

  @override
  String get homeNeededTitle => '必要なバッテリー容量は？';

  @override
  String get homeNeededSubtitle => '機器 + 時間 → 必要容量';

  @override
  String get homeNeededCta => '必要容量を計算';

  @override
  String get homeSavedTitle => '保存したセットアップ';

  @override
  String get commonSeeAll => 'すべて見る';

  @override
  String get commonAdd => '追加';

  @override
  String get commonSave => '保存';

  @override
  String get commonCancel => 'キャンセル';

  @override
  String get commonDone => '完了';

  @override
  String get commonDelete => '削除';

  @override
  String get commonEdit => '編集';

  @override
  String get commonReset => 'リセット';

  @override
  String get commonHours => '時間';

  @override
  String get commonMinutes => '分';

  @override
  String get commonDays => '日';

  @override
  String get onboarding1Title => '電源がどれくらい持つか、先に確認。';

  @override
  String get onboarding1Body => 'バッテリーと機器を追加して、実用的な使用時間を見積もります。';

  @override
  String get onboardingNext => '次へ';

  @override
  String get onboardingSkip => 'スキップ';

  @override
  String get onboarding2Title => '購入前に必要容量を計画。';

  @override
  String get onboarding2Body => '必要なバッテリー容量を見積もります。アカウント不要。保存データはこの端末に残ります。';

  @override
  String get onboardingStart => '始める';

  @override
  String get runtimeTitle => '使用時間';

  @override
  String get runtimeBattery => 'バッテリー';

  @override
  String get runtimeCapacity => '容量';

  @override
  String get runtimeCharge => '現在の充電量';

  @override
  String get runtimeConnection => '接続';

  @override
  String get runtimeDevices => '機器';

  @override
  String get runtimeAddDevice => '機器を追加';

  @override
  String get runtimeTotalLoad => '合計平均負荷';

  @override
  String get runtimeCalculate => '使用時間を計算';

  @override
  String get runtimeAdvanced => '詳細設定';

  @override
  String get runtimeReserve => '予備残量';

  @override
  String get runtimeEfficiency => '効率';

  @override
  String get runtimeAutomatic => '自動';

  @override
  String get runtimeMaxOutput => '最大連続出力';

  @override
  String get resultRuntimeTitle => '推定使用時間';

  @override
  String get resultRuntimeTypical => '標準的な見積もり';

  @override
  String get resultConservative => '保守的';

  @override
  String get resultTypical => '標準';

  @override
  String get resultBest => '最良条件';

  @override
  String get resultAvailableEnergy => '実効エネルギー';

  @override
  String get resultAverageLoad => '平均負荷';

  @override
  String get resultAssumptions => '計算条件';

  @override
  String get resultSaveSetup => 'セットアップを保存';

  @override
  String get resultUpdateSetup => 'セットアップを更新';

  @override
  String get resultAdjust => '機器を調整';

  @override
  String get neededTitle => '必要バッテリー容量';

  @override
  String get neededDesiredRuntime => '希望使用時間';

  @override
  String get neededCalculate => '容量を計算';

  @override
  String get neededResultTitle => '推奨容量';

  @override
  String get neededMinimum => '最小計算値';

  @override
  String get neededRecommended => '推奨';

  @override
  String get neededComfortable => '余裕あり';

  @override
  String get neededEnergyDemand => '必要エネルギー';

  @override
  String get deviceSearch => '機器を検索';

  @override
  String get deviceCustom => 'カスタム機器を追加';

  @override
  String get deviceName => '機器名';

  @override
  String get deviceWattage => '消費電力';

  @override
  String get deviceUsage => '使用パターン';

  @override
  String get deviceUsageAlways => '常時オン';

  @override
  String get deviceUsageUsually => 'ほぼ常時';

  @override
  String get deviceUsageCycles => '周期運転';

  @override
  String get deviceUsageOccasional => '時々使用';

  @override
  String get deviceUsageCustom => 'カスタム';

  @override
  String get deviceConnectionDefault => '計算機の既定値';

  @override
  String get deviceStartupSurge => '起動サージあり';

  @override
  String get deviceLabelHint => '可能であれば製品ラベルまたはワットメーターの値を確認してください。';

  @override
  String get deviceFridgeHint => 'コンプレッサー機器はオン・オフを繰り返します。定格Wと平均Wは同じではありません。';

  @override
  String get deviceCpapHint =>
      '加湿器や加温チューブの使用で消費電力が大きく変わることがあります。実際の構成の消費電力を使用してください。';

  @override
  String get savedEmptyTitle => '保存したセットアップはありません';

  @override
  String get savedEmptyBody => 'キャンプや停電用セットアップを保存して再利用できます。';

  @override
  String get appliancesTitle => 'マイ機器';

  @override
  String get appliancesEmptyTitle => '保存した機器はありません';

  @override
  String get appliancesEmptyBody => 'よく使う機器を保存すると次回の計算が速くなります。';

  @override
  String get toolsTitle => 'ツール';

  @override
  String get toolsConverter => 'Wh ↔ Ah 変換';

  @override
  String get converterWhToAh => 'Wh → Ah';

  @override
  String get converterAhToWh => 'Ah → Wh';

  @override
  String get converterVoltage => '電圧';

  @override
  String get converterResult => '結果';

  @override
  String get settingsTitle => '設定';

  @override
  String get settingsTheme => 'テーマ';

  @override
  String get settingsThemeSystem => 'システム';

  @override
  String get settingsThemeLight => 'ライト';

  @override
  String get settingsThemeDark => 'ダーク';

  @override
  String get settingsDefaults => '既定値';

  @override
  String get settingsDefaultConnection => '既定の接続';

  @override
  String get settingsResetDefaults => '既定値に戻す';

  @override
  String get settingsPrivacy => 'プライバシー';

  @override
  String get settingsPrivacyOptions => 'プライバシー設定';

  @override
  String get settingsPrivacyPolicy => 'プライバシーポリシー';

  @override
  String get settingsAbout => '情報';

  @override
  String get aboutCalculation => '計算について';

  @override
  String get aboutDisclaimer => '免責事項';

  @override
  String get errorInvalidCapacity => '0Whより大きい容量を入力してください。';

  @override
  String get errorInvalidWattage => '0Wより大きい消費電力を入力してください。';

  @override
  String get errorNoDevices => '機器を1つ以上追加してください。';

  @override
  String get errorInvalidRuntime => '0より大きい使用時間を入力してください。';

  @override
  String get errorChargeRange => '充電量は0〜100%にしてください。';

  @override
  String get errorReserveNoEnergy => '予備残量を差し引くと使用可能な電力がありません。';

  @override
  String get warningSurgeTitle => '起動サージを確認';

  @override
  String get warningSurgeBody =>
      'モーターやコンプレッサーは起動時に一時的に大きな電力を必要とすることがあります。ポータブル電源が起動サージに対応できるか確認してください。';

  @override
  String get warningOutputTitle => '出力上限を超える可能性があります';

  @override
  String get warningOutputBody => '機器の定格負荷合計が、入力した最大連続出力を上回っています。';

  @override
  String get warningLowLoadTitle => '低負荷時の見積もり';

  @override
  String get warningLowLoadBody =>
      'AC負荷が小さい場合、インバーターを動作させるための電力消費により効率が低下することがあります。';

  @override
  String get warningCpapTitle => '重要機器について';

  @override
  String get warningCpapBody =>
      '医療上必要な機器の唯一のバックアップ計画としてこの推定値だけに頼らないでください。機器とポータブル電源のメーカー指示に従い、実際の構成を事前にテストしてください。';

  @override
  String get disclaimerShort =>
      '実際の使用時間は、機器の動作、変換損失、温度、バッテリー状態、ポータブル電源の自己消費によって変わります。';

  @override
  String get disclaimerFull =>
      'PowerLeftは計画用の推定値を提供します。使用時間、起動時の互換性、電気的安全性を保証するものではありません。メーカーの制限を確認し、重要な構成は事前にテストしてください。';

  @override
  String get privacyLocal => '保存したバッテリーとセットアップはこの端末に残ります。';

  @override
  String get privacyNoAccount => 'アカウント不要。';

  @override
  String get adPrivacyNote =>
      '広告はGoogle AdMobが提供し、同意内容と適用法令に応じて、端末・広告・利用状況・診断データを処理する場合があります。';

  @override
  String get homeQuickTools => 'クイックツール';

  @override
  String get categoryAll => 'すべて';

  @override
  String get categoryCamping => 'キャンプ';

  @override
  String get categoryHomeBackup => '停電バックアップ';

  @override
  String get categoryOutdoor => 'アウトドア';

  @override
  String get categoryHighDraw => '高出力';

  @override
  String get devicePortableFridge => 'ポータブル冷蔵庫';

  @override
  String get deviceElectricBlanket => '電気毛布';

  @override
  String get deviceLedLight => 'LEDライト';

  @override
  String get deviceFan => '扇風機';

  @override
  String get devicePhoneCharger => 'スマートフォン充電器';

  @override
  String get deviceLaptop => 'ノートPC';

  @override
  String get deviceCpap => 'CPAP';

  @override
  String get deviceRefrigerator => '冷蔵庫';

  @override
  String get deviceFreezer => '冷凍庫';

  @override
  String get deviceWifiRouter => 'Wi-Fiルーター';

  @override
  String get deviceModem => 'モデム';

  @override
  String get deviceTv => 'TV';

  @override
  String get deviceDesktopPc => 'デスクトップPC';

  @override
  String get deviceProjector => 'プロジェクター';

  @override
  String get deviceSpeaker => 'スピーカー';

  @override
  String get deviceCameraCharger => 'カメラ充電器';

  @override
  String get deviceDroneCharger => 'ドローン充電器';

  @override
  String get deviceCoffeeMaker => 'コーヒーメーカー';

  @override
  String get deviceMicrowave => '電子レンジ';

  @override
  String get deviceInductionCooktop => 'IHクッキングヒーター';

  @override
  String get deviceHairDryer => 'ヘアドライヤー';

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
  String get fieldOptional => '任意';

  @override
  String get saveSetupName => 'セットアップ名';

  @override
  String get saveSetupDefaultRuntime => '使用時間セットアップ';

  @override
  String get saveSetupDefaultBattery => 'バッテリープラン';

  @override
  String get dialogSaveSetupTitle => 'このセットアップを保存';

  @override
  String get dialogDeleteTitle => 'セットアップを削除しますか？';

  @override
  String get dialogDeleteBody => 'この操作は元に戻せません。';

  @override
  String get commonClose => '閉じる';

  @override
  String get commonBackHome => 'ホームに戻る';

  @override
  String get resultRange => '推定範囲';

  @override
  String get resultInputLoad => '定格負荷';

  @override
  String get neededRoundedPlan => '計画目安';

  @override
  String get settingsReserveHelp => '意図的に使わず残しておく充電割合です。';

  @override
  String get settingsPrivacyOptionsUnavailable =>
      '現在の地域または同意状態ではプライバシー設定は必要ありません。';

  @override
  String get aboutTitle => 'PowerLeftについて';

  @override
  String get aboutLocalDataTitle => 'データ';

  @override
  String get aboutLocalDataBody => '保存したバッテリー、機器、セットアップはこの端末に保存されます。';

  @override
  String get aboutEstimateTitle => '計画用の推定値';

  @override
  String get aboutEstimateBody =>
      '使用時間は温度、バッテリー劣化、インバーター自己消費、機器の周期運転、起動サージなどで変わります。';

  @override
  String get aboutMedicalTitle => '重要な機器';

  @override
  String get aboutMedicalBody => '医療上必要な機器のバックアップ計画をPowerLeftだけに頼らないでください。';

  @override
  String get converterEnergy => 'エネルギー';

  @override
  String get converterCapacity => '容量';

  @override
  String get converterFormula => '計算式';

  @override
  String get converterEnterValues => '0より大きい有効な値を入力してください。';

  @override
  String get customPercentLabel => '稼働率 %';

  @override
  String get deviceSaveToMyDevices => 'マイ機器に保存';

  @override
  String get deviceTypicalRange => '一般的な範囲';

  @override
  String get deviceConfirmValue => '追加前に消費電力を確認または修正してください。';

  @override
  String get savedUpdated => '更新';

  @override
  String get setupModeRuntime => '使用時間';

  @override
  String get setupModeBattery => '必要容量';

  @override
  String get setupRecalculate => '再計算';

  @override
  String get myAppliancesAdd => 'カスタム機器を追加';

  @override
  String get myAppliancesDeleteTitle => '機器を削除しますか？';

  @override
  String get myAppliancesDeleteBody => '保存済みセットアップには現在の値がそのまま残ります。';

  @override
  String get settingsVersion => 'バージョン 1.0.0';

  @override
  String get commonNotAvailable => '利用できません';

  @override
  String get homeSubtitle => 'バッテリーの使用時間を、迷わず計算。';

  @override
  String get batteryChargeValue => '充電量';

  @override
  String get capacityUnit => '容量単位';

  @override
  String get runtimeNoUsableEnergy => '予備残量を差し引くと使用できるエネルギーがありません。';

  @override
  String get runtimeCapacityUnit => '容量単位';

  @override
  String get runtimeReserveHelp => 'この割合の充電量を使わずに残します。';

  @override
  String get runtimeEfficiencyPercent => '効率 %';

  @override
  String get runtimeEfficiencyHelp => '空欄の場合は接続方式の既定値を使用します。';

  @override
  String get runtimeMaxOutputHelp => '任意。定格負荷が大きすぎる場合の警告にのみ使用します。';

  @override
  String get runtimeBatteryEmpty => 'バッテリー残量がありません。';

  @override
  String get runtimeResultSaved => 'セットアップを保存しました。';

  @override
  String get runtimeSaveFailed => 'セットアップを保存できませんでした。';

  @override
  String get resultTypicalEnergy => '標準条件の実効エネルギー';

  @override
  String get resultRatedLoad => '定格負荷合計';

  @override
  String get resultAboutEstimate =>
      '実際の使用時間は、機器の周期運転、温度、バッテリー状態、変換損失、ポータブル電源の自己消費によって変わることがあります。';

  @override
  String get neededHoursHint => '時間を入力';

  @override
  String get neededQuick => 'クイック選択';

  @override
  String get neededResultSaved => 'バッテリープランを保存しました。';

  @override
  String get saveSetupNameRequired => 'セットアップ名を入力してください。';

  @override
  String get savedTitle => '保存したセットアップ';

  @override
  String get savedDelete => 'セットアップを削除';

  @override
  String get savedEmptyAction => '計算結果を保存すると、次回すぐに再利用できます。';

  @override
  String get setupDetails => 'セットアップ詳細';

  @override
  String get setupDevices => '機器';

  @override
  String get setupBattery => 'バッテリー';

  @override
  String get setupDesired => '希望使用時間';

  @override
  String get setupConnection => '接続方式';

  @override
  String get setupNotFound => 'このセットアップが見つかりません。';

  @override
  String get settingsDefaultReserve => '既定の予備残量';

  @override
  String get settingsResetDone => '既定値に戻しました。';

  @override
  String get settingsPrivacyExplanation =>
      '必要な場合はGoogle UMPでプライバシー設定を管理します。主要な計算機能はアカウントなしで使えます。';

  @override
  String get aboutPrivacyTitle => '広告とプライバシー';

  @override
  String get aboutPrivacyBody =>
      'PowerLeftの計算データは端末内に保存されます。Google AdMobは、同意内容と適用法令に応じて端末・広告・利用状況・診断データを処理する場合があります。';

  @override
  String get aboutNoGuarantee =>
      'PowerLeftは推定ツールです。使用時間、起動時の互換性、電気的安全性を保証しません。';

  @override
  String get converterWh => 'ワット時 (Wh)';

  @override
  String get converterAh => 'アンペア時 (Ah)';

  @override
  String get converterVoltageV => '電圧 (V)';

  @override
  String get converterWhToAhFormula => 'Ah = Wh ÷ V';

  @override
  String get converterAhToWhFormula => 'Wh = Ah × V';

  @override
  String get commonHoursShort => '時間';

  @override
  String get commonSaveSetup => 'セットアップを保存';

  @override
  String get commonUpdateSetup => 'セットアップを更新';

  @override
  String get commonRecalculate => '再計算';

  @override
  String get commonRemove => '削除';

  @override
  String get commonContinue => '続ける';

  @override
  String get adNoImpact => '広告が計算結果の確認を妨げることはありません。';

  @override
  String get commonMinutesShort => '分';

  @override
  String get commonDaysShort => '日';

  @override
  String get batteryProfilesTitle => '保存したバッテリー';

  @override
  String get batteryProfileChoose => '保存したバッテリーを選択';

  @override
  String get batteryProfileAdd => 'バッテリーを追加';

  @override
  String get batteryProfileName => 'バッテリー名';

  @override
  String get batteryProfileCapacity => '容量';

  @override
  String get batteryProfileMaxOutput => '最大連続出力';

  @override
  String get batteryProfileEmpty => '保存したバッテリーはありません';

  @override
  String get batteryProfileEmptyBody => 'よく使うポータブル電源やバッテリーを保存できます。';

  @override
  String get batteryProfileApplied => '保存したバッテリーを適用しました。';

  @override
  String get batteryProfileCharge => '既定の充電量';

  @override
  String get batteryProfileDelete => 'バッテリーを削除';

  @override
  String get errorReserveRange => '予備残量は0〜50%にしてください。';

  @override
  String get errorEfficiencyRange => '効率は50〜99%にしてください。';

  @override
  String get errorLoadData => '保存データを読み込めませんでした。';

  @override
  String get errorSaveData => '変更を保存できませんでした。';

  @override
  String get privacyPolicyTitle => 'プライバシーポリシー';

  @override
  String get privacyPolicyLocalTitle => '計算データ';

  @override
  String get privacyPolicyLocalBody =>
      'バッテリープロファイル、カスタム機器、保存したセットアップはこの端末に保存されます。PowerLeftはアカウントを必要とせず、これらの計算記録をPowerLeft独自のサーバーへ送信しません。';

  @override
  String get privacyPolicyAdsTitle => '広告';

  @override
  String get privacyPolicyAdsBody =>
      'PowerLeftはGoogle AdMobの全画面広告を使用します。地域、同意内容、端末設定、Google Mobile Adsの構成に応じて、Googleおよびパートナーが端末識別子、IPアドレスから推定されるおおまかな位置、広告操作、利用状況、診断情報を処理する場合があります。';

  @override
  String get privacyPolicyConsentTitle => 'プライバシー設定';

  @override
  String get privacyPolicyConsentBody =>
      '必要な地域では、広告をリクエストする前にGoogle User Messaging Platform（UMP）を使ってプライバシー設定を案内・管理します。広告が利用できない場合でも主要な計算機能は動作します。';

  @override
  String get privacyPolicyTrackingTitle => 'トラッキング許可';

  @override
  String get privacyPolicyTrackingBody =>
      'MVPではAppleのApp Tracking Transparency（ATT）許可を意図的に要求しません。将来Appleの定義するトラッキングを開始する場合は、公開前にアプリと本ポリシーを更新します。';

  @override
  String get privacyPolicyRetentionTitle => '保存期間';

  @override
  String get privacyPolicyRetentionBody =>
      '計算記録は、削除するかアプリを削除・リセットするまで端末に残ります。広告関連データの保存はGoogleおよびパートナーの方針に従います。';

  @override
  String get privacyPolicyChildrenTitle => '子ども';

  @override
  String get privacyPolicyChildrenBody => 'PowerLeftは子ども向けアプリとして設計・宣伝されていません。';

  @override
  String get privacyPolicyContactTitle => 'お問い合わせ';

  @override
  String get privacyPolicyContactBody =>
      'プライバシーまたはサポートに関するお問い合わせは、PowerLeftのApp Store製品ページに表示されるサポートリンクをご利用ください。';

  @override
  String get errorCapacityRange => '0Whより大きく100,000Wh以下の容量を入力してください。';

  @override
  String get errorWattageRange => '0Wより大きく10,000W以下の消費電力を入力してください。';

  @override
  String get errorRuntimeRange => '0時間より大きく336時間以下の使用時間を入力してください。';

  @override
  String get errorMaxOutputRange => '最大連続出力は0Wより大きい値にしてください。';

  @override
  String get errorNameRequired => '名前を入力してください。';

  @override
  String get settingsDataTitle => '保存データ';

  @override
  String get settingsDeleteLocalData => '保存データを削除';

  @override
  String get settingsDeleteLocalDataBody =>
      'この端末に保存したバッテリー、カスタム機器、セットアップをすべて削除します。アプリ設定とプライバシー選択は削除されません。';

  @override
  String get settingsDeleteLocalDataConfirm => '保存データを削除しますか？';

  @override
  String get settingsDeleteLocalDataDone => '保存データを削除しました。';

  @override
  String get categoryOther => 'その他';

  @override
  String get setupRenameTitle => 'セットアップ名を変更';

  @override
  String get setupRenameDone => 'セットアップ名を変更しました。';

  @override
  String get categoryWork => '仕事';

  @override
  String get deviceCategory => 'カテゴリ';

  @override
  String get devicePortableMonitor => 'ポータブルモニター';

  @override
  String get deviceWorkLight => '作業灯';

  @override
  String get devicePowerToolCharger => '電動工具充電器';

  @override
  String get deviceSolderingIron => 'はんだごて';

  @override
  String get aboutOpenSourceLicenses => 'オープンソースライセンス';

  @override
  String get aboutOpenSourceBody =>
      'PowerLeftで使用しているFlutterおよび外部パッケージのライセンスを確認します。';

  @override
  String get converterCaveat =>
      'Ahは電圧によって変わります。バッテリー種類、変換損失、予備残量、機器の動作によって実際に使えるエネルギーは減るため、この換算値は使用時間を保証しません。';

  @override
  String get errorCalculation => 'この値では計算できません。入力内容を確認してもう一度お試しください。';

  @override
  String get warningReserveTitle => '使用できる充電量がありません';

  @override
  String get designTagline => '電力を計画。もっと遠くへ。';

  @override
  String get designRuntimeQuestion => 'どのくらい\n使える？';

  @override
  String get designNeededQuestion => 'どのくらい\n必要？';

  @override
  String get designCampTitle => '大切な時間を、もっと長く。';

  @override
  String get designCampBody => 'キャンプ · 旅 · 停電対策';

  @override
  String get designRuntimeHelp => 'バッテリーと使う機器を入力してください。';

  @override
  String get designNeededHelp => '機器と必要な使用時間を選んでください。';

  @override
  String get designCompareHint => '3つの条件をひと目で比較。';

  @override
  String get designDetails => '計算の詳細';

  @override
  String get designSavedHint => 'よく使う計算をすぐに再利用。';

  @override
  String get designAppliancesHint => 'いつもの機器をまとめて保存。';

  @override
  String get designBatteriesHint => 'バッテリーの仕様を手元に。';

  @override
  String get designToolsHint => '容量換算と計算方法を確認。';

  @override
  String get designRuntimeBody => 'バッテリーと機器から使用時間を計算。';

  @override
  String get designNeededBody => '機器と時間から必要容量を計算。';

  @override
  String get settingsLanguage => '言語';

  @override
  String get settingsLanguageSystem => '端末の言語を使用';
}
