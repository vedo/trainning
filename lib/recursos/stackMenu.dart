import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trainning/recursos/constant.dart';
import 'package:trainning/recursos/navigationBars.dart';

SharedPreferences sharedPreferences;

class StandardMenu extends StatelessWidget {

  final Widget contenido;
  final String menuType;
  final String appBarTitle;
  final int menuIndex;

  StandardMenu({
    this.contenido,
    this.menuType: "full",
    this.appBarTitle,
    this.menuIndex,
  });

  @override
  Widget build(BuildContext context) {
    if(this.menuType == "full"){
      return FullBodyMenu(appBarTitle: this.appBarTitle, contenido: this.contenido, menuIndex: this.menuIndex);
    }else if( this.menuType == "topBottom"){
      return TopBottomMenu(appBarTitle: this.appBarTitle, contenido: this.contenido);
    }else{ //empty
      return MiScaffold(listaDeWidgets: <Widget>[this.contenido],);
    }
  }
}

class TopBottomMenu extends StatelessWidget {
  final String appBarTitle;
  final Widget contenido;
  const TopBottomMenu({
    @required this.appBarTitle,
    @required this.contenido,
  });
  @override
  Widget build(BuildContext context) {
    List<Widget> listaDeWidgets = [
      this.contenido,
      ClipPath(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 100,
          decoration: BoxDecoration(
            gradient: gradienteAzulDiagonal,
          ),
        ),
        clipper: CustomClipPath(),
      ),
      CustomAppBar(titulo: this.appBarTitle),
      CustomBottomBar()
    ];
    return MiScaffold(listaDeWidgets: listaDeWidgets,);
  }
}

class FullBodyMenu extends StatelessWidget {
  final String appBarTitle;
  final Widget contenido;
  final int menuIndex;
  const FullBodyMenu({
    this.appBarTitle,
    this.contenido,
    this.menuIndex,
  });
  @override
  Widget build(BuildContext context) {
    List<Widget> listaDeWidgets = [ // Lista de widgets que se entrega como parámetro a MiScaffold
      this.contenido,
      ClipPath(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 130,
          decoration: BoxDecoration(
            gradient: gradienteAzulDiagonal,
          ),
        ),
        clipper: CustomClipPath(),
      ),
      CustomAppBar(titulo: this.appBarTitle),
      CustomMenu(menuIndex: this.menuIndex),
      CustomBottomBar(),
    ];
    return MiScaffold(listaDeWidgets: listaDeWidgets,);
  }
}

class CustomClipPath extends CustomClipper<Path> {
  var r = 15.0;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - r);
    path.quadraticBezierTo(size.width/4, size.height, size.width/2, size.height - r );
    path.quadraticBezierTo(3/4*size.width, size.height - 2*r, size.width, size.height - r);
    path.lineTo(size.width, 0);
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class MiScaffold extends StatefulWidget {
  const MiScaffold({
    Key key,
    this.listaDeWidgets,
  }) : super(key: key);
  final List<Widget> listaDeWidgets;
  @override
  _MiScaffoldState createState() => _MiScaffoldState();
}

class _MiScaffoldState extends State<MiScaffold> {
  //static final List<String> drawerMenu = ["Mi Perfil", "Mis Anuncios", "Pedidos", "Mis Compras", "Mapa de la ciudad", "Mercado", "Mi Barrio"];
  //static final List<IconData> drawerIcons = [Icons.face, Icons.shopping_cart, Icons.laptop, Icons.laptop, Icons.laptop, Icons.laptop, Icons.laptop];
  
  destroySession() async{
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    Navigator.popAndPushNamed(context, '/');
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Mi Perfil',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.face),
              title: Text('Mi Perfil'),
              onTap: (){ Navigator.popAndPushNamed(context, "/Perfil");},
            ),
            ListTile(
              leading: Icon(Icons.record_voice_over),
              title: Text('Mis Anuncios'),
              onTap: (){ Navigator.popAndPushNamed(context, "/Anuncios");},
            ),
            ListTile(
              leading: Icon(Icons.ring_volume),
              title: Text('Pedidos'),
              onTap: (){ Navigator.popAndPushNamed(context, "/Pedidos");},
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text('Mis Compras'),
              onTap: (){ Navigator.popAndPushNamed(context, "/Compras");},
            ),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text('Mapa de la ciudad'),
              onTap: (){ Navigator.popAndPushNamed(context, "/Mapa");},
            ),
            ListTile(
              leading: Icon(Icons.shopping_basket),
              title: Text('Mercado'),
              onTap: (){ Navigator.popAndPushNamed(context, "/Mercado");},
            ),
            ListTile(
              leading: Icon(Icons.supervised_user_circle),
              title: Text('Mi Barrio'),
              onTap: (){ Navigator.popAndPushNamed(context, "/MiBarrio");},
            ),
            /* ListTile(
              leading: Icon(Icons.settings),
              title: Text('Ajustes'),
            ), */
            ListTile(
              leading: Icon(Icons.power_settings_new),
              title: Text('Cerrar Sesión'),
              onTap: (){destroySession();},
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text('Ayuda'),
            ),
          ] ,
        ),
      ),

      body: SafeArea(
        child: Container(
          decoration: imagenDeFondo,
          child: Stack(
            children: this.widget.listaDeWidgets
          ),
        ),
      ),
    );
  }
}

// INTENTO DE ENLISTAR LOS MENUS DEL DRAWER
/* final Iterable<Widget> menus = drawerMenu.map((titulo){
  int index = drawerMenu.indexOf(titulo);
  return ListTile(
    leading: Icon(drawerIcons[index]),
    title: Text(titulo),
  );
});
List<Widget> dHeader = [
  DrawerHeader(
    decoration: BoxDecoration(
      color: Colors.blue,
    ),
    child: Text(
      'Drawer Header',
      style: TextStyle(
        color: Colors.white,
        fontSize: 24,
      ),
    ),
  ),]; */