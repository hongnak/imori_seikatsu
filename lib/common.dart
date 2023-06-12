
enum DataKind {
  imorium,
  creature,
  plant,
  waterChange,
  feed,
  temperature,
  ph,
  diary
}

enum Mode {
  normal,
  add,
  edit,
  delete
}

DataKind dataKind = DataKind.imorium;
Mode mode = Mode.normal;
int iconIndex = 0;
String unit = '';
String collectionName = '';

