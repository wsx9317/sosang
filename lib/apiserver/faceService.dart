import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart';

import 'faceApi.dart';

class FaceService {
  Handler get handler {
    final router = Router();

    router.mount('/api/', FaceApi().router.call);

    router.all('/<ignored|.*>', (Request request) {
      return Response.notFound('Page not found');
    });

    final corsHeadersConfig = {
      'Access-Control-Allow-Origin': '*', // 모든 출처 허용
      'Access-Control-Allow-Methods': '*', // 모든 메서드 허용
      'Access-Control-Allow-Headers': '*', // 모든 헤더 허용
    };

    return const Pipeline()
        .addMiddleware(corsHeaders(headers: corsHeadersConfig))
        .addMiddleware(logRequests())
        .addHandler(router.call);
  }
}
