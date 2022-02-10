import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:payback/app/src/modules/home/stores/prescribe/prescribe_store.dart';
import 'package:payback/app/src/modules/util/colors/colors.dart';
import 'package:payback/app/src/modules/util/constants/icons_constants.dart';

class DrugPage extends StatefulWidget {
  const DrugPage({Key? key, required this.store}) : super(key: key);

  final PrescribeStore store;

  @override
  _DrugPageState createState() => _DrugPageState();
}

class _DrugPageState extends State<DrugPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * .01),
          child: const Text(
            'Selecionar Medicamentos',
            style: TextStyle(
                color: ColorsConstants.white,
                fontSize: 18,
                fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: ColorsConstants.primary,
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Observer(
              builder: (_) => Expanded(
                child: ListView.builder(
                    itemCount: widget.store.drugs.length,
                    itemBuilder: (_, index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: widget.store.drugs[index].isSelect
                                  ? ColorsConstants.secundary
                                  : ColorsConstants.primary),
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                        ),
                        child: ListTile(
                          title: Text(
                            widget.store.drugs[index].name,
                            textAlign: TextAlign.left,
                          ),
                          subtitle:
                              Text(widget.store.drugs[index].activePrinciple),
                          leading: (widget.store.drugs[index].logoUrl == null || widget.store.drugs[index].logoUrl!.isEmpty)
                              ? Image.asset(
                                  IconConstant.photography,
                                  color: ColorsConstants.primary,
                                )
                              : Image.network(
                                  widget.store.drugs[index].logoUrl!),
                          trailing: Visibility(
                            visible: widget.store.drugs[index].isSelect,
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              height: double.maxFinite,
                              width: 15.0,
                              color: ColorsConstants.secundary,
                            ),
                          ),
                          onTap: () => widget.store
                              .selectDrug(widget.store.drugs[index]),
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Observer(
        builder: (context) => Visibility(
          visible: widget.store.haveDrugSelected,
          child: FloatingActionButton(
            onPressed: widget.store.getAllDrugsSelected,
            elevation: 5,
            backgroundColor: ColorsConstants.secundary,
            tooltip: 'Confirmar',
            child: const Icon(
              Icons.check,
              color: ColorsConstants.white,
            ),
          ),
        ),
      ),
    );
  }
}
