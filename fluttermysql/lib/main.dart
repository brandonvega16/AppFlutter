import 'package:flutter/material.dart';
import 'Mysql/DataTable.dart';

void main()
{
  runApp(
    new HomeApp(),
    );
}

class HomeApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Mysql',
      home: new DataTableProduct() ,
    ) ;
  }
}