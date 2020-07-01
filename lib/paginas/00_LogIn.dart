import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:trainning/recursos/constant.dart';
// paquetes para comunicación con servidor
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final double buttonWidth = 250;
final double buttonHeight = 40;
SharedPreferences sharedPreferences;

class LogInMenu extends StatefulWidget {
  @override
  _LogInMenuState createState() => _LogInMenuState();
}

class _LogInMenuState extends State<LogInMenu> {
  String mensaje;
  SharedPreferences sharedPreferences;
  
  checkLogIn() async { // verdadero cuando hay un token
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString("token") != null;
  }

  @override
  void initState() {
    super.initState();
    loggedMove();   
  }

  loggedMove() async{
    sharedPreferences = await SharedPreferences.getInstance();
    if( sharedPreferences.getString("token") != null ){
      Navigator.popAndPushNamed(context, "/Anuncios");
    }
  }

  tryLogIn() async{
    Map data = {
      'username': emailController.text,
      'password': passwordController.text
    };
    var response = await http.post("https://algocerca.cl/wp-json/jwt-auth/v1/token", body: data);
    var jsonResponse = json.decode(response.body);
    if ( response.statusCode == 200 ){
      sharedPreferences.setString("token",             jsonResponse["token"]);
      sharedPreferences.setString("user_nicename",     jsonResponse["user_nicename"]);
      sharedPreferences.setString("user_display_name", jsonResponse["user_display_name"]);
      sharedPreferences.setString("user_display_name", jsonResponse["user_display_name"]);
      sharedPreferences.setString("user_id",           jsonResponse["user_id"]);
      Navigator.popAndPushNamed(context, "/Anuncios");
    }else{
      setState(() {
        mensaje = jsonResponse["message"];
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: imagenDeFondo,
          child: Center(
            child: FutureBuilder(
              future: checkLogIn(),
              builder: (BuildContext context, AsyncSnapshot logedIn) {
                switch (logedIn.connectionState) {
                  case ConnectionState.waiting:
                    return SpinKitThreeBounce(
                      color: Colors.blue,
                      size: 50.0,
                    );
                  default:
                    if (logedIn.hasError)
                      return Text('Error: ${logedIn.error}');
                    else{
                      if( logedIn.data ){
                        return Container();
                      }else{
                        return formularioLogin(context);
                      }
                    }
                } // FutureBuilder builder
              },
            ),
          ),
        ),
      ),
    );  
  }
  
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  Widget formularioLogin(BuildContext context){
  return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        mensaje == null ? Container() : Dialog(child: Text(mensaje),),
        FormComponent(tipo: "boton", color: buttonGreen, texto: "Crear Cuenta", onPressed: (){},),
        FormComponent(tipo: "campoTexto", texto: "Nombre de Usuario", obscureText: false, controller: emailController,),
        FormComponent(tipo: "campoTexto", texto: "Contraseña", obscureText: true, controller: passwordController,),
        FormComponent(tipo: "boton", color: Color(0xFF15A1CA), texto: "Ingresar", onPressed: (){tryLogIn();},),
        Text('¿Olvidaste tu contraseña?'),
        FormComponent(tipo: "boton", color: Color(0xFFE05959), texto: "Ingresa con Google", onPressed: (){},),
        FormComponent(tipo: "boton", color: Color(0xFF5C5DAD), texto: "Ingresa con Facebook", onPressed: (){Navigator.popAndPushNamed(context, "/Anuncios");},),
      ],
    );
  }  
}


class FormComponent extends StatelessWidget {
  final String tipo;
  final String texto;
  final Color color;
  final TextEditingController controller;
  final Function onPressed;
  final bool obscureText;
  FormComponent({
    this.tipo,
    this.texto,
    this.color,
    this.controller,
    this.onPressed,
    this.obscureText,
  });
  
  @override
  Widget build(BuildContext context) {
    if(this.tipo == "boton"){
      return ButtonTheme(
        minWidth: buttonWidth,
        height: buttonHeight,
        child: RaisedButton(
          color: this.color,
          onPressed: this.onPressed,
          child: Text(
            this.texto, 
            style: TextStyle(fontSize: 20)
          ),
        ),
      );
    }else if( this.tipo == "campoTexto" ){
      return Container(
          width: buttonWidth,
          height: buttonHeight,
          child: TextField(
            obscureText: this.obscureText,
            controller: this.controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: this.texto
            ),
          ),
        );
    }else{  // Es un texto si no es lo anterior
      return Text(this.texto);
    }
  }
}
