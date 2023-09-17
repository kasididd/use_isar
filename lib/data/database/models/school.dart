import 'dart:math';

import 'package:isar/isar.dart';
part 'school.g.dart';

@collection
class Student {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment

  @Index(type: IndexType.value)
  String? studentID;

  @Index(type: IndexType.value)
  String? fullName;

  final ClassRoom classRoom;
  Student({required this.classRoom});

  @enumerated
  Status status = Status.pending;
}

@embedded
class ClassRoom {
  int? classId;
  String? nameClass;
  toJson() => {'classID': classId, 'nameClass': nameClass};
}

extension JsonStudent on Student {
  toJson() {
    return {'id': id, 'studentID': studentID, 'name': fullName, 'class': classRoom.toJson()};
  }
}

@collection
class Email {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment

  @Index(type: IndexType.value)
  String title;

  List<Recipient>? recipients;

  @enumerated
  Status status = Status.pending;
  Email({required this.title});
  toJson() {
    return {'id': id, 'title': title, 'recipients': recipients?.map((e) => e.toJson()).toList(), 'status': status};
  }
}

@embedded
class Recipient {
  String? name;

  String? address;
}

enum Status {
  draft,
  pending,
  sent,
}

extension RecipientJson on Recipient {
  Map<String, dynamic> toJson() => {"name": name, "address": address};
}

const _chars = ["naLan", "join", "popy", "kinder"];
Random _rnd = Random();

Email get addEmail => Email(title: _chars[_rnd.nextInt(_chars.length)]);
