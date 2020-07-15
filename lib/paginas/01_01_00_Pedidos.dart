import 'package:flutter/material.dart';
import 'package:trainning/recursos/componentes.dart';

class Pedidos extends StatefulWidget {
  @override
  _PedidosState createState() => _PedidosState();
}

class _PedidosState extends State<Pedidos> {
  @override
  Widget build(BuildContext context) {
    return CarruselDeDosPantallas(
      pantalla1: ExampleCardList(titulo: "Ventas en proceso",),
      pantalla2: ExampleCardList(titulo: "Historial de ventas",),
      titulo1: "Ventas en proceso",
      titulo2: "Historial de ventas"
    );
  }
}


