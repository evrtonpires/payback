import 'package:payback/app/src/modules/remedy/stores/remedy_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'views/remedy_page.dart';

class RemedyModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => RemedyStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const RemedyPage()),
  ];
}
