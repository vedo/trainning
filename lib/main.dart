import 'package:flutter/material.dart';
import 'package:trainning/recursos/stackMenu.dart';
import 'package:trainning/paginas/imagePick.dart';

import 'package:trainning/paginas/00_00_PrimeraPantalla.dart';
import 'package:trainning/paginas/00_01_LogIn.dart';
import 'package:trainning/paginas/00_02_CreateUser.dart';
import 'package:trainning/paginas/01_00_00_MisAnuncios.dart';
import 'package:trainning/paginas/01_00_01_CrearAnuncio.dart';
import 'package:trainning/paginas/01_00_02_EditarAnuncio.dart';
import 'package:trainning/paginas/01_01_00_Pedidos.dart';
import 'package:trainning/paginas/01_01_01_HistorialVentas.dart';
import 'package:trainning/paginas/01_01_02_VentasEnProceso.dart';
import 'package:trainning/paginas/01_02_Compras.dart';
import 'package:trainning/paginas/02_Map.dart';
import 'package:trainning/paginas/03_00_Mercado.dart';
import 'package:trainning/paginas/03_01_DetalleProducto.dart';
import 'package:trainning/paginas/04_00_MiBarrio.dart';
import 'package:trainning/paginas/04_01_DetallePost.dart';
import 'package:trainning/paginas/04_02_CrearPost.dart';
import 'package:trainning/paginas/04_04_ComentarPost.dart';
import 'package:trainning/paginas/05_00_VerPerfil.dart';
import 'package:trainning/paginas/05_01_EditarPerfil.dart';

void main(){ 
  //print( checkLogIn() );
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        /* 0.0 Sección INTRO */
        '/':                (context) => PrimeraPantalla(),
        '/LogIn':           (context) => LogInMenu(),
        '/CreateUser':      (context) => CreateUser(),
        
        /* 1.0 Sección MI TIENDA */
        '/Anuncios':        (context) => StandardMenu( contenido: MisAnuncios(),     appBarTitle: 'Mis anuncios',        menuType: "full", menuIndex: 0,),
        '/CrearAnuncio':    (context) => StandardMenu( contenido: CrearAnuncio(),    appBarTitle: 'Crear anuncio',       menuType: "topBottom",),
        '/EditarAnuncio':   (context) => StandardMenu( contenido: EditarAnuncio(),   appBarTitle: 'Editar anuncio',      menuType: "topBottom",),
        
        '/Pedidos':         (context) => StandardMenu( contenido: Pedidos(),         appBarTitle: 'Pedidos',             menuType: "full", menuIndex: 1,),
        '/VentasEnProceso': (context) => StandardMenu( contenido: VentasEnProceso(), appBarTitle: 'Ventas en proceso',   menuType: "full", menuIndex: 1,),
        '/HistorialVentas': (context) => StandardMenu( contenido: HistorialVentas(), appBarTitle: 'Historial de ventas', menuType: "full", menuIndex: 1,),
        
        '/Compras':         (context) => StandardMenu( contenido: Compras(),         appBarTitle: 'Compras',             menuType: "full", menuIndex: 2,),
        
        /* Resto de secciones en el bottombar */
        '/Mapa':            (context) => StandardMenu( contenido: PantallaMaps(),    appBarTitle: 'Mapa',                menuType: "topBottom",),
        
        '/Mercado':         (context) => StandardMenu( contenido: StoreList(),       appBarTitle: 'Mercado',             menuType: "topBottom",),
        '/DetalleProducto': (context) => DetalleProducto(),
        //'/DetalleProducto': (context) => StandardMenu( contenido: DetalleProducto(), appBarTitle: 'Detalle producto',    menuType: "topBottom",),

        '/MiBarrio':        (context) => StandardMenu( contenido: MiBarrio(),        appBarTitle: 'Mi Barrio',           menuType: "topBottom",),
        '/DetallePost':     (context) => DetallePost(),
        '/CrearPost':       (context) => StandardMenu( contenido: CrearPost(),       appBarTitle: 'Crear publicación',   menuType: "topBottom",),
        '/ComentarPost':    (context) => StandardMenu( contenido: ComentarPost(),    appBarTitle: 'Comentar Post',       menuType: "topBottom",),

        /* Otros */
        '/Perfil':          (context) => StandardMenu( contenido: ProfileMenu(),     appBarTitle: 'Mi Perfil',           menuType: "topBottom",),
        '/EditarPerfil':    (context) => StandardMenu( contenido: EditarPerfil(),    appBarTitle: 'Editar Perfil',       menuType: "topBottom",),
        '/imagePick':       (context) => StandardMenu( contenido: ImagePick(),       appBarTitle: 'Selecciona la imagen',menuType: "topBottom",),
      },
    )
  );
}

