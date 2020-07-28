import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trainning/recursos/constant.dart';
import 'package:trainning/recursos/tarjetas.dart';
import 'package:trainning/recursos/client.dart';
import 'package:trainning/recursos/componentes.dart';

SharedPreferences sharedPreferences;

class MisAnuncios extends StatefulWidget {
  @override
  _MisAnunciosState createState() => _MisAnunciosState();
}

class _MisAnunciosState extends State<MisAnuncios> {
  @override //Checkear si es primera vez que se ingresa a esta pantalla 
  void initState() {
    super.initState();
    checkPantalla();
  }

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
            accion: () async{
              checkearDatosDeContacto();
            }
          ),
          SizedBox(height: 10,),
          Expanded(
            child: Container( 
              child: FutureServerCall(
                llamadaCliente: cliente.getMyProducts(),
                completedCallWidgetFunction: construirListaDeProductos
              ), 
            ),
          )
        ],
      ),
    );
  }

  checkPantalla() async{
    sharedPreferences = await SharedPreferences.getInstance();
    if( sharedPreferences.getString("misAnuncios_check") == null ){
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

  checkearDatosDeContacto() async{
    sharedPreferences = await SharedPreferences.getInstance();
    if( sharedPreferences.getString("datosContacto") == null ){
      Navigator.popAndPushNamed(context, "/EditarPerfil");
    }else{
      if( sharedPreferences.getString("datosContacto") == "ok" ){
        Navigator.popAndPushNamed(context, "/CrearAnuncio");
      }else{
        Navigator.popAndPushNamed(context, "/EditarPerfil");
      }
    }
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
        tituloTarjeta: snapshot.data[index].name.toString(),
        precioTarjeta: snapshot.data[index].price.toString(),
        id: idProducto,
        imagen: NetworkImage(snapshot.data[index].images[0].src),
      );
    },
  );
}