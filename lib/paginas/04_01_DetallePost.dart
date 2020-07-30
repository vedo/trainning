import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:trainning/recursos/ScreenArgument.dart';
import 'package:trainning/recursos/client.dart';
import 'package:trainning/recursos/componentes.dart';
import 'package:trainning/recursos/constant.dart';


String idPost;

class DetallePost extends StatelessWidget {
  //String idPost;
  
  @override
  Widget build(BuildContext context) {
    ScreenArguments args = ModalRoute.of(context).settings.arguments;
    idPost = args.id;
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: imagenDeFondo,
          child: FutureServerCall(
            llamadaCliente: cliente.getDetailPost( idPost ),
            completedCallWidgetFunction: construirPaginaDetallePost,
          ),
        ),
      ),
    );  
  }


  Widget construirPaginaDetallePost(BuildContext context, AsyncSnapshot snapshot) {
    final data = snapshot.data;
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0, left: 0, right: 0, bottom: 0,
          child: Column(
            children: <Widget>[

              Container( // Tarjeta de información
                color: Colors.grey[300],
                alignment: Alignment.topLeft,
                height: 150,
                child: Stack(
                  children: <Widget>[
                    
                    Positioned( // Titulo y descripción
                      top: 10, left: 10, right: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(data["_embedded"]["author"][0]["name"]),
                          Text(
                            parse(data["title"]["rendered"]).body.text,
                            style: TextStyle( fontWeight: FontWeight.bold, fontSize: 22, ),
                          ),
                          SizedBox(height: 10),
                          Text(parse(data["content"]["rendered"]).body.text)
                        ],
                      )
                    ),
                ],),
              ),

              SizedBox(height: 10),
              Container(
                alignment: Alignment.centerLeft,
                height: 30,
                child: Text(
                  "Comentarios:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.topCenter,
                  child: FutureServerCall(
                    llamadaCliente: cliente.getComments( postID: idPost ),
                    completedCallWidgetFunction: construirListaDeComentarios,
                  ),
                ),
              )
            ],
          ),
        ),
        
        Positioned( // Contactar
          bottom: 20, left: 20, right: 20,
          child: Container(
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: gradientBlue,
            ),
            child: FlatButton(
              padding: EdgeInsets.all(0),
              child: Text("Comentar"),
              onPressed: (){
                Navigator.pushNamed(context, 
                  "/ComentarPost",
                  arguments: ScreenArguments(
                    id: idPost, 
                    apiClient: cliente
                  ),
                );
              },
            ),
          ),
        ),

      ],
    );
  } // construir

  Widget construirListaDeComentarios(BuildContext context, AsyncSnapshot snapshot) {
    final data = snapshot.data;
    return ListView.builder(       // Verdadero : Sin error en message
      scrollDirection: Axis.vertical,
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        String idComentario = data[index]["id"].toString();
        return Container(
          margin: EdgeInsets.only(bottom: 15),
          height: 100,
          color: Colors.grey[300],
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 10, left: 10,
                child: Text(data[index]["author_name"].toString()),
              ),
              Positioned(
                top: 35, left: 10, right: 10,
                child: Text(parse(data[index]["content"]["rendered"]).body.text),
              )
            ],
          ),
        );
      },
    );
  }
}


 /* Acá tendría que enlistar los comentarios */
/*  Container(
      height: 100,
      color: Colors.grey[300],
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 10, left: 10,
            child: Text("Autor comentario"),
          ),
          Positioned(
            top: 30, left: 10, right: 10,
            child: Text("Comentario"),
          )
        ],
      ),
    ),
  SizedBox(height: 10,), 
  
  
  TarjetaPost(
          titulo: parse(data[index]["title"]["rendered"]).body.text,
          id: idPost,
          contenido: parse(data[index]["content"]["rendered"]).body.text,
        );
  */