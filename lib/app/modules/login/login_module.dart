import 'package:flutter_modular/flutter_modular.dart';
import 'package:payback/app/modules/login/login_routing.dart';

import '../login/login_store.dart';

class LoginModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton(
      (i) => LoginStore(
        authController: Modular.get(),
      ),
    ),
  ];

  @override
  List<ModularRoute> get routes => LoginRouting.routes;
}
