import 'dart:async';

import 'package:flutter/material.dart';
import 'package:use_isar/data/database/function/crude_isar.dart';
import 'package:use_isar/data/database/mapping/mapping_isar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<Student> listStudents = [];
  List<Email> listEmails = [];
  bool selectStudents = true;
  final stcSetDisplay = StreamController<bool>.broadcast();
  @override
  void initState() {
    Stream<dynamic> queryStream = isar.emails.watchLazy();
    queryStream.listen((event) async {
      await readEmail();
      stcSetDisplay.add(false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const txtStyleButton = TextStyle(fontSize: 32);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            color: Colors.redAccent,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: DefaultTextStyle(
                style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w400),
                child: StreamBuilder<bool>(
                    stream: stcSetDisplay.stream,
                    builder: (context, snapshot) {
                      return Column(
                        children: [
                          (listStudents.isNotEmpty && listEmails.isNotEmpty)
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: selectStudents ? null : () => {selectStudents = true, stcSetDisplay.add(false)},
                                      child: const Text("Students"),
                                    ),
                                    ElevatedButton(
                                      onPressed: !selectStudents ? null : () => {selectStudents = false, stcSetDisplay.add(false)},
                                      child: const Text("Emails"),
                                    ),
                                  ],
                                )
                              : Text(listStudents.isNotEmpty
                                  ? "Students"
                                  : listEmails.isNotEmpty
                                      ? "Emails"
                                      : "No data"),
                          SizedBox(
                            height: 520,
                            child: Container(
                              decoration: const BoxDecoration(
                                  border: Border(
                                top: BorderSide(),
                              )),
                              child: ListView.builder(
                                shrinkWrap: false,
                                itemCount: (listStudents.isNotEmpty && listEmails.isNotEmpty)
                                    ? [listStudents.length, listEmails.length][selectStudents ? 0 : 1]
                                    : listStudents.isNotEmpty
                                        ? listStudents.length
                                        : listEmails.length,
                                itemBuilder: (context, index) {
                                  if ((listStudents.isNotEmpty && selectStudents) || listEmails.isEmpty) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
                                      decoration: const BoxDecoration(border: Border(bottom: BorderSide(), left: BorderSide(), right: BorderSide())),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                "name",
                                                style: TextStyle(fontWeight: FontWeight.bold),
                                              ),
                                              Text(listStudents[index].fullName ?? "No name"),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                "ClassRoom",
                                                style: TextStyle(fontWeight: FontWeight.bold),
                                              ),
                                              Text(listStudents[index].classRoom.nameClass ?? "No name"),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                "status",
                                                style: TextStyle(fontWeight: FontWeight.bold),
                                              ),
                                              Text(listStudents[index].status.name),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                  return Container(
                                    decoration: const BoxDecoration(border: Border(bottom: BorderSide())),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "Namee",
                                              style: TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                            Text(listEmails[index].title),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "status",
                                              style: TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                            Text(listEmails[index].status.name),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
              ),
            ),
          ),
          DefaultTextStyle(
            style: const TextStyle(fontSize: 32, color: Colors.red, fontWeight: FontWeight.bold),
            child: Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              // defaultColumnWidth: const FixedColumnWidth(12¸),
              children: [
                const TableRow(children: [
                  Text(
                    "Students",
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Emails",
                    textAlign: TextAlign.center,
                  ),
                ]),
                TableRow(children: [
                  Padding(
                      padding: const EdgeInsets.all(6),
                      child: ElevatedButton(
                          onPressed: readStudents,
                          child: const Text(
                            "Read",
                            style: txtStyleButton,
                          ))),
                  Padding(
                      padding: const EdgeInsets.all(6),
                      child: ElevatedButton(
                          onPressed: readEmail,
                          child: const Text(
                            "Read",
                            style: txtStyleButton,
                          )))
                ]),
                TableRow(children: [
                  Padding(
                      padding: const EdgeInsets.all(6),
                      child: ElevatedButton(
                          onPressed: () => {createIsarStudent().then((value) => readStudents())},
                          child: const Text(
                            "Create",
                            style: txtStyleButton,
                          ))),
                  Padding(
                      padding: const EdgeInsets.all(6),
                      child: ElevatedButton(
                          onPressed: () => {createIsarEmails().then((value) => readEmail())},
                          child: const Text(
                            "Create",
                            style: txtStyleButton,
                          )))
                ]),
                TableRow(children: [
                  Padding(
                      padding: const EdgeInsets.all(6),
                      child: ElevatedButton(
                          onPressed: () => {updateIsarStudent().then((value) => readStudents())},
                          child: const Text(
                            "Update",
                            style: txtStyleButton,
                          ))),
                  Padding(
                      padding: const EdgeInsets.all(6),
                      child: ElevatedButton(
                          onPressed: () => {updateIsarEmail(2).then((value) => readEmail())},
                          child: const Text(
                            "Update",
                            style: txtStyleButton,
                          )))
                ]),
                TableRow(children: [
                  Padding(
                      padding: const EdgeInsets.all(6),
                      child: ElevatedButton(
                          onPressed: () => {deleteIsarStudents(2).then((value) => readStudents())},
                          child: const Text(
                            "Delete",
                            style: txtStyleButton,
                          ))),
                  Padding(
                      padding: const EdgeInsets.all(6),
                      child: ElevatedButton(
                          onPressed: () => {deleteIsarEmails(2).then((value) => readEmail())},
                          child: const Text(
                            "Delete",
                            style: txtStyleButton,
                          )))
                ]),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future readEmail() async {
    // await readIsarEmails().then((value) => {listEmails = value, stcSetDisplay.add(false)});
    await readIsarEmails().then((value) => {listEmails = value});
  }

  void readStudents() async {
    await readIsarStudent().then((value) => listStudents = value);
    stcSetDisplay.add(false);
  }
}
