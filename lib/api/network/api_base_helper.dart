

import 'dart:io';

import 'package:art_flutter/api/network/response.dart';
import 'package:dio/dio.dart';

import 'Logger.dart';
import 'error.dart';

enum HTTPMETHOD { GET, POST, PUT, DELETE, BYTE, BYTE_POST }
//
final apiBaseHelper = ApiBaseHelper();

class ApiBaseHelper{

    static BaseOptions opts = BaseOptions(
    responseType: ResponseType.json,
    connectTimeout: 30000,
    receiveTimeout: 30000,
  );

    static final dio = createDio();
  // static final cookieJar = CookieJar();
  // static final persistCookieJar = PersistCookieJar(ignoreExpires: true);
  static final baseAPI = addInterceptors(dio);

    static addInterceptors(Dio dio) {
    // dio.interceptors.add(CookieManager(cookieJar));
    dio.interceptors.add(CustomeHeader());
    // dio.interceptors.add(RemoveCookie());
    // dio.interceptors.add(CookieStorage());
    // dio.interceptors.add(LoggingInterceptor());
    // dio.interceptors.add(NetworkTraceInterceptor());
    // if (Platform.isAndroid) {
    //   if (FlavorConfig.instance.values!.environment == "PPD" ||
    //       FlavorConfig.instance.values!.environment == "PROD") {
    //     dio.interceptors.add(CertificatePinningInterceptor(
    //         allowedSHAFingerprints: getSHAFingerPrints(),
    //         basePath: FlavorConfig.instance.values!.baseUrl));
    //   }
    // }
    return dio;
  }
  DateTime? _startTime;
  DateTime? _endTime;
      Future<CustomeResponse> request({
    String? url,
    dynamic data,
    Map<String, dynamic>? headers,
    bool isCookie = true,
    HTTPMETHOD method = HTTPMETHOD.GET,
    int? timeOut,
  }) async {
    Response? response;
    try {
      Logger.logLongString(url!);

      /// Delete cookies in Jar if user logout and login again from different user
      // if (cookieJar != null && url == Helpers.login) cookieJar.deleteAll();

      /// Check For Network
      // if (!await checkInternetConnectivity()) {
      //   return CustomeResponse(
      //     message: "Internet Error",
      //     data: null,
      //     success: false,
      //     fullResponse: null,
      //   );
      // }
      switch (method) {
        case HTTPMETHOD.GET:
          _startTime = DateTime.now();
          response = await baseAPI.get(
            url,
            options: Options(
              headers: headers,
            ),
          );
          break;
        case HTTPMETHOD.POST:
          _startTime = DateTime.now();
          response = await baseAPI.post(
            url,
            data: data,
            options: timeOut == null ? Options(
              headers: headers,
            ) : Options(receiveTimeout: timeOut, sendTimeout: timeOut),
          );
          break;
        case HTTPMETHOD.PUT:
          _startTime = DateTime.now();
          response = await baseAPI.put(
            url,
            data: data,
            options: Options(
              headers: headers,
            ),
          );
          break;
        case HTTPMETHOD.DELETE:
          _startTime = DateTime.now();
          response = await baseAPI.delete(
            url,
            data: data,
            options: Options(
              headers: headers,
            ),
          );
          break;
        case HTTPMETHOD.BYTE:
          _startTime = DateTime.now();
          response = await baseAPI.get(
            url,
            options: Options(
              headers: headers,
              responseType: ResponseType.bytes,
            ),
          );
          break;
        case HTTPMETHOD.BYTE_POST:
          _startTime = DateTime.now();
          response = await baseAPI.post(
            url,
            data: data,
            options: Options(
              headers: headers,
              responseType: ResponseType.bytes,
            ),
          );
          break;
        default:
      }

      final  resMessage;
      if (response!.data is Map) {
        resMessage = response?.data["message"];
      } else {
        resMessage = "";
      }
      final resData = response!.data is Map ? response?.data["result"] : "";

      _endTime = DateTime.now();
      var duration = (_endTime?.difference(_startTime!).inMilliseconds)! / 1000;

      return CustomeResponse(
        success: true,
        message: resMessage,
        data: resData,
        fullResponse: response,
      );
    } on DioError catch (error) {
      return ErrorHandler.response(error);
    }
  }

  static Dio createDio() {
    return Dio(opts);
  }



}

class CustomeHeader extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // final version = await _getVersion();
    // final cookie = await CustomeStorage.readSecureStorageData("ACCESS_TOKEN");
    // final sessionId = await getUUID();
    options.headers.putIfAbsent("appVersion", () => "444");
    // options.headers[HttpHeaders.cookieHeader] = cookie;
    // options.headers.putIfAbsent("sessionId", () => sessionId);
    return super.onRequest(options, handler);
  }
}