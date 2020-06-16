import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trainning/recursos/constant.dart';



class PantallaMaps extends StatefulWidget {
  final LatLng initialMapPosition = LatLng(-22.454104,-68.918158);
  
  @override
  _PantallaMapsState createState() => _PantallaMapsState();
}

class _PantallaMapsState extends State<PantallaMaps> {
  GoogleMapController mapController;
  Completer<GoogleMapController> _controller = Completer();
  bool closeWindow = true;

  Widget pantallaTienda(){
    if( closeWindow ){
      return Container();
    }else{
      return MapStore(
        onPressed: (){
          setState(() {
            closeWindow = true;
          });
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
              markers: _createMarkers(),
              mapType: MapType.terrain,
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

  Set<Marker> _createMarkers(){
    var markerList = Set<Marker>();
    markerList.add(
      Marker(
        markerId: MarkerId('Cowork'),
        position: LatLng(-22.453636,-68.914739),
        onTap: (){
          setState(() {
            closeWindow = false;
          });
        },
      )
    );
    //print( markerList.first.markerId.value.toString() );
    return markerList;
  } // Create Markers
}// Pantalla Map State

class MapStore extends StatelessWidget {
  final VoidCallback onPressed;

  const MapStore({
    Key key,
    this.onPressed
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
                        "Nombre Tienda",
                        style: TextStyle(
                          fontSize: 20
                        ),
                      )
                    ],
                  ),

                  SizedBox(height: 15,),

                  Container(
                    height: 160,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        TarjetaProducto(
                          nombreProducto: "Holi",
                          precioProducto: 200.toString(),
                        ),
                        TarjetaProducto(
                          nombreProducto: "Holi",
                          precioProducto: 200.toString(),
                        ),
                        TarjetaProducto(
                          nombreProducto: "Holi",
                          precioProducto: 200.toString(),
                        ),
                        TarjetaProducto(
                          nombreProducto: "Holi",
                          precioProducto: 200.toString(),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
  }
}


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
                color: kPrimaryColor.withOpacity(0.4),
                /* image: DecorationImage(
                  image: this.imagenProducto,
                  fit: BoxFit.cover,
                ), */
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
}