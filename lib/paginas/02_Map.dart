import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trainning/recursos/constant.dart';
import 'package:trainning/claves.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';



class PantallaMaps extends StatefulWidget {
  final LatLng initialMapPosition = LatLng(-22.454104,-68.918158);
  
  @override
  _PantallaMapsState createState() => _PantallaMapsState();
}

class _PantallaMapsState extends State<PantallaMaps> {
  GoogleMapController mapController;
  Completer<GoogleMapController> _controller = Completer();
  bool closeWindow = true;
  var markerList = Set<Marker>();
  List<LatLng> posiciones = [ 
    LatLng(-22.453636,-68.914739),
    LatLng(-22.4545754,-68.9230375),
    LatLng(-22.4545242,-68.9199767),
    LatLng(-22.4517295,-68.9191101),
    LatLng(-22.4564465,-68.9198948),
    LatLng(-22.4553776,-68.9216041),   
  ];

  String nombreTienda = "";
  String idVendor = "";
  Widget listaProductos = Container();

  void obtenerTiendas(){
    final futureVendors = cliente.getVendors();
    futureVendors.then( (resp){
      int numeroDeClientes = resp.length;
      setState((){
        for( var i = 0 ; i < numeroDeClientes; i++ ) { 
          String idTienda = resp[i].id.toString();
          markerList.add(
            Marker(
              markerId: MarkerId(idTienda),
              position: posiciones[i],
              /* infoWindow: InfoWindow(
                title: resp[i].login.toString(),
              ), */
              onTap: (){
                setState(() {
                  closeWindow = false;
                  nombreTienda = resp[i].login.toString();
                  idVendor = resp[i].id.toString();
                  listaProductos = FutureBuilder(
                    future: cliente.getProductos(idVendor),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return SpinKitThreeBounce(
                            color: Colors.blue,
                            size: 30.0,
                          );
                        default:
                          if (snapshot.hasError)
                            return Text('Error: ${snapshot.error}');
                          else
                            return construirListaDeProductos(context, snapshot);
                      }
                    },
                  );
                  /* Future futureProductos = cliente.getProductos(idVendor);
                  futureProductos.then( (respProductos ){
                    setState(() {
                      listaProductos = construirListaDeProductos( respProductos );
                    });
                  }); */
                });
              },
            )
          );
        }
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

  @override
  Widget build(BuildContext context) {
    obtenerTiendas();
    return Expanded(
      child: Container(
        child: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              buildingsEnabled: false,
              myLocationEnabled: true,
              rotateGesturesEnabled: false,
              initialCameraPosition: CameraPosition(
                target: widget.initialMapPosition,
                zoom: 15,
              ),
              mapType: MapType.terrain,
              markers: markerList,
            ),

            Center(
              child: pantallaTienda(),
            )
          ],
        ),
      ),
    );
  
  } // Build Pantalla Map State
  
  Future<void> moveMap() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(-22.4542482,-68.923041),
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
                Navigator.pushNamed(context, '/DetalleProducto',);
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