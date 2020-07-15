import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:trainning/recursos/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trainning/recursos/componentes.dart';

SharedPreferences sharedPreferences;

class PrimeraPantalla extends StatefulWidget {
  @override
  _PrimeraPantallaState createState() => _PrimeraPantallaState();
}

class _PrimeraPantallaState extends State<PrimeraPantalla> {
  
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
    checkPantalla();
  }

  loggedMove() async{
    if( await checkLogIn() ){
      Navigator.popAndPushNamed(context, "/Anuncios");
    }
  }

  checkPantalla() async{
    sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("primeraPantalla_check") == null ){
      showPopup(
        context: context,
        titulo: "Bienvenido!",
        contenido: [
          Image(image: AssetImage('assets/img/activistas.png')),
          Text("\nLa pandemia nos ha enseñado que necesitamos colaborar y cuidarnos como sociedad.\n"),
          Text("AlgoCerca es una empresa sin fines de lucro cuyo objetivo es crear herramietas útiles para vecinas y vecinos en todo Chile.\n"),
          Text("Si quieres saber más sobre como funcionamos puedes visitar nuestro portal algocerca.cl."),
        ]
      );
      sharedPreferences.setString("primeraPantalla_check", "ok");
    }
  }
  
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: imagenDeFondoLogin,
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
                    if ( logedIn.hasError )
                      return Text('Error: ${logedIn.error}');
                    else{
                      if( logedIn.data ){
                        return Container(); //Container vacío
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

  Widget formularioLogin(BuildContext context){
  return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.8,
        ),
        Container(
          width: 250,
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.all(0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(100),
            color: Colors.transparent,
          ),
          child: FlatButton(
            onPressed: (){
              Navigator.pushNamed(context, "/LogIn");
            },
            child: Text(
              "Iniciar Sesión",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        ),

        SizedBox(height: 25,),
        Container(
          width: 250,
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.all(0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.white,
          ),
          child: FlatButton(
            onPressed: (){
              Navigator.pushNamed(context, "/CreateUser");
            },
            child: Text(
              "Crear una Cuenta",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        ),

        /* Botones facebook y google */
        SizedBox(height: 50,),
          Text(
            "O conectate con",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              BotonIcono(icono: FaIcon(FontAwesomeIcons.google, color: Colors.white, size: 18,), ancho: 120, color: Color(0xFFE05959), texto: "Google", onPressed: (){},),
              SizedBox(width: 10,),
              BotonIcono(icono: FaIcon(FontAwesomeIcons.facebookF, color: Colors.white, size: 18,), ancho: 120, color: Color(0xFF5C5DAD), texto: " Facebook", onPressed: (){},),
            ],
          )
      ],
    );
  }  
}

class BotonIcono extends StatelessWidget {
  final String texto;
  final Color color;
  final Function onPressed;
  final double ancho;
  final FaIcon icono;
  
  BotonIcono({
    this.texto,
    this.color,
    this.onPressed,
    this.ancho,
    this.icono,
  });
  
  @override
  Widget build(BuildContext context) {
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
            this.icono,
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
}

