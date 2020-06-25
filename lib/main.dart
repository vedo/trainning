import 'package:flutter/material.dart';
import 'package:trainning/paginas/11_CreateUser.dart';
import 'package:trainning/paginas/imagePick.dart';
import 'package:trainning/recursos/StandardMenu.dart';
import 'package:trainning/paginas/00_LogIn.dart';
import 'package:trainning/paginas/01_Stores.dart';
import 'package:trainning/paginas/02_Map.dart';
import 'package:trainning/paginas/03_MiTienda.dart';
import 'package:trainning/paginas/04_EditarPerfil.dart';
import 'package:trainning/paginas/05_MisAnuncios.dart';
import 'package:trainning/paginas/06_HistorialVentas.dart';
import 'package:trainning/paginas/07_CrearAnuncio.dart';
import 'package:trainning/paginas/08_Compras.dart';
import 'package:trainning/paginas/09_DetalleProducto.dart';

void main(){
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/':                (context) => StandardMenu( contenido:LogInMenu(),         showMenus: false,),
        '/CreateUser':      (context) => CreateUser(),
        '/MiTienda':        (context) => StandardMenu( contenido: MiTienda(),         appBarTitle: 'Mi Tienda',),
        '/ListaTiendas':    (context) => StandardMenu( contenido: StoreList(),        appBarTitle: 'Lista de Tiendas',),
        '/Mapa':            (context) => StandardMenu( contenido: PantallaMaps(),     appBarTitle: 'Mapa del Barrio',),
        '/MisAnuncios':     (context) => StandardMenu( contenido: MisAnuncios(),      appBarTitle: 'Mis Anuncios',),
        '/HistorialVentas': (context) => StandardMenu( contenido: HistorialVentas(),  appBarTitle: 'Historial de Ventas',),
        '/CrearAnuncio':    (context) => StandardMenu( contenido: CrearAnuncio(),     appBarTitle: 'CrearAnuncio',),
        '/Compras':         (context) => StandardMenu( contenido: Compras(),          appBarTitle: 'Compras',),
        '/Perfil':          (context) => StandardMenu( contenido: ProfileMenu(),      appBarTitle: 'Mi Perfil',),
        '/DetalleProducto': (context) => StandardMenu( contenido: DetalleProducto(),  appBarTitle: 'Detalle Producto',),
        '/imagePick':       (context) => StandardMenu( contenido: ImagePick(),        appBarTitle: 'Selecciona la imagen',),
      },
    )
  );
}

class Vecci extends StatelessWidget {
  final Widget home;

  Vecci({this.home});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vecci',
      home: this.home,
      debugShowCheckedModeBanner: false,
    );
  }
  
}
