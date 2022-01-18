import 'package:flutter_modular/flutter_modular.dart';

import 'prescribe_routing.dart';
import 'stores/prescribe_store.dart';

class PrescribeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => PrescribeStore()),
  ];

  @override
  List<ModularRoute> get routes => PrescribeRouting.routes;
}
