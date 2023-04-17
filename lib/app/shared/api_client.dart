import 'package:dio/dio.dart';
import 'package:riverpod/riverpod.dart';

final apiClientProvider = Provider((ref) => ApiClient());

class ApiClient {
  final Dio _dio;

  ApiClient() : _dio = Dio();

  Future<Response> get(String path) async {
    try {
      final response = await _dio.get(path);
      return response;
    } on DioError catch (e) {
      throw e;
    }
  }
}
