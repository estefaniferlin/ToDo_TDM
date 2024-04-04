class Filme {
  final int id;
  final String nome;
  final String genero;
  final String ano;
  final String diretor;

  Filme({
    required this.id,
    required this.nome,
    required this.genero,
    required this.ano,
    required this.diretor,
  });

  @override
  String toString() {
    return 'Filme{id: $id, nome: $nome, genero: $genero, ano: $ano, diretor: $diretor}';
  }
}
