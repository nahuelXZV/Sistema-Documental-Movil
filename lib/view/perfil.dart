import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sistemadocumental/main.dart';
import 'package:sistemadocumental/model/direccion.dart';
import 'package:sistemadocumental/view/login.dart';

class perfil extends StatelessWidget {
  const perfil({Key? key}) : super(key: key);

  Future<void> _cerrar(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = await prefs.getString("token").toString();
    var url = Uri.parse(Direccion().servidor + 'signoff');
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
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        gradient: const LinearGradient(colors: [Colors.blue, Colors.green]),
      ),
      child: MaterialButton(
        onPressed: () {
          _cerrar(context);
        },
        child: const Text(
          "Cerrar sesion",
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
          ),
        ),
      ),
    ));
  }
}
