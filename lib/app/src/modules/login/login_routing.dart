import 'package:flutter_modular/flutter_modular.dart';

import '../../app_routing.dart';
import 'views/login_page.dart';

class LoginRouting {
  static final List<ModularRoute> routes = [
    ChildRoute(
      LoginRouteNamed.login._path!,
      child: (_, args) =>  LoginPage(sucess: args.data?['sucess'] ?? false),
    ),
  ];
}

enum LoginRouteNamed {
  login,
}

extension AppRouteNamedExtension on LoginRouteNamed {
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
