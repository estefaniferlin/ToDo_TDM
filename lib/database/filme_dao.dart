import 'package:sqflite/sqflite.dart';
import '../model/filme.dart';
import 'app_database.dart';

class FilmeDao {

  static const String _tableName = 'filmes';
  static const String _id = 'id';
  static const String _nome = 'nome';
  static const String _genero = 'genero';
  static const String _ano = 'ano';
  static const String _diretor = 'diretor';
  static const String tableSQL = 'CREATE TABLE filmes ('
      'id INTEGER PRIMARY KEY AUTOINCREMENT, '
      'nome TEXT, '
      'genero TEXT, '
      'ano TEXT, '
      'diretor TEXT )';

  Map<String, dynamic> toMap(Filme filme){
    final Map<String, dynamic> filmeMap  = Map();
    filmeMap[_nome] = filme.nome;
    filmeMap[_genero] = filme.genero;
    filmeMap[_ano] = filme.ano;
    filmeMap[_diretor] = filme.diretor;
    return filmeMap;
  }

  Future<int> save(Filme filme) async{
    final Database db = await getDatabase();
    Map<String, dynamic> filmeMap = toMap(filme);
    return db.insert(_tableName, filmeMap);
  }

  Future<int> update(Filme filme) async {
    final Database db = await getDatabase();
    Map<String, dynamic> filmeMap = toMap(filme);
    return db.update(_tableName, filmeMap, where: 'id = ?',
        whereArgs: [filme.id]);
  }

  Future<int> delete(int id) async{
    final Database db = await getDatabase();
    return db.delete(_tableName, where: '$_id = ?', whereArgs: [id]);
  }

  List<Filme> toList(List<Map<String, dynamic>> result){
    final List<Filme> filmes = [];
    for (Map<String, dynamic> row in result){
      final Filme filme = Filme(
          id: row[_id],
          nome: row[_nome],
          genero: row[_genero],
          ano: row[_ano],
          diretor: row[_diretor],
      );
      filmes.add(filme);
    }
    return filmes;
  }

  Future<List<Filme>> findAll() async{
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    List<Filme> filmes = toList(result);
    return filmes;
  }
}