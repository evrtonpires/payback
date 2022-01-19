import 'package:flutter/material.dart';
import 'package:payback/app/src/modules/util/colors/colors.dart';

class SearchDialog extends StatefulWidget {
  const SearchDialog({Key? key}) : super(key: key);

  @override
  _SearchDialogState createState() => _SearchDialogState();
}

class _SearchDialogState extends State<SearchDialog> {
  _SearchDialogState() : _controller = TextEditingController();

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            Positioned(
              top: 2,
              left: 2,
              right: 2,
              child: Column(
                children: [
                  Card(
                    child: TextField(
                        controller: _controller,
                        textInputAction: TextInputAction.search,
                        autofocus: true,
                        cursorColor: ColorsConstants.secundary,
                        decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 15),
                            border: InputBorder.none,
                            focusColor: Colors.red,
                            prefixIcon: IconButton(
                              icon: const Icon(Icons.arrow_back,
                                  color: ColorsConstants.secundary),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            suffixIcon: IconButton(
                                icon: const Icon(Icons.close,
                                    color: ColorsConstants.secundary),
                                onPressed: () {
                                  _controller.clear();
                                })),
                        onSubmitted: (text) {
                          Navigator.of(context).pop(text);
                        }),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
