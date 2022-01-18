import 'package:flutter_modular/flutter_modular.dart';
import 'package:payback/app/src/modules/sign_up/interfaces/sign_up_repository_interface.dart';
import 'package:payback/app/src/modules/sign_up/controllers/sign_up_controller.dart';
import 'package:payback/app/src/modules/sign_up/repositories/sign_up_repository.dart';

import 'sign_up_routing.dart';
import 'stores/sign_up_store.dart';

class SignUpModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.singleton<ISignUpRepository>((i) => SignUpRepository(Modular.get())),
    Bind.singleton((i) => SignUpController(i.get(), i.get())),
    Bind.lazySingleton(
      (i) => SignUpStore(signUpController: i.get()),
    ),
  ];

  @override
  List<ModularRoute> get routes => SignUpRouting.routes;
}
