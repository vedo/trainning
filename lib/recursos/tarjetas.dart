import 'package:flutter/material.dart';
import 'package:trainning/recursos/ScreenArgument.dart';
import 'package:trainning/recursos/client.dart';
import 'package:trainning/recursos/constant.dart';

/* PENDIENTE: ORDENAR ESTE CÓDIGO */

double radioBorde = 28;

/* TARJETA UTILIZADA PARA MERCADO */
class Tarjeta1 extends StatelessWidget {
  final String tituloTarjeta;
  final String precioTarjeta;
  final String id;
  final NetworkImage imagen;
  final String nombreBoton;

  const Tarjeta1({
    this.tituloTarjeta,
    this.precioTarjeta,
    this.id,
    this.imagen,
    this.nombreBoton: "Ver Producto",
  });

  @override
  Widget build(BuildContext context) {
    return Container( // Tarjeta producto
      margin: EdgeInsets.only(right: 15),
      width: 300, height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radioBorde),
        color: kBorderColor
      ),
      child: Stack(
        children: <Widget>[

          Positioned( //Imágen del producto
            top: 5, left: 5, bottom: 5,
            child: Container( 
              width: 145, height: 145,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radioBorde-4),
                //color: kPrimaryColor.withOpacity(0.4),
                image: DecorationImage(
                  image: this.imagen,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          Positioned( // Bloque de texto
            left: 160, top: 10, right: 10,
            child: Container(
              width: 150, height: 160,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    this.tituloTarjeta,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  this.precioTarjeta!="" ? Text( "\$ " + this.precioTarjeta ) : Container() ,
                ],
              ),
            ),
          ),

          Positioned( // Botón detalle producto
            right: 10, bottom: 5,
            child: FlatButton(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              child: Text(this.nombreBoton),
              onPressed: () {
                Navigator.pushNamed(
                  context, '/DetalleProducto',
                  arguments: ScreenArguments(
                    id: this.id, 
                    apiClient: cliente
                  ),
                );
              },
            ),
          )

        ],
      ),
    );
  } // TarjetaProducto Build
} // TarjetaProducto

/* DONDE SE USA ? */
class Tarjeta2 extends StatelessWidget {
  final String buttonText;
  final List<Widget> cuerpo;

  const Tarjeta2({
    this.buttonText,
    this.cuerpo,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      height: 150,
      child: Stack(children: <Widget>[
        
        FractionallySizedBox(
          widthFactor: 0.8,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey,
            ),
          ),
        ),

        Align(
          alignment: Alignment.centerRight,
          child: FractionallySizedBox(
              widthFactor: 0.5,
              heightFactor: 0.9,
              child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.lightBlue[200],
              ),
            ),
          ),
        ),
    

        Positioned(
          top: 10,
          left: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: this.cuerpo,
          ),
        ),

        Positioned(
          left: 0,
          bottom: 0,
          child: FlatButton(
            padding: EdgeInsets.zero,
            onPressed: (){
              Navigator.popAndPushNamed(context, '/DetalleProducto',);
            },
            child: Text(
              this.buttonText
            ),
          ),
        ),
      ],),
    );
  }
}

class Tarjeta3 extends StatelessWidget {
  final String buttonText;
  final List<Widget> cuerpo;
  final String id;
  final String imagenProducto;

  const Tarjeta3({
    this.buttonText,
    this.cuerpo,
    @required this.id,
    this.imagenProducto,
  });
  
  @override
  Widget build(BuildContext context) {
    double fraccionImagen = 0.45;
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      height: 150,
      child: Stack(children: <Widget>[
        
        Align( //Espacio de texto
          alignment: Alignment.centerRight,
          child: FractionallySizedBox(
            widthFactor: 1 - fraccionImagen,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), topRight: Radius.circular(10)),
                color: Colors.white,
              ),
              child: Stack(children: <Widget>[
                Positioned(
                  top: 10,
                  left: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: this.cuerpo,
                  ),
                ),
                Positioned(
                  left: 0,
                  bottom: 0,
                  child: FlatButton(
                    padding: EdgeInsets.zero,
                    onPressed: (){
                      Navigator.popAndPushNamed(
                        context, '/EditarAnuncio',
                        arguments: ScreenArguments(id: this.id),
                      );
                    },
                    child: Text( this.buttonText ),
                  ),
                ),
              ],),
            ),
          ),
        ),

        Align( //Espacio Imágen
          alignment: Alignment.centerLeft,
          child: FractionallySizedBox(
              widthFactor: fraccionImagen,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), topLeft: Radius.circular(10)),
                  image: DecorationImage(
                    image: NetworkImage(this.imagenProducto),
                    fit: BoxFit.cover,
                  ),
                ),
            ),
          ),
        ),
      ],),
    );
  }
}

class TarjetaPost extends StatelessWidget {
  final String titulo;
  final String id;
  final String contenido;
  final bool margenHorizontal;
  const TarjetaPost({
    this.titulo,
    this.id,
    this.contenido,
    this.margenHorizontal: false,
  });

  @override
  Widget build(BuildContext context) {
    return Container( // Tarjeta producto
      margin: EdgeInsets.only(bottom: 10, right: margenHorizontal ? 15 : 0 ),
      height: 150, width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(34),
        color: kBorderColor
      ),
      child: Stack(
        children: <Widget>[

          Positioned( // Bloque de texto
            left: 20, top: 15, right: 20,
            child: Container(
              height: 160, 
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    this.titulo,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(height: 5,),
                  Text(this.contenido),
                ],
              ),
            ),
          ),

          Positioned( // Botón Leer Más
            right: 20, bottom: 5,
            child: FlatButton(
              child: Text("Leer más"),
              onPressed: () {
                Navigator.pushNamed(
                  context, '/DetallePost',
                  arguments: ScreenArguments(
                    id: this.id, 
                    apiClient: cliente
                  ),
                );
              },
            ),
          ),

          Positioned( // Botón detalle
            left: 20, bottom: 20,
            child: FutureBuilder(
              future: cliente.getUserName(this.id), // Client get posts ? se puede construir esta parte de la app con los post del blog ?
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Text("");
                  default:
                    return Text(snapshot.data.toString()); 
                } // FutureBuilder builder
              },
            ),
          )

        ],
      ),
    );
  } // TarjetaProducto Build
} // TarjetaProducto

/* Modelo gráfico de una tienda, se usa en pestaña '/Mercado' */
class Tienda extends StatelessWidget {
  
  final String nombreTienda;
  final Widget listaDeProductos;

  const Tienda({
    Key key,
    this.nombreTienda,
    this.listaDeProductos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 30, left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                /* Container(
                  height: 40, width: 40,
                  decoration: BoxDecoration( borderRadius: BorderRadius.circular(100), color: Colors.grey ),
                  child: Icon(Icons.face),
                ),*/
                SizedBox(width: 5,), 
                Text(
                  this.nombreTienda,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ],
            )
          ),
          
          SizedBox(height: 10,),
          Container( // Contenedor de lista de tiendas
            height: 160,
            child: this.listaDeProductos,
          ),
        ],
      ),
    );
  } // Tienda Build
} //


/* TARJETA QUE SE MUESTRA AL ABRIR UNA TIENDA EN EL MAPA */
class MapStore extends StatelessWidget {
  final VoidCallback onPressed;
  final String nombreTienda;
  final Widget listaDeProductos;
  final Widget listaDePublicaciones;

  const MapStore({
    Key key,
    this.onPressed,
    this.nombreTienda,
    this.listaDeProductos,
    this.listaDePublicaciones
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 350,
        height: 520,
        decoration: BoxDecoration(
          color: gradientBlue.withOpacity(0.9),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              right: 10, top: 10,
              child: Container(
                child: RawMaterialButton(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  constraints: BoxConstraints(minWidth: 0.0, minHeight: 0.0),
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
                      
                      Container( /* Icono al costado del nombre */
                        width: 70, height: 70,
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
                  Text(
                    "Productos:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    height: 160,
                    child: this.listaDeProductos,
                  ),

                  SizedBox(height: 30,),
                  Text(
                    "Comentarios en el barrio:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    height: 160,
                    child: this.listaDePublicaciones,
                  )
                ],
              ),
            )
          ],
        ),
      );
  }
} // MapStore