import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:trainning/recursos/constant.dart';
import 'package:trainning/recursos/client2.dart';
import 'dart:convert';

class DetallePost extends StatelessWidget {

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
                    return Container();
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
  
    return Container(
      padding: EdgeInsets.only(top: topPadding, left: 15, right: 15),
      child: ListView(
        children: 
        <Widget>[
          
        ],
      ),
    );
  }
}
