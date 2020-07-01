import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:trainning/recursos/constant.dart';
import 'package:trainning/recursos/tarjetas.dart';
import 'package:trainning/recursos/client2.dart';
// paquetes para comunicación con servidor
import 'dart:convert';

class MisAnuncios extends StatefulWidget {
  @override
  _MisAnunciosState createState() => _MisAnunciosState();
}

class _MisAnunciosState extends State<MisAnuncios> {
  
  FutureBuilder futureBuilderAnuncios(){
    return FutureBuilder(
      future: servidor.getMyProducts(),
      builder: (BuildContext context,  AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text("No Conextion");
          case ConnectionState.waiting:
            return SpinKitThreeBounce(
              color: Colors.blue,
              size: 50.0,
            );
          default:
            if (snapshot.hasError){
              return Text('Error: ${snapshot.error}');
            }
            else{
              var jsonResponse = json.decode(snapshot.data.body);
              if (snapshot.data.statusCode != 200 ){
                return Text(
                  'Status: ' + snapshot.data.statusCode.toString() + '\n' + 
                  jsonResponse.toString()
                );
              } else{
                return ListView(
                  padding: EdgeInsets.only(top: 10),
                  children: List<Widget>.from(jsonResponse.map((item){
                    return Tarjeta3(
                      imagenProducto: item["images"][0]["src"],
                      id: item["id"].toString(),
                      buttonText: "Editar", 
                      cuerpo: <Widget>[
                        Text(item["name"]),
                        Text('\$ ' + item["price"].toString()),
                      ],
                    );
                  }))
                );
              }
            }
        } // FutureBuilder builder
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          SizedBox(height: topPadding,),
          Titulo1(titulo: "Mis Anuncios",),
          SizedBox(height: 20,),
          botonCrearAnuncio(),
          SizedBox(height: 10,),
          Expanded(
            child: Container(
              child: futureBuilderAnuncios(),
            ),
          )
        ],
      ),
    );
  }

  FlatButton botonCrearAnuncio(){
    return FlatButton(
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
    );
  }
}

