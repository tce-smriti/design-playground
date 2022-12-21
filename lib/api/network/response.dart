import 'package:flutter/foundation.dart';

class CustomeResponse {
  bool? success;
  String? message;
  dynamic data;
  dynamic fullResponse;
  CustomeResponse({
    @required this.success,
    @required this.message,
    @required this.data,
    this.fullResponse,
  });
}
