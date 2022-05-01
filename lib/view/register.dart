import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sistemadocumental/view/login.dart';
import 'package:sistemadocumental/view/welcome.dart';

class register extends StatelessWidget {
  const register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Register",
      home: pageRegister(),
    );
  }
}

class pageRegister extends StatefulWidget {
  const pageRegister({Key? key}) : super(key: key);

  @override
  State<pageRegister> createState() => _pageRegisterState();
}

class _pageRegisterState extends State<pageRegister> {
  TextEditingController _name = TextEditingController(text: '');
  TextEditingController _email = TextEditingController(text: '');
  TextEditingController _password = TextEditingController(text: '');

  Future<void> _register() async {
    if (_email.text.isNotEmpty &&
        _password.text.isNotEmpty &&
        _name.text.isNotEmpty) {
      var url =
          Uri.parse('https://sistema-documental.herokuapp.com/api/register');
      Map data = {
        'name': _name.text,
        'email': _email.text,
        'password': _password.text,
      };
      var response = await http.post(url, body: data);
      if (response.statusCode == 200) {
        String body = utf8.decode(response.bodyBytes);
        final jsonData = jsonDecode(body);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("name", jsonData['data']['name']);
        prefs.setString("token", jsonData['data']['token']);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => dashboard()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Credenciales invalidas"),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Ingrese todos los campos"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(30),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 44,
              ),
              const Image(
                image: NetworkImage(
                    'https://www.tumomopegas.com/files/pictures/14088495_1021722774604549_5065974349096293686_n.png'),
                width: 200,
                height: 200,
              ),
              const SizedBox(
                height: 35,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: "Nombre",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                controller: _name,
                validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
              ),
              const SizedBox(
                height: 25,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "Correo electrónico",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                controller: _email,
                validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
              ),
              const SizedBox(
                height: 25,
              ),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Contraseña",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: Icon(Icons.remove_red_eye),
                ),
                controller: _password,
                validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
              ),
              const SizedBox(
                height: 5,
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  gradient:
                      const LinearGradient(colors: [Colors.blue, Colors.green]),
                ),
                child: MaterialButton(
                  onPressed: () {
                    _register();
                  },
                  child: const Text(
                    "Registrase",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const Divider(
                height: 30,
                color: Colors.black,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Tienes una cuenta?",
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.7),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => login()),
                        );
                      },
                      child: const Text("Iniciar sesion"))
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
