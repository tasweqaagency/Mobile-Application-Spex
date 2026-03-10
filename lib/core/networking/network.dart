import 'package:dio/dio.dart';

class Network {
  final Dio _dio;
  Network(this._dio);

  Future<Response> getData(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.get(
      url,
      queryParameters: queryParameters,
      options: options,
    );
  } 
   Future<Response> postData(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.post(
      url,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response> putDataWithBodyAndQuery(
    var jsonData,
    var jsonQuery,
    String url, {
    Options? options,
  }) async {
    return await _dio.put(
      url,
      data: jsonData,
      queryParameters: jsonQuery,
      options: options,
    );
  }

  Future<Response> getDataWithBodyAndQuery(
    var jsonData,
    var jsonQuery,
    String url, {
    Options? options,
  }) async {
    return await _dio.post(
      url,
      data: jsonData,
      queryParameters: jsonQuery,
      options: options,
    );
  }

  Future<Response> getDataWithQuery(
    var jsonQuery,
    String url, {
    Options? options,
  }) async {
    return await _dio.post(url, queryParameters: jsonQuery, options: options);
  }

  Future<Response> deleteData(
    var jsonQuery,
    String url, {
    Options? options,
  }) async {
    return await _dio.delete(url, queryParameters: jsonQuery, options: options);
  }
}
