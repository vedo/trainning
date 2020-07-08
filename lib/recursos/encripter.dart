import 'package:simple_rsa/simple_rsa.dart';
/*
Librería para enviar datos encriptados en RSA (asíncrono) a la sub api de authentificación de tipo JWT
Esta librería crea el objeto Ecripter con su único método encripter(<String>) que devuelve el mensaje en criptado
a través de la llave pública representando en un string en base64;
Básicamente se separó en un modulo aparte para no incluir métodos de encriptación dentro de la librería cliente,
para así hacer más fácil su lectura/depuración :)
 */
class Encripter{

  final publicKey = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxDayvVXq9pCeNSilJFvl"+
      "k7u7WoOkkrn6KnwzSgds/xSEJu5rgEYZVr8CDgJKc6q4mqfYbfRXiVGntEzJJDiz"+
      "3QW/H9eCrZMqeB50CgFQ905vIu3yrPANBJuTIIflo7w2ZnfCI4gEUCfi6OgSf5Ik"+
      "+aak8vWValnc/Z7Ho903Ssj/rkgJ/lGDAuXTyxRupmQP8/0d+fhyxRKsiqkEvaLM"+
      "RnQ1Tj+U/k+JNobzxFAXIF8saLd0sT9XW5j+cRD8JV5YVHK5tLTHzSWmDaD56Rf9"+
      "dDTA3+/ZvV1ZtoHefVl1o+sTXp53w8L2bZdloOU7fHNrI9UoWQWWzmTQlhgjSmz7"+
      "XwIDAQAB";

  Future<String> encripter(String message) async{
    String encryptedText =  await encryptString(message, publicKey);
    final mssgWTBreakLine = encryptedText.replaceAll("\n", "");
    return mssgWTBreakLine;
  }
}