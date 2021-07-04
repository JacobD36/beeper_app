import 'package:beeper_app/src/utils/back_design.dart';
import 'package:beeper_app/src/widgets/menu.dart';
import 'package:flutter/material.dart';

class ConfigPage extends StatelessWidget {
  static final String routeName = 'config';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configuración'),
      ),
      drawer: Drawer(
        child: MenuWidget()
      ),
      body: Stack(
        children: [
          BackDesign(),
          SingleChildScrollView(
            child: Column(
              children: [
                _titulos(),
                _botonesRedondeados()
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _titulos() {
    final estiloTexto1 = TextStyle(
      color: Colors.white,
      fontSize: 30.0,
      fontWeight: FontWeight.bold
    );

    final estiloTexto2 = TextStyle(
      color: Colors.white,
      fontSize: 18.0
    );

    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Configuración', style: estiloTexto1),
            SizedBox(height: 10.0),
            Text('Establece las opciones básicas para el sistema', style: estiloTexto2)
          ],
        ),
      ),
    );
  }

   Widget _botonesRedondeados() {
    return Table(
      children: [
        TableRow(
          children: [
            _crearBotonRedondeado(Colors.blue, Icons.account_balance_sharp, 'Sedes'),
            _crearBotonRedondeado(Colors.green, Icons.account_circle_rounded, 'Perfiles')
          ]
        ),
        TableRow(
          children: [
            _crearBotonRedondeado(Colors.purpleAccent, Icons.assignment_ind_outlined, 'Personal'),
            _crearBotonRedondeado(Colors.pinkAccent, Icons.assignment_ind_outlined, 'Personal')
          ]
        )
      ],
    );
  }

  Widget _crearBotonRedondeado(Color color, IconData icono, String texto) {
    return Container(
      height: 180.0,
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Color.fromRGBO(62, 66, 107, 0.7),
        borderRadius: BorderRadius.circular(20.0)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(height: 5.0),
          CircleAvatar(
            backgroundColor: color,
            radius: 35.0,
            child: Icon(icono, color: Colors.white, size: 30.0),
          ),
          Text(texto, style: TextStyle(color: Colors.white)),
          SizedBox(height: 5.0)
        ],
      ),
    );
  }
}