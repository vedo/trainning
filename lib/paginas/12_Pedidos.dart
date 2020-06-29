import 'package:flutter/material.dart';
import 'package:trainning/recursos/constant.dart';
import 'package:trainning/recursos/tarjetas.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Pedidos extends StatefulWidget {
  @override
  _PedidosState createState() => _PedidosState();
}

class _PedidosState extends State<Pedidos> {
  static int selectedIndex = 0;
  static final CarouselController _controller = CarouselController();
  final BoxDecoration selectedDecoration = BoxDecoration(gradient: gradientenNaranjoDiagonal,borderRadius: BorderRadius.circular(100),);
  final BoxDecoration unselectedDecoration = BoxDecoration();
  final List<String> titulosSlider = ["Ventas en Proceso", "Historial de Ventas"];
  final List<VoidCallback> llamadas = [() {_controller.previousPage();}, () {_controller.nextPage();}];

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Container(
      child: Stack(
        children: <Widget>[
          
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 50,
              margin: EdgeInsets.only(top: topPadding, left: 20, right: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey.withOpacity(0.7),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: titulosSlider.map((titulo){
                  int index = titulosSlider.indexOf(titulo);
                  BoxDecoration decoration = index == selectedIndex ? selectedDecoration : unselectedDecoration;
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.center,
                    child: FlatButton(
                      onPressed: this.llamadas[index],
                      child: Text(titulo)
                    ),
                    decoration: decoration,
                  );
                }).toList(), 
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: topPadding + 80),
            child: CarouselSlider(
              options: CarouselOptions(
                height: height,
                viewportFraction: 1.0,
                enlargeCenterPage: false,
                enableInfiniteScroll: false,
                onPageChanged: (i,reason){
                  setState(() {
                    selectedIndex = 1 - selectedIndex;
                  });
                },
              ),
              carouselController: _controller,
              items: [
                CarrouselItem(titulo: "Ventas en Proceso",),
                CarrouselItem(titulo: "Historial de Ventas",),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CarrouselItem extends StatelessWidget {
  final String titulo;
  const CarrouselItem({
    Key key,
    this.titulo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Titulo1(titulo: this.titulo,),
          SizedBox(height: 20,),
          Expanded(
            child: Container(
              child: ListView(
                padding: EdgeInsets.only(right: 20, left: 20, top: 10),
                children: <Widget>[
                  Tarjeta2( buttonText: "ver", cuerpo: <Widget>[
                    Text("08/06/2020"),
                    Text("Pie de limón (x2)"),
                    Text("\$5.690"),
                    Text("Realizada")
                  ],),
                  Tarjeta2( buttonText: "ver", cuerpo: <Widget>[
                    Text("08/06/2020"),
                    Text("Pie de limón (x2)"),
                    Text("\$5.690"),
                    Text("Realizada")
                  ],),
                  Tarjeta2( buttonText: "ver", cuerpo: <Widget>[
                    Text("08/06/2020"),
                    Text("Pie de limón (x2)"),
                    Text("\$5.690"),
                    Text("Realizada")
                  ],),
                  Tarjeta2( buttonText: "ver", cuerpo: <Widget>[
                    Text("08/06/2020"),
                    Text("Pie de limón (x2)"),
                    Text("\$5.690"),
                    Text("Realizada")
                  ],),
                ],
              ),
            ),
          )

        ],
      ),
    );
  }
}
