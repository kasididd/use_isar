import 'package:use_isar/data/database/mapping/mapping_isar.dart';

late Isar isar;
Future openIsar() async {
  final dir = await getApplicationDocumentsDirectory();
  isar = await Isar.open(
    [EmailSchema, StudentSchema],
    directory: dir.path,
  );
}

Future clearIsar() async {
  await isar.writeTxn(() async => await isar.clear());
}
