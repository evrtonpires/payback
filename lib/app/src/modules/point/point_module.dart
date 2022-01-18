import 'package:flutter_modular/flutter_modular.dart';

import 'point_routing.dart';
import 'stores/point_store.dart';

class PointModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => PointStore()),
  ];

  @override
  List<ModularRoute> get routes => PointRouting.routes;
}
