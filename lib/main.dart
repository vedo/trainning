import 'package:flutter/material.dart';
import 'package:trainning/recursos/stackMenu.dart';
import 'package:trainning/paginas/imagePick.dart';

import 'package:trainning/paginas/00_PrimeraPantalla.dart';
import 'package:trainning/paginas/01_LogIn.dart';
import 'package:trainning/paginas/02_CreateUser.dart';
import 'package:trainning/paginas/03_MisAnuncios.dart';
import 'package:trainning/paginas/04_Mercado.dart';
import 'package:trainning/paginas/05_VentasEnProceso.dart';
import 'package:trainning/paginas/06_HistorialVentas.dart';
import 'package:trainning/paginas/07_CrearAnuncio.dart';
import 'package:trainning/paginas/08_Compras.dart';
import 'package:trainning/paginas/09_DetalleProducto.dart';
import 'package:trainning/paginas/11_EditarPerfil.dart';
import 'package:trainning/paginas/12_Pedidos.dart';
import 'package:trainning/paginas/13_EditarAnuncio.dart';
import 'package:trainning/paginas/14_Map.dart';


void main(){ 
  //print( checkLogIn() );
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/':                (context) => PrimeraPantalla(),
        '/LogIn':           (context) => LogInMenu(),
        '/CreateUser':      (context) => CreateUser(),
        '/Anuncios':        (context) => StandardMenu( contenido: MisAnuncios(),     appBarTitle: 'Mis Anuncios',        menuType: "full", menuIndex: 0,),
        '/Pedidos':         (context) => StandardMenu( contenido: Pedidos(),         appBarTitle: 'Pedidos',             menuType: "full", menuIndex: 1,),
        '/VentasEnProceso': (context) => StandardMenu( contenido: VentasEnProceso(), appBarTitle: 'Ventas en Proceso',   menuType: "full", menuIndex: 1,),
        '/ListaTiendas':    (context) => StandardMenu( contenido: StoreList(),       appBarTitle: 'Lista de Tiendas',    menuType: "topBottom",),
        '/Mapa':            (context) => StandardMenu( contenido: PantallaMaps(),    appBarTitle: 'Mapa',                menuType: "topBottom",),
        '/Perfil':          (context) => StandardMenu( contenido: ProfileMenu(),     appBarTitle: 'Mi Perfil',           menuType: "topBottom",),
        '/CrearAnuncio':    (context) => StandardMenu( contenido: CrearAnuncio(),    appBarTitle: 'CrearAnuncio',        menuType: "topBottom",),
        '/DetalleProducto': (context) => StandardMenu( contenido: DetalleProducto(), appBarTitle: 'Detalle Producto',    menuType: "topBottom",),
        '/imagePick':       (context) => StandardMenu( contenido: ImagePick(),       appBarTitle: 'Selecciona la imagen',menuType: "topBottom",),
        '/HistorialVentas': (context) => StandardMenu( contenido: HistorialVentas(), appBarTitle: 'Historial de Ventas', menuType: "full", menuIndex: 1,),
        '/Compras':         (context) => StandardMenu( contenido: Compras(),         appBarTitle: 'Compras',             menuType: "full", menuIndex: 2,),
        '/EditarAnuncio':   (context) => StandardMenu( contenido: EditarAnuncio(),   appBarTitle: 'Editar Anuncio',      menuType: "topBottom",),
      },
    )
  );
}

