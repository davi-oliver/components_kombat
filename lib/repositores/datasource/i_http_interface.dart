import 'package:componets_kombat/repositores/err/errors.dart';
import 'package:dartz/dartz.dart';

abstract class IHttpInterfacePostPut {
  Future<Either<HttpRequestFailure, dynamic>> makeJsonRequest(
      {required String url, params});
}

abstract class IHttpInterfaceGet {
  Future<Either<HttpRequestFailure, dynamic>> makeGetJsonRequest(
      {required String url, String? params});
}
