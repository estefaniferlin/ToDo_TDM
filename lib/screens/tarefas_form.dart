import 'package:flutter/material.dart';
import 'package:projeto1/database/tarefa_dao.dart';
import '../model/tarefa.dart';
import '../components/editor.dart';

class FormTarefa extends StatefulWidget {
  final Tarefa? tarefa; // pode chegar com valor nulo null
  FormTarefa({this.tarefa}); // {} -> opcionalidade

  final TextEditingController _controladorTarefa = TextEditingController();
  final TextEditingController _controladorObs = TextEditingController();

  @override
  State<StatefulWidget> createState() {
    return FormTarefaState();
  }
}

class FormTarefaState extends State<FormTarefa> {
  int? _id; // pode conter valor nulo
  final _formKey = GlobalKey<FormState>(); // para validar campos

  @override
  void initState() {
    super.initState();
    if (widget.tarefa != null) {
      //significa que é uma alteração
      _id = widget.tarefa!.id;
      widget._controladorTarefa.text = widget.tarefa!.descricao;
      widget._controladorObs.text = widget.tarefa!.obs;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form Tarefa"),
      ),
      body: Form(
        key: _formKey, // Associar ao _formKey
        child: Column(
          children: [
            TextFormField(
              controller: widget._controladorTarefa,
              decoration: InputDecoration(
                labelText: "Tarefa",
                hintText: "Indique a tarefa",
                icon: Icon(Icons.assignment),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, indique a tarefa';
                }
                return null; // A entrada é válida
              },
            ),
            TextFormField(
              controller: widget._controladorObs,
              decoration: InputDecoration(
                labelText: "Observação",
                hintText: "Indique a observação",
                icon: Icon(Icons.comment),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, indique a observação';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            criarTarefa(context);
          }
        },
        child: Icon(Icons.save),
      ),
    );
    // TODO: implement build
    throw UnimplementedError();
  }

  void criarTarefa(BuildContext context) {
    TarefaDao _dao = TarefaDao();
    if (_id != null) {
      // alteração
      final tarefaCriada = Tarefa(
          _id!, widget._controladorTarefa.text, widget._controladorObs.text);
      _dao.update(tarefaCriada).then((id) {
        Navigator.pop(context, tarefaCriada);
      });
    } else {
      //inclusão
      final tarefaCriada = Tarefa(
          0, widget._controladorTarefa.text, widget._controladorObs.text);
      _dao.save(tarefaCriada).then((id) {
        Navigator.pop(context, tarefaCriada);
      });
    }
    final SnackBar snackBar = SnackBar(content: const Text("Tarefa criada"));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    _dao.findAll().then((tarefa) => print(tarefa.toString()));
  }
}
