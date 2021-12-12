import 'package:flutter_modular/flutter_modular.dart';

class HomeRouting {
  static final List<ModularRoute> routes = [];
}

enum HomeRouteNamed { app }

extension AppouteNamedExtension on HomeRouteNamed {
  String? get _path {
    switch (this) {
      case HomeRouteNamed.app:
        return '/';
      default:
        return null;
    }
  }

  String? get fullPath => _path;
}
