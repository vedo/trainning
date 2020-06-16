import 'package:flutter/material.dart';

class ProfileMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: ListView(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              
              Text(
                "Edita tu cuenta",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),

              SizedBox(height: 10,),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RoundedEditButton(
                    icono: Icon(Icons.person),
                  ),

                  RoundedEditButton(
                    icono: Icon(Icons.home),
                  ),
                ],
              ),

              SizedBox(height: 10,),
              TitledTextField(
                titulo: "Nombre",
                valor: "Víctor Diaz",
              ),

              SizedBox(height: 10,),
              TitledTextField(
                titulo: "Apellidos",
                valor: "Díaz Osorio",
              ),

              SizedBox(height: 10,),
              TitledTextField(
                titulo: "Número de teléfono",
                valor: "+56 9 82287003",
              ),

              SizedBox(height: 10,),
              TitledTextField(
                titulo: "Correo Electrónico",
                valor: "victor.diazosorio@gmail.com",
              ),

              SizedBox(height: 10,),
              TitledTextField(
                titulo: "Contraseña",
                valor: "********",
              ),
              
            ],
          )
        ),
      ),
    );
  }
}

class TitledTextField extends StatelessWidget {
  final String titulo;
  final String valor;
  const TitledTextField({
    Key key,
    this.titulo,
    this.valor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            this.titulo,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 18,
            ),
          ),
          Text(
            this.valor,
            style: TextStyle(
              fontSize: 20,
            ),
          )
        ],
      ),
    );
  }
}

class RoundedEditButton extends StatelessWidget {
  final Icon icono;
  final Color color;
  
  const RoundedEditButton({
    Key key,
    this.icono,
    this.color : Colors.blue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      child: FlatButton(
        padding: EdgeInsets.zero,

        onPressed: (){},
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: this.color,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: this.icono,
              ),
            ),

            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Icon(Icons.edit, size: 15,)
              ),
            ),
          ],
        ),
      ),
    );
  }
}