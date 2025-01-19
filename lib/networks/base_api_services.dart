/// The above class is an abstract class that defines methods for making various types of API requests
/// and uploading files in Dart.
import 'dart:io';

abstract class BaseApiServices {
  Future<dynamic> postApiResponse(String url, dynamic data,
      [Map<String, dynamic>? headers]);
  Future<dynamic> loginPostApi(String url, dynamic data,
      [Map<String, dynamic>? headers]);
  Future<dynamic> postApiResponseWithUrl(String url,
      [Map<String, dynamic>? headers]);
  Future<dynamic> getApiResponse(String url);
  Future<dynamic> putApiResponse(String url, Map<String, dynamic> data);
  Future<dynamic> patchApiResponse(String url, Map<String, dynamic> data);
  Future<dynamic> deleteApiResponse(
    String url,
  );
  Future<dynamic> uploadFile(
    Function(int sent, int total),
    String url,
    List<int> bytesList,
    File file,
  );
  Future<dynamic> uploadFileBytes(
      Function(int sent, int total), String url, List<int> bytesList,
      {String? fileNameForServer});

  Future<dynamic> postImageFile(String url, String imagePath);
  Future<dynamic> postVideoFile(String url, String videoPath);
}
