import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:payback/app/modules/home/home_module.dart';

import 'app_routing.dart';
import 'modules/login/login_module.dart';
import 'modules/shared/auth/auth_controller.dart';
import 'modules/shared/auth/auth_repositories/auth_repository.dart';
import 'modules/shared/auth/auth_repositories/auth_repository_interface.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind<IAuthRepository>(
      (i) => AuthRepository(dio: i.get()),
    ),
    Bind.singleton((i) => AuthController()),
    Bind((i) => Dio()),
  ];

  @override
  List<ModularRoute> get routes => AppRouting.routes;
}
