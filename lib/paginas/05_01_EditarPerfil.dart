//import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:trainning/recursos/client.dart';
import 'package:trainning/recursos/constant.dart';

class EditarPerfil extends StatefulWidget {
  EditarPerfil({Key key}) : super(key: key);

  @override
  _EditarPerfilState createState() => _EditarPerfilState();
}

class _EditarPerfilState extends State<EditarPerfil> {
  String direccion;
  String ciudad;
  String comuna;
  String telefono;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
        child: Padding(
          padding: EdgeInsets.only(top: topPadding, left: 20, right: 20),
            child: ListView(
              children: <Widget>[
                
                Text( // Titulo del formulario
                  "Editar Perfil",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                SizedBox(width: 20,),
                TextFormField(
                  decoration: InputDecoration( labelText: 'Dirección', ),
                  validator: (value) {
                    direccion = value;
                    return null;
                  },
                ),

                SizedBox(width: 20,),
                TextFormField(
                  decoration: InputDecoration( labelText: 'Ciudad', ),
                  validator: (value) {
                    ciudad = value;
                    return null;
                  },
                ),

                SizedBox(width: 20,),
                TextFormField(
                  decoration: InputDecoration( labelText: 'Comuna', ),
                  validator: (value) {
                    comuna = value;
                    return null;
                  },
                ),

                SizedBox(height: 10,),
                TextFormField(
                  decoration: InputDecoration( labelText: 'Teléfono', ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    telefono = value;
                    return null;
                  }
                ),
                
                SizedBox(height: 20,),
                RaisedButton(
                  child: Text("Actualizar Perfil"),
                  onPressed: ()  {
                    if (_formKey.currentState.validate()) {
                      cliente.updateMyProfile(direccion: direccion, ciudad: ciudad, comuna: comuna, telefono: telefono);
                      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Actualizando tus datos')));
                    }
                  },
                ),

                SizedBox(height: 100,),
              ],
          ),
        ),
      );
  }
}