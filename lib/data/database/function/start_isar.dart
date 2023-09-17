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

extension IsarShorHand on Isar {
  Future<void> w() async => await writeTxn(() async {
        // await run;
        // await isar.students.put(Student(classRoom: ClassRoom()..nameClass = "sofware"));
        // print(isar.students.put(Student(classRoom: ClassRoom()..nameClass = "sofware")).runtimeType);
      });
}
