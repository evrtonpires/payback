import 'package:flutter_modular/flutter_modular.dart';
import 'package:payback/app/src/modules/home/views/prescribe/add_prescribe_page.dart';

import '../../app_routing.dart';
import 'views/home_page.dart';
import 'views/prescribe/drug_page.dart';

class HomeRouting {
  static final List<ModularRoute> routes = [
    ChildRoute(
      HomeRouteNamed.home._path!,
      child: (_, args) => HomePage(
        prescribeStore: Modular.get(),
        distributorsStore: Modular.get(),
      ),
    ),
    ChildRoute(
      HomeRouteNamed.addPrescribe._path!,
      child: (_, args) => AddPrescribePage(
        store: Modular.get(),
        prescribe: args.data,
      ),
    ),  ChildRoute(
      HomeRouteNamed.selectDrugs._path!,
      child: (_, args) => DrugPage(
        store: Modular.get(),
      ),
    ),
  ];
}

enum HomeRouteNamed {
  home,
  remedy,
  prescribe,
  point,
  addPrescribe,
  selectDrugs
}

extension HomeouteNamedExtension on HomeRouteNamed {
  String? get _path {
    switch (this) {
      case HomeRouteNamed.home:
        return '/';
      case HomeRouteNamed.addPrescribe:
        return '/prescribe/addPrescribe';
      case HomeRouteNamed.selectDrugs:
        return '/prescribe/addPrescribe/selectDrugs';
      default:
        return null;
    }
  }

  String? get fullPath => AppRouteNamed.home.fullPath! + _path!;
}
