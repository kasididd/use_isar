import 'package:use_isar/data/database/mapping/mapping_isar.dart';

Future<List<Email>> readIsarEmails() async {
  List<Email>? emails = await isar.emails.where().findAll();
  return (emails.map((e) => e).toList());
}

Future<List<Student>> readIsarStudent() async {
  List<Student>? students = await isar.students.where().findAll();
  return (students.map((e) => e).toList());
}

Future createIsarStudent() async {
  var newStudents = Student(classRoom: ClassRoom()..nameClass = "software");
  newStudents
    ..fullName = 'Kasidit Wansudon'
    ..status = Status.sent;
  await isar.writeTxn(() => isar.students.put(newStudents));
}

Future createIsarEmails() async {
  var newEmail = addEmail;
  newEmail.status = Status.sent;
  final recipient = Recipient()..address = 'new address';
  newEmail.recipients = [recipient];
  await isar.writeTxnSync(() async {
    isar.emails.putAllSync([newEmail]);
  });
}

Future updateIsarStudent() async {
  var data = isar.students.filter().classRoom((q) => q.nameClassContains('software')).findAllSync();
  if (data.isEmpty) return;
  var newStudents = data.first;
  // newStudents.id = 2;
  newStudents
    ..classRoom.nameClass = 'New Class'
    ..status = Status.sent;
  await isar.writeTxn(() async {
    await isar.students.putAll([newStudents]); // insert & update
  });
}

Future updateIsarEmail(int id) async {
  var data = isar.emails.filter().statusEqualTo(Status.sent).findAllSync();
  if (data.isEmpty) return;
  final newEmail = data.first;
  newEmail.status = Status.draft;
  final recipient = Recipient()..address = 'me';
  newEmail.recipients = [recipient];
  await isar.writeTxn(() async {
    await isar.emails.putAll([newEmail]); // insert & update
  });
}

Future deleteIsarStudents(int id) async {
  final data = isar.students.where().findAllSync();
  if (data.isNotEmpty) isar.writeTxnSync(() => isar.students.deleteSync(data.last.id));
}

Future deleteIsarEmails(int id) async {
  final data = isar.emails.where().findAllSync();
  if (data.isNotEmpty) isar.writeTxnSync(() => isar.emails.deleteSync(data.last.id));
}
