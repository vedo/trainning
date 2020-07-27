import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:trainning/recursos/constant.dart';
import 'package:trainning/recursos/tarjetas.dart';

/* Diálogo de pop up que se muestra en las pantallas la primera vez que se visualiza */
void showPopup({BuildContext context, String titulo, List<Widget> contenido, String textoBoton = "Entendido!"}) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: titulo != null ? Text(titulo) : null,
        content: SingleChildScrollView(
          child: ListBody(
            children: contenido
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(textoBoton),
            onPressed: () { Navigator.of(context).pop(); },
          ),
        ],
      )
  );
}


/* Botón de color degradado con título encima */
FlatButton botonCentral({BuildContext context, String titulo, Function accion}){
  return FlatButton(
    onPressed: accion,
    child: Column(
      children: <Widget>[
        Text(titulo, style: TextStyle(color: gradientYellow),),
        Container(
          height: 40,
          width: 40,
          child: Center(child: Icon(Icons.add, color: Colors.white,)),
          decoration: BoxDecoration(
            gradient: gradientenNaranjoDiagonal,
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ],
    ),
  );
}

class TituloConLineas extends StatelessWidget {
  final String titulo;
  const TituloConLineas({
    this.titulo,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          height: 1,
          width: 90,
          color: gradientBlue,
        ),
        Text(
          this.titulo,
          style: TextStyle( fontSize: 20, color: gradientBlue, fontWeight: FontWeight.bold ),
        ),
        Container(
          height: 1,
          width: 90,
          color: gradientBlue,
        ),
      ],
    );
  }
}


/* Página de carrusel con dos pantallas, se usa en "/Pedidos" y "/MiBarrio" */
class CarruselDeDosPantallas extends StatefulWidget {
  final Widget pantalla1;
  final Widget pantalla2;
  final String titulo1;
  final String titulo2;
  const CarruselDeDosPantallas ({ 
    Key key, 
    this.pantalla1,
    this.pantalla2,
    this.titulo1,
    this.titulo2,
  }): super(key: key);

  @override
  _CarruselDeDosPantallasState createState() => _CarruselDeDosPantallasState();
}

class _CarruselDeDosPantallasState extends State<CarruselDeDosPantallas> {
  static int selectedIndex = 0;
  static final CarouselController _controller = CarouselController();
  final BoxDecoration selectedDecoration = BoxDecoration(gradient: gradientenNaranjoDiagonal,borderRadius: BorderRadius.circular(100),);
  final BoxDecoration unselectedDecoration = BoxDecoration();
  final List<VoidCallback> llamadas = [() {_controller.previousPage();}, () {_controller.nextPage();}];

  @override
  Widget build(BuildContext context) {
    final List<String> titulosSlider = [widget.titulo1, widget.titulo2];
    final double altoPagina = MediaQuery.of(context).size.height;
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
                height: altoPagina,
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
                widget.pantalla1,
                widget.pantalla2,
              ],
            ),
          ),
        ],
      ),
    );
  }
}


/* Página de maqueta con componentes título con linea y listado de Tarjetas 2 
 Lo estoy usando hasta ahora en Pedidos y Mi Barrio 
 Se construyó en conjunto con el carrusel, por lo que sirve de plantilla para usarlo 
 como parámetros de pantalla 1 y 2 de objeto carrusel de dos pantallas
*/
class ExampleCardList extends StatelessWidget {
  final List<int> pedidos = [1];
  final String titulo;
  
  ExampleCardList({
    Key key,
    this.titulo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          TituloConLineas(titulo: this.titulo,),
          SizedBox(height: 20,),
          Expanded(
            child: Container(
              child: ListView(
                padding: EdgeInsets.only(right: 20, left: 20, top: 10),
                children: this.pedidos.map( (nro) {
                  return Tarjeta2( buttonText: "ver", cuerpo: <Widget>[
                    Text("08/06/2020"),
                    Text("Pie de limón (x2)"),
                    Text("\$5.690"),
                    Text("Realizada")
                  ],);
                }).toList() 
              ),
            ),
          )
        ],
      ),
    );
  }
}

/* Llamadas futuras */
class FutureServerCall extends StatelessWidget {
  final Future<dynamic> llamadaCliente;
  final Function completedCallWidgetFunction;
  const FutureServerCall({
    Key key,
    this.llamadaCliente,
    this.completedCallWidgetFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: this.llamadaCliente,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return SpinKitThreeBounce(
              color: gradientBlue,
              size: 50.0,
            );
          default:
            if (snapshot.hasError){
              showPopup(
                titulo: "Error",
                contenido: <Widget>[Text("$snapshot.error")]
              );
              return Container();
            }else{
              return this.completedCallWidgetFunction(context, snapshot);
            }
        } 
      },
    );
  }
} 

