import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:trainning/recursos/constant.dart';


final double buttonWidth = 250;
final double buttonHeight = 40;

class LogInMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 120.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ButtonTheme(
              minWidth: buttonWidth,
              height: buttonHeight,
              child: RaisedButton(
                color: buttonGreen,
                onPressed: () {
                  Navigator.popAndPushNamed(context, '/CreateUser');
                },
                child: Text(
                  'Crear cuenta', 
                  style: TextStyle(fontSize: 20)
                ),
              ),
            ),
            
            Container(
              width: buttonWidth,
              height: buttonHeight,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Correo electrónico',
                ),
              ),
            ),
            
            Container(
              width: buttonWidth,
              height: buttonHeight,
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Contraseña',
                ),
              ),
            ),
            
            ButtonTheme(
              minWidth: buttonWidth,
              height: buttonHeight,
              child: RaisedButton(
                color: Color(0xFF15A1CA),
                onPressed: () {
                  Navigator.popAndPushNamed(context, '/Anuncios');
                },
                child: Text(
                  'Entrar', 
                  style: TextStyle(fontSize: 20)
                ),
              ),
            ),
            
            Text('¿Olvidaste tu contraseña?'),
            
            SizedBox(height: 20,),
            
            ButtonTheme(
              minWidth: buttonWidth,
              height: buttonHeight,
              child: RaisedButton(
                color: Color(0xFFE05959),
                onPressed: () {},
                child: Text(
                  'Inicia con Google', 
                  style: TextStyle(fontSize: 20)
                ),
              ),
            ),
            ButtonTheme(
              minWidth: buttonWidth,
              height: buttonHeight,
              child: RaisedButton(
                color: Color(0xFF5C5DAD),
                onPressed: () {},
                child: Text(
                  'Inicia con Facebook', 
                  style: TextStyle(fontSize: 20)
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}