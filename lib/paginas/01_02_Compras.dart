import 'package:flutter/material.dart';
import 'package:trainning/recursos/componentes.dart';
import 'package:trainning/recursos/constant.dart';
import 'package:trainning/recursos/tarjetas.dart';


class Compras extends StatelessWidget {
  final List<String> productos = ["Pie de limón", "Tiramisú", "Torta tres leches", "Cus cus"];
  final List<String> fechas = ["07/05/2019", "12/09/2014", "22/11/2020", "03/03/2013"];
  final List<String> precios = ["1.990", "3.500", "12.850", "15.990"];
  final List<String> vistos = ["2", "5", "3", "2"];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          SizedBox(height: topPadding,),
          TituloConLineas(titulo: "Compras",),
          SizedBox(height: 20,),
          
          SizedBox(height: 10,),
          Expanded(
            child: Container(
              child: ListView(
                padding: EdgeInsets.only(right: 20, left: 20, top: 10),
                children: productos.map((producto){
                  int index = productos.indexOf(producto);
                  return Tarjeta2(buttonText: "Editar", cuerpo: <Widget>[
                    Text(fechas[index]),
                    Text(producto),
                    Text("\$" + precios[index]),
                    Text("Visto por: " + vistos[index])
                  ],);
                }).toList()
              ),
            ),
          )
        ],
      ),
    );
  }
}
