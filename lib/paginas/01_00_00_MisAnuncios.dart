import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trainning/recursos/constant.dart';
import 'package:trainning/recursos/tarjetas.dart';
import 'package:trainning/recursos/client.dart';
import 'package:trainning/recursos/componentes.dart';
// paquetes para comunicación con servidor

SharedPreferences sharedPreferences;

class MisAnuncios extends StatefulWidget {
  @override
  _MisAnunciosState createState() => _MisAnunciosState();
}

class _MisAnunciosState extends State<MisAnuncios> {

  /* Checkear si es primera vez que se ingresa a esta pantalla */
  @override
  void initState() {
    super.initState();
    checkPantalla();
  }
  checkPantalla() async{
    sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("misAnuncios_check") == null ){
      showPopup(
        context: context,
        titulo: "Tutorial:",
        contenido: [
          Text("\nEsta es tu tienda:\n \n"),
          Text("En la pestaña 'Anuncios' podrás crear nuevos productos para poner a la venta.\n"),
          Text("La pestaña 'Pedidos' te permite hacer seguimiento a las compras que te han realizado.\n"),
          Text("En la pestala 'Compras' podrás ver el estado de los productos que has comprado."),
        ]
      );
      sharedPreferences.setString("misAnuncios_check", "ok");
    }
  }

  /* Llamada futura al listado de anuncios */
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
              return Text('Error: ${snapshot.error}');
            }
            else{ return construirListaDeProductos(context, snapshot); }
        } // FutureBuilder builder
      },
    );
  }

  /* Main builder function */
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          SizedBox(height: topPadding,),
          TituloConLineas(titulo: "Mis Anuncios",),
          SizedBox(height: 20,),
          botonCentral(
            context: context, 
            titulo: "Nuevo Anuncio", 
            accion: (){Navigator.popAndPushNamed(context, "/CrearAnuncio");}
          ),
          SizedBox(height: 10,),
          Expanded(
            child: Container(
              /* VOLVER ATRAS !!! */
              //child: futureBuilderAnuncios(),
            ),
          )
        ],
      ),
    );
  }
}

/* Lista de productos a partir de la llamada al servidor */
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