import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:trainning/recursos/client.dart';
import 'package:trainning/recursos/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
    if (respLogin["token"] != null || respLogin["token"] != ""){      //Si está ok, guardamos el token para hacer el login permanente
      sharedPreferences = await SharedPreferences.getInstance();
      /* sharedPreferences.setString("token", respLogin["token"]); */
      sharedPreferences.setString("token", "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE1OTQ2Njg4NTIsInN1YiI6MX0.D--zjnU4LrJ9uGLJLfGWWoW6Z5Agz7n_nj76iGBuYoc");
      Navigator.popAndPushNamed(context, "/Anuncios"); // y enviamos a /Anuncios
    }

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
          decoration: imagenDeFondoLogin,
          child: Center(
            child:formularioLogin(context)
          ),
        ),
      ),
    );  
  }
  
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  Widget formularioLogin(BuildContext context){
  return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          /* Mensaje de error */
          mensaje == null ? Container() : Dialog(child: Text(mensaje),),
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
                      if( loginFormKey.currentState.validate()){
                        //String body = await cliente.testValidation(name: user,password: password);
                        tryLogIn();
                        //Map json = jsonDecode(body);
                        //_onLoading(urlConfirm: json["url"]);
                      }
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

          /* SizedBox(height: MediaQuery.of(context).size.width * 0.7,), */

          /* Campos de texto */
          /* FormComponent(tipo: "campoTexto", texto: "Nombre de Usuario", obscureText: false, controller: emailController,),
          SizedBox(height: 10,),
          FormComponent(tipo: "campoTexto", texto: "Contraseña", obscureText: true, controller: passwordController,),
          Container(
            width: 250,
            alignment: Alignment.centerRight,
            child: FlatButton(
              onPressed: (){},
              child: Text('¿Olvidaste tu contraseña?', style: TextStyle(color: Colors.white),)
            )
          ), */
          
          /* Boton ingresar */
          /* FormComponent(tipo: "boton", ancho: 250, color: Color(0xFF15A1CA), texto: "Ingresar", onPressed: (){tryLogIn();}, ), */
          
          
        ],
      ),
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
  final double ancho;
  final FaIcon icono;
  FormComponent({
    this.tipo,
    this.texto,
    this.color,
    this.controller,
    this.onPressed,
    this.obscureText,
    this.ancho,
    this.icono,
  });
  
  @override
  Widget build(BuildContext context) {
    if(this.tipo == "boton"){
      return Container(
          width: this.ancho,
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.all(0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: this.color
          ),
          child: FlatButton(
            onPressed: this.onPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  this.texto,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        );
    }
    
    else if( this.tipo == "campoTexto" ){
      return Container(
          width: 250,
          height: 60,
          
          child: TextField(
            obscureText: this.obscureText,
            controller: this.controller,
            decoration: InputDecoration(
              labelText: this.texto,
            ),
          ),
        );
    }
    
    else{  // Es un texto si no es lo anterior
      return Text(this.texto);
    }
  }
}
