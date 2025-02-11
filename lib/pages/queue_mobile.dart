import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//import 'package:laundry_firebase/variables/item_count_helper.dart';
import 'package:laundry_firebase/variables/variables.dart';

class MyQueueMobile extends StatefulWidget {
  const MyQueueMobile({super.key});

  @override
  State<MyQueueMobile> createState() => _MyQueueMobileState();
}

class _MyQueueMobileState extends State<MyQueueMobile> {
  bool bHeader = true;
  //List<ProductsRemaining> listRemaining = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      appBar: AppBar(
        title: const Text("M O B I L E Q U E U E"),
        toolbarHeight: 25,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.hardEdge,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                width: 200,
                color: Colors.blue,
                padding: const EdgeInsets.all(8.0),
                child: Column(children: <Widget>[
                  const SizedBox(
                    height: 1,
                  ),
                  _readData('Det'),
                ]),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                width: 200,
                color: Colors.blue,
                padding: const EdgeInsets.all(8.0),
                child: Column(children: <Widget>[
                  const SizedBox(
                    height: 1,
                  ),
                  _readData('Det'),
                ]),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                width: 200,
                color: Colors.blue,
                padding: const EdgeInsets.all(8.0),
                child: Column(children: <Widget>[
                  const SizedBox(
                    height: 1,
                  ),
                  _readData('Det'),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //read
  Widget _readData(String streamName) {
    bool zebra = false;
    //read
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('ProductsUsed')
          .orderBy('Date')
          .snapshots(),
      builder: (context, snapshot) {
        bHeader = true;
        List<TableRow> rowDatas = [];
        if (snapshot.hasData) {
          //header
          if (bHeader) {
            const rowData = TableRow(
                decoration: BoxDecoration(color: Colors.blueGrey),
                children: [
                  Text(
                    "Job #",
                    style: TextStyle(fontSize: 10),
                  ),
                  Text(
                    "Type",
                    style: TextStyle(fontSize: 10),
                  ),
                  Text(
                    "Item Name",
                    style: TextStyle(fontSize: 10),
                  )
                ]);
            rowDatas.add(rowData);
            bHeader = false;
          }

          //body
          final buffRecords = snapshot.data?.docs.reversed.toList();

          for (var buffRecord in buffRecords!) {
            if (zebra) {
              zebra = false;
            } else {
              zebra = true;
            }
            final rowData = TableRow(
                decoration:
                    BoxDecoration(color: zebra ? Colors.grey : Colors.white),
                children: [
                  Text("#${buffRecord['jobid']}",
                      style: const TextStyle(fontSize: 10)),
                  Text(
                    "${buffRecord['Type']}",
                    style: const TextStyle(fontSize: 10),
                  ),
                  Text(
                    mapBleNames[buffRecord['Id']] ??
                        mapFabNames[buffRecord['Id']] ??
                        mapDetNames[buffRecord['Id']] ??
                        mapOthNames[buffRecord['Id']]!,
                    style: const TextStyle(fontSize: 7),
                  )
                ]);
            rowDatas.add(rowData);
            //listRemaining.add(ProductsRemaining(buffRecord['Type'], buffRecord['Count']));
          }
        }

        /*
        for (int i = 0; i < listRemaining.length; i++) {
          ProductsRemaining prodRem = listRemaining[i];

          log("watata${prodRem.count}");
        }
        */

        return Table(
          children: rowDatas,
        );
      },
    );
  }

  static convertTimeStamp(Timestamp timestamp) {
    //assert(timestamp != null);
    String convertedDate;
    convertedDate = DateFormat.yMMMd().add_jm().format(timestamp.toDate());
    return convertedDate;
  }
}
