import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:trainning/recursos/client.dart';
import 'package:trainning/recursos/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    String token = sharedPreferences.getString("access_token");
    print("Acá el token: $token");
    if( await checkLogIn() ){
      Navigator.popAndPushNamed(context, "/Anuncios");
    }
  }

  tryLogIn() async{
    Map data = {
      'username': emailController.text,
      'password': passwordController.text
    };
    Map respLogin = await cliente.login(credentials: data);
    if (respLogin["access_token"] != null || respLogin["access_token"] != ""){      //Si está ok, guardamos el token para hacer el login permanente
      sharedPreferences = await SharedPreferences.getInstance();
      print("acá el token recibido");
      print(respLogin["access_token"]);
      sharedPreferences.setString("token", respLogin["access_token"]);
      Navigator.popAndPushNamed(context, "/Anuncios"); // y enviamos a /Anuncios
    }
    /*
    //esto está muy bueno y simple, el unico problema es que las credenciales viajan sin encriptación
    var response = await http.post("https://algocerca.cl/wp-json/jwt-auth/v1/token", body: data);
    var jsonResponse = json.decode(response.body);
    if ( response.statusCode == 200 ){
      sharedPreferences.setString("token",             jsonResponse["token"]);
      sharedPreferences.setString("nice_name",     jsonResponse["user_nicename"]);
      sharedPreferences.setString("user_display_name", jsonResponse["user_display_name"]);
      sharedPreferences.setString("user_display_name", jsonResponse["user_display_name"]);
      sharedPreferences.setString("user_id",           jsonResponse["user_id"]);
      Navigator.popAndPushNamed(context, "/Anuncios");
    }
    */
    else{
      setState(() {
        mensaje = respLogin["message"];
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
        FormComponent(tipo: "boton", color: buttonGreen, texto: "Crear Cuenta", onPressed: (){Navigator.popAndPushNamed(context, "/CreateUser");},),
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
