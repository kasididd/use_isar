// ignore_for_file: avoid_print
import 'package:use_isar/data/database/mapping/mapping_isar.dart';

void readIsarEmails() async {
  List<Email>? emails = await isar.emails.where().findAll();
  if (kDebugMode) {
    print(emails.map((e) => e.toJson()).toList());
  }
}

Future<void> readIsarStudent() async {
  List<Student>? students = await isar.students.where().findAll();
  final ems = isar.students.filter().idLessThan(3).findAll();
  print((await ems).map((e) => e.toJson()).toList());
  print(students.map((e) => e.toJson()).toList());
}

void createIsarStudent() async {
  var newStudents = Student(classRoom: ClassRoom()..nameClass = "sofware");
  newStudents
    ..fullName = 'Kasidit Wansudon'
    ..status = Status.sent;
  isar.writeTxn(() => isar.students.put(newStudents));
}

void createIsarEmails() async {
  var newEmail = addEmail;
  newEmail.status = Status.sent;
  final recipient = Recipient()..address = 'new address';
  print(recipient);
  newEmail.recipients = [recipient];
  await isar.writeTxn(() async {
    await isar.emails.putAll([newEmail]).then(print); // insert & update
  });
}

void updateIsarStudent() async {
  var newStudents = Student(classRoom: ClassRoom()..nameClass = "sofware");
  // newStudents.id = 2;
  newStudents
    ..fullName = 'kasiddi'
    ..status = Status.sent;
  await isar.writeTxn(() async {
    await isar.students.putAll([newStudents]); // insert & update
  });
}

void updateIsarEmail(int id) async {
  var newEmail = addEmail;
  if (isar.emails.where().idEqualTo(id).isEmptySync()) return;
  newEmail.id = 2;
  newEmail.status = Status.sent;
  final recipient = Recipient()..address = 'me';
  newEmail.recipients = [recipient];
  await isar.writeTxn(() async {
    await isar.emails.putAll([newEmail]).then(print); // insert & update
  });
}

void deleteIsarStudents(int id) async {
  isar.writeTxnSync(() => isar.students.deleteSync(id));
}

void deleteIsarEmails(int id) async {
  isar.writeTxnSync(() => isar.emails.deleteSync(isar.emails.where().findAllSync().last.id));
}
