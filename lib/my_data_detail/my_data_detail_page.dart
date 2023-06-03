import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../domain/imorium.dart';
import '../widgets/my_data_detail/detail_data_widget.dart';

class MyDataDetailPage extends StatelessWidget {
  MyDataDetailPage({super.key, required this.imorium});
  Imorium imorium;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(imorium.name), centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz))
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
              child: detailDataWidget(imorium, context)
          )
      ),
    );
  }

}