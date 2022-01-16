import 'package:flutter_modular/flutter_modular.dart';

import 'modules/cadastro_de_usuario/cadastro_de_usuario_module.dart';
import 'modules/home/home_module.dart';
import 'modules/login/login_module.dart';
import 'modules/recovery_password/recovery_password_module.dart';

class AppRouting {
  static final List<ModularRoute> routes = [
    ModuleRoute(AppRouteNamed.login._path!, module: LoginModule()),
    ModuleRoute(
      AppRouteNamed.home._path!,
      module: HomeModule(),
    ),
    ModuleRoute(
      AppRouteNamed.signUp._path!,
      module: CadastroDeUsuarioModule(),
    ),
    ModuleRoute(
      AppRouteNamed.recoveryPassword._path!,
      module: RecoveryPasswordModule(),
    ),
  ];
}

enum AppRouteNamed { login, home, signUp, recoveryPassword }

extension AppouteNamedExtension on AppRouteNamed {
  String? get _path {
    switch (this) {
      case AppRouteNamed.login:
        return '/login/';
      case AppRouteNamed.home:
        return '/home/';
      case AppRouteNamed.signUp:
        return '/signup/';
      case AppRouteNamed.recoveryPassword:
        return '/recoveryPassword/';
      default:
        return null;
    }
  }

  String? get fullPath => _path;
}
