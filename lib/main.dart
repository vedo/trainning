import 'package:flutter/material.dart';
import 'package:trainning/paginas/11_CreateUser.dart';
import 'package:trainning/paginas/imagePick.dart';
import 'package:trainning/recursos/stackMenu.dart';
import 'package:trainning/paginas/00_LogIn.dart';
import 'package:trainning/paginas/01_Stores.dart';
import 'package:trainning/paginas/02_Map.dart';
import 'package:trainning/paginas/03_VentasEnProceso.dart';
import 'package:trainning/paginas/04_EditarPerfil.dart';
import 'package:trainning/paginas/05_MisAnuncios.dart';
import 'package:trainning/paginas/06_HistorialVentas.dart';
import 'package:trainning/paginas/07_CrearAnuncio.dart';
import 'package:trainning/paginas/08_Compras.dart';
import 'package:trainning/paginas/09_DetalleProducto.dart';
import 'package:trainning/paginas/12_Pedidos.dart';

void main(){
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/':                (context) => StandardMenu( contenido:LogInMenu(),                                             menuType: "empty",),
        '/CreateUser':      (context) => CreateUser(),
        '/ListaTiendas':    (context) => StandardMenu( contenido: StoreList(),        appBarTitle: 'Lista de Tiendas',    menuType: "topBottom",),
        '/Mapa':            (context) => StandardMenu( contenido: PantallaMaps(),     appBarTitle: 'Mapa',                menuType: "topBottom",),
        '/Perfil':          (context) => StandardMenu( contenido: ProfileMenu(),      appBarTitle: 'Mi Perfil',           menuType: "topBottom",),
        '/CrearAnuncio':    (context) => StandardMenu( contenido: CrearAnuncio(),     appBarTitle: 'CrearAnuncio',        menuType: "topBottom",),
        '/DetalleProducto': (context) => StandardMenu( contenido: DetalleProducto(),  appBarTitle: 'Detalle Producto',    menuType: "topBottom",),
        '/imagePick':       (context) => StandardMenu( contenido: ImagePick(),        appBarTitle: 'Selecciona la imagen',menuType: "topBottom",),
        '/Anuncios':        (context) => StandardMenu( contenido: MisAnuncios(),      appBarTitle: 'Mis Anuncios',        menuType: "full", menuIndex: 0,),
        '/Pedidos':         (context) => StandardMenu( contenido: Pedidos(),          appBarTitle: 'Pedidos',             menuType: "full", menuIndex: 1,),
        '/VentasEnProceso': (context) => StandardMenu( contenido: VentasEnProceso(),  appBarTitle: 'Ventas en Proceso',   menuType: "full", menuIndex: 1,),
        '/HistorialVentas': (context) => StandardMenu( contenido: HistorialVentas(),  appBarTitle: 'Historial de Ventas', menuType: "full", menuIndex: 1,),
        '/Compras':         (context) => StandardMenu( contenido: Compras(),          appBarTitle: 'Compras',             menuType: "full", menuIndex: 2,),
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
