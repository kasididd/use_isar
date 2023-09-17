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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Card(
          //   color: Colors.redAccent,
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: DefaultTextStyle(
          //       style: const TextStyle(color: Colors.white),
          //       child: Column(
          //         children: [
          //           const Text("Students"),
          //           Expanded(
          //             child: ListView.builder(
          //               itemCount: listStudents.length,
          //               itemBuilder: (context, index) {
          //                 return Row(
          //                   children: [
          //                     const Text("Namee"),
          //                     Text(listStudents[index].fullName ?? "No name"),
          //                   ],
          //                 );
          //               },
          //             ),
          //           ),
          //           const Text("data"),
          //           const Text("data"),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),

          Table(
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
                        onPressed: () async {
                          await readIsarStudent();
                          setState(() {});
                        },
                        child: const Text("Read"))),
                const Padding(padding: EdgeInsets.all(6), child: ElevatedButton(onPressed: readIsarEmails, child: Text("Read")))
              ]),
              const TableRow(children: [
                Padding(padding: EdgeInsets.all(6), child: ElevatedButton(onPressed: createIsarStudent, child: Text("Create"))),
                Padding(padding: EdgeInsets.all(6), child: ElevatedButton(onPressed: createIsarEmails, child: Text("Create")))
              ]),
              TableRow(children: [
                Padding(padding: const EdgeInsets.all(6), child: ElevatedButton(onPressed: () => updateIsarEmail(2), child: const Text("Update"))),
                Padding(padding: const EdgeInsets.all(6), child: ElevatedButton(onPressed: () => updateIsarEmail(2), child: const Text("Update")))
              ]),
              TableRow(children: [
                Padding(padding: const EdgeInsets.all(6), child: ElevatedButton(onPressed: () => deleteIsarStudents(2), child: const Text("Delete"))),
                Padding(padding: const EdgeInsets.all(6), child: ElevatedButton(onPressed: () => deleteIsarEmails(2), child: const Text("Delete")))
              ]),
            ],
          )
        ],
      ),
    );
  }
}
