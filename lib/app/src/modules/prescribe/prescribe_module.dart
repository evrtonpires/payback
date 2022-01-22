import 'package:flutter_modular/flutter_modular.dart';

import 'controllers/prescribe_controller.dart';
import 'interfaces/prescribe_repository_interface.dart';
import 'prescribe_routing.dart';
import 'repositories/prescribe_repository.dart';
import 'stores/prescribe_store.dart';

class PrescribeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.singleton<IPrescribeRepository>(
      (i) => PrescribeRepository(Modular.get()),
    ),
    Bind.singleton(
      (i) => PrescribeController(i.get(), i.get()),
    ),
    Bind.lazySingleton(
      (i) => PrescribeStore(prescribeController: i.get()),
    ),
  ];

  @override
  List<ModularRoute> get routes => PrescribeRouting.routes;
}
