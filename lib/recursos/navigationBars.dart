import 'package:flutter/material.dart';
import 'package:trainning/recursos/constant.dart';



/* Menú de que se muestra en la pantalla mi tienda */
/* Muestra Anuncios, Pedidos y Compras */
/* Se localiza debajo del App bar */
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
              onPressed: (){  Navigator.popAndPushNamed(context, '/' + titulo,);  },
              child: Text(  titulo,  style: estilo,  ),
            ); 
          }).toList()
        ),
      ),
    );
  }
} // Custom menu

/* App bar de la aplicación */
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
          title: Text( this.titulo ),
          actions: this.iconosAppbar.map( (icono) {
            int index = iconosAppbar.indexOf(icono);
            return IconButton( icon: Icon(icono), onPressed: this.accionesIconos[index], );
          }).toList()        
        ),
    );
  }
} // Custom appbar

/* Bottom bar de la aplicación */
/* PENDIENTE: Que el item seleccionado se mueste de otro color */
/* PENDIENTE: Que se quede abajo y que no interrumpa el scroll: solución posible, que sea realmente un bottom bar */
class CustomBottomBar extends StatelessWidget {
  final List<Icon> iconos = [Icon(Icons.home), Icon(Icons.map), Icon(Icons.shopping_basket), Icon(Icons.people)];
  final List<String> textos = ["Mi Tienda","Mapa","Mercado","Mi Barrio",];
  final List<String> enlaces = ["/Anuncios","/Mapa","/Mercado","/MiBarrio",];
  
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      //bottom: 0,
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          gradient: gradienteAzul,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: this.textos.map( (nombreBoton) {
            int index = textos.indexOf(nombreBoton);
            return Column(
              children: <Widget>[
                IconButton(
                  icon: this.iconos[index],
                  onPressed: () {  Navigator.popAndPushNamed(context, this.enlaces[index]);  },
                ),
                Text( nombreBoton )
              ],
            );
          }).toList()
        ),
      ),
    );
  }
} // Bottom bar

class NewBottomBar extends StatefulWidget {
  @override
  _NewBottomBarState createState() => _NewBottomBarState();
}

class _NewBottomBarState extends State<NewBottomBar> {
  final List<Icon> iconos = [Icon(Icons.home), Icon(Icons.map), Icon(Icons.shopping_basket), Icon(Icons.people)];
  final List<String> textos = ["Mi Tienda","Mapa","Mercado","Mi Barrio",];
  final List<String> enlaces = ["/Anuncios","/Mapa","/Mercado","/MiBarrio",];

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        items: this.textos.map( (nombreBoton) {
            int index = textos.indexOf(nombreBoton);
            return BottomNavigationBarItem(
              icon: this.iconos[index],
              title: Text(nombreBoton),
            );
          }).toList(),
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      );
  }
}