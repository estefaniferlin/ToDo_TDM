import 'package:projeto1/database/tarefa_dao.dart';
import 'package:projeto1/database/filme_dao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> getDatabase() async {

  const String tableSQL2 = 'CREATE TABLE cursos ('
      'id INTEGER PRIMARY KEY, '
      'nome TEXT, '
      'descricao TEXT )';

  final String path = join(await getDatabasesPath(), 'dbtarefas.db');
  return openDatabase(
      path,
      onCreate: (db, version){
        db.execute(TarefaDao.tableSQL);
        db.execute(FilmeDao.tableSQL);
      },
      onUpgrade: (db, oldVersion, newVersion) {
        if (oldVersion < 2) {
          db.execute(FilmeDao.tableSQL);
        }
      },
      version: 2,
      onDowngrade: onDatabaseDowngradeDelete
  );
}
