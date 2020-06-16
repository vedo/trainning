import 'package:flutter/material.dart';
import 'package:trainning/recursos/constant.dart';

class MisAnuncios extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(

      child: Center(

        child: Column(
          children: <Widget>[
            SizedBox(height: 20,),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[

                ButtonTheme( //Botón Historial de Ventas
                  minWidth: 150,
                  height: 40,
                  child: RaisedButton(
                    color: Color(0xFF5586A2),
                    onPressed: () {
                      Navigator.popAndPushNamed(context, '/HistorialVentas');
                    },
                    child: Text(
                      'Historial de Ventas', 
                      style: TextStyle(fontSize: 15, color: Colors.white)
                    ),
                  ),
                ),

                ButtonTheme( // Botón ventas en proceso -> Mi tienda
                  minWidth: 150,
                  height: 40,
                  child: RaisedButton(
                    color: Color(0xFF5586A2),
                    onPressed: () {
                      Navigator.popAndPushNamed(context, '/MiTienda');
                    },
                    child: Text(
                      'Ventas en proceso', 
                      style: TextStyle(fontSize: 15, color: Colors.white)
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 10,),

            Text(
              "Mis Anuncios",
              style: TextStyle( fontSize: 20, color: Color(0xFFDAC8CF) ),
            ),
            
            SizedBox(height: 10,),

            ButtonTheme(
              minWidth: 150,
              height: 40,
              child: RaisedButton(
                color: buttonGreen,
                onPressed: () {
                  Navigator.popAndPushNamed(context, '/CrearAnuncio');
                },
                child: Text(
                  'Crear Anuncio', 
                  style: TextStyle(fontSize: 15, color: Colors.white)
                ),
              ),
            ),

            Expanded(
              child: Container(
                child: ListView(
                  padding: EdgeInsets.only(right: 20, left: 20, top: 10),
                  children: <Widget>[
                    TarjetaAnuncio(),
                    TarjetaAnuncio(),
                    TarjetaAnuncio(),
                    TarjetaAnuncio(),
                  ],
                ),
              ),
            )

            
          ],
        ),
      ),
    );
  }
}

class TarjetaAnuncio extends StatelessWidget {

  const TarjetaAnuncio({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      height: 150,
      child: Stack(children: <Widget>[
        
        FractionallySizedBox(
          widthFactor: 0.8,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey,
            ),
          ),
        ),

        Align(
          alignment: Alignment.centerRight,
          child: FractionallySizedBox(
              widthFactor: 0.5,
              heightFactor: 0.9,
              child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.lightBlue[200],
              ),
            ),
          ),
        ),
    

        Positioned(
          top: 10,
          left: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[          
              Text("08/06/2020"),
              Text("Pie de limón"),
              Text("\$5.690"),
              Text("Visto por: 40")
            ],
          ),
        ),

       
        Positioned(
          left: 0,
          bottom: 0,
          child: FlatButton(
            padding: EdgeInsets.zero,
            onPressed: (){
              Navigator.pushNamed(context, '/DetalleProducto',);
            },
            child: Text(
              "Editar"
            ),
          ),
        ),
      ],),
    );
  }
}