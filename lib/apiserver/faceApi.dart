import 'dart:async' show Future;

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:event_bus/event_bus.dart';

import '../common/globalvar.dart';

class FaceApi {
  Future<Response> _messages(Request request) async {
    try {
      var str = request.url.queryParameters['mesg'];
      GV.eventBus.fire(str);
      print('callback str $str');
    } catch (e) {
      print(e);
    }
    return Response.ok('[]');
  }

  // By exposing a [Router] for an object, it can be mounted in other routers.
  Router get router {
    final router = Router();

    // A handler can have more that one route.
    router.get('/callback', _messages);
    router.get('/messages/', _messages);

    // This nested catch-all, will only catch /api/.* when mounted above.
    // Notice that ordering if annotated handlers and mounts is significant.
    router.all('/<ignored|.*>', (Request request) => Response.notFound('null'));

    return router;
  }
}
