import 'package:flutter/material.dart';
import 'package:trainning/recursos/constant.dart';
import 'package:trainning/recursos/tarjetas.dart';


class MisAnuncios extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: topPadding,),
            Titulo1(titulo: "Mis Anuncios",),
            SizedBox(height: 20,),

            FlatButton(
              onPressed: (){
                Navigator.popAndPushNamed(context, "/CrearAnuncio");
              },
              child: Column(
                children: <Widget>[
                  Text("Nuevo anuncio", style: TextStyle(color: gradientYellow),),
                  Container(
                    height: 40,
                    width: 40,
                    child: Center(child: Icon(Icons.add, color: Colors.white,)),
                    decoration: BoxDecoration(
                      gradient: gradientenNaranjoDiagonal,
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 10,),
            Expanded(
              child: Container(
                child: ListView(
                  padding: EdgeInsets.only(right: 20, left: 20, top: 10),
                  children: <Widget>[
                    Tarjeta2(buttonText: "Editar", cuerpo: <Widget>[
                      Text("08/06/2020"),
                      Text("Pie de limón"),
                      Text("\$5.690"),
                      Text("Visto por: 40")
                    ],),
                    Tarjeta2(buttonText: "Editar", cuerpo: <Widget>[
                      Text("08/06/2020"),
                      Text("Pie de limón"),
                      Text("\$5.690"),
                      Text("Visto por: 40")
                    ],),
                    Tarjeta2(buttonText: "Editar", cuerpo: <Widget>[
                      Text("08/06/2020"),
                      Text("Pie de limón"),
                      Text("\$5.690"),
                      Text("Visto por: 40")
                    ],),
                    Tarjeta2(buttonText: "Editar", cuerpo: <Widget>[
                      Text("08/06/2020"),
                      Text("Pie de limón"),
                      Text("\$5.690"),
                      Text("Visto por: 40")
                    ],)
                  ],
                ),
              ),
            )
          ],
        ),
      );
  }
}
