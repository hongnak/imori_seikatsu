import 'package:flutter/material.dart';

Widget creatureAndPlantContainer(List<dynamic> dataList, String label) {
  Widget widget = Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add, color: Colors.grey, size: 18.0),
          )
        ],
      ),
      dataList.isNotEmpty
          ?
      Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 18.0),
            height: 120.0,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, i) => Column(
                  children: [
                    GestureDetector(
                      child: dataList[i].imgURL != ''
                          ?
                      Container(
                          width: 90.0,
                          height: 90.0,
                          padding: const EdgeInsets.all(2.0),
                          decoration: BoxDecoration(shape: BoxShape.circle, image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(dataList[i].imgURL)))
                      )
                          :
                      Container(
                          width: 90.0,
                          height: 90.0,
                          padding: const EdgeInsets.all(2.0),
                          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey[200]), child: const Center(child: Text('No Image'))
                      ),
                      onTap: () {
                        //setDataKind(title);
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => DetailDataPage(data: dataList[i], tankName: tankName, kind: title, tankID: id)));
                      },
                    ),
                    Text(dataList[i].name, overflow: TextOverflow.ellipsis)
                  ],
                ),
                separatorBuilder: (BuildContext context, int i) => const SizedBox(width: 10.0),
                itemCount: dataList.length
            ),
          ),
          //addDataButtonWidget(model, context, title, id, lastWaterChangeDate, lastFeedDate)
        ],
      )
          :
      Column(
        children: [
          Container(
              // alignment: Alignment.center,
              // padding: const EdgeInsets.all(2),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
                child: Column(
                  children: [
                    CircleAvatar(child: Icon(Icons.emoji_food_beverage)),
                    SizedBox(height: 5.0),
                    Text('登録がありません', style: TextStyle(fontSize: 11, color: Colors.grey)),
                  ],
                ),
              )
          ),
          //addDataButtonWidget(model, context, title, id, lastWaterChangeDate, lastFeedDate)
        ],
      ),
    ],
  );
  return widget;
}