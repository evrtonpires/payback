import 'package:flutter_modular/flutter_modular.dart';

import '../../modules/point/point_module.dart';
import '../../modules/prescribe/prescribe_module.dart';
import '../../modules/remedy/remedy_module.dart';
import '../../app_routing.dart';
import 'views/home_page.dart';

class HomeRouting {
  static final List<ModularRoute> routes = [
    ChildRoute(
      HomeRouteNamed.home._path!,
      child: (_, args) => const HomePage(),
      children: [
        ModuleRoute(
          HomeRouteNamed.remedy._path!,
          module: RemedyModule(),
        ),
        ModuleRoute(
          HomeRouteNamed.prescribe._path!,
          module: PrescribeModule(),
        ),
        ModuleRoute(
          HomeRouteNamed.point._path!,
          module: PointModule(),
        ),
      ],
    ),
  ];
}

enum HomeRouteNamed { home, remedy, prescribe, point }

extension HomeouteNamedExtension on HomeRouteNamed {
  String? get _path {
    switch (this) {
      case HomeRouteNamed.home:
        return '/';
      case HomeRouteNamed.remedy:
        return 'remedy/';
      case HomeRouteNamed.prescribe:
        return 'prescribe/';
      case HomeRouteNamed.point:
        return 'point/';
      default:
        return null;
    }
  }

  String? get fullPath => AppRouteNamed.home.fullPath! + _path!;
}
