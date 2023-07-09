
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:invoice/constants/api_constants.dart';
import 'package:invoice/models/auth.dart';
import 'package:invoice/models/user.dart';
import 'package:invoice/preferences/preferences.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';

class UserApiClient {
  static const baseUrl = ApiConstants.BASE_URL;
  static final userName = Prefer.prefs!.getString('userName');
  final http.Client httpClient;

  UserApiClient({http.Client? httpClient})

    return request;
  }

  // *************  end Prepare Method  *************/
}
