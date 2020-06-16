import 'package:trainning/recursos/client.dart';

class ScreenArguments {
  ClientApi apiClient;
  final String idProduct;
  final String idVendor;
  final String id;

  ScreenArguments({
    this.idProduct, 
    this.apiClient, 
    this.idVendor,
    this.id,
  });
}