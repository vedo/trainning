//import 'dart:convert';
//import 'package:flutter_spinkit/flutter_spinkit.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:trainning/recursos/client.dart';
import 'package:trainning/recursos/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trainning/recursos/componentes.dart';

SharedPreferences sharedPreferences;

class LogInMenu extends StatefulWidget {
  @override
  _LogInMenuState createState() => _LogInMenuState();
}

class _LogInMenuState extends State<LogInMenu> {
  String mensaje;
  SharedPreferences sharedPreferences; 
  final loginFormKey = GlobalKey<FormState>();
  String user;
  String password;

  decoraInputText({String text, IconData icono}){
    return InputDecoration(
      //border    : OutlineInputBorder(),
      labelText : '$text',
      labelStyle: TextStyle(color: Colors.grey[400]),
      suffixIcon: Icon(icono, color: Colors.grey[400],),
    );
  }

  tryLogIn() async{
    Map data = {
      'username': user,
      'password': password
    };
    Map respLogin = await cliente.login(credentials: data);
    if (respLogin["token"] != null && respLogin["token"] != "" && respLogin["token"] != "null"){      //Si está ok, guardamos el token para hacer el login permanente
      sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString("token", respLogin["token"]);
      /* sharedPreferences.setString("token", "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE1OTQ2Njg4NTIsInN1YiI6MX0.D--zjnU4LrJ9uGLJLfGWWoW6Z5Agz7n_nj76iGBuYoc"); */
      Navigator.popAndPushNamed(context, "/Anuncios"); // y enviamos a /Anuncios
    }else{
      setState(() {
        mensaje = respLogin["message"];
        showPopup(
          context: context,
          contenido: [Text(mensaje),],
          textoBoton: "Ok",
        );
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: imagenDeFondoLogin,
          child: Center(
            child:formularioLogin(context)
          ),
        ),
      ),
    );  
  }
  
  Widget formularioLogin(BuildContext context){
  return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Form(
            key: loginFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.width * 0.7,),
                
                /* Username */
                Container(
                  width: 250,
                  child: TextFormField(
                    //maxLength: 16,
                    style: TextStyle(color: Colors.white),
                    decoration: decoraInputText(text: "Nombre de usuario", icono: Icons.person ),
                    validator: (value){
                      String specialCaracters = r'[!@#$%^&*(),?":{}|<>\ ]';
                      RegExp regex = new RegExp(specialCaracters);
                      if (regex.hasMatch(value)){return "Tu nombre tiene caracteres que no están permitidos";}
                      if (value.isEmpty){return "No ingresaste tu nombre de usuario o de tienda";}
                      user = value;
                      return null;
                    },
                  ),
                ),

                /* Password */
                SizedBox(height: 25,),
                Container(
                  width: 250,
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    obscureText: true,
                    decoration: decoraInputText(text: "Contraseña", icono: Icons.lock_outline),
                    validator: (value){
                      if (value.isEmpty){return "No ingresaste contraseña";}
                      if (value.length < 8){return "Contraseña muy corta, mínimo 8 caracteres";}
                      password = value;
                      return null;
                    },
                  ),
                ),
                
                /* Botón ingresar */
                SizedBox(height: 50,),
                Container(
                  width: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: Colors.white),
                  ),
                  child: FlatButton(
                    onPressed: () async {
                      if( loginFormKey.currentState.validate()){ tryLogIn(); }
                    },
                    child: Text(
                      "Ingresar",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
  );
  }  
}




