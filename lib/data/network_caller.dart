import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;  // Add alias 'http'
import '../model/network_response_model.dart';

class NetworkCaller {
  static Future<NetworkResponse> getRequest({required String url}) async {
    Uri uri = Uri.parse(url);
    debugPrint(url);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    try {
      final http.Response response = await http.get(uri, headers: headers);  // Use 'http.Response'
      printRequest(url, null, headers);
      printResponse(url, response);

      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        return NetworkResponse(
            isSuccess: true,
            statusCode: response.statusCode,
            responseData: decodedData);
      } else if (response.statusCode == 401) {
        return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMessage: "Unauthenticated User!");
      } else {
        return NetworkResponse(
            isSuccess: false, statusCode: response.statusCode);
      }
    } catch (e) {
      return NetworkResponse(
          isSuccess: false, statusCode: -1, errorMessage: e.toString());
    }
  }

  static Future<NetworkResponse> postRequest(
      {required String url, Map<String, dynamic>? body}) async {
    Uri uri = Uri.parse(url);
    debugPrint(url);

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    try {
      final http.Response response =
      await http.post(uri, body: jsonEncode(body), headers: headers);  // Use 'http.Response'
      printRequest(url, body, headers);
      printResponse(url, response);

      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        return NetworkResponse(
            isSuccess: true,
            statusCode: response.statusCode,
            responseData: decodedData);
      } else if (response.statusCode == 401) {
        return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMessage: "Unauthenticated User!");
      } else {
        return NetworkResponse(
            isSuccess: false, statusCode: response.statusCode);
      }
    } catch (e) {
      return NetworkResponse(
          isSuccess: false, statusCode: -1, errorMessage: e.toString());
    }
  }

  static void printRequest(
      String url, Map<String, dynamic>? body, Map<String, dynamic>? headers) {
    debugPrint("URL: $url\nBODY: $body\nHEADERS: $headers");
  }

  static void printResponse(String url, http.Response response) {  // Use 'http.Response'
    debugPrint(
        "URL: $url\n RESPONSE CODE: ${response.statusCode}\n BODY: ${response.body}");
  }
}
