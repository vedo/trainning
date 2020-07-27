import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:trainning/recursos/constant.dart';
//import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:trainning/recursos/client.dart';
import 'package:trainning/recursos/componentes.dart';

class PantallaMaps extends StatefulWidget {
  @override
  _PantallaMapsState createState() => _PantallaMapsState();
}

class _PantallaMapsState extends State<PantallaMaps> {
  
  GoogleMapController mapController;
  Completer<GoogleMapController> _controller = Completer();
  CameraPosition posicionInicialCamara = CameraPosition(
    zoom: 15,
    target: LatLng(-22.454104, -68.918158),
  );
  var markerList = Set<Marker>();
 
  bool closeWindow = true;  
  String nombreTienda = "";
  String idVendor = "";
  Widget listaProductos = Container();

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
              print("holi");
              setState(() {
                closeWindow = false;
                nombreTienda = resp["login"].toString();
                idVendor = resp[i]["id"].toString();
                listaProductos = FutureServerCall(
                  llamadaCliente: cliente.getProductos(idVendor),
                  completedCallWidgetFunction: construirListaDeProductos, 
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

class MapStore extends StatelessWidget {
  final VoidCallback onPressed;
  final String nombreTienda;
  final Widget listaDeProductos;

  const MapStore({
    Key key,
    this.onPressed,
    this.nombreTienda,
    this.listaDeProductos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 350,
        height: 300,
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.8),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              right: 10,
              top: 10,
              child: Container(
                child: RawMaterialButton(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  constraints: BoxConstraints(minWidth: 0.0, minHeight: 0.0),
                  padding: EdgeInsets.zero,
                  onPressed: this.onPressed,
                  child: Icon(Icons.close)
                ),
              )
            ),
            
            Container(
              padding: EdgeInsets.only(top: 10, left: 10,),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  Row(
                    children: <Widget>[
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Icon(Icons.person),
                      ),
                      SizedBox(width: 10,),
                      Text(
                        this.nombreTienda,
                        style: TextStyle(
                          fontSize: 20
                        ),
                      )
                    ],
                  ),

                  SizedBox(height: 15,),

                  Container(
                    height: 160,
                    child: this.listaDeProductos,
                  )
                ],
              ),
            )
          ],
        ),
      );
  }
} // MapStore

class TarjetaProducto extends StatelessWidget {
  final String nombreProducto;
  final String precioProducto;
  final String idProducto;
  final NetworkImage imagenProducto;

  const TarjetaProducto({
    Key key,
    this.nombreProducto,
    this.precioProducto,
    this.idProducto,
    this.imagenProducto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container( // Tarjeta producto
      margin: EdgeInsets.only(left: 10),
      height: 160,
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(34),
        color: Colors.blue.withOpacity(.6)
      ),
      child: Stack(
        children: <Widget>[

          Positioned( //Imágen del producto
            top: 5,
            left: 5,
            child: Container( 
              height: 145,
              width: 145,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(34),
                //color: kPrimaryColor.withOpacity(0.4),
                image: DecorationImage(
                  image: this.imagenProducto,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          Positioned( // Bloque de texto
            left: 160,
            top: 15,
            child: Container(
              height: 160,
              width: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    this.nombreProducto,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text( "\$ " + this.precioProducto ) ,
                ],
              ),
            ),
          ),

          Positioned( // Botón detalle
            left: 160,
            bottom: 10,
            child: FlatButton(
              child: Text("Ver producto"),
              onPressed: () {
                Navigator.popAndPushNamed(context, '/DetalleProducto',);
              },
            ),
          )

        ],
      ),
    );
  }
} //TarjetaProducto

Widget construirListaDeProductos(BuildContext context, AsyncSnapshot snapshot) {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: snapshot.data.length,
    itemBuilder: (BuildContext context, int index) {
      String idProducto = snapshot.data[index].id.toString();
      return TarjetaProducto(
        nombreProducto: snapshot.data[index].name.toString(),
        precioProducto: snapshot.data[index].price.toString(),
        idProducto: idProducto,
        imagenProducto: NetworkImage(snapshot.data[index].images[0].src),
      );
    },
  );
} 