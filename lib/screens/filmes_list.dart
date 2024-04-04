import 'package:flutter/material.dart';
import 'package:projeto1/database/filme_dao.dart';
import '../model/filme.dart';
import 'package:projeto1/screens/filmes_form.dart';

// Cria a tela para listar filmes
class ListaFilme extends StatefulWidget {
  @override
  _ListaFilmeState createState() => _ListaFilmeState();
}

class _ListaFilmeState extends State<ListaFilme> {
  final FilmeDao _dao = FilmeDao();

  @override
  Widget build(BuildContext context) {
    // Constrói a UI da tela
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Filmes"),
      ),
      body: FutureBuilder<List<Filme>>(
        future: _dao.findAll(),
        builder: (context, snapshot) {
          final filmes = snapshot.data ?? []; // se existem dados, usa eles. senão, uma lista vazia
          if (snapshot.connectionState == ConnectionState.done) { // se a Future está concluída é construída a lista
            return ListView.builder(
              itemCount: filmes.length,
              itemBuilder: (context, index) { // Constrói cada item da lista.
                final filme = filmes[index];
                return ItemFilme(
                  filme: filme, // passa o filme para o widtget ItemFilme
                  onEdit: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => FormFilme(filme: filme))) // cria a rota para a tela de form para editar
                        .then((_) => setState(() {})); // sinaliza que o widget precisa ser reconstruído pós alteração
                  },
                  onDelete: () => _confirmarExclusao(context, filme.id),
                );
              },
            );
          }
          return Center(child: CircularProgressIndicator()); // mostra que está carregando enquanto busca os dados
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FormFilme()), // abre o form para criar o filme
          ).then((_) => setState(() {})); // Atualiza a lista de filmes
        },
        child: Icon(Icons.add), // ícone do botão
      ),
    );
  }

  void _confirmarExclusao(BuildContext context, int filmeId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar exclusão'),
          content: Text('Você realmente deseja excluir este filme?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Excluir'),
              onPressed: () {
                _dao.delete(filmeId).then((_) {
                  Navigator.of(context).pop(); // Fecha o diálogo
                  setState(() {}); // Atualiza a lista após excluir o filme
                });
              },
            ),
          ],
        );
      },
    );
  }
}

class ItemFilme extends StatefulWidget {
  final Filme filme;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  ItemFilme({required this.filme, required this.onEdit, required this.onDelete});

  @override
  _ItemFilmeState createState() => _ItemFilmeState();
}

class _ItemFilmeState extends State<ItemFilme> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! > 0) { // Arrastar da esquerda para a direita para editar
          widget.onEdit();
        } else if (details.primaryVelocity! < 0) { // Arrastar da direita para a esquerda para excluir
          widget.onDelete();
        }
      },
      child: Card(
        child: ExpansionTile(
          title: Text(widget.filme.nome),
          children: [
            SizedBox(height: 8.0),
            Divider(),
            Row(
              children: [
                Icon(Icons.category_outlined, color: Colors.grey),
                SizedBox(width: 8.0),
                Text(widget.filme.genero, style: TextStyle(fontSize: 16.0)),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Icon(Icons.calendar_today, color: Colors.grey),
                SizedBox(width: 8.0),
                Text('Ano: ${widget.filme.ano}', style: TextStyle(fontSize: 16.0)),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Icon(Icons.person, color: Colors.grey),
                SizedBox(width: 8.0),
                Expanded(child: Text('Diretor: ${widget.filme.diretor}', style: TextStyle(fontSize: 16.0))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}