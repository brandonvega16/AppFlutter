import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'Product.dart';

class Services
{
  static const ROOT = 'http://192.168.1.168/AppFlutter/conexion.php';
  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _GET_ALL_ACTION = 'GET_ALL';
  static const _GET_DATA_ACTION = 'GET_DATA';
  static const _ADD_PRODUCT_ACTION = "ADD_PRODUCT";

  //Metodo para Crear la Tabla
  static Future<String> createTable() async
  {
    try
    {
      var map = Map<String, dynamic>();
      map['action'] = _CREATE_TABLE_ACTION;
      final response = await http.post(ROOT, body:map);
      print('Create Table Response: ${response.body}');
      return response.body;
    }
    catch(e)
    {
      return "Error";
    }
  }

  //Metodo Obtener Datos por Busqueda
  static Future<List<Product>> getProduct(String clave) async {
    try 
    {
      var map = Map<String, dynamic>();
      map['action'] = _GET_DATA_ACTION;
      map['Clave'] = clave;
      final response = await http.post(ROOT, body: map);
      print('getProduct Response: ${response.body}');

      if (200 == response.statusCode) 
      {
        List<Product> list = parseResponse(response.body);
        return list;
      } 
      else 
      {
        return List<Product>();
      }
    } 
    catch (e) 
    {
      return List<Product>(); 
    }
  }

   static Future<List<Product>> getAllProduct() async {
    try 
    {
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_ACTION;
      final response = await http.post(ROOT, body: map);
      print('getProduct Response: ${response.body}');

      if (200 == response.statusCode) 
      {
        List<Product> list = parseResponse(response.body);
        return list;
      } 
      else 
      {
        return List<Product>();
      }
    } 
    catch (e) 
    {
      return List<Product>(); 
    }
  }
 
  static List<Product> parseResponse(String responseBody) 
  {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Product>((json) => Product.fromjson(json)).toList();
  }

  static Future<String> addProduct(String clave, String nombre, String zona, String existencia, String conteo) async
  {
    try 
    {
      var map = Map<String, dynamic>();
      map['action'] = _ADD_PRODUCT_ACTION;
      map['Clave'] = clave;
      map['Nombre'] = nombre; 
      map['Zona'] = zona;
      map['Existencia'] = existencia;
      map['Conteo'] = conteo;

      final response = await http.post(ROOT, body: map);
      print('addProduct Response: ${response.body}');

      if (200 == response.statusCode) 
      {
        return response.body;
      } 
      else 
      {
        return "Error";
      }
    } 
    catch (e) 
    {
      return "Error";
    }
  }
}