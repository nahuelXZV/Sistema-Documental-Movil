import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sistemadocumental/main.dart';
import 'package:sistemadocumental/view/login.dart';

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
  Future<void> _cerrar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = await prefs.getString("token").toString();
    var url = Uri.parse('https://sistema-documental.herokuapp.com/api/signoff');
    var response =
        await http.post(url, headers: {'Authorization': 'Bearer ' + token});
    if (response.statusCode == 200) {
      await prefs.remove("name");
      await prefs.remove("token");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyApp()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Error al cerrar sesion"),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              child: Text(
                'Menú',
                style: TextStyle(color: Colors.black, fontSize: 25),
              ),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 209, 194, 194),
              ),
            ),
            ListTile(
              title: Text('Cerrar sesion'),
              onTap: () {
                _cerrar();
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Clinica de salud"),
      ),
      body: Center(
        child: Container(
          height: 60,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            gradient: const LinearGradient(colors: [Colors.blue, Colors.green]),
          ),
          child: MaterialButton(
            onPressed: () {
              _cerrar();
            },
            child: const Text(
              "Cerrar sesion",
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
