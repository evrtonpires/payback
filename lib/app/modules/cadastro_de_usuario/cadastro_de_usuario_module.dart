import 'package:flutter_modular/flutter_modular.dart';

import 'cadastro_de_usuario_page.dart';
import 'cadastro_de_usuario_store.dart';

class CadastroDeUsuarioModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton(
      (i) => CadastroDeUsuarioStore(
        authController: Modular.get(),
      ),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (_, args) => CadastroDeUsuarioPage(
        authController: Modular.get(),
      ),
    ),
  ];
}
