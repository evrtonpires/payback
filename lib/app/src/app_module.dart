import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app_routing.dart';
import 'core/services/api.service.dart';
import 'core/interfaces/api.interface.dart';
import 'app_store.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.singleton((i) => AppStore()),
    Bind((i) => Dio()),
    Bind<IApi>(
      (i) => ApiService(dio: i.get()),
    ),
  ];

  @override
  List<ModularRoute> get routes => AppRouting.routes;
}
