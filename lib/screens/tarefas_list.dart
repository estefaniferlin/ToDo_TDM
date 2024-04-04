import 'package:flutter/material.dart';
import 'package:projeto1/database/tarefa_dao.dart';
import '../model/tarefa.dart';
import 'tarefas_form.dart';

class ListaTarefa extends StatefulWidget {
  final List<Tarefa> _tarefas = [];

  @override
  State<StatefulWidget> createState() {
    return ListaTarefaState();
  }
}

class ListaTarefaState extends State<ListaTarefa> {
  final TarefaDao _dao = TarefaDao();

  @override
  Widget build(BuildContext context) {
    // widget._tarefas.add(Tarefa("elaborar prova prog2", "provas diferentes"));
    // widget._tarefas.add(Tarefa("preparar aula TDM", "postar no clasroom"));

    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Tarefas"),
      ),
      body: FutureBuilder<List<Tarefa>>(
        initialData: [],
        future: Future.delayed(Duration(seconds: 1))
            .then((value) => _dao.findAll()),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (snapshot.data != null) {
                final List<Tarefa>? tarefas = snapshot.data;
                return ListView.builder(
                    itemBuilder: (context, index) {
                      final Tarefa tarefa = tarefas![index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => FormTarefa(tarefa: tarefa))).then((_) => setState(() {}));
                        },
                        child: Dismissible(
                          key: Key(tarefa.id.toString()),
                          direction: DismissDirection.horizontal,
                          confirmDismiss: (direction) async {
                            if (direction == DismissDirection.endToStart) {
                              return await _confirmarExclusao(context, tarefa.id);
                            }
                            return false;
                          },
                          onDismissed: (direction) {
                            _dao.delete(tarefa.id).then((id) => setState(() {}));
                          },
                          background: Container(color: Colors.green),
                          secondaryBackground: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.delete, color: Colors.white),
                            ),
                          ),
                          child: Card(
                            child: ListTile(
                              leading: Icon(Icons.assignment),
                              title: Text(tarefa.descricao),
                              subtitle: Text(tarefa.obs),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: tarefas!.length);
              }
              break;
            default:
              return Center(
                child: Text("Carregando"),
              );
          }
          return Center(
            child: Text("Carregando..."),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("pressionou botão");
          final Future future =
              Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FormTarefa();
          }));
          future.then((tarefa) {
            print("Tarefa retornada: ");
            print(tarefa);
            widget._tarefas.add(tarefa);
            setState(() {});
          });
        },
        child: Icon(Icons.add),
      ),
    );
    // TODO: implement build
    throw UnimplementedError();
  }

  Widget ItemTarefa(BuildContext context, Tarefa _tarefa) {
    return Dismissible(
        key: Key(_tarefa.id.toString()), // Uma chave única para o Dismissible
        direction: DismissDirection
            .endToStart, // Permite deslizar apenas da direita para a esquerda
        onDismissed: (direction) {
          // Chama o método de exclusão quando o item é deslizado e removido
          _dao.delete(_tarefa.id).then((id) {
          });
        },
        background: Container(
          color: Colors.red,
          padding: EdgeInsets.symmetric(horizontal: 20),
          alignment: AlignmentDirectional.centerEnd,
          child: Icon(Icons.delete, color: Colors.white),
        ),
        child: Card(
            child: ListTile(
          leading: Icon(Icons.add_alert),
          title: Text(_tarefa.descricao),
          subtitle: Text(_tarefa.obs),
        )));
  }

  Future<bool> _confirmarExclusao(BuildContext context, int tarefaId) async {
    final confirmacao = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar exclusão'),
          content: Text('Você realmente deseja excluir esta tarefa?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
              child: Text('Excluir'),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    );
    return confirmacao ?? false;
  }

}
