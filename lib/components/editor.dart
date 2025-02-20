import 'package:flutter/material.dart';

class Editor extends StatelessWidget {
  final TextEditingController controlador;
  final String rotulo;
  final String dica;
  final IconData? icone;

  Editor(this.controlador, this.rotulo, this.dica, [this.icone]);

  @override
  Widget build(BuildContext context) {
    return  Padding(padding: const EdgeInsets.all(16.0),
      child: TextField( style: TextStyle( fontSize: 24.0),
          controller: this.controlador,
          decoration: InputDecoration(
              icon: icone !=  null ? Icon(icone) : null,
              labelText: this.rotulo,
              hintText: this.dica)),
    );
    // TODO: implement build
    throw UnimplementedError();
  }
}