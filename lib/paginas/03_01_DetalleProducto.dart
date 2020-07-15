import 'package:flutter/material.dart';
import 'package:trainning/recursos/ScreenArgument.dart';
import 'package:trainning/recursos/componentes.dart';
import 'package:trainning/recursos/constant.dart';
import 'package:trainning/recursos/client.dart';
import 'package:url_launcher/url_launcher.dart';

class DetalleProducto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenArguments args = ModalRoute.of(context).settings.arguments;
    String idProducto = args.id;
    return Container( // Lista de tinedas 
      padding: EdgeInsets.only(top: topPadding, left: 15, right: 15),
      child: FutureServerCall(
        llamadaCliente: cliente.getDetailProduct( idProducto ),
        completedCallWidgetFunction: construirPaginaDetalleProducto,
      ),
    );
  }
}

Widget construirPaginaDetalleProducto(BuildContext context, AsyncSnapshot snapshot) {
  //print(snapshot.toString());
  final data = snapshot.data;
  return Container(
    child: ListView(children: <Widget>[
      Text("Vendor name (id x ahora) :" + data["vendor"].toString()),
      Text(data["store_name"].toString()),
      Text(data["name"].toString()),
      Text(data["short_description"].toString()),
      Text("Precio: \$" + data["price"].toString()),
      Text("Nota: " + data["average_rating"].toString()),
      Text("Cantidad de revisiones: " + data["rating_count"].toString()),
      FlatButton(
        child: Text("Deja un comentario") ,
        onPressed: (){},
      ),
      FlatButton(
        child: Text("Enviar whatsapp") ,
        onPressed: (){
        },
      ),
      FlatButton(
        child: Text("Enviar mensaje de texto") ,
        onPressed: (){
        },
      ),
      FlatButton(
        child: Text("Llamar") ,
        onPressed: (){
        },
      ),
    ],)
  );
} // construir
  
/* Maqueta de como quiero que se vea la página */
Widget maquetaEditarProducto(){
  return Container(
    child: ListView(
      children: 
      <Widget>[
        TituloValor(
          titulo: "Pie de limón \$5.690:",
          valor: "Vendido el 01/06/2020",
          colorValor: null,
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

/* Elemento gráfico usado arriba */
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