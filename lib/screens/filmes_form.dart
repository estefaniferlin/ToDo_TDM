import 'package:flutter/material.dart';
import 'package:projeto1/database/filme_dao.dart';
import '../model/filme.dart';

class FormFilme extends StatefulWidget {
  final Filme? filme; // pode chegar com valor nulo null
  FormFilme({this.filme}); // {} -> opcionalidade

  final TextEditingController _controladorNome = TextEditingController();
  final TextEditingController _controladorGenero = TextEditingController();
  final TextEditingController _controladorAno = TextEditingController();
  final TextEditingController _controladorDiretor = TextEditingController();

  @override
  State<StatefulWidget> createState() {
    return FormFilmeState();
  }
}

class FormFilmeState extends State<FormFilme> {
  int? _id; // pode conter valor nulo
  final _formKey = GlobalKey<FormState>(); // para validar campos

  @override
  void initState() {
    super.initState();
    if (widget.filme != null) {
      //significa que é uma alteração
      _id = widget.filme!.id;
      widget._controladorNome.text = widget.filme!.nome;
      widget._controladorGenero.text = widget.filme!.genero;
      widget._controladorAno.text = widget.filme!.ano;
      widget._controladorDiretor.text = widget.filme!.diretor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form Filme"),
      ),
      body: Form(
        key: _formKey, // Associar ao _formKey
        child: Column(
          children: [
            TextFormField(
              controller: widget._controladorNome,
              decoration: InputDecoration(
                labelText: "Nome",
                hintText: "Indique o nome do filme/série",
                icon: Icon(Icons.assignment),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, indique o nome';
                }
                return null; // A entrada é válida
              },
            ),
            TextFormField(
              controller: widget._controladorGenero,
              decoration: InputDecoration(
                labelText: "Gênero",
                hintText: "Indique o gênero do filme/série",
                icon: Icon(Icons.comment),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, indique o gênero';
                }
                return null;
              },
            ),
            TextFormField(
              controller: widget._controladorAno,
              decoration: InputDecoration(
                labelText: "Ano",
                hintText: "Indique o ano de lançamento",
                icon: Icon(Icons.comment),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, indique o ano';
                }
                return null;
              },
            ),
            TextFormField(
              controller: widget._controladorDiretor,
              decoration: InputDecoration(
                labelText: "Diretor",
                hintText: "Indique o diretor do filme/série",
                icon: Icon(Icons.comment),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, indique o diretor';
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
            criarFilme(context);
          }
        },
        child: Icon(Icons.save),
      ),
    );
    // TODO: implement build
    throw UnimplementedError();
  }

  void criarFilme(BuildContext context) {
    FilmeDao _dao = FilmeDao();
    if (_id != null) {
      // alteração
      final filmeCriado = Filme(
          id: _id!,
          nome: widget._controladorNome.text,
          ano: widget._controladorAno.text,
          genero: widget._controladorGenero.text,
          diretor: widget._controladorDiretor.text);
      _dao.update(filmeCriado).then((id) {
        Navigator.pop(context, filmeCriado);
      });
    } else {
      //inclusão
      final filmeCriado = Filme(
          id: 0,
          nome: widget._controladorNome.text,
          ano: widget._controladorAno.text,
          genero: widget._controladorGenero.text,
          diretor: widget._controladorDiretor.text);
      _dao.save(filmeCriado).then((id) {
        Navigator.pop(context, filmeCriado);
      });
    }
    final SnackBar snackBar = SnackBar(content: const Text("Filme criado"));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    _dao.findAll().then((filme) => print(filme.toString()));
  }
}
