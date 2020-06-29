import 'package:flutter/material.dart';
import 'package:trainning/recursos/tarjetas.dart';

class VentasEnProceso extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          children: <Widget>[

            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[

                ButtonTheme(
                  minWidth: 150,
                  height: 40,
                  child: RaisedButton(
                    color: Color(0xFF5586A2),
                    onPressed: () {
                      Navigator.popAndPushNamed(context, '/MisAnuncios');
                    },
                    child: Text(
                      'Mis Anuncios', 
                      style: TextStyle(fontSize: 15, color: Colors.white)
                    ),
                  ),
                ),

                ButtonTheme(
                  minWidth: 150,
                  height: 40,
                  child: RaisedButton(
                    color: Color(0xFF5586A2),
                    onPressed: () {
                      Navigator.popAndPushNamed(context, '/HistorialVentas');
                    },
                    child: Text(
                      'Historial de Ventas', 
                      style: TextStyle(fontSize: 15, color: Colors.white)
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 10,),
            Text(
              "Ventas en proceso",
              style: TextStyle( fontSize: 20, color: Color(0xFFDAC8CF) ),
            ),

            Expanded(
              child: Container(
                child: ListView(
                  padding: EdgeInsets.only(right: 20, left: 20, top: 10),
                  children: <Widget>[
                    Tarjeta2(buttonText: "Ver", cuerpo: <Widget>[
                      Text("08/06/2020"),
                      Text("Pie de limón"),
                      Text("\$5.690"),
                      Text("En Proceso")
                    ],),
                    Tarjeta2(buttonText: "Ver", cuerpo: <Widget>[
                      Text("08/06/2020"),
                      Text("Pie de limón"),
                      Text("\$5.690"),
                      Text("En Proceso")
                    ],),
                    Tarjeta2(buttonText: "Ver", cuerpo: <Widget>[
                      Text("08/06/2020"),
                      Text("Pie de limón"),
                      Text("\$5.690"),
                      Text("En Proceso")
                    ],),
                    Tarjeta2(buttonText: "Ver", cuerpo: <Widget>[
                      Text("08/06/2020"),
                      Text("Pie de limón"),
                      Text("\$5.690"),
                      Text("En Proceso")
                    ],),
                  ],
                ),
              ),
            )

            
          ],
        ),
      );
  }
}

