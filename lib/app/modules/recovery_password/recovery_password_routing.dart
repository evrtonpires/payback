import 'package:flutter_modular/flutter_modular.dart';
import 'package:payback/app/modules/recovery_password/recovery_password_page.dart';

import '../../app_routing.dart';

class RecoveryPasswordRouting {
  static final List<ModularRoute> routes = [
    ChildRoute(
      RecoveryPasswordRouteNamed.recoveryPassword._path!,
      child: (_, args) => RecoveryPasswordPage(
        authController: Modular.get(),
        store: Modular.get(),
      ),
    ),
  ];
}

enum RecoveryPasswordRouteNamed { recoveryPassword }

extension AppouteNamedExtension on RecoveryPasswordRouteNamed {
  String? get _path {
    switch (this) {
      case RecoveryPasswordRouteNamed.recoveryPassword:
        return '/';
      default:
        return null;
    }
  }

  String? get fullPath => AppRouteNamed.recoveryPassword.fullPath! + _path!;
}
