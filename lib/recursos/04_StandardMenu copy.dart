import 'package:flutter/material.dart';
import 'package:trainning/constant.dart';

class StandardMenu extends StatelessWidget {
  final Widget contenido;
  final bool showMenus;
  final bool showAppBar;
  final bool showMenu;
  final bool showBottomBar;
  final bool backGroundImage;

  StandardMenu({
    this.contenido,
    this.showMenus: true,
    this.showAppBar: true,
    this.showMenu: true,
    this.showBottomBar: true,
    this.backGroundImage: true,
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
        child: Stack(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (this.showMenus) ...[
              if (this.showAppBar) ...[
                CustomAppBar(titulo: 'Tiendas'),
              ],
              if (this.showMenu) ...[
                CustomMenu(),
              ],
              SizedBox(
                height: 160,
              ),
            ] else ...[
              SizedBox(
                height: 350,
              ),
            ],
            Align(
              alignment: Alignment.bottomCenter,
              child: FractionallySizedBox(
                  heightFactor: 0.57, child: this.contenido),
            ),
            if (this.showMenus && this.showBottomBar) ...[CustomBottomBar()]
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
                  icon: Icon(Icons.android),
                  onPressed: () {
                    Navigator.popAndPushNamed(context, '/ListaTiendas');
                  },
                ),
                Text("Holi")
              ],
            ),

          ],
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  final String titulo;

  CustomAppBar({this.titulo});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 0, left: 20, right: 20),
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
        )
    );
  }
}

class CustomMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        // Menu
        padding: const EdgeInsets.only(top: 30.0, bottom: 10.0),
        child: Row(
          //Esta fila van a ser los menus
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text('Ventas'),
            Text('Compras'),
            Text('Perfil'),
          ],
        ),
      ),
    );
  }
}

class CustomBottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
