// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appName => 'PowerLeft';

  @override
  String get homeRuntimeTitle => '이 배터리로 얼마나 쓸 수 있나요?';

  @override
  String get homeRuntimeSubtitle => '배터리 + 기기 → 예상 사용시간';

  @override
  String get homeRuntimeCta => '사용시간 계산';

  @override
  String get homeNeededTitle => '배터리가 얼마나 필요하나요?';

  @override
  String get homeNeededSubtitle => '기기 + 시간 → 필요한 용량';

  @override
  String get homeNeededCta => '필요 용량 계산';

  @override
  String get homeSavedTitle => '저장한 세팅';

  @override
  String get commonSeeAll => '전체 보기';

  @override
  String get commonAdd => '추가';

  @override
  String get commonSave => '저장';

  @override
  String get commonCancel => '취소';

  @override
  String get commonDone => '완료';

  @override
  String get commonDelete => '삭제';

  @override
  String get commonEdit => '수정';

  @override
  String get commonReset => '초기화';

  @override
  String get commonHours => '시간';

  @override
  String get commonMinutes => '분';

  @override
  String get commonDays => '일';

  @override
  String get onboarding1Title => '전력이 얼마나 버틸지 미리 확인하세요.';

  @override
  String get onboarding1Body => '배터리와 사용할 기기를 추가하면 현실적인 사용시간을 추정합니다.';

  @override
  String get onboardingNext => '다음';

  @override
  String get onboardingSkip => '건너뛰기';

  @override
  String get onboarding2Title => '구매 전에 필요한 용량을 계산하세요.';

  @override
  String get onboarding2Body =>
      '필요한 배터리 용량을 추정합니다. 계정은 필요 없고 저장한 세팅은 이 기기에만 보관됩니다.';

  @override
  String get onboardingStart => '시작하기';

  @override
  String get runtimeTitle => '사용시간';

  @override
  String get runtimeBattery => '배터리';

  @override
  String get runtimeCapacity => '용량';

  @override
  String get runtimeCharge => '현재 충전량';

  @override
  String get runtimeConnection => '연결 방식';

  @override
  String get runtimeDevices => '기기';

  @override
  String get runtimeAddDevice => '기기 추가';

  @override
  String get runtimeTotalLoad => '총 평균 부하';

  @override
  String get runtimeCalculate => '사용시간 계산';

  @override
  String get runtimeAdvanced => '고급 설정';

  @override
  String get runtimeReserve => '남겨둘 충전량';

  @override
  String get runtimeEfficiency => '효율';

  @override
  String get runtimeAutomatic => '자동';

  @override
  String get runtimeMaxOutput => '최대 연속 출력';

  @override
  String get resultRuntimeTitle => '예상 사용시간';

  @override
  String get resultRuntimeTypical => '일반적인 예상치';

  @override
  String get resultConservative => '보수적';

  @override
  String get resultTypical => '일반';

  @override
  String get resultBest => '최적 조건';

  @override
  String get resultAvailableEnergy => '실사용 가능 에너지';

  @override
  String get resultAverageLoad => '평균 부하';

  @override
  String get resultAssumptions => '계산 기준';

  @override
  String get resultSaveSetup => '세팅 저장';

  @override
  String get resultUpdateSetup => '세팅 업데이트';

  @override
  String get resultAdjust => '기기 조정';

  @override
  String get neededTitle => '필요 배터리 용량';

  @override
  String get neededDesiredRuntime => '원하는 사용시간';

  @override
  String get neededCalculate => '용량 계산';

  @override
  String get neededResultTitle => '권장 배터리 용량';

  @override
  String get neededMinimum => '최소 계산값';

  @override
  String get neededRecommended => '권장';

  @override
  String get neededComfortable => '여유 있게';

  @override
  String get neededEnergyDemand => '필요 에너지';

  @override
  String get deviceSearch => '기기 검색';

  @override
  String get deviceCustom => '직접 기기 추가';

  @override
  String get deviceName => '기기 이름';

  @override
  String get deviceWattage => '소비전력';

  @override
  String get deviceUsage => '사용 패턴';

  @override
  String get deviceUsageAlways => '항상 켬';

  @override
  String get deviceUsageUsually => '대부분 켬';

  @override
  String get deviceUsageCycles => '주기적으로 작동';

  @override
  String get deviceUsageOccasional => '가끔 사용';

  @override
  String get deviceUsageCustom => '직접 설정';

  @override
  String get deviceConnectionDefault => '계산기 기본값 사용';

  @override
  String get deviceStartupSurge => '시동 순간 높은 전력 사용';

  @override
  String get deviceLabelHint => '가능하면 제품 라벨이나 전력 측정기의 값을 확인하세요.';

  @override
  String get deviceFridgeHint => '컴프레서 기기는 켜졌다 꺼지므로 정격 W와 실제 평균 W가 다를 수 있습니다.';

  @override
  String get deviceCpapHint =>
      '가습기와 열선 호스 사용 여부에 따라 소비전력이 크게 달라질 수 있습니다. 실제 세팅의 소비전력을 사용하세요.';

  @override
  String get savedEmptyTitle => '저장한 세팅이 없습니다';

  @override
  String get savedEmptyBody => '캠핑이나 정전 대비 세팅을 저장해 다음에 빠르게 다시 계산하세요.';

  @override
  String get appliancesTitle => '내 기기';

  @override
  String get appliancesEmptyTitle => '저장한 기기가 없습니다';

  @override
  String get appliancesEmptyBody => '자주 쓰는 기기를 저장하면 다음 계산이 더 빨라집니다.';

  @override
  String get toolsTitle => '도구';

  @override
  String get toolsConverter => 'Wh ↔ Ah 변환';

  @override
  String get converterWhToAh => 'Wh → Ah';

  @override
  String get converterAhToWh => 'Ah → Wh';

  @override
  String get converterVoltage => '전압';

  @override
  String get converterResult => '결과';

  @override
  String get settingsTitle => '설정';

  @override
  String get settingsTheme => '테마';

  @override
  String get settingsThemeSystem => '시스템';

  @override
  String get settingsThemeLight => '라이트';

  @override
  String get settingsThemeDark => '다크';

  @override
  String get settingsDefaults => '기본값';

  @override
  String get settingsDefaultConnection => '기본 연결 방식';

  @override
  String get settingsResetDefaults => '기본값 초기화';

  @override
  String get settingsPrivacy => '개인정보';

  @override
  String get settingsPrivacyOptions => '개인정보 선택';

  @override
  String get settingsPrivacyPolicy => '개인정보 처리방침';

  @override
  String get settingsAbout => '정보';

  @override
  String get aboutCalculation => '계산 방식';

  @override
  String get aboutDisclaimer => '주의사항';

  @override
  String get errorInvalidCapacity => '0Wh보다 큰 용량을 입력하세요.';

  @override
  String get errorInvalidWattage => '0W보다 큰 소비전력을 입력하세요.';

  @override
  String get errorNoDevices => '기기를 하나 이상 추가하세요.';

  @override
  String get errorInvalidRuntime => '0보다 큰 사용시간을 입력하세요.';

  @override
  String get errorChargeRange => '충전량은 0~100% 사이여야 합니다.';

  @override
  String get errorReserveNoEnergy => '남겨둘 충전량을 제외하면 사용할 수 있는 에너지가 없습니다.';

  @override
  String get warningSurgeTitle => '시동 전력을 확인하세요';

  @override
  String get warningSurgeBody =>
      '모터나 컴프레서는 시작 순간 정격보다 훨씬 큰 전력이 필요할 수 있습니다. 파워스테이션의 순간 출력 한도를 확인하세요.';

  @override
  String get warningOutputTitle => '출력 한도를 넘을 수 있습니다';

  @override
  String get warningOutputBody => '입력한 최대 연속 출력보다 기기 정격부하 합계가 큽니다.';

  @override
  String get warningLowLoadTitle => '낮은 부하의 오차 가능성';

  @override
  String get warningLowLoadBody =>
      'AC 부하가 매우 낮으면 인버터 자체 소비전력 때문에 실제 효율이 더 낮을 수 있습니다.';

  @override
  String get warningCpapTitle => '중요 장비 주의';

  @override
  String get warningCpapBody =>
      '의학적으로 필요한 장비의 유일한 백업 판단 근거로 이 추정값만 사용하지 마세요. 장비와 파워스테이션 제조사 지침을 따르고 실제 조합을 미리 시험하세요.';

  @override
  String get disclaimerShort =>
      '실제 사용시간은 기기 작동 방식, 변환 손실, 온도, 배터리 상태, 파워스테이션 자체 소비전력에 따라 달라집니다.';

  @override
  String get disclaimerFull =>
      'PowerLeft의 결과는 계획용 추정치입니다. 실제 사용시간, 시동 호환성, 전기적 안전을 보장하지 않습니다. 제조사 한도를 확인하고 중요한 백업 세팅은 실제로 시험하세요.';

  @override
  String get privacyLocal => '저장한 배터리와 세팅은 이 기기에 보관됩니다.';

  @override
  String get privacyNoAccount => '계정이 필요 없습니다.';

  @override
  String get adPrivacyNote =>
      '광고는 Google AdMob에서 제공하며 동의 선택과 적용 법률에 따라 기기·광고·사용·진단 관련 데이터를 처리할 수 있습니다.';

  @override
  String get homeQuickTools => '빠른 도구';

  @override
  String get categoryAll => '전체';

  @override
  String get categoryCamping => '캠핑';

  @override
  String get categoryHomeBackup => '정전 대비';

  @override
  String get categoryOutdoor => '야외';

  @override
  String get categoryHighDraw => '고출력';

  @override
  String get devicePortableFridge => '휴대용 냉장고';

  @override
  String get deviceElectricBlanket => '전기담요';

  @override
  String get deviceLedLight => 'LED 조명';

  @override
  String get deviceFan => '선풍기';

  @override
  String get devicePhoneCharger => '휴대폰 충전기';

  @override
  String get deviceLaptop => '노트북';

  @override
  String get deviceCpap => 'CPAP';

  @override
  String get deviceRefrigerator => '냉장고';

  @override
  String get deviceFreezer => '냉동고';

  @override
  String get deviceWifiRouter => 'Wi-Fi 공유기';

  @override
  String get deviceModem => '모뎀';

  @override
  String get deviceTv => 'TV';

  @override
  String get deviceDesktopPc => '데스크톱 PC';

  @override
  String get deviceProjector => '프로젝터';

  @override
  String get deviceSpeaker => '스피커';

  @override
  String get deviceCameraCharger => '카메라 충전기';

  @override
  String get deviceDroneCharger => '드론 충전기';

  @override
  String get deviceCoffeeMaker => '커피메이커';

  @override
  String get deviceMicrowave => '전자레인지';

  @override
  String get deviceInductionCooktop => '인덕션';

  @override
  String get deviceHairDryer => '헤어드라이어';

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
  String get fieldOptional => '선택사항';

  @override
  String get saveSetupName => '세팅 이름';

  @override
  String get saveSetupDefaultRuntime => '사용시간 세팅';

  @override
  String get saveSetupDefaultBattery => '배터리 계획';

  @override
  String get dialogSaveSetupTitle => '이 세팅 저장';

  @override
  String get dialogDeleteTitle => '세팅을 삭제할까요?';

  @override
  String get dialogDeleteBody => '삭제 후 되돌릴 수 없습니다.';

  @override
  String get commonClose => '닫기';

  @override
  String get commonBackHome => '홈으로';

  @override
  String get resultRange => '예상 범위';

  @override
  String get resultInputLoad => '정격 부하';

  @override
  String get neededRoundedPlan => '계획 기준 용량';

  @override
  String get settingsReserveHelp => '사용하지 않고 남겨둘 충전량 비율입니다.';

  @override
  String get settingsPrivacyOptionsUnavailable =>
      '현재 지역 또는 동의 상태에서는 별도의 개인정보 선택 화면이 필요하지 않습니다.';

  @override
  String get aboutTitle => 'PowerLeft 정보';

  @override
  String get aboutLocalDataTitle => '내 데이터';

  @override
  String get aboutLocalDataBody => '저장한 배터리, 기기, 세팅은 이 기기에 보관됩니다.';

  @override
  String get aboutEstimateTitle => '계획용 추정치';

  @override
  String get aboutEstimateBody =>
      '온도, 배터리 상태, 인버터 자체 소비, 기기 작동 주기, 시동전력에 따라 실제 사용시간이 달라질 수 있습니다.';

  @override
  String get aboutMedicalTitle => '중요 장비';

  @override
  String get aboutMedicalBody =>
      '의학적으로 필요한 장비의 유일한 백업 계획 수단으로 PowerLeft만 사용하지 마세요.';

  @override
  String get converterEnergy => '에너지';

  @override
  String get converterCapacity => '용량';

  @override
  String get converterFormula => '공식';

  @override
  String get converterEnterValues => '0보다 큰 올바른 값을 입력하세요.';

  @override
  String get customPercentLabel => '작동 비율 %';

  @override
  String get deviceSaveToMyDevices => '내 기기에 저장';

  @override
  String get deviceTypicalRange => '일반 범위';

  @override
  String get deviceConfirmValue => '추가하기 전에 소비전력을 확인하거나 수정하세요.';

  @override
  String get savedUpdated => '수정됨';

  @override
  String get setupModeRuntime => '사용시간';

  @override
  String get setupModeBattery => '필요 용량';

  @override
  String get setupRecalculate => '다시 계산';

  @override
  String get myAppliancesAdd => '직접 기기 추가';

  @override
  String get myAppliancesDeleteTitle => '기기를 삭제할까요?';

  @override
  String get myAppliancesDeleteBody => '기존에 저장한 세팅의 값은 그대로 유지됩니다.';

  @override
  String get settingsVersion => '버전 1.0.0';

  @override
  String get commonNotAvailable => '사용할 수 없음';

  @override
  String get homeSubtitle => '배터리 사용시간을 간단하게 계산하세요.';

  @override
  String get batteryChargeValue => '충전량';

  @override
  String get capacityUnit => '용량 단위';

  @override
  String get runtimeNoUsableEnergy => '남겨둘 충전량을 제외하면 사용할 에너지가 없습니다.';

  @override
  String get runtimeCapacityUnit => '용량 단위';

  @override
  String get runtimeReserveHelp => '이 비율만큼의 충전량은 사용하지 않고 남겨둡니다.';

  @override
  String get runtimeEfficiencyPercent => '효율 %';

  @override
  String get runtimeEfficiencyHelp => '비워두면 연결 방식의 기본값을 사용합니다.';

  @override
  String get runtimeMaxOutputHelp => '선택사항입니다. 정격부하가 너무 큰 경우 경고하는 데만 사용합니다.';

  @override
  String get runtimeBatteryEmpty => '배터리 충전량이 0%입니다.';

  @override
  String get runtimeResultSaved => '세팅을 저장했습니다.';

  @override
  String get runtimeSaveFailed => '세팅을 저장하지 못했습니다.';

  @override
  String get resultTypicalEnergy => '실사용 에너지';

  @override
  String get resultRatedLoad => '정격부하 합계';

  @override
  String get resultAboutEstimate =>
      '실제 사용시간은 기기 작동 주기, 온도, 배터리 상태, 변환 손실, 파워스테이션 자체 소비전력에 따라 달라질 수 있습니다.';

  @override
  String get neededHoursHint => '시간 입력';

  @override
  String get neededQuick => '빠른 선택';

  @override
  String get neededResultSaved => '배터리 계획을 저장했습니다.';

  @override
  String get saveSetupNameRequired => '세팅 이름을 입력하세요.';

  @override
  String get savedTitle => '저장한 세팅';

  @override
  String get savedDelete => '세팅 삭제';

  @override
  String get savedEmptyAction => '계산 후 세팅을 저장하면 다음에 다시 사용할 수 있습니다.';

  @override
  String get setupDetails => '세팅 상세';

  @override
  String get setupDevices => '기기';

  @override
  String get setupBattery => '배터리';

  @override
  String get setupDesired => '원하는 사용시간';

  @override
  String get setupConnection => '연결 방식';

  @override
  String get setupNotFound => '세팅을 찾을 수 없습니다.';

  @override
  String get settingsDefaultReserve => '기본 남겨둘 충전량';

  @override
  String get settingsResetDone => '기본값으로 되돌렸습니다.';

  @override
  String get settingsPrivacyExplanation =>
      '필요한 지역에서는 Google UMP로 개인정보 선택을 관리합니다. 핵심 계산 기능은 계정 없이 작동합니다.';

  @override
  String get aboutPrivacyTitle => '광고 및 개인정보';

  @override
  String get aboutPrivacyBody =>
      'PowerLeft의 계산 데이터는 기기에 저장됩니다. Google AdMob은 사용자의 동의 선택과 적용 법률에 따라 기기·광고·사용·진단 관련 데이터를 처리할 수 있습니다.';

  @override
  String get aboutNoGuarantee =>
      'PowerLeft는 추정 도구이며 실제 사용시간, 시동 호환성 또는 전기적 안전을 보장하지 않습니다.';

  @override
  String get converterWh => '와트시(Wh)';

  @override
  String get converterAh => '암페어시(Ah)';

  @override
  String get converterVoltageV => '전압(V)';

  @override
  String get converterWhToAhFormula => 'Ah = Wh ÷ V';

  @override
  String get converterAhToWhFormula => 'Wh = Ah × V';

  @override
  String get commonHoursShort => '시간';

  @override
  String get commonSaveSetup => '세팅 저장';

  @override
  String get commonUpdateSetup => '세팅 업데이트';

  @override
  String get commonRecalculate => '다시 계산';

  @override
  String get commonRemove => '제거';

  @override
  String get commonContinue => '계속';

  @override
  String get adNoImpact => '광고는 계산 결과 확인을 막지 않습니다.';

  @override
  String get commonMinutesShort => '분';

  @override
  String get commonDaysShort => '일';

  @override
  String get batteryProfilesTitle => '저장한 배터리';

  @override
  String get batteryProfileChoose => '저장한 배터리 선택';

  @override
  String get batteryProfileAdd => '배터리 추가';

  @override
  String get batteryProfileName => '배터리 이름';

  @override
  String get batteryProfileCapacity => '용량';

  @override
  String get batteryProfileMaxOutput => '최대 연속 출력';

  @override
  String get batteryProfileEmpty => '저장한 배터리가 없습니다';

  @override
  String get batteryProfileEmptyBody => '자주 쓰는 파워스테이션이나 배터리를 저장하세요.';

  @override
  String get batteryProfileApplied => '저장한 배터리를 적용했습니다.';

  @override
  String get batteryProfileCharge => '기본 충전량';

  @override
  String get batteryProfileDelete => '배터리 삭제';

  @override
  String get errorReserveRange => '남겨둘 충전량은 0~50% 사이여야 합니다.';

  @override
  String get errorEfficiencyRange => '효율은 50~99% 사이여야 합니다.';

  @override
  String get errorLoadData => '저장된 데이터를 불러오지 못했습니다.';

  @override
  String get errorSaveData => '변경 내용을 저장하지 못했습니다.';

  @override
  String get privacyPolicyTitle => '개인정보 처리방침';

  @override
  String get privacyPolicyLocalTitle => '계산 데이터';

  @override
  String get privacyPolicyLocalBody =>
      '배터리 프로필, 직접 추가한 기기, 저장한 세팅은 이 기기에 로컬로 저장됩니다. PowerLeft는 계정을 요구하지 않으며 이러한 계산 기록을 PowerLeft 자체 서버로 전송하지 않습니다.';

  @override
  String get privacyPolicyAdsTitle => '광고';

  @override
  String get privacyPolicyAdsBody =>
      'PowerLeft는 Google AdMob 전면광고를 사용합니다. 사용자의 지역, 동의 선택, 기기 설정 및 Google Mobile Ads 구성에 따라 Google 및 관련 파트너는 기기 식별자, IP 주소에서 추정된 일반적 위치, 광고 상호작용, 사용 및 진단 정보를 처리할 수 있습니다.';

  @override
  String get privacyPolicyConsentTitle => '개인정보 선택';

  @override
  String get privacyPolicyConsentBody =>
      '필요한 지역에서는 광고 요청 전에 Google User Messaging Platform(UMP)을 사용해 개인정보 선택을 안내하거나 관리합니다. 광고 이용 가능 여부와 관계없이 핵심 계산 기능은 계속 작동합니다.';

  @override
  String get privacyPolicyTrackingTitle => '추적 권한';

  @override
  String get privacyPolicyTrackingBody =>
      'MVP는 Apple의 앱 추적 투명성(ATT) 권한을 의도적으로 요청하지 않습니다. 향후 Apple이 정의하는 추적을 시작하는 경우 출시 전에 앱과 본 방침을 수정해야 합니다.';

  @override
  String get privacyPolicyRetentionTitle => '보관 기간';

  @override
  String get privacyPolicyRetentionBody =>
      '계산 기록은 사용자가 삭제하거나 앱을 삭제·초기화할 때까지 기기에 남습니다. 광고 관련 데이터의 보관은 Google 및 관련 파트너 정책을 따릅니다.';

  @override
  String get privacyPolicyChildrenTitle => '아동';

  @override
  String get privacyPolicyChildrenBody => 'PowerLeft는 아동용 앱으로 설계하거나 홍보하지 않습니다.';

  @override
  String get privacyPolicyContactTitle => '문의';

  @override
  String get privacyPolicyContactBody =>
      '개인정보 또는 고객지원 문의는 PowerLeft의 App Store 제품 페이지에 표시된 공개 지원 링크를 이용하세요.';

  @override
  String get errorCapacityRange => '0Wh보다 크고 100,000Wh 이하인 용량을 입력하세요.';

  @override
  String get errorWattageRange => '0W보다 크고 10,000W 이하인 소비전력을 입력하세요.';

  @override
  String get errorRuntimeRange => '0시간보다 크고 336시간 이하인 사용시간을 입력하세요.';

  @override
  String get errorMaxOutputRange => '최대 연속 출력은 0W보다 커야 합니다.';

  @override
  String get errorNameRequired => '이름을 입력하세요.';

  @override
  String get settingsDataTitle => '저장 데이터';

  @override
  String get settingsDeleteLocalData => '저장 데이터 삭제';

  @override
  String get settingsDeleteLocalDataBody =>
      '이 기기에 저장된 배터리, 직접 추가한 기기, 세팅을 모두 삭제합니다. 앱 설정과 개인정보 동의 선택은 삭제하지 않습니다.';

  @override
  String get settingsDeleteLocalDataConfirm => '저장 데이터를 삭제할까요?';

  @override
  String get settingsDeleteLocalDataDone => '저장 데이터를 삭제했습니다.';

  @override
  String get categoryOther => '기타';

  @override
  String get setupRenameTitle => '세팅 이름 변경';

  @override
  String get setupRenameDone => '세팅 이름을 변경했습니다.';

  @override
  String get categoryWork => '업무';

  @override
  String get deviceCategory => '카테고리';

  @override
  String get devicePortableMonitor => '휴대용 모니터';

  @override
  String get deviceWorkLight => '작업등';

  @override
  String get devicePowerToolCharger => '전동공구 충전기';

  @override
  String get deviceSolderingIron => '인두기';

  @override
  String get aboutOpenSourceLicenses => '오픈소스 라이선스';

  @override
  String get aboutOpenSourceBody =>
      'PowerLeft에서 사용하는 Flutter 및 타사 패키지의 라이선스를 확인합니다.';

  @override
  String get converterCaveat =>
      'Ah는 전압에 따라 달라집니다. 배터리 종류, 변환 손실, 남겨둘 충전량, 기기 작동 방식에 따라 실제 사용가능 에너지가 줄 수 있으므로 이 변환값은 사용시간을 보장하지 않습니다.';

  @override
  String get errorCalculation => '이 값으로 계산할 수 없습니다. 입력값을 확인한 뒤 다시 시도하세요.';

  @override
  String get warningReserveTitle => '사용할 수 있는 충전량 없음';

  @override
  String get designTagline => '내 전력, 더 오래.';

  @override
  String get designRuntimeQuestion => '얼마나\n쓸 수 있을까?';

  @override
  String get designNeededQuestion => '얼마나\n필요할까?';

  @override
  String get designCampTitle => '좋아하는 순간을 더 오래.';

  @override
  String get designCampBody => '캠핑 · 여행 · 정전 대비';

  @override
  String get designRuntimeHelp => '배터리와 사용할 기기를 알려주세요.';

  @override
  String get designNeededHelp => '사용할 기기와 필요한 시간을 알려주세요.';

  @override
  String get designCompareHint => '세 가지 조건을 한눈에 비교하세요.';

  @override
  String get designDetails => '계산 자세히 보기';

  @override
  String get designSavedHint => '자주 쓰는 계산을 다시 꺼내보세요.';

  @override
  String get designAppliancesHint => '사용하는 기기를 모아두세요.';

  @override
  String get designBatteriesHint => '내 배터리 정보를 간편하게.';

  @override
  String get designToolsHint => '용량 변환과 계산 기준을 확인하세요.';

  @override
  String get designRuntimeBody => '배터리와 기기로\n사용시간을 계산해요.';

  @override
  String get designNeededBody => '기기와 시간으로\n필요 용량을 구해요.';

  @override
  String get settingsLanguage => '언어';

  @override
  String get settingsLanguageSystem => '기기 언어 사용';
}
