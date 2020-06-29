import 'package:flutter/material.dart';
import 'package:trainning/recursos/ScreenArgument.dart';
import 'package:trainning/recursos/client.dart';
import 'package:trainning/recursos/constant.dart';

class Tarjeta1 extends StatelessWidget {
  final String nombreProducto;
  final String precioProducto;
  final String idProducto;
  final NetworkImage imagenProducto;

  const Tarjeta1({
    this.nombreProducto,
    this.precioProducto,
    this.idProducto,
    this.imagenProducto,
  });

  @override
  Widget build(BuildContext context) {
    return Container( // Tarjeta producto
      margin: EdgeInsets.only(right: 10),
      height: 150,
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(34),
        color: Colors.blue.withOpacity(.8)
      ),
      child: Stack(
        children: <Widget>[

          Positioned( //Imágen del producto
            top: 5,
            left: 5,
            child: Container( 
              height: 145,
              width: 145,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(34),
                //color: kPrimaryColor.withOpacity(0.4),
                image: DecorationImage(
                  image: this.imagenProducto,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          Positioned( // Bloque de texto
            left: 160,
            top: 15,
            child: Container(
              height: 160,
              width: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    this.nombreProducto,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text( "\$ " + this.precioProducto ) ,
                ],
              ),
            ),
          ),

          Positioned( // Botón detalle
            left: 160,
            bottom: 10,
            child: FlatButton(
              child: Text("Ver producto"),
              onPressed: () {
                Navigator.popAndPushNamed(
                  context, '/DetalleProducto',
                  arguments: ScreenArguments(
                    id: this.idProducto, 
                    apiClient: cliente
                  ),
                );
              },
            ),
          )

        ],
      ),
    );
  } // TarjetaProducto Build

} // TarjetaProducto


class Tarjeta2 extends StatelessWidget {
  final String buttonText;
  final List<Widget> cuerpo;

  const Tarjeta2({
    this.buttonText,
    this.cuerpo,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      height: 150,
      child: Stack(children: <Widget>[
        
        FractionallySizedBox(
          widthFactor: 0.8,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey,
            ),
          ),
        ),

        Align(
          alignment: Alignment.centerRight,
          child: FractionallySizedBox(
              widthFactor: 0.5,
              heightFactor: 0.9,
              child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.lightBlue[200],
              ),
            ),
          ),
        ),
    

        Positioned(
          top: 10,
          left: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: this.cuerpo,
          ),
        ),

        Positioned(
          left: 0,
          bottom: 0,
          child: FlatButton(
            padding: EdgeInsets.zero,
            onPressed: (){
              Navigator.popAndPushNamed(context, '/DetalleProducto',);
            },
            child: Text(
              this.buttonText
            ),
          ),
        ),
      ],),
    );
  }
}


class Titulo1 extends StatelessWidget {
  final String titulo;
  const Titulo1({
    this.titulo,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          height: 1,
          width: 90,
          color: gradientBlue,
        ),
        Text(
          this.titulo,
          style: TextStyle( fontSize: 20, color: gradientBlue, fontWeight: FontWeight.bold ),
        ),
        Container(
          height: 1,
          width: 90,
          color: gradientBlue,
        ),
      ],
    );
  }
}