import 'package:flutter_modular/flutter_modular.dart';

import '../home/home_store.dart';
import 'home_routing.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => HomeStore()),
  ];

  @override
  List<ModularRoute> get routes => HomeRouting.routes;
}
