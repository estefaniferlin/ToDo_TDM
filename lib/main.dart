import 'package:flutter/material.dart';
import 'package:projeto1/menu.dart';
import 'database/tarefa_dao.dart';
import 'theme/app_theme.dart';
import 'notifiers/theme_notifier.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(AppTheme.lightTheme, false),
      child: TarefaApp(),
    ),
  );
  TarefaDao db = TarefaDao();
  //db.save(Tarefa(0,"tarefa teste", 'obs teste' )).then((id) {
  //  print("id gerado: "+ id.toString());
  //});
  db.findAll().then((tarefa) => print(tarefa.toString()));
}

class TarefaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
        home: MenuOptions(),
        theme: themeNotifier.getTheme(),
    );
    throw UnimplementedError();
  }
}


