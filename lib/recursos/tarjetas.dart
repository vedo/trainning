import 'package:flutter/material.dart';
import 'package:trainning/recursos/ScreenArgument.dart';
import 'package:trainning/recursos/client.dart';

/* PENDIENTE: ORDENAR ESTE CÓDIGO */

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

          Positioned( // Botón detalle producto
            left: 160,
            bottom: 10,
            child: FlatButton(
              child: Text("Ver producto"),
              onPressed: () {
                Navigator.pushNamed(
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

class Tarjeta3 extends StatelessWidget {
  final String buttonText;
  final List<Widget> cuerpo;
  final String id;
  final String imagenProducto;

  const Tarjeta3({
    this.buttonText,
    this.cuerpo,
    @required this.id,
    this.imagenProducto,
  });
  
  @override
  Widget build(BuildContext context) {
    double fraccionImagen = 0.45;
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      height: 150,
      child: Stack(children: <Widget>[
        
        Align( //Espacio de texto
          alignment: Alignment.centerRight,
          child: FractionallySizedBox(
            widthFactor: 1 - fraccionImagen,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), topRight: Radius.circular(10)),
                color: Colors.white,
              ),
              child: Stack(children: <Widget>[
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
                      Navigator.popAndPushNamed(
                        context, '/EditarAnuncio',
                        arguments: ScreenArguments(id: this.id),
                      );
                    },
                    child: Text( this.buttonText ),
                  ),
                ),
              ],),
            ),
          ),
        ),

        Align( //Espacio Imágen
          alignment: Alignment.centerLeft,
          child: FractionallySizedBox(
              widthFactor: fraccionImagen,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), topLeft: Radius.circular(10)),
                  image: DecorationImage(
                    image: NetworkImage(this.imagenProducto),
                    fit: BoxFit.cover,
                  ),
                ),
            ),
          ),
        ),
      ],),
    );
  }
}

class TarjetaPost extends StatelessWidget {
  final String titulo;
  final String id;
  final String contenido;
  const TarjetaPost({
    this.titulo,
    this.id,
    this.contenido,
  });

  @override
  Widget build(BuildContext context) {
    return Container( // Tarjeta producto
      margin: EdgeInsets.only(bottom: 10),
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(34),
        color: Colors.blue[50]
      ),
      child: Stack(
        children: <Widget>[

          Positioned( // Bloque de texto
            left: 20,
            top: 15,
            child: Container(
              height: 160,
              width: MediaQuery.of(context).size.width - 40,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    this.titulo,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(this.contenido, overflow: TextOverflow.visible,),
                ],
              ),
            ),
          ),

          Positioned( // Botón detalle
            right: 20,
            bottom: 5,
            child: FlatButton(
              child: Text("Leer más"),
              onPressed: () {
                Navigator.popAndPushNamed(
                  context, '/DetallePost',
                  arguments: ScreenArguments(
                    id: this.id, 
                    apiClient: cliente
                  ),
                );
              },
            ),
          ),

          Positioned( // Botón detalle
            left: 20,
            bottom: 20,
            child: FutureBuilder(
              future: cliente.getUserName(this.id), // Client get posts ? se puede construir esta parte de la app con los post del blog ?
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Text("");
                  default:
                    return Text(snapshot.data.toString()); 
                } // FutureBuilder builder
              },
            ),
          )

        ],
      ),
    );
  } // TarjetaProducto Build
} // TarjetaProducto

/* Modelo gráfico de una tienda, se usa en pestaña '/Mercado' */
class Tienda extends StatelessWidget {
  final String nombreTienda;
  final Widget listaDeProductos;
  const Tienda({
    Key key,
    this.nombreTienda,
    this.listaDeProductos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20, left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              this.nombreTienda,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            )
          ),
          SizedBox(height: 5,),
          
          Container(
            height: 160,
            child: this.listaDeProductos,
          ),
        ],
      ),
    );
  } // Tienda Build
} //