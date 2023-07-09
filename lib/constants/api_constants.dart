


import 'dart:io';

class ApiConstants {
  static const BASE_URL = 'http://62.12.101.94:8080';//'http://62.12.101.62/ApiTest' ;//'http://tweety.sharedwithexpose.com/api';
}

Map<String, String> requestHeaders(String token) {
  return {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $token'
  };
}
