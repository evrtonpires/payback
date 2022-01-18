import 'package:flutter_modular/flutter_modular.dart';
import 'package:payback/app/src/modules/home/home_routing.dart';
import 'package:payback/app/src/modules/recovery_password/views/recovery_password_page.dart';

import '../../app_routing.dart';

class RemedyRouting {
  static final List<ModularRoute> routes = [
    ChildRoute(
      RemedyRouteNamed.remedy._path!,
      child: (_, args) => const RecoveryPasswordPage(),
    ),
  ];
}

enum RemedyRouteNamed { remedy }

extension AppRouteNamedExtension on RemedyRouteNamed {
  String? get _path {
    switch (this) {
      case RemedyRouteNamed.remedy:
        return '/';
      default:
        return null;
    }
  }

  String? get fullPath => HomeRouteNamed.remedy.fullPath! + _path!;
}
