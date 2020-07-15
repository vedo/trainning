import 'package:flutter/material.dart';
import 'package:trainning/recursos/client.dart';
import 'package:trainning/recursos/constant.dart';
import 'package:trainning/recursos/tarjetas.dart';
import 'package:trainning/recursos/componentes.dart';

class StoreList extends StatefulWidget {
  @override
  _StoreListState createState() => _StoreListState();
} // Store List Stateful

class _StoreListState extends State<StoreList> {
  @override
  Widget build(BuildContext context) {
    return Container( // Lista de tinedas 
      padding: EdgeInsets.only(top: topPadding),
      child: FutureServerCall(
        llamadaCliente: cliente.getVendors(),
        completedCallWidgetFunction: construirListaDeTiendas,
      ),
    );
  } //_StoreListState Build
}

Widget construirListaDeTiendas(BuildContext context, AsyncSnapshot snapshot) {
  return ListView.builder(
    itemCount: snapshot.data.length,
    itemBuilder: (BuildContext context, int index) {
      String idVendor = snapshot.data[index].id.toString();
      return Tienda(
        nombreTienda: snapshot.data[index].login.toString(),
        listaDeProductos:FutureServerCall(
          llamadaCliente: cliente.getProductos(idVendor),
          completedCallWidgetFunction: construirListaDeProductos,
        ) 
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

