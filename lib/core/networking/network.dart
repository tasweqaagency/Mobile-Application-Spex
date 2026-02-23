import 'package:dio/dio.dart';

class Network {
  final Dio _dio;
  Network(this._dio);

  Future<Response> getData(String url) async {
    return await _dio.get(url);
  }

  Future<Response> putDataWithBodyAndQuery(
    var jsonData,
    var jsonQuery,
    String url,
  ) async {
    return await _dio.put(url, data: jsonData, queryParameters: jsonQuery);
  }

  Future<Response> getDataWithBodyAndQuery(
    var jsonData,
    var jsonQuery,
    String url,
  ) async {
    return await _dio.post(url, data: jsonData, queryParameters: jsonQuery);
  }

  Future<Response> getDataWithQuery(var jsonQuery, String url) async {
    return await _dio.post(url, queryParameters: jsonQuery);
  }

  Future<Response> deleteData(var jsonQuery, String url) async {
    return await _dio.delete(url, queryParameters: jsonQuery);
  }
}
