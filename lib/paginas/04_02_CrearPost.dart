// Unused imports
//import 'dart:convert';
//import 'dart:io';
//import 'package:image_picker/image_picker.dart';

/* Import de paquetes */
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:trainning/recursos/constant.dart';
import 'package:trainning/recursos/client.dart';

class CrearPost extends StatefulWidget {
  CrearPost({Key key}) : super(key: key);

  @override
  _CrearPostState createState() => _CrearPostState();
}

class _CrearPostState extends State<CrearPost> {
  String tituloPost;
  String contenido;
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
                "Nueva publicación en el barrio",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.indigo[300],
                ),
              ),
              
              SizedBox(width: 20,),
              TextFormField(
                decoration: InputDecoration( labelText: 'Título de la publicación', ),
                validator: (value) {
                  if (value.isEmpty){ return "Falta nombre del producto"; }
                  if (value.length <=3){ return "Este nombre es muy corto"; }
                  tituloPost = value;
                  return null;
                },
              ),

              SizedBox(height: 10,),
              TextFormField(
                decoration: InputDecoration( labelText: 'Texto de la publicación', ),
                maxLines: 8,
                validator: (value) {
                  if (value.isEmpty){ return "Falta descripción"; }
                  if (value.length <=10){ return "Esta descripción es muy corta"; }
                  if (value.length >=510){  return "Esta descripción es muy larga, máximo 510 caracteres"; }
                  contenido = value;
                  return null;
                },
              ),

              SizedBox(height: 10,),
              RaisedButton(
                child: Text("Crear publicación"),
                onPressed: ()  {
                  if (_formKey.currentState.validate()) {
                    cliente.createPost(postTitle: tituloPost, contenido:  contenido);
                    Scaffold.of(context).showSnackBar(SnackBar(content: Text('Creando publicación')));
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