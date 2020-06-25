import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trainning/modelos/LogCreateUser.dart';
import 'package:trainning/recursos/client.dart';

/*
TODO
 [x] Minimun lenght password, 8?
 [x] UserName without space blank or especial characters.
 [x] Obscure text password
 [x] Email regex validator
 [x] No empty fields
 [x] Max Lenght name = 16
 []
 */

void main() {
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(
    CreateUser(),
  );
}
class CreateUser extends StatefulWidget {
  CreateUser({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _CreateUserState createState() => _CreateUserState();
}
class _CreateUserState extends State<CreateUser> {
  final TextStyle textstyle =
  TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
  decoraInputText({String text, Icon icono}){
  return InputDecoration(border    : OutlineInputBorder(),
                         labelText : '$text',
                          suffixIcon: icono,
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
        theme: ThemeData(
        primarySwatch: Colors.blue,
    ),
    home: Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Form(
              key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                FlutterLogo(
                  size: 190,
                ),
                SizedBox(
                  height: 15,
                ),
                /*

                Tu nombre

                 */
                TextFormField(
                    maxLength: 16,
                    decoration: decoraInputText(text: "Tu nombre", icono: Icon(Icons.person)),
                  // ignore: missing_return
                  validator: (value){
                      String specialCaracters = r'[!@#$%^&*(),?":{}|<>\ ]';
                      RegExp regex = new RegExp(specialCaracters);
                      if (regex.hasMatch(value)){
                        return "Tu nombre tiene caracteres que no están permitidos";
                      }
                    if (value.isEmpty){
                      return "Faltó el nombre tuyo o de tu tienda";
                    }
                    user = value;
                    return null;
                  },
                ),
                SizedBox(
                  height: 15,
                ),

                /*

                EMAIL

                 */

                TextFormField(
                  decoration: decoraInputText(text: "Tu email", icono: Icon(Icons.email)),
                  validator: (value){
                    if (value.isEmpty){
                      return "Faltó que pusieras tu email";
                    }

                    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                    RegExp regex = new RegExp(pattern);
                    if (!regex.hasMatch(value)){
                      return "Email no válido";
                    }
                    else {
                      email = value;
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                /*

                 CONTRASEÑA

                 */
                TextFormField(

                  obscureText: true,
                  decoration: decoraInputText(text: "Tu contraseña", icono: Icon(Icons.lock_outline)),
                  validator: (value){
                    if (value.isEmpty){
                      return "Faltó contraseña";
                    }
                    if (value.length < 8){
                      return "Contraseña muy corta, mínimo 8 caracteres";
                    }
                    password = value;
                    return null;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                /*

                REPITE LA CONTRASEÑA

                 */
                TextFormField(
                  validator: (value){
                    if (value.isEmpty){
                      return "Faltó que repitieras tu contraseña";
                    }
                    repeatPassword = value;
                    if(password != "" && repeatPassword != password){
                      return "Las contraseñas no coinciden, debieran ser iguales";
                    }
                    return null;
                  },
                  obscureText: true,
                  decoration: decoraInputText(text: "Repite tu contraseña", icono: Icon(Icons.lock)),
                ),
                /*

                BOTON CREAR CUENTA

                 */
                SizedBox(
                  height: 15,
                ),
                RaisedButton(
                  onPressed: (){
     if( _formKey.currentState.validate()){
       cli.createUser(email: email, password: password, username: user).then((value){
      if (value.success==true){
        showDialog(context: context,
                   );
      }   
       });
     }
     },

                  child: Text("Crear cuenta"),

                ),
              ],
            ),
          ),
          ),
        ),
      ),
    ),
    );
  }
}