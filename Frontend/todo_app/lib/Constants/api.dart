import 'package:http/http.dart' as http;
import 'dart:io';

class ApiService {
  final String host = Platform.isAndroid ? '10.0.2.2' : '127.0.0.1';
  late final String baseUrl;

  ApiService() {
    baseUrl = _generateBaseUrl();
  }

  String _generateBaseUrl() {
    return 'http://${host}:8000/';
  }

  Future<http.Response> getRequest(String urlSegment) async {
    final url = '$baseUrl$urlSegment';
    return await http.get(Uri.parse(url));
  }
}