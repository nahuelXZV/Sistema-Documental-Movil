import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sistemadocumental/model/direccion.dart';
import 'package:sistemadocumental/model/paciente.dart';
import 'package:shared_preferences/shared_preferences.dart';

class paciente extends StatefulWidget {
  const paciente({Key? key}) : super(key: key);

  @override
  State<paciente> createState() => _pacienteState();
}

class _pacienteState extends State<paciente> {
  var datos;
  final List<String> atributo = <String>[
    'Nombre: ',
    'Documento: ',
    'Telefono: '
  ];
  final List<String> valor = <String>[
    'Nahuel Zalazar',
    '1299553',
    '15451321635'
  ];

  Future<void> _getPaciente() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = await prefs.getString("token").toString();
    var url = Uri.parse(Direccion().servidor + 'pacientes/2');
    var response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);
      datos = new Paciente(jsonData);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Error al cargar pacientes"),
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
      body: FutureBuilder(
        future: _getPaciente(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Text(datos.toString()),
            );
          } else {
            return ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: atributo.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 40,
                      child: Text('${atributo[index]} ${valor[index]}',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 20)),
                    ),
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            );
          }
        },
      ),
    );
  }
}
