import 'package:flutter_modular/flutter_modular.dart';

import '../../core/interfaces/recovery_password_repository_interface.dart';
import 'repositories/recovery_password_repository.dart';
import 'controllers/recovery_password_controller.dart';
import 'recovery_password_routing.dart';
import 'stores/recovery_password_store.dart';

class RecoveryPasswordModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.singleton<IRecoveryPasswordRepository>(
      (i) => RecoveryPasswordRepository(Modular.get()),
    ),
    Bind.singleton(
      (i) => RecoveryPasswordController(i.get(), i.get()),
    ),
    Bind.lazySingleton(
      (i) => RecoveryPasswordStore(recoveryPasswordController: i.get()),
    ),
  ];

  @override
  List<ModularRoute> get routes => RecoveryPasswordRouting.routes;
}
