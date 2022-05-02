import 'package:flutter/material.dart';

class reserva extends StatefulWidget {
  const reserva({Key? key}) : super(key: key);

  @override
  State<reserva> createState() => _reservaState();
}

class _reservaState extends State<reserva> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Reserva para el dia Lunes a las 10 AM'),
              subtitle: Text('Tipo de reserva: Medico General.'),
              selectedColor: Colors.amber,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                const SizedBox(width: 8),
                TextButton(
                  child: const Text('Ver detalles'),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
