import 'package:flutter/material.dart';
//import 'package:trainning/recursos/constant.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:trainning/recursos/ScreenArgument.dart';
import 'package:trainning/recursos/client.dart';


class StoreList extends StatefulWidget {
  
  @override
  _StoreListState createState() => _StoreListState();
} // Store List Stateful

class _StoreListState extends State<StoreList> {

  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: Container( // Lista de tinedas 
        child: FutureBuilder(
          future: cliente.getVendors(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return SpinKitThreeBounce(
                  color: Colors.blue,
                  size: 50.0,
                );
              default:
                if (snapshot.hasError)
                  return Text('Error: ${snapshot.error}');
                else
                  return construirListaDeTiendas(context, snapshot);
            }
          },
        ),
      ),
    );
  } //_StoreListState Build
  
} //_StoreListState

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 10, top: 10),
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
    );
  } // Tienda Build

} // Tienda

class TarjetaProducto extends StatelessWidget {
  
  final String nombreProducto;
  final String precioProducto;
  final String idProducto;
  final NetworkImage imagenProducto;

  const TarjetaProducto({
    Key key,
    this.nombreProducto,
    this.precioProducto,
    this.idProducto,
    this.imagenProducto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container( // Tarjeta producto
      margin: EdgeInsets.only(left: 10),
      height: 160,
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(34),
        color: Colors.blue.withOpacity(.2)
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

Widget construirListaDeTiendas(BuildContext context, AsyncSnapshot snapshot) {
  return ListView.builder(
    itemCount: snapshot.data.length,
    itemBuilder: (BuildContext context, int index) {
      String idVendor = snapshot.data[index].id.toString();
      return Tienda(
        nombreTienda: snapshot.data[index].login.toString(),
        listaDeProductos: FutureBuilder(
          future: cliente.getProductos(idVendor),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return SpinKitThreeBounce(
                  color: Colors.blue,
                  size: 20.0,
                );
              default:
                if (snapshot.hasError)
                  return Text('Error: ${snapshot.error}');
                else
                  return construirListaDeProductos(context, snapshot);
            }
          },
        ),
      );
    }, // Item Builder
  );
} //construirListaDeTiendas (Función)

Widget construirListaDeProductos(BuildContext context, AsyncSnapshot snapshot) {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: snapshot.data.length,
    itemBuilder: (BuildContext context, int index) {
      String idProducto = snapshot.data[index].id.toString();
      return TarjetaProducto(
        nombreProducto: snapshot.data[index].name.toString(),
        precioProducto: snapshot.data[index].price.toString(),
        idProducto: idProducto,
        imagenProducto: NetworkImage(snapshot.data[index].images[0].src),
      );
    },
  );
} // construirListaDeProductos

