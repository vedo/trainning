//import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trainning/recursos/client.dart';
import 'package:trainning/recursos/constant.dart';

final double buttonWidth = 250;
final double buttonHeight = 40;

class CrearAnuncio extends StatefulWidget {
  CrearAnuncio({Key key}) : super(key: key);

  @override
  _CrearAnuncioState createState() => _CrearAnuncioState();
}

class _CrearAnuncioState extends State<CrearAnuncio> {
  File _image;
  final picker = ImagePicker();

  Future getCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(pickedFile.path);
    });
  }
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
    });
  }
  Color labelImage = Colors.black;
  String titleProduct;
  String precio;
  String descripcion;
  String stock;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
        child: Padding(
          padding: EdgeInsets.only(top: topPadding, left: 20, right: 20),
            child: ListView(
              children: <Widget>[
                Text(
                  "Nuevo Anuncio",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                      onPressed: (){
                        _settingModalBottomSheet(context);
                        },
                    tooltip: 'Pick Image',
                    icon: Icon(Icons.add_a_photo),
                    ),
                    //SI LA IMAGEN ES NULA
                    _image == null ?
                    Text(
                    "Agregar imagen del producto",
                    style: TextStyle(
                    color: labelImage,
                    fontSize: 20
                    ),
                    )

                    //SI la imagen no es nula , la muestro
                        : SizedBox(height: 200, width: 200,  child: Image.file(_image))
                    ],
                    ),
                    Container(
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.indigo[300],
                    ),
                    ),
                SizedBox(width: 20,),
                TextFormField(
                  validator: (value) {

                    if (value.isEmpty){
                      return "Falta nombre del producto";}

                    if (value.length <=3){
                      return "Este nombre es muy corto";
                    }
                    //si el campo es válido guardo el valor
                      titleProduct = value;
                      return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Título del anuncio',
                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Precio de venta',
                  ),
                  validator: (value) {
                    if (value.isEmpty){
                    return "Falta el precio";
                    }
                    //si el campo es válido guardo el valor
                    precio = value;
                    return null;
                  }
                ),
                SizedBox(height: 10,),
          TextFormField(
            validator: (value) {

              if (value.isEmpty){
                return "Falta descripción";}

              if (value.length <=10){
                return "Esta descripción es muy corta";
              }
              if (value.length >=510){
                return "Esta descripción es muy larga, máximo 510 caracteres";
              }
              //si el campo es válido guardo el valor
              descripcion = value;
              return null;
            },
            decoration: InputDecoration(
              labelText: 'Descripción',
            ),
          ),
                SizedBox(height: 10,),
                TextFormField(
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value.isEmpty){
                      return "¿Cuántos vendes?";
                    }
                    //si el campo es válido guardo el valor
                    stock = value;
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Stock disponible',
                  ),
                ),
                SizedBox(height: 10,),
                RaisedButton(
                  child: Text("Subir producto"),
                  onPressed: ()  {
                    if (_image == null){
                      Scaffold.of(context)
                          .showSnackBar(SnackBar(content: Text('Falta seleccionar una imagen')));
                    }
                    if (_formKey.currentState.validate()) {
                      print("Form Valido");
                      // Acá se carga el proceso de api! luego envía un modal de exito o fracaso
                      // If the form is valid, display a Snackbar.
                     cliente.postProductWithImage(imagePath: _image, nameProduct: titleProduct, description:  descripcion, regular_price: precio);
                      Scaffold.of(context)
                          .showSnackBar(SnackBar(content: Text('Subiendo producto')));
                    }
                  },

                ),
                SizedBox(height: 100,),
              ],
          ),
        ),
      );
  }

  //BOTTOM SHEET
   _settingModalBottomSheet(context){
  setState((){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc){
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.camera_alt),
                    title: new Text('Camara'),
                    onTap: () => {
                      getCamera()
                    }
                ),
                new ListTile(
                  leading: new Icon(Icons.photo),
                  title: new Text('Galería'),
                  onTap: () => {
                    getImage()
                  },
                ),
              ],
            ),
          );
        }
    );
  }
  );
  }
}