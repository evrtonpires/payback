import 'package:flutter_modular/flutter_modular.dart';
import 'package:payback/app/src/modules/home/home_routing.dart';

import 'stores/home_store.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind(
      (i) => HomeStore(),
    ),
  ];

  @override
  List<ModularRoute> get routes => HomeRouting.routes;
}
