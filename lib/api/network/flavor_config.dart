import 'package:flutter/material.dart';

enum Flavor { ENV }

class FlavorValues {
  FlavorValues(
      {@required this.baseUrl,
      this.version,
      this.buildNumber,
      @required this.environment,
      this.appId,
      this.symptomSubscriptionKey,
      this.symptomMainURL,
      this.symptomApplicabilityURL,
      this.isOTPModuleEnable = false});
  final String? baseUrl;
  final String? appId;
  final String? version;
  final String? buildNumber;
  final String? environment;
  final String? symptomSubscriptionKey;
  final String? symptomMainURL;
  final String? symptomApplicabilityURL;
  final bool? isOTPModuleEnable;
}

class FlavorConfig {
  final FlavorValues? values;
  static FlavorConfig? _instance;

  factory FlavorConfig({@required FlavorValues? values}) {
    _instance ??= FlavorConfig._internal(values);
    return _instance!;
  }

  FlavorConfig._internal(this.values);
  static FlavorConfig get instance {
    return _instance!;
  }
}
