import 'package:flutter/material.dart';
import 'package:trainning/recursos/constant.dart';

class CustomBottomBar extends StatelessWidget {
  final List<Icon> iconos = [Icon(Icons.home), Icon(Icons.map), Icon(Icons.shopping_basket), Icon(Icons.people)];
  final List<String> textos = ["Mi Tienda","Mapa","Mercado","Mi Barrio",];
  final List<String> enlaces = ["/Anuncios","/Mapa","/ListaTiendas","/ListaTiendas",];
  
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          gradient: gradienteAzul,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: textos.map((nombreBoton) {
            int index = textos.indexOf(nombreBoton);
            return Column(
              children: <Widget>[
                IconButton(
                  icon: iconos[index],
                  onPressed: () {
                    Navigator.popAndPushNamed(context, enlaces[index]);
                  },
                ),
                Text(nombreBoton)
              ],
            );
          }).toList()
        ),
      ),
    );
  }
}// Custom bottom bar

class CustomMenu extends StatelessWidget {
  static TextStyle selectedStyle = TextStyle(color: Colors.white, fontWeight: FontWeight.bold,);
  static TextStyle unselectedStyle = TextStyle(color: Colors.black);
  static List<String> titulos = ["Anuncios", "Pedidos", "Compras"];
  final int menuIndex;
  const CustomMenu({
    this.menuIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 60,
      left: 0,
      child: Container(
        width: MediaQuery.of(context).copyWith().size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: titulos.map((titulo){
            int index = titulos.indexOf(titulo);
            TextStyle estilo = (index == this.menuIndex) ? selectedStyle : unselectedStyle;
            return FlatButton( // Botón anuncios
              onPressed: (){
                Navigator.popAndPushNamed(context, '/' + titulo,);
              },
              child: Text(
                titulo,
                style: estilo,
              ),
            ); 
          }).toList()
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  final List<IconData> iconosAppbar = [Icons.search, Icons.notifications];
  final List<VoidCallback> accionesIconos = [(){},(){},];
  final String titulo;
  CustomAppBar({
    this.titulo,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text(this.titulo),
          actions: iconosAppbar.map((icono) {
            int index = iconosAppbar.indexOf(icono);
            return IconButton(
              icon: Icon(icono),
              onPressed: accionesIconos[index],
            );
          }).toList()        
        ),
    );
  }
}