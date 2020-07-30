import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trainning/recursos/constant.dart';
import 'package:trainning/recursos/client.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ValidateUser extends StatefulWidget {
  ValidateUser({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _ValidateUserState createState() => _ValidateUserState();
}

class _ValidateUserState extends State<ValidateUser> {
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
  String code;
  ClientApi cli = new ClientApi();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Validar tu email',
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
                      Text("Te enviamos un mail súper-secreto", style: TextStyle(color: Colors.white)),
                      Text("con un código de verificación", style: TextStyle(color: Colors.white)),
                      /* Username */
                      Container(
                        width: 250,
                        child: TextFormField(
                          //maxLength: 16,
                          style: TextStyle(color: Colors.white),
                          decoration: decoraInputText(text: "Código", icono: Icons.person ),
                          validator: (value){
                            if (value.length <= 5){return "Te faltaron dígitos";}
                            if (value.length > 6){return "Te sobraron dígitos";}
                            if (value.isEmpty){return "Este código está en el mail que nos diste";}
                            code = value;
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 20,),

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
                              SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                              String validate_url = sharedPreferences.getString("validate_url");
                              http.Response resp = await cliente.confirmValidation(url: validate_url, code: code);
                              int status = resp.statusCode;
                              String body = resp.body;
                              Map body_json = jsonDecode(body);
                              if (status  == 200){
                                SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                                String token = sharedPreferences.getString("token");
                                if (token != null) {
                                  sharedPreferences.remove("validate_url");
                                  //Acá va el code si la confirmación es positiva
                                  Navigator.popAndPushNamed(context, '/');
                                }
                                else{
                                  _onLoading(validate_url: validate_url, code: code);
                                }
                              }

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

  void _onLoading({String code, String validate_url}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Pucha!"),
          content: new Text("El código que pusiste no es el mismo que te enviamos a tu email :("),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Re-intentar!"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );

      },
    );


  }
}