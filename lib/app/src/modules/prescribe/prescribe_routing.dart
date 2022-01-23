import 'package:flutter_modular/flutter_modular.dart';
import 'package:payback/app/src/modules/prescribe/views/drug_page.dart';

import '../../modules/home/home_routing.dart';
import 'views/add_prescribe_page.dart';
import 'views/prescribe_page.dart';

class PrescribeRouting {
  static final List<ModularRoute> routes = [
    ChildRoute(
      PrescribeRouteNamed.prescribe._path!,
      child: (_, args) => const PrescribePage(),
    ),
    ChildRoute(PrescribeRouteNamed.addPrescribe._path!,
        child: (_, args) =>  AddPrescribePage(store: Modular.get()),
        transition: TransitionType.fadeIn),
    ChildRoute(PrescribeRouteNamed.selectDrugs._path!,
        child: (_, args) => DrugPage(store: Modular.get()),
        transition: TransitionType.fadeIn),
  ];
}

enum PrescribeRouteNamed { prescribe, addPrescribe, selectDrugs }

extension AppRouteNamedExtension on PrescribeRouteNamed {
  String? get _path {
    switch (this) {
      case PrescribeRouteNamed.prescribe:
        return '/';
      case PrescribeRouteNamed.addPrescribe:
        return '/addPrescribe/';
      case PrescribeRouteNamed.selectDrugs:
        return '/selectDrugs/';
      default:
        return null;
    }
  }

  String? get fullPath => HomeRouteNamed.prescribe.fullPath! + _path!;
}
