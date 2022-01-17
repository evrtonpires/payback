import 'package:flutter_modular/flutter_modular.dart';

import 'views/sign_up_page.dart';

import '../../app_routing.dart';

class SignUpRouting {
  static final List<ModularRoute> routes = [
    ChildRoute(
      SignUpRouteNamed.signUp._path!,
      child: (_, args) => const SignUpPage(),
    ),
  ];
}

enum SignUpRouteNamed {
  signUp,
}

extension AppouteNamedExtension on SignUpRouteNamed {
  String? get _path {
    switch (this) {
      case SignUpRouteNamed.signUp:
        return '/';
      default:
        return null;
    }
  }

  String? get fullPath => AppRouteNamed.signUp.fullPath! + _path!;
}
