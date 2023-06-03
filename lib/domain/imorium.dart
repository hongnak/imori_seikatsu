import 'package:cloud_firestore/cloud_firestore.dart';

class Imorium {
  Imorium(this.name, this.size, this.memo, this.imgURL, this.id,
      this.registrationDate, this.lastUpdatedDate, this.lastWaterChangeDate,
      this.lastFeedDate, this.waterChangeReminder, this.feedReminder, this.cleanReminder,
      this.addWaterReminder, this.sprayReminder, this.filterExchangeReminder, this.lastCleanDate,
      this.lastAddWaterDate, this.lastSprayDate, this.lastFilterExchangeDate);

  String name;
  String size;
  String memo;
  String imgURL;
  String id;
  Timestamp registrationDate;
  Timestamp lastUpdatedDate;
  Timestamp lastWaterChangeDate;
  Timestamp lastFeedDate;
  int waterChangeReminder;
  int feedReminder;
  int cleanReminder;
  int addWaterReminder;
  int sprayReminder;
  int filterExchangeReminder;
  Timestamp lastCleanDate;
  Timestamp lastAddWaterDate;
  Timestamp lastSprayDate;
  Timestamp lastFilterExchangeDate;
}