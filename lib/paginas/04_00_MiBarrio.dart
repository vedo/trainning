import 'package:flutter/material.dart';
import 'package:html/parser.dart';
//import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:trainning/recursos/client.dart';
import 'package:trainning/recursos/tarjetas.dart';
import 'package:trainning/recursos/componentes.dart';


class MiBarrio extends StatefulWidget {
  @override
  _MiBarrioState createState() => _MiBarrioState();
}

class _MiBarrioState extends State<MiBarrio> {
  @override
  Widget build(BuildContext context) {
    return CarruselDeDosPantallas(
      pantalla1: PantallaBarrio(),
      pantalla2: PantallMisPublicaciones(),
      titulo1: "Barrio",
      titulo2: "Mis mensajes"
    );
  }
}

class PantallaBarrio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          TituloConLineas(titulo: "Barrio",),
          SizedBox(height: 20,),
          Expanded(
            child: Container(
              child: FutureServerCall(
                llamadaCliente: cliente.getPosts(), // Client get posts ? se puede construir esta parte de la app con los post del blog ?
                completedCallWidgetFunction: construirListaDePosts, 
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PantallMisPublicaciones extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          TituloConLineas(titulo: "Mis mensajes",),
          SizedBox(height: 10,),
          botonCentral(
            context: context, 
            titulo: "Nuevo mensaje", 
            accion: (){ Navigator.popAndPushNamed(context, "/CrearPost"); },
          ),
          SizedBox(height: 20,),
          Expanded(
            child: Container(
              child: FutureServerCall(
                llamadaCliente: cliente.getMyPosts(),
                completedCallWidgetFunction: construirListaDePosts,
              ) 
            ),
          )
        ],
      ),
    );
  }
}

/* Lista de posts a partir de la llamada al servidor */
Widget construirListaDePosts(BuildContext context, dynamic snapshot) {
  final data = snapshot.data;
  //return snapshot["message"] == null ?
  return ListView.builder(       // Verdadero : Sin error en message
    scrollDirection: Axis.vertical,
    itemCount: data.length,
    itemBuilder: (BuildContext context, int index) {
      String idPost = data[index]["id"].toString();
      return TarjetaPost(
        titulo: parse(data[index]["title"]["rendered"]).body.text,
        id: idPost,
        contenido: parse(data[index]["content"]["rendered"]).body.text,
      );
    },
  );
  //: Container(child: Text(snapshot["message"].toString())) ; // Falso : Mensaje error
}