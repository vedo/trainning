import 'package:flutter/material.dart';

class MiTienda extends StatelessWidget {
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

                ButtonTheme(
                  minWidth: 150,
                  height: 40,
                  child: RaisedButton(
                    color: Color(0xFF5586A2),
                    onPressed: () {
                      Navigator.popAndPushNamed(context, '/MisAnuncios');
                    },
                    child: Text(
                      'Mis Anuncios', 
                      style: TextStyle(fontSize: 15, color: Colors.white)
                    ),
                  ),
                ),

                ButtonTheme(
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
              ],
            ),
            
            SizedBox(height: 10,),
  
            Text(
              "Ventas en proceso",
              style: TextStyle( fontSize: 20, color: Color(0xFFDAC8CF) ),
            ),

            Expanded(
              child: Container(
                child: ListView(
                  padding: EdgeInsets.only(right: 20, left: 20, top: 10),
                  children: <Widget>[
                    TarjetaProducto2(),
                    TarjetaProducto2(),
                    TarjetaProducto2(),
                    TarjetaProducto2(),
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

class TarjetaProducto2 extends StatelessWidget {
  const TarjetaProducto2({
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
              Text("En Proceso")
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
              "Ver"
            ),
          ),
        ),
      ],),
    );
  }
}