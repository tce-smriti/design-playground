import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:hrplatform/analytics/analytics_event.dart';
// import 'package:hrplatform/common/Logger.dart';
// import 'package:hrplatform/common/helper.dart';
// import 'package:hrplatform/common/pref_storage.dart';
// import 'package:hrplatform/payroll/presentation/PayrollHome/Component/PDFDialog.dart';
// import 'package:hrplatform/payroll/utils/CentralizeString.dart';
// import 'package:hrplatform/routes/app_pages.dart';
// import 'package:path_provider/path_provider.dart';
// import '../storage.dart';
import 'constant.dart';
import 'response.dart';

class ErrorHandler {
  static bool isFirstTime = true;

  static response(DioError exception) {
    try {
      String? message;
      /*Logger.writeLog(exception);*/
      switch (exception.type) {
        case DioErrorType.connectTimeout:
        case DioErrorType.sendTimeout:
        case DioErrorType.receiveTimeout:
          message = connectionTimeout;
          // fireAnalyticsEvent(exception, connectionTimeout);
          return CustomeResponse(
              success: false,
              message: connectionTimeout,
              data: null,
              fullResponse: connectionTimeout);
          break;
        case DioErrorType.response:
          switch (exception.response!.statusCode) {
            case 400:
              /*Logger.writeLog(exception.response!.toString());*/
              if (exception.response!.data is Map) {
                message = exception.response!.data["message"] != null
                    ? (exception.response!.data["message"] is String
                        ? exception.response!.data["message"]
                        : badrequest)
                    : exception.response!.data["result"] is String
                        ? exception.response!.data["result"]
                        : exception.response!.data["result"]["message"] != null
                            ? (exception.response!.data["result"]["message"]
                                    is String
                                ? exception.response!.data["result"]["message"]
                                : badrequest)
                            : badrequest;
              } else {
                message = exception?.response!?.statusMessage ?? "";
              }
              // fireAnalyticsEvent(exception, message);
              return CustomeResponse(
                success: false,
                message: message!,
                data: null,
                fullResponse: exception.response!.data,
              );
              break;
            case 401:
              if (exception.response!.data is Map) {
                message = exception.response!.data["message"] != null
                    ? exception.response!.data["message"]
                    : exception.response!.data["result"]["message"] != null
                        ? exception.response!.data["result"]["message"]
                        : unauthorization;
              } else {
                message = exception?.response!?.statusMessage ?? "";
              }
              if (isFirstTime && message?.toLowerCase() == "invalid cookies") {
                isFirstTime = false;
                appLogout();
              }
              // fireAnalyticsEvent(exception, message);
              return CustomeResponse(
                success: false,
                message: message!,
                data: null,
                fullResponse: exception.response!.data,
              );
              break;
            case 404:
              if (exception.response!.data is Map) {
                message = exception.response!.data["message"] != null
                    ? exception.response!.data["message"]
                    : exception.response!.data["result"]["message"] != null
                        ? exception.response!.data["result"]["message"]
                        : notFound;
              } else {
                message = exception?.response!?.statusMessage ?? "";
              }
              // fireAnalyticsEvent(exception, message);
              return CustomeResponse(
                success: false,
                message: message!,
                data: null,
                fullResponse: exception.response!.data,
              );
              break;
            case 417:
              if (exception.response!.data is Map) {
                message = exception.response!.data["message"] ?? exception.response!.data["result"]["message"] != null
                        ? exception.response!.data["result"]["message"]
                        : notFound;
              } else {
                message = exception.response!.statusMessage ?? "";
              }
              // fireAnalyticsEvent(exception, message);
              return CustomeResponse(
                success: false,
                message: message!,
                data: null,
                fullResponse: exception.response!.data,
              );
              break;
            case 500:
              if (exception.response!.data is Map) {
                message = GetUtils.isNullOrBlank(
                            exception.response!.data["result"])! &&
                        GetUtils.isNullOrBlank(
                            exception.response!.data["result"]["message"])! &&
                        exception.response!.data["result"]["message"] is String
                    ? exception.response!.data["result"]["message"]
                    : exception.response!.data["message"] ?? "Error";
              } else {
                message = exception?.response!?.statusMessage ?? "";
              }
              // fireAnalyticsEvent(exception, message);
              return CustomeResponse(
                success: false,
                message: message!,
                data: null,
                fullResponse: exception.response!.data,
              );
              break;
            default:
              if (exception.response! != null) {
                message = exception.response!.statusMessage != null
                    ? exception.response!.statusMessage
                    : unknow;
                // fireAnalyticsEvent(exception, message);
                return CustomeResponse(
                  success: false,
                  message: message!,
                  data: null,
                  fullResponse: exception.response!.statusMessage != null
                      ? exception.response!.statusMessage.toString()
                      : exception.response!.toString(),
                );
              } else {
                // fireAnalyticsEvent(exception, unknow);
                return CustomeResponse(
                  success: false,
                  message: unknow,
                  data: null,
                  fullResponse: exception.response!.toString(),
                );
              }
              break;
          }
          break;
        case DioErrorType.cancel:
          // fireAnalyticsEvent(exception, cancel);
          return CustomeResponse(
            success: false,
            message: cancel,
            data: null,
            fullResponse: cancel,
          );
          break;
        case DioErrorType.other:
          // fireAnalyticsEvent(exception, somethingWrong);
          return CustomeResponse(
            success: false,
            message: somethingWrong,
            data: null,
            fullResponse: somethingWrong,
          );
          break;
      }
    } on Exception catch (error) {

    }
  }



  static appLogout() async {
    // await CustomeStorage.clear();
    // await PreferenceStorage().clearAll();
    // AnalyticsEvent.get().renewAnalytics();
    // Get.back();
    // Get.offAllNamed(AppRoutes.login);
    //
    // Get.snackbar("Info", "Session Expired please login",
    //     backgroundColor: Colors.red,
    //     colorText: Colors.white,
    //     snackPosition: SnackPosition.BOTTOM);
    //
    // await _deleteAppDir();
  }


}
