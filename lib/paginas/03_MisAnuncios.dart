import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:trainning/recursos/constant.dart';
import 'package:trainning/recursos/tarjetas.dart';
import 'package:trainning/recursos/client.dart';
// paquetes para comunicación con servidor

class MisAnuncios extends StatefulWidget {
  @override
  _MisAnunciosState createState() => _MisAnunciosState();
}

class _MisAnunciosState extends State<MisAnuncios> {

  FutureBuilder futureBuilderAnuncios(){
    return FutureBuilder(
      future: cliente.getMyProducts(),
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
              return Text('Error po: ${snapshot.error}');
            }
            else{
                return construirListaDeProductos(context, snapshot);
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
              //child: futureBuilderAnuncios(),
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

Widget construirListaDeProductos(BuildContext context, AsyncSnapshot snapshot) {

  return ListView.builder(
    scrollDirection: Axis.vertical,
    itemCount: snapshot.data.length,
    itemBuilder: (BuildContext context, int index) {
      String idProducto = snapshot.data[index].id.toString();
      return Tarjeta1(
        nombreProducto: snapshot.data[index].name.toString(),
        precioProducto: snapshot.data[index].price.toString(),
        idProducto: idProducto,
        imagenProducto: NetworkImage(snapshot.data[index].images[0].src),
      );
    },
  );
}