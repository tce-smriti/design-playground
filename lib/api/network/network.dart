// import 'dart:io';
//
// // import 'package:connectivity/connectivity.dart';
// // import 'package:cookie_jar/cookie_jar.dart';
// // import 'package:device_info/device_info.dart';
// // import 'package:dio/dio.dart';
// // import 'package:hrplatform/analytics/analytics_event.dart';
// // import 'package:firebase_performance/firebase_performance.dart';
// // import 'package:hrplatform/common/Logger.dart';
// // import 'package:hrplatform/common/firebase/FirebaseController.dart';
// // import 'package:hrplatform/common/flavor_config.dart';
// // import 'package:hrplatform/common/helper.dart';
// // import 'package:hrplatform/common/network/error.dart';
// // import 'package:hrplatform/common/network/response.dart';
// // import 'package:hrplatform/common/storage.dart';
// // import 'package:hrplatform/pms/infrastructure/api_endpoints.dart';
// // import 'package:http_certificate_pinning/certificate_pinning_interceptor.dart';
// // import 'package:injectable/injectable.dart';
// // import 'package:package_info/package_info.dart';
// import 'package:dio/dio.dart';
// import 'package:get/get.dart' as GetX;
// import 'package:habit_tracker_app/api/network/response.dart';
// import 'Logger.dart';
// import 'constant.dart';
// import 'error.dart';
// import 'flavor_config.dart';
//
// enum HTTPMETHOD { GET, POST, PUT, DELETE, BYTE, BYTE_POST }
//
// final apiBaseHelper = ApiBaseHelper();
//
//
// class ApiBaseHelper {
//   static BaseOptions opts = BaseOptions(
//     responseType: ResponseType.json,
//     connectTimeout: 30000,
//     receiveTimeout: 30000,
//   );
//
//   static Dio createDio() {
//     return Dio(opts);
//   }
//
//   static List<String> getSHAFingerPrints() {
//     List<String> allowedSHAFingerprints = [];
//     if (FlavorConfig.instance.values!.environment == "PPD") {
//       allowedSHAFingerprints.add(AppConstant.SHA_PPD);
//     } else if (FlavorConfig.instance.values!.environment == "PROD") {
//       allowedSHAFingerprints.add(AppConstant.SHA_PROD);
//     }
//     return allowedSHAFingerprints;
//   }
//
//   static addInterceptors(Dio dio) {
//     // dio.interceptors.add(CookieManager(cookieJar));
//     dio.interceptors.add(CustomeHeader());
//     // dio.interceptors.add(RemoveCookie());
//     dio.interceptors.add(CookieStorage());
//     dio.interceptors.add(LoggingInterceptor());
//     dio.interceptors.add(NetworkTraceInterceptor());
//     if (Platform.isAndroid) {
//       if (FlavorConfig.instance.values!.environment == "PPD" ||
//           FlavorConfig.instance.values!.environment == "PROD") {
//         dio.interceptors.add(CertificatePinningInterceptor(
//             allowedSHAFingerprints: getSHAFingerPrints(),
//             basePath: FlavorConfig.instance.values!.baseUrl));
//       }
//     }
//     return dio;
//   }
//
//   static final dio = createDio();
//   static final cookieJar = CookieJar();
//   static final persistCookieJar = PersistCookieJar(ignoreExpires: true);
//   static final baseAPI = addInterceptors(dio);
//
//   DateTime _startTime;
//   DateTime _endTime;
//
//   Future<CustomeResponse> request({
//     String? url,
//     dynamic data,
//     Map<String, dynamic>? headers,
//     bool isCookie = true,
//     HTTPMETHOD method = HTTPMETHOD.GET,
//     int? timeOut,
//   }) async {
//     Response? response;
//     try {
//       Logger.logLongString(url!);
//
//       /// Delete cookies in Jar if user logout and login again from different user
//       // if (cookieJar != null && url == Helpers.login) cookieJar.deleteAll();
//
//       /// Check For Network
//       if (!await checkInternetConnectivity()) {
//         return CustomeResponse(
//           message: internetError,
//           data: null,
//           success: false,
//           fullResponse: null,
//         );
//       }
//       switch (method) {
//         case HTTPMETHOD.GET:
//           _startTime = DateTime.now();
//           response = await baseAPI.get(
//             url,
//             options: Options(
//               headers: headers,
//             ),
//           );
//           break;
//         case HTTPMETHOD.POST:
//           _startTime = DateTime.now();
//           response = await baseAPI.post(
//             url,
//             data: data,
//             options: timeOut == null ? Options(
//               headers: headers,
//             ) : Options(receiveTimeout: timeOut, sendTimeout: timeOut),
//           );
//           break;
//         case HTTPMETHOD.PUT:
//           _startTime = DateTime.now();
//           response = await baseAPI.put(
//             url,
//             data: data,
//             options: Options(
//               headers: headers,
//             ),
//           );
//           break;
//         case HTTPMETHOD.DELETE:
//           _startTime = DateTime.now();
//           response = await baseAPI.delete(
//             url,
//             data: data,
//             options: Options(
//               headers: headers,
//             ),
//           );
//           break;
//         case HTTPMETHOD.BYTE:
//           _startTime = DateTime.now();
//           response = await baseAPI.get(
//             url,
//             options: Options(
//               headers: headers,
//               responseType: ResponseType.bytes,
//             ),
//           );
//           break;
//         case HTTPMETHOD.BYTE_POST:
//           _startTime = DateTime.now();
//           response = await baseAPI.post(
//             url,
//             data: data,
//             options: Options(
//               headers: headers,
//               responseType: ResponseType.bytes,
//             ),
//           );
//           break;
//         default:
//       }
//
//       final  resMessage;
//       if (response!.data is Map) {
//         resMessage = response?.data["message"];
//       } else {
//         resMessage = "";
//       }
//       final resData = response!.data is Map ? response?.data["result"] : "";
//
//       _endTime = DateTime.now();
//       var duration = _endTime.difference(_startTime).inMilliseconds / 1000;
//
//       return CustomeResponse(
//         success: true,
//         message: resMessage,
//         data: resData,
//         fullResponse: response,
//       );
//     } on DioError catch (error) {
//       return ErrorHandler.response(error);
//     }
//   }
//
//   Future<bool> checkInternetConnectivity() async {
//     // var connectivityResult = await (Connectivity().checkConnectivity());
//     // if (connectivityResult == ConnectivityResult.mobile) {
//     //   return true;
//     // } else if (connectivityResult == ConnectivityResult.wifi) {
//     //   return true;
//     // } else if (connectivityResult == ConnectivityResult.none) {
//     //   return false;
//     // } else {
//     //   return false;
//     // }
//     return true;
//   }
// }
//
//
//
// class RemoveCookie extends Interceptor {
//   @override
//   void onRequest(
//       RequestOptions options, RequestInterceptorHandler handler) async {
//     if (options != null &&
//         options.headers != null &&
//         options.path == Helpers.loginUrl) {
//       options.headers.remove(HttpHeaders.cookieHeader);
//     }
//     return super.onRequest(options, handler);
//   }
// }
//
// getUUID() async {
//   final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
//
//   if (Platform.isAndroid) {
//     AndroidDeviceInfo androidDeviceInfo = await deviceInfoPlugin.androidInfo;
//     return androidDeviceInfo.androidId;
//   }
//
//   if (Platform.isIOS) {
//     IosDeviceInfo iosDeviceInfo = await deviceInfoPlugin.iosInfo;
//     return iosDeviceInfo.identifierForVendor;
//   }
//
//   return "";
// }
//
// class CustomeHeader extends Interceptor {
//   @override
//   void onRequest(
//       RequestOptions options, RequestInterceptorHandler handler) async {
//     final version = await _getVersion();
//     // final cookie = await CustomeStorage.readSecureStorageData("ACCESS_TOKEN");
//     final sessionId = await getUUID();
//     options.headers.putIfAbsent("appVersion", () => version);
//     // options.headers[HttpHeaders.cookieHeader] = cookie;
//     options.headers.putIfAbsent("sessionId", () => sessionId);
//     return super.onRequest(options, handler);
//   }
//
//   Future<String> _getVersion() async {
//     try {
//       final PackageInfo packageInfo = await PackageInfo.fromPlatform();
//       return packageInfo.version;
//     } catch (e) {
//       return "";
//     }
//   }
// }
//
// class CookieStorage extends Interceptor {
//   @override
//   void onResponse(Response response, ResponseInterceptorHandler handler) {
//     _saveCookies(response)
//         .then((_) => handler.next(response))
//         .catchError((e, stackTrace) {
//       var err = DioError(requestOptions: response.requestOptions, error: e);
//       err.stackTrace = stackTrace;
//       handler.reject(err, true);
//     });
//   }
//
//   _saveCookies(Response response) async {
//     if (response != null &&
//             response.headers != null &&
//             response.requestOptions.path == Helpers.loginUrl ||
//         response.requestOptions.path == Helpers.validateOTPUrl ||
//         response.requestOptions.path == Helpers.hrloginUrl ||
//         response.requestOptions.path == Helpers.requestOTPUrl) {
//       List<String> cookies = response.headers[HttpHeaders.setCookieHeader];
//       List<String> filterCookies = [];
//       String _cookies;
//       cookies?.forEach((element) {
//         final cookie = Cookie.fromSetCookieValue(element);
//         if (cookie.name == "MYSAPSSO2" || cookie.name == "MYSSO") {
//           // filterCookies.add("${cookie.name}=${cookie.value}");
//           _cookies = "${cookie.name}=${cookie.value}";
//         }
//       });
//       // await CustomeStorage.write("MYSAPSSO2", filterCookies.join("; "));
//
//       String oldToken =
//           await CustomeStorage.readSecureStorageData("ACCESS_TOKEN");
//
//       if (oldToken == null || oldToken.isEmpty)
//         await CustomeStorage.writeSecureStorageData("ACCESS_TOKEN", _cookies);
//       else {
//         if (_cookies != null) {
//           oldToken = "$oldToken; $_cookies";
//         }
//         //   oldToken = oldToken + "; " + _cookies ?? "";
//         await CustomeStorage.writeSecureStorageData("ACCESS_TOKEN", oldToken);
//       }
//     }
//   }
// }
//
// class LoggingInterceptor extends Interceptor {
//   int _maxCharactersPerLine = 200;
//
//   @override
//   void onRequest(
//       RequestOptions options, RequestInterceptorHandler handler) async {
//     Logger.writeLog("--> ${options.method} ${options.path}");
//     Logger.writeLog("Content type: ${options.contentType}");
//     Logger.writeLog("<-- END HTTP");
//     return super.onRequest(options, handler);
//   }
//
//   @override
//   void onResponse(Response response, ResponseInterceptorHandler handler) {
//     Logger.writeLog(
//         "<-- ${response.statusCode} ${response.requestOptions.method} ${response.requestOptions.path}");
//     String responseAsString = response.data.toString();
//     if (responseAsString.length > _maxCharactersPerLine) {
//       Logger.logLongString(responseAsString);
//     } else {
//       Logger.writeLog(response.data.toString());
//     }
//     Logger.writeLog("<-- END HTTP");
//     return super.onResponse(response, handler);
//   }
//
//   @override
//   Future onError(DioError err, ErrorInterceptorHandler handler) async {
//     Logger.writeLog("<-- Error -->");
//     Logger.writeLog(err.error.toString());
//     Logger.writeLog(err.message.toString());
//     return super.onError(err, handler);
//   }
// }
//
// class NetworkTraceInterceptor extends Interceptor {
//   @override
//   void onRequest(
//       RequestOptions options, RequestInterceptorHandler handler) async {
//     var type = options.method == "POST"
//         ? HttpMethod.Post
//         : options.method == "PUT"
//             ? HttpMethod.Put
//             : options.method == "DELETE"
//                 ? HttpMethod.Delete
//                 : HttpMethod.Get;
//
//     String pathName = options.path.split('/').last;
//     Logger.writeLog(type);
//     Logger.writeLog(pathName);
//
//     FireBaseController.getFirebaseController()
//         .firebasePerformanceStart(url: options.path, type: type);
//     FireBaseController.getFirebaseController().startTrace(name: pathName);
//     return super.onRequest(options, handler);
//   }
//
//   @override
//   void onResponse(Response response, ResponseInterceptorHandler handler) {
//     var responsePayloadSize = !GetX.GetUtils.isNullOrBlank(response)
//         ? (!GetX.GetUtils.isNullOrBlank(response.headers)
//             ? (!GetX.GetUtils.isNullOrBlank(
//                         response.headers["content-length"]) &&
//                     response.headers["content-length"].length > 0
//                 ? response.headers["content-length"][0]
//                 : 0)
//             : 0)
//         : 0;
//
//     var responseContentType = !GetX.GetUtils.isNullOrBlank(response)
//         ? (!GetX.GetUtils.isNullOrBlank(response.headers)
//             ? (!GetX.GetUtils.isNullOrBlank(response.headers["content-type"]) &&
//                     response.headers["content-type"].length > 0
//                 ? response.headers["content-type"][0]
//                 : "application/json")
//             : "application/json")
//         : "application/json";
//
//     var statusCode = !GetX.GetUtils.isNullOrBlank(response)
//         ? (!GetX.GetUtils.isNullOrBlank(response.statusCode)
//             ? response.statusCode
//             : 500)
//         : 500;
//
//     FireBaseController.getFirebaseController().firebasePerformanceStop(
//         responsePayloadSize: responsePayloadSize,
//         responseContentType: responseContentType,
//         httpResponseCode: statusCode);
//
//     FireBaseController.getFirebaseController().stopTrace();
//     return super.onResponse(response, handler);
//   }
//
//   @override
//   Future onError(DioError err, ErrorInterceptorHandler handler) async {
//     var responsePayloadSize = !GetX.GetUtils.isNullOrBlank(err.response)
//         ? (!GetX.GetUtils.isNullOrBlank(err.response.headers)
//             ? (!GetX.GetUtils.isNullOrBlank(
//                         err.response.headers["content-length"]) &&
//                     err.response.headers["content-length"].length > 0
//                 ? err.response.headers["content-length"][0]
//                 : 0)
//             : 0)
//         : 0;
//
//     var responseContentType = !GetX.GetUtils.isNullOrBlank(err.response)
//         ? (!GetX.GetUtils.isNullOrBlank(err.response.headers)
//             ? (!GetX.GetUtils.isNullOrBlank(
//                         err.response.headers["content-type"]) &&
//                     err.response.headers["content-type"].length > 0
//                 ? err.response.headers["content-type"][0]
//                 : "application/json")
//             : "application/json")
//         : "application/json";
//
//     var statusCode = !GetX.GetUtils.isNullOrBlank(err.response)
//         ? (!GetX.GetUtils.isNullOrBlank(err.response.statusCode)
//             ? err.response.statusCode
//             : 500)
//         : 500;
//
//     FireBaseController.getFirebaseController().firebasePerformanceStop(
//         responsePayloadSize: responsePayloadSize,
//         responseContentType: responseContentType,
//         httpResponseCode: statusCode);
//
//     FireBaseController.getFirebaseController().stopTrace();
//     return super.onError(err, handler);
//   }
// }
