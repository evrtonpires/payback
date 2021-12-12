import 'package:flutter_modular/flutter_modular.dart';

import 'recovery_password_page.dart';
import 'recovery_password_routing.dart';
import 'recovery_password_store.dart';

class RecoveryPasswordModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton(
        (i) => RecoveryPasswordStore(authController: Modular.get())),
  ];

  @override
  List<ModularRoute> get routes => RecoveryPasswordRouting.routes;
}
