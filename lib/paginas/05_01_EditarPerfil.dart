//import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trainning/recursos/client.dart';
import 'package:trainning/recursos/constant.dart';

SharedPreferences sharedPreferences;

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
                if( value != "" ){  
                  direccion = value;  
                  return null;
                }else{
                  return "Por favor ingresa una dirección";
                }  
              },
            ),

            SizedBox(width: 20,),
            TextFormField(
              decoration: InputDecoration( labelText: 'Ciudad', ),
              validator: (value) {
                if( value != "" ){  
                  ciudad = value;  
                  return null;
                }else{
                  return "Por favor ingresa una ciudad";
                }  
              },
            ),

            SizedBox(width: 20,),
            TextFormField(
              decoration: InputDecoration( labelText: 'Comuna', ),
              validator: (value) {
                if( value != "" ){  
                  comuna = value;  
                  return null;
                }else{
                  return "Por favor ingresa una comuna";
                }  
              },
            ),

            SizedBox(height: 10,),
            TextFormField(
              decoration: InputDecoration( labelText: 'Teléfono', ),
              keyboardType: TextInputType.number,
              validator: (value) {
                Pattern pattern = '^(?:[+0]9)?[0-9]{10}';
                RegExp regex = new RegExp(pattern);
                if (!regex.hasMatch(value))
                  return 'Por favor ingresa un número de teléfono válido';
                else{
                  telefono = value;  
                  return null;
                }  
              }
            ),
            
            SizedBox(height: 20,),
            RaisedButton(
              child: Text("Actualizar Perfil"),
              onPressed: () async{
                if ( _formKey.currentState.validate() ) {
                  await cliente.updateMyProfile(direccion: direccion, ciudad: ciudad, comuna: comuna, telefono: telefono);
                  Scaffold.of(context).showSnackBar(SnackBar(content: Text('Actualizando tus datos')));
                  sharedPreferences.setString("datosContacto", "ok");
                  Navigator.popAndPushNamed(context, '/Perfil');
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