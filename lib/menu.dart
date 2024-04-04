import 'package:flutter/material.dart';
import 'package:projeto1/screens/gifs.dart';
import 'package:projeto1/screens/tmdb_service.dart';
import 'package:projeto1/screens/tarefas_list.dart';
import 'package:projeto1/screens/filmes_list.dart';
import 'package:provider/provider.dart';
import 'package:projeto1/notifiers/theme_notifier.dart';

class MenuOptions extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MenuOptionsState();
  }
}

class MenuOptionsState extends State<MenuOptions>{
  int paginaAtual = 0;
  PageController? pc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pc,
        children: [
          ListaTarefa(),
          ListaFilme(),
          MoviesScreen(),
          GifsPage(),
        ],
        onPageChanged: setPaginaAtual,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: paginaAtual,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.access_alarm), label: "Tarefas"),
          BottomNavigationBarItem(icon: Icon(Icons.movie), label: "Filmes/Séries"),
          BottomNavigationBarItem(icon: Icon(Icons.live_tv), label: "Populares"),
          BottomNavigationBarItem(icon: Icon(Icons.gif_box_outlined), label: "Gifs"),
        ],
        onTap: (pagina) {
          pc?.animateToPage(pagina, duration: const Duration(microseconds: 400),
              curve: Curves.ease);
        },
        backgroundColor: Colors.grey[200],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<ThemeNotifier>(context, listen: false).toggleTheme();
        },
        child: Icon(Icons.brightness_4),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat, // Posiciona o botão no canto inferior esquerdo
    );
  }

  setPaginaAtual(pagina){
    setState(() {
      paginaAtual = pagina;
    });
  }

  @override
  void initState() {
    super.initState();
    pc = PageController(initialPage: paginaAtual);
  }
}