import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:trainning/recursos/ScreenArgument.dart';
import 'package:trainning/recursos/constant.dart';
import 'package:trainning/recursos/client.dart';

class ComentarPost extends StatefulWidget {
  ComentarPost({Key key}) : super(key: key);

  @override
  _ComentarPostState createState() => _ComentarPostState();
}

class _ComentarPostState extends State<ComentarPost> {
  String tituloPost;
  String contenido;
  String postId;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
        child: Padding(
          padding: EdgeInsets.only(top: topPadding, left: 20, right: 20),
          child: ListView(
            children: <Widget>[
              Text(
                'Comentar el post',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              SizedBox(width: 50,),             
              TextFormField(
                decoration: InputDecoration( labelText: 'Comentario', ),
                maxLines: 8,
                validator: (value) {
                  if (value.isEmpty){ return 'Ingresa un comentario'; }
                  if (value.length >= 510){  return 'Esta descripción es muy larga, máximo 510 caracteres'; }
                  contenido = value;
                  return null;
                },
              ),

              SizedBox(height: 15,),
              RaisedButton(
                child: Text( 'Comentar' ),
                onPressed: ()  {
                  if ( _formKey.currentState.validate() ) {
                    cliente.commentPost(contenido:  contenido, postId: postId);
                    Scaffold.of(context).showSnackBar(SnackBar(content: Text( 'Creando comentario' )));
                    Navigator.pushNamed(
                      context, '/DetallePost',
                      arguments: ScreenArguments(
                        id: this.postId, 
                        apiClient: cliente
                      ),
                    );
                  }
                },
              ),

              SizedBox(height: bottomPadding,),

            ],
          ),
        ),
      );
  }
}