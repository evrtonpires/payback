import 'package:flutter_modular/flutter_modular.dart';

import '../../modules/home/home_routing.dart';
import 'views/prescribe_page.dart';

class PrescribeRouting {
  static final List<ModularRoute> routes = [
    ChildRoute(
      PrescribeRouteNamed.prescribe._path!,
      child: (_, args) => const PrescribePage(),
    ),
  ];
}

enum PrescribeRouteNamed { prescribe }

extension AppRouteNamedExtension on PrescribeRouteNamed {
  String? get _path {
    switch (this) {
      case PrescribeRouteNamed.prescribe:
        return '/';
      default:
        return null;
    }
  }

  String? get fullPath => HomeRouteNamed.prescribe.fullPath! + _path!;
}
