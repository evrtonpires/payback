import 'package:flutter_modular/flutter_modular.dart';

import 'home_page.dart';

class HomeRouting {
  static final List<ModularRoute> routes = [
    ChildRoute(
      HomeRouteNamed.home._path!,
      child: (_, args) => const HomePage(),
    ),
  ];
}

enum HomeRouteNamed { home }

extension HomeouteNamedExtension on HomeRouteNamed {
  String? get _path {
    switch (this) {
      case HomeRouteNamed.home:
        return '/home';
      default:
        return null;
    }
  }

  String? get fullPath => _path;
}
