import 'dart:convert';

import 'package:flutter/material.dart';
import 'Product.dart';
import 'Services.dart';

class DataTableProduct extends StatefulWidget
{
  DataTableProduct () : super();
  final String title = 'Mysql Flutter';
  @override
  DataTableProductState createState() => DataTableProductState();
}

class DataTableProductState extends State<DataTableProduct>
{
  List<Product> _products;
  GlobalKey<ScaffoldState> _scaffoldKey;
  TextEditingController _clave;
  TextEditingController _nombre;
  TextEditingController _zona;
  TextEditingController _existencia;
  TextEditingController _conteo;

  Product _selectedProduct;
  bool _isUpdating;
  String _titleProgress;

  @override
  void initState()
  {
    super.initState();
    _products = [];
    _isUpdating = false;
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey();

    //Campos
    _clave = TextEditingController();
    _nombre = TextEditingController();
    _zona = TextEditingController();
    _existencia = TextEditingController();
    _conteo = TextEditingController();
    _getAllProduct();
  }

  //Actualizar Barra de Titulo
  _showProgress(String message)
  {
    setState(() {
      _titleProgress = message;
    });
  }

  _showSnackBar(context, message)
  {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message),),);
  }

  _createTable()
  {
    _showProgress('Creando Tabla...');
    Services.createTable().then((result)
    {
      if('success' == result)
      {
        _showSnackBar(context, result);
        _showProgress(widget.title);
      }
    });
  }

  _addProduct()
  {
    if(_clave.text.isEmpty || _nombre.text.isEmpty || _zona.text.isEmpty || _existencia.text.isEmpty || _conteo.text.isEmpty)
    {
      print('Campos Vacios!');
      return;
    }

    _showProgress('Agregando Producto...');
    Services.addProduct(_clave.text, _nombre.text, _zona.text, _existencia.text, _conteo.text)
    .then((result)
    {
      if('success' == result)
      {
        _getProduct();
      }
      _clearValues();
    });

  }

  _getProduct()
  {
    if(_clave.text.isEmpty)
    {
      print('No se Encontro Producto!');
      return;
    }
    _showProgress('Cargando Datos...');
    Services.getProduct(_clave.text).then((products)
    {
      setState(() {
        _products = products;
      });

      _showProgress(widget.title);
      print('Datos: ${products.length}');
    });

  }

_getAllProduct()
  {
    _showProgress('Cargando Datos...');
    Services.getAllProduct().then((products)
    {
      setState(() {
        _products = products;
       
      });

      _showProgress(widget.title);
      print('Datos: ${products.length}');
    });
  }
  //Limpiar Campos
  _clearValues()
  {
    _clave.text = '';
    _nombre.text = '';
    _zona.text = '';
    _existencia.text = '';
    _conteo.text = '';
  }

//Llenado de Datos
_showValues(Product product) {
    _clave.text = product.clave;
    _nombre.text = product.nombre;
    _zona.text = product.zona;
    _existencia.text = product.existencia;
    _conteo.text =product.conteo;
  }


//Crear Tabla de Datos

  SingleChildScrollView _dataBody()
  {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns:
          [
            DataColumn(
              label: Text ('Clave'),
            ),

            DataColumn(
              label: Text ('Nombre'),
            ),

            DataColumn(
              label: Text ('Zona'),
            ),

            DataColumn(
              label: Text ('Existencia'),
            ),

            DataColumn(
              label: Text ('Conteo'),
            )
          ], 
          rows:
          _products.map((Product)=>DataRow(cells:[
              DataCell(Text(Product.clave.toString()),
              onTap: ()
              {
                _showValues(Product);
              }
              ),

              DataCell(Text(Product.nombre.toUpperCase()),
              onTap: ()
              {
                _showValues(Product);
              }
              ),

              DataCell(Text(Product.zona.toUpperCase()),
              onTap: ()
              {
                _showValues(Product);
              }
              ),

              DataCell(Text(Product.existencia.toUpperCase()),
              onTap: ()
              {
                _showValues(Product);
              }
              ),

              DataCell(Text(Product.conteo.toUpperCase()),
              onTap: ()
              {
                _showValues(Product);
              }
              )
            ]),
          )
          .toList(),
          ),
      ),
    );
  }
 

  //Intefaz UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(_titleProgress),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add), 
          onPressed: (){
            _createTable();
          },
          ),

          IconButton(icon: Icon(Icons.search), 
          onPressed: (){
            _getProduct();
            
          },
          )
        ],
      ),

      body: 
       Container(
         child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: _clave,
                decoration: InputDecoration.collapsed(
                  hintText: 'Clave del Producto',
                  ),
              ),
              ),

              Padding(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: _nombre,
                decoration: InputDecoration.collapsed(
                  hintText: 'Nombre del Producto',
                  ),
              ),
              ),

              Padding(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: _zona,
                decoration: InputDecoration.collapsed(
                  hintText: 'Zona',
                  ),
              ),
              ),

              Padding(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: _existencia,
                decoration: InputDecoration.collapsed(
                  hintText: 'Existencia',
                  ),
              ),
              ),

              Padding(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: _conteo,
                decoration: InputDecoration.collapsed(
                  hintText: 'Conteo',
                  ),
              ),
              ),

              //Agregar Botones para Actualizar y Cancelar
              _isUpdating?
              Row(
                children: <Widget>[
                  OutlineButton(
                    child: Text('Actualizar'),
                    onPressed:()
                    {
                      //Metodo de Actualizar
                    },
                    ),

                    OutlineButton(
                    child: Text('Cancelar'),
                    onPressed:()
                    {
                      setState(() {
                        _isUpdating = false;
                      });
                      _clearValues();
                    },
                    ),
                ],
              ):Container(),
              _dataBody(),
          ],
        ),
        ),
      ),
      
        floatingActionButton: FloatingActionButton(
          onPressed:()
          {
            _addProduct();
            _getAllProduct();
          },
          child: Icon(Icons.add), ),
    );
  }
}