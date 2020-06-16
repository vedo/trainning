import 'package:flutter/material.dart';

class Compras extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(

      child: Center(

        child: Column(
          children: <Widget>[
            SizedBox(height: 10,),
            
            Expanded(
              child: Container(
                child: ListView(
                  padding: EdgeInsets.only(right: 20, left: 20, top: 10),
                  children: <Widget>[
                    TarjetaCompras(),
                    TarjetaCompras(),
                    TarjetaCompras(),
                    TarjetaCompras(),
                    TarjetaCompras(),
                    TarjetaCompras(),
                    TarjetaCompras(),
                    TarjetaCompras(),
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

class TarjetaCompras extends StatelessWidget {
  const TarjetaCompras({
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
              Text("Pie de limón (x2)"),
              Text("\$5.690"),
              Text("Realizada")
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