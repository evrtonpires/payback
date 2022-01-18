import 'package:flutter_modular/flutter_modular.dart';
import 'package:payback/app/src/modules/home/home_routing.dart';

import 'views/point_page.dart';

class PointRouting {
  static final List<ModularRoute> routes = [
    ChildRoute(
      PointRouteNamed.point._path!,
      child: (_, args) => const PointPage(),
    ),
  ];
}

enum PointRouteNamed { point }

extension AppRouteNamedExtension on PointRouteNamed {
  String? get _path {
    switch (this) {
      case PointRouteNamed.point:
        return '/';
      default:
        return null;
    }
  }

  String? get fullPath => HomeRouteNamed.point.fullPath! + _path!;
}
