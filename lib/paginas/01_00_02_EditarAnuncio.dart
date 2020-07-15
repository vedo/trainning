import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:trainning/recursos/constant.dart';
import 'package:trainning/recursos/client2.dart';
import 'package:trainning/recursos/ScreenArgument.dart';
import 'dart:convert';

class EditarAnuncio extends StatelessWidget {

  FutureBuilder futureBuilderProducto( String idProducto){
    return FutureBuilder(
      future: servidor.getProductDetail( idProducto ),
      builder: (BuildContext context,  AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return SpinKitThreeBounce(
              color: Colors.blue,
              size: 50.0,
            );
          default:
            if (snapshot.hasError){ return Text('Error: ${snapshot.error}'); }
            else{
              var jsonResponse = json.decode(snapshot.data.body);
              if (snapshot.data.statusCode != 200 ){
                return Text(
                  'Status: ' + snapshot.data.statusCode.toString() + '\n' + 
                  jsonResponse.toString()
                );
              } else{
                return ListView(
                  children: <Widget>[
                    Text(jsonResponse['name']),
                    Text(jsonResponse['description']),
                    Text(jsonResponse['Price'].toString()),
                    Text(jsonResponse['manage_stock'].toString()),
                    Text(jsonResponse['stock_quantity'].toString()),
                  ],
                ); 
              }
            }
        } // FutureBuilder builder
      },
    );
  }
  
  @override
  Widget build(BuildContext context) {
    ScreenArguments args = ModalRoute.of(context).settings.arguments;
    String idProducto = args.id;
    return Container(
      padding: EdgeInsets.only(top: topPadding, left: 15, right: 15),
      child: futureBuilderProducto(idProducto), 
    );
  }
}

class TituloValor extends StatelessWidget {
  final String titulo;
  final String valor;
  final bool sinValor;
  final Color colorValor;
  
  const TituloValor({
    Key key,
    this.titulo,
    this.valor,
    this.sinValor : false,
    this.colorValor : Colors.yellow
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        
        Text( // Titulo
          this.titulo,
          style: TextStyle(
            fontSize: 20,
          ),
        ),

        Text( // Valor
          this.valor,
          style: TextStyle(
            color: this.colorValor,
          ),
        ),
        SizedBox( height: 10,),
      ],
    );
  }
}