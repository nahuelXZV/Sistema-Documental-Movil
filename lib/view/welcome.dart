import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sistemadocumental/main.dart';
import 'package:sistemadocumental/view/login.dart';
import 'package:sistemadocumental/view/paciente.dart';
import 'package:sistemadocumental/view/perfil.dart';
import 'package:sistemadocumental/view/reserva.dart';

class dashboard extends StatelessWidget {
  const dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Clinica de salud",
      home: dashboardf(),
    );
  }
}

class dashboardf extends StatefulWidget {
  const dashboardf({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _dashboardf();
}

class _dashboardf extends State<dashboardf> {
  int _page = 0;
  List<Widget> _pages = [paciente(), reserva(), perfil()];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Clinica de salud"),
      ),
      body: _pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        currentIndex: _page,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Reservas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
