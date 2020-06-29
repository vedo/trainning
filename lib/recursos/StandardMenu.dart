import 'package:flutter/material.dart';
import 'package:trainning/recursos/constant.dart';

class StandardMenu extends StatelessWidget {
  
  final Widget contenido;
  final bool showMenus;
  final bool showAppBar;
  final bool showMenu;
  final bool showBottomBar;
  final bool backGroundImage;
  final String appBarTitle;

  StandardMenu({
    this.contenido, 
    this.showMenus : true,
    this.showAppBar : true,
    this.showMenu : true,
    this.showBottomBar : true,
    this.backGroundImage : true,
    this.appBarTitle : 'hola!'
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/img/dibujo.png"),
            fit: BoxFit.cover,
          ),
        ),
  
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if ( this.showMenus ) ...[
              if ( this.showAppBar ) ...[
                CustomAppBar(titulo: this.appBarTitle),
              ],
              if ( this.showMenu ) ...[
                CustomMenu(),
              ],
              SizedBox(height: 0,),
            ]else ...[
              SizedBox(height: 350,),
            ],

            this.contenido,

            if( this.showMenus ) ...[
              CustomBottomBar()
            ]
          ],
        ),

      ),
    );
  }
}

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: bottomBarColor,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[

            Column(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.home),
                  onPressed: () {
                    Navigator.popAndPushNamed(context, '/MiTienda');
                  },
                  padding: EdgeInsets.all(0.0),
                ),
                Text("Mi Tienda")
              ],
            ),

            Column(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.map),
                  onPressed: () {
                    Navigator.popAndPushNamed(context, '/Mapa');
                  },
                ),
                Text("Mapa")
              ],
            ),

            Column(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.people),
                  onPressed: () {
                    Navigator.popAndPushNamed(context, '/ListaTiendas');
                  },
                ),
                Text("Lista")
              ],
            ),
          ],
        ),
      ),
    );
  }
} // Custom bottom bar

class CustomAppBar extends StatelessWidget {
  final String titulo;

  CustomAppBar({this.titulo});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      // AppBar
      padding: const EdgeInsets.only(top: 40.0, left: 20, right: 20),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {},
          ),
          Expanded(child: Center(child: Text(this.titulo))),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
        ],
      ),
    ));
  }
}

class CustomMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        // Menu
        padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
        child: Row(
          //Esta fila van a ser los menus
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              child: FlatButton(
                child: Text('Ventas'),
                onPressed: () {
                  Navigator.popAndPushNamed(context, '/MiTienda');
                },
              ),
            ),
            FlatButton(
              child: Text('Compras'),
              onPressed: () {
                Navigator.popAndPushNamed(context, '/Compras');
              },
            ),
            FlatButton(
              child: Text('Perfil'),
              onPressed: () {
                Navigator.popAndPushNamed(context, '/Perfil');
              },
            ),
          ],
        ),
      ),
    );
  }
}


