//import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trainning/recursos/client.dart';
import 'package:trainning/recursos/constant.dart';

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
                
                Text( // Titulo del formulario
                  "Nuevo Anuncio",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                Row(  // Fila agregar imagen del producto
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                      onPressed: (){ _settingModalBottomSheet(context); },
                      tooltip: 'Pick Image',
                      icon: Icon(Icons.add_a_photo),
                    ),
                    
                    //SI LA IMAGEN ES NULA
                    _image == null ?
                    Text(  // Retorno texto
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

                SizedBox(width: 20,),
                TextFormField(
                  decoration: InputDecoration( labelText: 'Título del anuncio', ),
                  validator: (value) {
                    if (value.isEmpty){ return "Falta nombre del producto"; }
                    if (value.length <=3){ return "Este nombre es muy corto"; }
                    titleProduct = value;
                    return null;
                  },
                ),
                
                SizedBox(height: 10,),
                TextFormField(
                  decoration: InputDecoration( labelText: 'Precio de venta', ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value.isEmpty){ return "Falta el precio"; }
                    precio = value;
                    return null;
                  }
                ),
                
                SizedBox(height: 10,),
                TextFormField(
                  decoration: InputDecoration( labelText: 'Descripción', ),
                  validator: (value) {
                    if (value.isEmpty){ return "Falta descripción"; } 
                    if (value.length <=10){ return "Esta descripción es muy corta"; }
                    if (value.length >=510){ return "Esta descripción es muy larga, máximo 510 caracteres"; }
                    descripcion = value;
                    return null;
                  },
                ),
                
                SizedBox(height: 10,),
                TextFormField(
                  decoration: InputDecoration( labelText: 'Stock disponible', ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value.isEmpty){ return "¿Cuántos vendes?"; }
                    stock = value;
                    return null;
                  },
                ),
                
                SizedBox(height: 10,),
                RaisedButton(
                  child: Text("Subir producto"),
                  onPressed: ()  {
                    if (_image == null){
                      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Falta seleccionar una imagen')));
                    }
                    if (_formKey.currentState.validate()) {
                      cliente.postProductWithImage(imagePath: _image, nameProduct: titleProduct, description:  descripcion, regularPrice: precio);
                      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Subiendo producto')));
                    }
                  },
                ),

                SizedBox(height: bottomPadding,),
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
                ListTile(
                    leading: new Icon(Icons.camera_alt),
                    title: new Text('Camara'),
                    onTap: () => { getCamera() }
                ),
                ListTile(
                  leading: new Icon(Icons.photo),
                  title: new Text('Galería'),
                  onTap: () => { getImage() },
                ),
              ],
            ),
          );
        }
      );
    });
  }
}