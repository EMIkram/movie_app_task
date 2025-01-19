/// PATCH, DELETE, and file upload requests, and handling errors and authentication.
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:tentwenty_task/utils/app_exceptions.dart';
import 'package:tentwenty_task/utils/utils.dart';
import 'base_api_services.dart';



Interceptor dioInterceptor = InterceptorsWrapper(
  onError: (DioException error, handler) async {
    // This function is called whenever an error occurs in the network request.
    // You can handle the error, log it, or take appropriate actions.

    if (error.response != null) {
     ///TODO: here check auth etc and handle error
    } else {
      throw (error);
      // Network error (no response received).
    }
  },
);


void _renderCurlRepresentation(Response response) {
  // add a breakpoint here so all errors can break
  try {
    cyanPrint(_postmanCompatibleCURL(response.requestOptions));
  } catch (err) {
    if(kDebugMode) log('unable to create a CURL representation of the requestOptions');
  }
}

String _postmanCompatibleCURL(RequestOptions options) {
  List<String> components = ['curl --location'];

  // Add the request method
  components.add("--request ${options.method.toUpperCase()}");

  // Add the URL
  components.add("'${options.uri.toString()}' \\");

  // Add headers
  options.headers.forEach((k, v) {
    if (k != 'Cookie') {
      components.add("--header '$k: $v' \\");
    }
  });

  // Add data if present
  if (options.data != null) {
    if (options.data is FormData) {
      // Convert FormData to a simple Map for JSON-serialization
      options.data = Map.fromEntries(options.data.fields);
    }

    final data = json.encode(options.data);
    components.add("--data-raw '$data' \\");
  }

  // Remove the last backslash and newline for correct formatting
  String curlCommand = components.join('\n').trim();
  if (curlCommand.endsWith('\\')) {
    curlCommand = curlCommand.substring(0, curlCommand.length - 1).trim();
  }

  return curlCommand;
}



/// The NetworkApiService class is a subclass of BaseApiServices.
class NetworkApiService extends BaseApiServices {
  
  /// The function checks for a DioException and returns a dynamic value.
  /// 
  /// Args:
  ///   e (DioException): A required parameter of type DioException, which represents an exception that
  /// occurred during a Dio HTTP request.
  dynamic checkDioError({required DioException e}) {
      return returnResponse(e.response!);
  }

// For post Api's
  @override
  /// The `postApiResponse` method is responsible for making a POST request to the specified `url` with
  /// the provided `data`. It returns a `Future<dynamic>` which represents the asynchronous result of
  /// the network request.
  Future<dynamic> postApiResponse(String url, dynamic data,
      [Map<String, dynamic>? headers]) async {
    dynamic responseJson;
    var dio = Dio();
    try {
      Response response = await dio
          .post(
            url,
            data: data,
            options: Options(
              headers: headers ??
                  {
                    'Content-Type': 'application/json',
                  },
            ),
          )
          .timeout(const Duration(seconds: 30));
      // log("response here is $response");
      responseJson = returnResponse(response);
      return responseJson;
    } on SocketException {
    } on DioException catch (e) {
      checkDioError(e: e);
    }
  }

  //For get Api's
  @override
  /// The function `getApiResponse` is a Dart function that returns a `Future` object representing the
  /// result of an asynchronous API call.
  /// 
  /// Args:
  ///   url (String): The URL of the API endpoint that you want to make a request to.
  Future<dynamic> getApiResponse(String url) async {
    dynamic responseJson;
    var dio = Dio();
    print(url);
    try {
      final response = await dio.get(url,
          options: Options());

      responseJson = returnResponse(response);
      return responseJson;
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    } on DioException catch (e) {
       checkDioError(e: e);
    }
  }

  @override
  /// The function `postImageFile` is used to send an image file to a specified URL.
  /// 
  /// Args:
  ///   url (String): The URL where the image will be posted.
  ///   imagePath (String): The file path of the image that you want to post.
  Future<dynamic> postImageFile(String url, String imagePath) async {
    dynamic responseJson;

    var dio = Dio();
    //dio.interceptors.add(dioInterceptor);
    FormData imageData = FormData.fromMap({
      "file": await MultipartFile.fromFile(imagePath,
          filename: "userName$imagePath")
    });
    try {
      Response response = await dio
          .post(
            url,
            data: imageData,
            options: Options(
              headers: {
                'Content-Type': 'application/json',
              },
            ),
          )
          .timeout(const Duration(seconds: 10));
      // log("response here is $response");
      responseJson = response.data;
      return responseJson;
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    } on DioException catch (e) {
       checkDioError(e: e);
    }
  }


  Future<dynamic> postVideoFile(String url, String videoPath) async {
    dynamic responseJson;

    var dio = Dio();
    FormData videoData = FormData.fromMap({
      "file": await MultipartFile.fromFile(videoPath,
          filename: "userName$videoPath")
    });
    try {
      Response response = await dio
          .post(
        url,
        data: videoData,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      )
          .timeout(const Duration(seconds: 15));
      // log("response here is $response");
      responseJson = response.data;
      return responseJson;
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    } on DioException catch (e) {
      checkDioError(e: e);
    }
  }

  //For patch Api's
  @override
  /// The `patchApiResponse` method is responsible for making a PATCH request to the specified `url`
  /// with the provided `data`. It returns a `Future<dynamic>` which represents the asynchronous result
  /// of the network request.
  Future<dynamic> patchApiResponse(
      String url, Map<String, dynamic> data) async {
    dynamic responseJson ;

    var dio = Dio();
    try {
      Response response = await dio.patch(url,
          data: data,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
            },
          )) .timeout(const Duration(seconds: 15));
      // log("response here is $response");
      responseJson = response.data;
      return responseJson;
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    } on DioException catch (e) {
       checkDioError(e: e);
    }
  }

  @override
Future<dynamic> deleteApiResponse(
    String url,
  ) async {
    dynamic responseJson;
    var dio = Dio();
    try {
      final response = await dio
          .delete(url,
              options: Options())
          .timeout(const Duration(seconds: 10));
      responseJson = {"code": response.statusCode};
    } on SocketException catch (e, s) {
      if(kDebugMode) log("trace $s");
      if(kDebugMode) log(" socket error $e");
      throw FetchDataException("No Internet Connection");
    } on DioException catch (e, s) {
      if(kDebugMode) log("trace $s");
      if(kDebugMode) log("error $e");
      return {"code": e.response};
    }
    //if true then it'll return json response
    return responseJson;
  }

  @override
  /// The `uploadFile` method in the `NetworkApiService` class is responsible for sending a file to a
  /// specified URL. It takes in the `url` of the API endpoint and the `bytesList` and `file`
  /// representing the file to be uploaded.
  Future<dynamic> uploadFile(
      Function(int sent, int total) onSendProgress,
    String url,
    List<int> bytesList,
    File file,
  ) async {
    dynamic responseJson;
    // await LocalStorage.getAccessToken();
    String fileName = file.path.split('/').last;
    if(kDebugMode) log("file name is $fileName");
    var dio = Dio();
   // dio.interceptors.add(dioInterceptor);
    FormData imageData = FormData.fromMap(
        {"file": MultipartFile.fromBytes(bytesList, filename: fileName)});
    try {
      Response response = await dio
          .post(
            url,
            data: imageData,
        onSendProgress: onSendProgress,
          )
          .timeout(const Duration(seconds: 130));
      // log("response here is $response");
      responseJson = response.data;
      return responseJson;
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    } on DioException catch (e) {
       checkDioError(e: e);
    }
  }

  @override
  Future<dynamic> uploadFileBytes(
  Function (int sent, int total) onSendProgress,
      String url,
      List<int> bytesList,
      {String? fileNameForServer}
      ) async {
    dynamic responseJson;
    String fileName = fileNameForServer ?? "Hero Video ${ math.Random().nextInt(10000)}";
    if(kDebugMode) log("file name is $fileName");
    var dio = Dio();
    // dio.interceptors.add(dioInterceptor);
    FormData imageData = FormData.fromMap(
        {"file": MultipartFile.fromBytes(bytesList, filename: fileName)});
    try {
      Response response = await dio
          .post(
        onSendProgress: onSendProgress,
        url,
        data: imageData,
      )
          .timeout(const Duration(minutes: 15));
      // log("response here is $response");
      responseJson = response.data;
      return responseJson;
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    } on DioException catch (e) {
      checkDioError(e: e);
    }
  }

  @override
  Future putApiResponse(String url, Map<String, dynamic> data) async {
    dynamic responseJson;
    var dio = Dio();
    //dio.interceptors.add(dioInterceptor);
    try {
      final response = await dio
          .put(url,
              data: data,
              options: Options())
          .timeout(const Duration(seconds: 10));
      prettyPrintJson(response.data);
      responseJson = returnResponse(response);
    } on SocketException catch (e, s) {
      if(kDebugMode) log("trace $s");
      if(kDebugMode) log(" socket error $e");
      throw FetchDataException("No Internet Connection");
    } on DioException catch (e) {
      checkDioError(e: e);
    }

    //if true then it'll return json response
    return responseJson;
  }

  /// The function returns a dynamic value based on the provided response.
  /// 
  /// Args:
  ///   response (Response): The "response" parameter is an object of type "Response".
  dynamic returnResponse(Response response) {
    if(kDebugMode){
      yellowPrint(response.realUri.path);
      _renderCurlRepresentation(response);
      greenPrint('status code: ${response.statusCode.toString()}\n');
    }
    if (response.statusCode! >= 200 && response.statusCode! <= 299) {
      return response.data ?? {"value": response.statusCode};
    } else if (response.statusCode! >= 400 && response.statusCode! <= 499) {
      throw BadRequestException(response.data['errorMessage']);
    } else if (response.statusCode! >= 500 && response.statusCode! <= 599) {
      throw InternalServerErrorException(
          'Internal Server Error: ${response.statusCode}}');
    } else {
      throw FetchDataException(
          'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  @override
  /// The above code is declaring a function named `postApiResponseWithUrl` that takes two parameters:
  /// `url` (a string) and `
  Future postApiResponseWithUrl(String url,
      [Map<String, dynamic>? headers]) async {
    dynamic responseJson;
    var dio = Dio();
    try {
      Response response = await dio
          .post(
            url,
            data: null,
            options: Options(
              headers: headers ??
                  {
                    'Content-Type': 'application/json',
                  },
            ),
          )
          .timeout(const Duration(seconds: 30));
      // log("response here is $response");
      responseJson = returnResponse(response);
      return responseJson;
    } on SocketException catch (e, s) {
      if(kDebugMode) log("trace $s");
      if(kDebugMode) log(" socket error $e");
      throw FetchDataException("No Internet Connection");
    } on DioException catch (e) {
       checkDioError(e: e);
    }
  }

  @override
  /// The above code is defining a function called `loginPostApi` in Dart. This function takes three
  /// parameters: `url` (a string), `data` (a dynamic type), and `headers` (a map of string keys and
  /// dynamic values).
  Future<dynamic> loginPostApi(String url, dynamic data,
      [Map<String, dynamic>? headers]) async {
    dynamic responseJson;

    var dio = Dio();
    try {
      Response response = await dio
          .post(
            url,
            data: data,
            options: Options(
              headers: headers ??
                  {
                    'Content-Type': 'application/json',
                  },
            ),
          )
          .timeout(const Duration(seconds: 30));
      // log("response here is $response");
      responseJson = returnResponse(response);
      return responseJson;
    } on SocketException {
    } on DioException catch (e) {
      return returnResponse(e.response!);
    }
  }
}
