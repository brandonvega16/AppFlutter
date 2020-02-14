class Product
{
  String clave;
  String nombre;
  String zona;
  String existencia;
  String conteo;

  Product({this.clave, this.nombre, this.zona, this.existencia, this.conteo});

  factory Product.fromjson(Map<String, dynamic> json)
  {
    return Product(
      clave: json['Clave'] as String,
      nombre: json['Nombre'] as String,
      zona: json['Zona'] as String,
      existencia: json['Existencia'] as String,
      conteo: json['Conteo'] as String,);
  }
}