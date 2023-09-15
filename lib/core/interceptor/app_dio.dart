import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kenz_app/constants/style_manager.dart';
import 'package:kenz_app/core/interceptor/retry_interceptor.dart';

import '../../constants/api_const/api_const.dart';
import '../../main.dart';
import 'auth_interceptor.dart';
import 'connectivity_retry_interceptor.dart';

class Api {
  final dio = createDio();

  // final tokenDio = Dio(BaseOptions(baseUrl: AppAPI.BaseUrl));

  Api._internal();

  static final _singleton = Api._internal();

  factory Api() => _singleton;

  static Dio createDio() {
    var dio = Dio();
    dio.options.baseUrl = AppAPI.baseUrl;
    dio.interceptors
    ..add(LogInterceptor(
        responseBody: true,
        error: true,
        requestHeader: false,
        responseHeader: false,
        request: false,
        requestBody: true))
      ..add(AuthInterceptor(dio))
      ..add(AppInterceptors(dio))
      ..add(
        RetryOnConnectionChangeInterceptor(
          requestRetrier: DioConnectivityRequestRetrier(
              dio: dio, connectivity: Connectivity()),
        ),
      );
    return dio;
  }
}

class AppInterceptors extends Interceptor {
  final Dio dio;

  AppInterceptors(this.dio);

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        throw DeadlineExceededException(err.requestOptions);
      case DioErrorType.response:
        switch (err.response?.statusCode) {
          case 400:
            const SnackBar snackBar = SnackBar(
                backgroundColor: Colors.red, content: Text("Something went wrong"));
            snackbarKey.currentState?.showSnackBar(snackBar);
            throw BadRequestException(err.requestOptions);
          case 401:
             SnackBar snackBar = SnackBar(
                backgroundColor: Colors.red, content: Text( err.response!.data["error"].toString(),style: getRegularStyle(color: Colors.white),));
             snackbarKey.currentState?.showSnackBar(snackBar);

             throw UnauthorizedException(err.requestOptions);
          case 404:
            throw NotFoundException(err.requestOptions);
          case 409:
            throw ConflictException(err.requestOptions);
          case 500:
            throw InternalServerErrorException(err.requestOptions);
        }
        break;
      case DioErrorType.cancel:
        break;
      case DioErrorType.other:
         SnackBar snackBar = SnackBar(
            backgroundColor: Colors.red, content: Text("No Internet Connection",style: getSemiBoldStyle(color: Colors.white),));
        snackbarKey.currentState?.showSnackBar(snackBar);
         throw NoInternetConnectionException(err.requestOptions);

    }
    return handler.next(err);
  }
}

class BadRequestException extends DioError {
  BadRequestException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Invalid request';
  }
}

class InternalServerErrorException extends DioError {
  InternalServerErrorException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Unknown error occurred, please try again later.';
  }
}

class ConflictException extends DioError {
  ConflictException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Conflict occurred';
  }
}

class UnauthorizedException extends DioError {
  UnauthorizedException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Access denied';
  }
}

class NotFoundException extends DioError {
  NotFoundException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The requested information could not be found';
  }
}

class NoInternetConnectionException extends DioError {
  NoInternetConnectionException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'No internet connection detected, please try again.';
  }
}

class DeadlineExceededException extends DioError {
  DeadlineExceededException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The connection has timed out, please try again.';
   }
}