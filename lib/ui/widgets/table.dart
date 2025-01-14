import 'package:client_contact_manager/data/client_model.dart';
import 'package:client_contact_manager/ui/widgets/cell.dart';
import 'package:flutter/material.dart';

class MyTable extends StatelessWidget {
  final List<Client> allClients;
  const MyTable({super.key, required this.allClients});

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(color: Colors.black),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        const TableRow(children: [
          MyCell(content: 'Client', header: true),
          MyCell(content: 'Contact 1', header: true),
          MyCell(content: 'Contact 2', header: true),
          MyCell(content: 'Contact 3', header: true),
          MyCell(content: 'Last Updated', header: true),
        ]),
        ...allClients.map((client) {
          return TableRow(children: [
            MyCell(
              content: client.name,
              header: false,
            ),
            MyCell(
                content:'${client.contact1.name}\n${client.contact1.email}\n${client.contact1.phnNum}',
                header: false),
            MyCell(
                content:'${client.contact2.name}\n${client.contact2.email}\n${client.contact2.phnNum}',
                header: false),
            MyCell(
                content:'${client.contact3.name}\n${client.contact3.email}\n${client.contact3.phnNum}',
                header: false),
            MyCell(
                content:'${client.lastUpdated.day}/${client.lastUpdated.month}/${client.lastUpdated.year}',
                header: false),
          ]);
        }),
      ],
    );
  }
}
