import 'package:flutter_modular/flutter_modular.dart';
import 'package:payback/app/modules/home/home_routing.dart';

import 'home_store.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind(
      (i) => HomeStore(
        authController: Modular.get(),
      ),
    ),
  ];

  @override
  List<ModularRoute> get routes => HomeRouting.routes;
}
