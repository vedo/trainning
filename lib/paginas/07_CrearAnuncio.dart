import 'dart:ui';
import 'package:flutter/material.dart';

final double buttonWidth = 250;
final double buttonHeight = 40;

class CrearAnuncio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded( //Formulario de log in
        child: Padding(
          padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: ListView(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                
                Text(
                  "Nuevo Anuncio",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                SizedBox(height: 10,),

                TextField(
                  decoration: InputDecoration(
                    labelText: 'Título del anuncio',
                  ),
                ),

                SizedBox(height: 10,),

                TextField(
                  decoration: InputDecoration(
                    labelText: 'Precio de venta',
                  ),
                ),

                SizedBox(height: 10,),

                TextField(
                  decoration: InputDecoration(
                    labelText: 'Descripción',
                  ),
                ),

                SizedBox(height: 20,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      "Agregar fotos",
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 20
                      ),
                    ),
                    SizedBox(width: 20,),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.indigo[300],
                      ),
                      child: IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10,),

                TextField(
                  decoration: InputDecoration(
                    labelText: 'Stock disponible',
                  ),
                ),


              ],
          ),
        ),
      );
  }
}