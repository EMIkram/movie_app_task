import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';


class Utils {
  static String getLastNCharactersFromString(String str, int n) {
    // assert(str.length <= n);
    if (str.length <= n) {
      return str;
    }
    return str.substring(str.length - n);
  }

  static int getFileSizeFromUint8List(Uint8List fileBytes) =>
      fileBytes.lengthInBytes; //not tested yet

  static File getFileFromUint8List(Uint8List uint8list) =>
      File.fromRawPath(uint8list); //not tested yet

}

  /// Prints text in green
  void greenPrint(String message) {
    print('\x1B[32m$message\x1B[0m');
  }

  /// Prints text in pink (magenta)
  void pinkPrint(String message) {
    print('\x1B[35m$message\x1B[0m');
  }

  /// Prints text in cyan
  void cyanPrint(String message) {
    print('\x1B[36m$message\x1B[0m');
  }

  /// Prints text in yellow
  void yellowPrint(String message) {
    print('\x1B[33m$message\x1B[0m');
  }

  /// Prints text in red
  void redPrint(String message) {
    print('\x1B[31m$message\x1B[0m');
  }

  /// Prints text in blue
  void bluePrint(String message) {
    print('\x1B[34m$message\x1B[0m');
  }

  /// Prints text in white (reset color)
  void whitePrint(String message) {
    print('\x1B[37m$message\x1B[0m');
  }

  /// Function to pretty print JSON data
  void prettyPrintJson(Map<String, dynamic> jsonData) {
    if (kDebugMode) {
      const JsonEncoder encoder = JsonEncoder.withIndent('  ');
      String prettyJson = encoder.convert(jsonData);
      greenPrint(prettyJson);
    }
  }
