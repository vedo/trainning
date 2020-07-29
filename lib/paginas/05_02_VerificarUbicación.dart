import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:html/parser.dart';
import 'package:trainning/recursos/client.dart';
import 'package:trainning/recursos/componentes.dart';
import 'package:trainning/recursos/tarjetas.dart';

class VerificarDireccion extends StatefulWidget {
  @override
  _VerificarDireccionState createState() => _VerificarDireccionState();
}

class _VerificarDireccionState extends State<VerificarDireccion> {
  GoogleMapController mapController;
  Completer<GoogleMapController> _controller = Completer();
  CameraPosition posicionInicialCamara = CameraPosition(
    zoom: 15,
    target: LatLng(-33.446399,-70.6618155),
  );
  var markerList = Set<Marker>();
 
  bool closeWindow = true;  
  String nombreTienda = "";
  String idVendor = "";
  Widget listaProductos = Container();
  Widget listaPublicaciones = Container();

  @override
  void initState() {
    obtenerTiendas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                getMyPosition();
              },
              buildingsEnabled: false,
              myLocationEnabled: true,
              rotateGesturesEnabled: false,
              initialCameraPosition: posicionInicialCamara,
              mapType: MapType.terrain,
              markers: markerList,
            ),

            Center(
              child: pantallaTienda(),
            )
          ],
        ),
      );
  } // Build Pantalla Map State

  Future<void> getMyPosition() async{
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    moveMap(position.latitude, position.longitude);
  }

  void obtenerTiendas() async{
    final futureVendors = cliente.getVendorsWithAddress();
    futureVendors.then( (resp) async{
      var newMarkerList = Set<Marker>();

      int numeroDeClientes = resp.length;
      for( var i = 0 ; i < numeroDeClientes; i++ ) { 
        String direccion = resp[i]["address"]["address_1"].toString();
        String ciudad = resp[i]["address"]["city"].toString();
        String comuna = resp[i]["address"]["state"].toString();
        String pais = resp[i]["address"]["country"].toString();
        List<Placemark> placemark = await Geolocator().placemarkFromAddress("$direccion, $ciudad, $comuna, $pais");
        newMarkerList.add(
          Marker(
            markerId: MarkerId( resp[i]["id"].toString() ),
            position: LatLng(placemark[0].position.latitude, placemark[0].position.longitude),
            onTap: (){
              setState(() {
                closeWindow = false;
                nombreTienda = resp[i]["login"].toString();
                idVendor = resp[i]["id"].toString();
                listaProductos = FutureServerCall(
                  llamadaCliente: cliente.getProductos(idVendor),
                  completedCallWidgetFunction: construirListaDeProductos, 
                );
                listaPublicaciones = FutureServerCall(
                  llamadaCliente: cliente.getMyPosts(),
                  completedCallWidgetFunction: construirListaDePosts,
                );
              });
            },
          )
        );
      }

      /* Después de crear la lista de marcadores los seteo */
      setState((){
        markerList = newMarkerList;
      }); 
    });
  }

  Widget pantallaTienda(){
    if( closeWindow ){
      return Container();
    }else{
      return MapStore(
        nombreTienda: nombreTienda,
        onPressed: (){
          setState(() {
            closeWindow = true;
            listaProductos = Container();
          });
        },
        listaDeProductos: listaProductos,
        listaDePublicaciones: listaPublicaciones,
      );
    }
  }
  
  Future<void> moveMap(latitud, longitud) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(latitud,longitud),
          zoom: 15,
        )
      )
    );
  } // Move Map
}// Pantalla Map State

Widget construirListaDeProductos(BuildContext context, AsyncSnapshot snapshot) {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: snapshot.data.length,
    itemBuilder: (BuildContext context, int index) {
      String idProducto = snapshot.data[index].id.toString();
      return Tarjeta1(
        tituloTarjeta: snapshot.data[index].name.toString(),
        precioTarjeta: snapshot.data[index].price.toString(),
        id: idProducto,
        imagen: NetworkImage(snapshot.data[index].images[0].src),
      );
    },
  );
} 

Widget construirListaDePosts(BuildContext context, AsyncSnapshot snapshot) {
  final data = snapshot.data;
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: snapshot.data.length,
    itemBuilder: (BuildContext context, int index) {
      String idPost = data[index]["id"].toString();
      return TarjetaPost(
        titulo: parse(data[index]["title"]["rendered"]).body.text,
        id: idPost,
        contenido: parse(data[index]["content"]["rendered"]).body.text,
        margenHorizontal: true,
      );
    },
  );
} 
