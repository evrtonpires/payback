import 'package:flutter_modular/flutter_modular.dart';

import '../../app_routing.dart';
import 'login_page.dart';

class LoginRouting {
  static final List<ModularRoute> routes = [
    ChildRoute(
      LoginRouteNamed.login._path!,
      child: (_, args) => LoginPage(
        authController: Modular.get(),
      ),
    ),
  ];
}

enum LoginRouteNamed { login,}

extension AppouteNamedExtension on LoginRouteNamed {
  String? get _path {
    switch (this) {
      case LoginRouteNamed.login:
        return '/';
      default:
        return null;
    }
  }

  String? get fullPath => AppRouteNamed.login.fullPath! + _path!;
}
