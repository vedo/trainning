import 'package:flutter/material.dart';
//import 'package:trainning/recursos/constant.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:trainning/recursos/client.dart';
import 'package:trainning/recursos/constant.dart';
import 'package:trainning/recursos/tarjetas.dart';


class StoreList extends StatefulWidget {
  @override
  _StoreListState createState() => _StoreListState();
} // Store List Stateful

class _StoreListState extends State<StoreList> {
  @override
  Widget build(BuildContext context) {
    return Container( // Lista de tinedas 
      padding: EdgeInsets.only(top: topPadding),
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
          } // FutureBuilder builder
        },
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

} // Tienda

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
      return Tarjeta1(
        nombreProducto: snapshot.data[index].name.toString(),
        precioProducto: snapshot.data[index].price.toString(),
        idProducto: idProducto,
        imagenProducto: NetworkImage(snapshot.data[index].images[0].src),
      );
    },
  );
} // construirListaDeProductos

