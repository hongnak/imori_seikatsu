import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imori_seikatsu/common.dart';
import 'package:imori_seikatsu/domain/creature.dart';
import 'package:imori_seikatsu/domain/diary.dart';
import 'package:imori_seikatsu/domain/feed.dart';
import 'package:imori_seikatsu/domain/ph.dart';
import 'package:imori_seikatsu/domain/plant.dart';
import 'package:imori_seikatsu/domain/temperature.dart';
import 'package:imori_seikatsu/domain/waterChange.dart';
import 'package:imori_seikatsu/my_data_detail/my_data_detail_page.dart';
import 'package:imori_seikatsu/my_tank_detail/my_tank_detail_model.dart';
import 'package:imori_seikatsu/widgets/my_tank_detail/creature_and_plant_widget.dart';
import 'package:imori_seikatsu/widgets/my_tank_detail/data_list_widget.dart';
import 'package:provider/provider.dart';
import '../domain/imorium.dart';

class MyTankDetailPage extends StatelessWidget {
  const MyTankDetailPage({super.key, required this.imorium});
  final Imorium imorium;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyTankDetailModel>(
      create: (_) => MyTankDetailModel(imorium: imorium)..fetchData(),
      child: Consumer<MyTankDetailModel>(
        builder: (context, model, child) {
          final List<Creature>? creatures = model.creatures;
          final List<Plant>? plants = model.plants;
          final List<WaterChange>? waterChanges = model.waterChanges;
          final List<Feed>? feeds = model.feeds;
          final List<Temperature>? temperatures = model.temperatures;
          final List<Ph>? ph = model.ph;
          final List<Diary>? diaries = model.diaries;
          double imgWidth = MediaQuery.of(context).size.width*0.85;
          double imgHeight = MediaQuery.of(context).size.height*0.3;

          if (creatures == null || plants == null || waterChanges == null || feeds == null
              || temperatures == null || ph == null || diaries == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return Scaffold(
            appBar: AppBar(title: Text(imorium.name), centerTitle: true),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      imorium.imgURL != ''
                          ?
                      InkWell(
                        onTap: () {
                          dataKind = DataKind.imorium;
                          Navigator.push(context, MaterialPageRoute(builder: (context) => MyDataDetailPage(data: imorium, label: '水槽', imorium: imorium), fullscreenDialog: true));
                        },
                        child: Container(
                            width: imgWidth,
                            height: imgHeight,
                            decoration: BoxDecoration(shape: BoxShape.rectangle, image: DecorationImage(image: NetworkImage(imorium.imgURL), fit: BoxFit.cover))
                        )
                      )
                          :
                      InkWell(
                        onTap: () async {
                          dataKind = DataKind.imorium;
                          Navigator.push(context, MaterialPageRoute(builder: (context) => MyDataDetailPage(data: imorium, label: '水槽', imorium: imorium), fullscreenDialog: true));
                        },
                        child: Container(
                            width: imgWidth,
                            height: imgHeight,
                            color: Colors.grey[200], child: const Center(child: Text('No Image'))
                        )
                      ),
                      Padding(
                        padding: const EdgeInsets.all(28.0),
                        child: Column(
                          children: [
                            creatureAndPlantContainer(creatures, '生き物', context, imorium, model),
                            Divider(color: Colors.grey[200]),
                            creatureAndPlantContainer(plants, '水草', context, imorium, model),
                            Divider(color: Colors.grey[200]),
                            dataListWidget(model, context, waterChanges, '水交換', 0, imorium),
                            Divider(color: Colors.grey[200]),
                            dataListWidget(model, context, feeds, '餌やり', 1, imorium),
                            Divider(color: Colors.grey[200]),
                            dataListWidget(model, context, temperatures, '水温', 2, imorium),
                            Divider(color: Colors.grey[200]),
                            dataListWidget(model, context, ph, 'ph', 2, imorium),
                            Divider(color: Colors.grey[200]),
                            dataListWidget(model, context, diaries, '日記', 3, imorium),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}