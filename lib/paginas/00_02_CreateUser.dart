import 'package:flutter/material.dart';
import 'package:trainning/recursos/constant.dart';
import 'package:trainning/recursos/client.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CreateUser extends StatefulWidget {
  CreateUser({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _CreateUserState createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  //@override
  //final TextStyle textstyle = TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
  decoraInputText({String text, IconData icono}){
    return InputDecoration(
      //border    : OutlineInputBorder(),
      labelText : '$text',
      labelStyle: TextStyle(color: Colors.grey[400]),
      suffixIcon: Icon(icono, color: Colors.grey[400],),
    );
  }

  final _formKey = GlobalKey<FormState>();
  String user;
  String email;
  String password;
  String repeatPassword;
  ClientApi cli = new ClientApi();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crear una cuenta',
      home: Scaffold(
        body: SafeArea(
          child: Container(
            decoration: imagenDeFondoLogin,
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: MediaQuery.of(context).size.width * 0.75,),

                      /* Username */
                      Container(
                        width: 250,
                        child: TextFormField(
                          //maxLength: 16,
                          style: TextStyle(color: Colors.white),
                          decoration: decoraInputText(text: "Tu nombre", icono: Icons.person ),
                          validator: (value){
                            String specialCaracters = r'[!@#$%^&*(),?":{}|<>\ ]';
                            RegExp regex = new RegExp(specialCaracters);
                            if (regex.hasMatch(value)){return "Tu nombre tiene caracteres que no están permitidos";}
                            if (value.isEmpty){return "Faltó el nombre tuyo o de tu tienda";}
                            user = value;
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 20,),

                      /* Email */
                      Container(
                        width: 250,
                        child: TextFormField(
                          style: TextStyle(color: Colors.white),
                          decoration: decoraInputText(text: "Tu email", icono: Icons.email),
                          validator: (value){
                            if (value.isEmpty){ return "Faltó que pusieras tu email"; }
                            String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                            RegExp regex = new RegExp(pattern);
                            if (!regex.hasMatch(value)){ return "Email no válido"; }
                            else {
                              email = value;
                              return null;
                            }
                          },
                        ),
                      ),
                      SizedBox( height: 20 ),

                      /* CONTRASEÑA */
                      Container(
                        width: 250,
                        child: TextFormField(
                          style: TextStyle(color: Colors.white),
                          obscureText: true,
                          decoration: decoraInputText(text: "Tu contraseña", icono: Icons.lock_outline),
                          validator: (value){
                            if (value.isEmpty){return "Faltó contraseña";}
                            if (value.length < 8){return "Contraseña muy corta, mínimo 8 caracteres";}
                            password = value;
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 20,),

                      /* REPITE LA CONTRASEÑA */
                      Container(
                        width: 250,
                        child: TextFormField(
                          style: TextStyle(color: Colors.white),
                          obscureText: true,
                          decoration: decoraInputText(text: "Repite tu contraseña", icono: Icons.lock),
                          validator: (value){
                            if (value.isEmpty){return "Faltó que repitieras tu contraseña";}
                            repeatPassword = value;
                            if(password != "" && repeatPassword != password){return "Las contraseñas no coinciden, debieran ser iguales";}
                            return null;
                          },
                        ),
                      ),

                      /* BOTON CREAR CUENTA */
                      SizedBox(height: 40,),
                      Container(
                        width: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: Colors.white),
                        ),
                        child: FlatButton(
                          onPressed: () async {
                            if( _formKey.currentState.validate()){
                              String body = await cliente.testValidation(name: user,password: password,email: email);
                              //Validación en proceso
                              Map json = jsonDecode(body);
                              String validateUrl = json["url"];
                              //Guarda la url de validación, que determinará el inicio de la app hasta que la cuenta sea validada
                              SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                              sharedPreferences.setString("validate_url", validateUrl);
                              Navigator.popAndPushNamed(context, "/"); // y enviamos a /Anuncios
                            }
                          },
                          child: Text(
                            "Crear cuenta",
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
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onLoading({String urlConfirm}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Solicitud enviada con éxto!"),
          content: new Text("Acá debiera decir, te enviamos un email revisalo para confirmar tu identidad"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("Confirm!"),
              onPressed: () async {
                http.Response resp = await cliente.confirmValidation(url: urlConfirm);
                int status = resp.statusCode;
                if (status  == 200){
                  //Acá va el code si la confirmación es positiva
                  Navigator.popAndPushNamed(context, '/');
                }
              },
            ),
          ],
        );

      },
    );


  }
}