import 'package:flutter/material.dart';
import 'package:trainning/recursos/constant.dart';


class DetalleProducto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: topPadding, left: 15, right: 15),
      child: ListView(
        children: <Widget>[

          TituloValor(
            titulo: "Pie de limón \$5.690:",
            valor: "Vendido el 01/06/2020",
          ),
          TituloValor(
            titulo: "Estado de la venta:",
            valor: "En proceso",
          ),
          TituloValor(
            titulo: "Modalidad de pago:",
            valor: "Pagado",
            colorValor: Colors.green,
          ),
          TituloValor(
            titulo: "Modalidad de entrega:",
            valor: "Delivery",
          ),
          TituloValor(
            titulo: "Estado de la entrega:",
            valor: "Pendiente, plazo hasta el 02/06/2020 15:00",
          ),
          Text( // Titulo
            "Comprador/a:",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          
          SizedBox(height: 3,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Juan Perez"),
                  Text(
                    "0.9 km de dist",
                    style: TextStyle(color: Colors.green),
                  )
                ],
              ),

              FlatButton.icon(onPressed: (){}, icon: Icon(Icons.phone), label: Text("Lamar")),
              FlatButton.icon(onPressed: (){}, icon: Icon(Icons.mail), label: Text("Escribir")),
            ],
          ),

          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FlatButton(
                padding: EdgeInsets.zero,
                onPressed: (){},
                child: Container(
                  height: 40,
                  width: 150,
                  decoration: BoxDecoration(
                    color: buttonRed,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      offset: Offset(2, 2), // changes position of shadow
                    )]
                  ),
                  child: Center(child: Text("Cancelar venta")),
                ),
              ),
              FlatButton(
                padding: EdgeInsets.zero,
                onPressed: (){},
                child: Container(
                  height: 40,
                  width: 150,
                  decoration: BoxDecoration(
                    color: buttonRed,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      offset: Offset(2, 2), // changes position of shadow
                    )]
                  ),
                  child: Center(child: Text("Tuve un problema")),
                ),
              ),
            ],
          ),
          SizedBox(height: 20,)
        ],
      ),
    );
  }
}

class TituloValor extends StatelessWidget {
  final String titulo;
  final String valor;
  final bool sinValor;
  final Color colorValor;
  
  const TituloValor({
    Key key,
    this.titulo,
    this.valor,
    this.sinValor : false,
    this.colorValor : Colors.yellow
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        
        Text( // Titulo
          this.titulo,
          style: TextStyle(
            fontSize: 20,
          ),
        ),

        Text( // Valor
          this.valor,
          style: TextStyle(
            color: this.colorValor,
          ),
        ),
        SizedBox( height: 10,),
      ],
    );
  }


}