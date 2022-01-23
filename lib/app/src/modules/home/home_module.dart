import 'package:flutter_modular/flutter_modular.dart';
import 'package:payback/app/src/modules/home/home_routing.dart';
import 'package:payback/app/src/modules/home/repositories/prescribe/prescribe_repository.dart';
import 'package:payback/app/src/modules/home/stores/prescribe/prescribe_store.dart';

import 'controllers/prescribe/prescribe_controller.dart';
import 'stores/home_store.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => HomeStore()),
    Bind((i) => PrescribeRepository(i.get())),
    Bind((i) => PrescribeController(i.get(), i.get())),
    Bind((i) => PrescribeStore(prescribeController: i.get())),
  ];

  @override
  List<ModularRoute> get routes => HomeRouting.routes;
}
