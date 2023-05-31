import 'dart:html';

import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../provider/detect_renters_IDandName.dart';
import '../provider/renters_all-data.dart';
import '../provider/sub_transaction_all_data.dart';

class RentersTableRow extends StatelessWidget {
  String name;
  String number;
  DateTime date;
  double amount;
  String note;
  int id;
  var screenWith;

  RentersTableRow(
      {required this.amount,
      required this.date,
      required this.id,
      required this.name,
      required this.note,
      required this.number,
      required this.screenWith});

  @override
  Widget build(BuildContext context) {
    var provi = Provider.of<DetectRentersIdandName>(context, listen: false);
    String type = provi.type;
    var provi2 = Provider.of<RentersAllData>(context, listen: false);

//////////////////////////////////// for big screen ///////////////////////////////////
    if (screenWith > 800) {
      return Card(
        //color: Colors.black54,
        elevation: 3,

        child: Wrap(
          direction: Axis.horizontal,
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(5),
              //color: Colors.amber,
              width: 60,
              child: AutoSizeText(
                maxFontSize: 18,
                overflow: TextOverflow.ellipsis,
                id.toString(),
                style: GoogleFonts.roboto(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                maxLines: 1,
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(5),
              width: 140,
              // color: Colors.amber,
              child: AutoSizeText(
                maxFontSize: 18,
                //date.toString(),
                DateFormat.yMMMEd().format(date),
                style: GoogleFonts.roboto(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                maxLines: 1,
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 250,
              // color: Colors.amber,
              padding: EdgeInsets.all(5),
              child: AutoSizeText(
                maxFontSize: 19,
                name,
                style: GoogleFonts.roboto(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                maxLines: 1,
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(5),
              width: 140,
              //color: Colors.amber,
              child: AutoSizeText(
                maxFontSize: 18,
                number,
                style: GoogleFonts.roboto(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                maxLines: 1,
              ),
            ),
            /////////////////

            Consumer<SubTransactionAlldata>(builder: ((context, value, child) {
              // check
              var sum = value.SumAmount(id);
              //
              return Container(
                width: 100,
                //color: Colors.amber,
                alignment: Alignment.center,
                padding: EdgeInsets.all(5),
                child: AutoSizeText(
                  maxFontSize: 18,
                  sum.toString(),
                  style: GoogleFonts.roboto(
                      fontSize: 18,
                      color: sum <= -1 ? Colors.red : Colors.green,
                      fontWeight: FontWeight.bold),
                  maxLines: 1,
                ),
              );
            })),

            Container(
              width: 260,
              //color: Colors.black38,
              alignment: Alignment.center,
              padding: EdgeInsets.all(5),
              child: AutoSizeText(
                maxFontSize: 16,
                note,
                style: GoogleFonts.roboto(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                maxLines: 3,
              ),
            ),

            //
            Container(
              alignment: Alignment.center,
              width: 100,
              // color: Colors.deepPurpleAccent,
              padding: EdgeInsets.all(5),
              child: FloatingActionButton.extended(
                heroTag: null,
                onPressed: () {
                  //
                  final myProvider = Provider.of<DetectRentersIdandName>(
                      context,
                      listen: false);
                  myProvider.id = id;
                  myProvider.name = name;

                  //
                  Navigator.of(context).pushNamed('/SubTransactionScreen');
                },
                label: const Text('View'),
                icon: const Icon(
                  Icons.view_agenda,
                  size: 10,
                ),
                backgroundColor: Color.fromARGB(255, 212, 120, 7),
              ),
            ),
            ////
            type == 'admin'
                ? Container(
                    child: IconButton(
                      color: Colors.red,
                      icon: Icon(Icons.delete), // specify the icon to use
                      onPressed: () {
                        //
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                'Delete Alert',
                                style: TextStyle(color: Colors.redAccent),
                              ),
                              content: Text(
                                'Do you want to delete ' +
                                    '"' +
                                    name +
                                    '"' +
                                    ' ?',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 4, 66, 117)),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('No'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text('Yes'),
                                  onPressed: () {
                                    provi2
                                        .deletRentersWithAllData(id)
                                        .then((_) {
                                      Navigator.of(context).pop();
                                    });
                                  },
                                ),
                              ],
                            );
                          },
                        );

                        //
                        //     provi2.deletRentersWithAllData(id);
                        print('Button pressed!');
                      },
                    ),
                  )
                : Padding(padding: EdgeInsets.all(0.1)),
            ////
            //
          ],
        ),
      );
      //

      //////////////////////////////////////////////////////// // for phone ////////////////////////////////////////////
    } else if (screenWith <= 800) {
      return Card(
        //color: Colors.black54,
        elevation: 3,

        child: Wrap(
          direction: Axis.horizontal,
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(2),
              //color: Colors.amber,
              width: 50,
              child: AutoSizeText(
                maxFontSize: 18,
                overflow: TextOverflow.ellipsis,
                id.toString(),
                style: GoogleFonts.roboto(
                    fontSize: 13,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                maxLines: 1,
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 240,
              // color: Colors.amber,
              padding: EdgeInsets.all(2),
              child: AutoSizeText(
                maxFontSize: 19,
                name,
                style: GoogleFonts.roboto(
                    fontSize: 13,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                maxLines: 1,
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(2),
              width: 130,
              // color: Colors.amber,
              child: AutoSizeText(
                maxFontSize: 18,
                //date.toString(),
                DateFormat.yMMMEd().format(date),
                style: GoogleFonts.roboto(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                maxLines: 1,
              ),
            ),

            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(2),
              width: 110,
              // color: Colors.amber,
              child: AutoSizeText(
                maxFontSize: 18,
                number,
                style: GoogleFonts.roboto(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                maxLines: 1,
              ),
            ),
            /////////////////

            Consumer<SubTransactionAlldata>(builder: ((context, value, child) {
              // check
              var sum = value.SumAmount(id);
              //
              return Container(
                width: 110,
                //color: Colors.amber,
                alignment: Alignment.center,
                padding: EdgeInsets.all(2),
                child: AutoSizeText(
                  maxFontSize: 16,
                  sum.toString(),
                  style: GoogleFonts.roboto(
                      // fontSize: 15,
                      color: sum <= -1 ? Colors.red : Colors.green,
                      fontWeight: FontWeight.bold),
                  maxLines: 1,
                ),
              );
            })),

            Container(
              width: 200,
              //color: Colors.black38,
              alignment: Alignment.center,
              padding: EdgeInsets.all(2),
              child: AutoSizeText(
                maxFontSize: 16,
                note,
                style: GoogleFonts.roboto(
                    fontSize: 11,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                maxLines: 3,
              ),
            ),

            //
            Container(
              alignment: Alignment.center,
              width: 90,
              height: 35,
              // color: Colors.deepPurpleAccent,
              padding: EdgeInsets.all(2),
              child: FloatingActionButton.extended(
                heroTag: null,
                onPressed: () {
                  //
                  final myProvider = Provider.of<DetectRentersIdandName>(
                      context,
                      listen: false);
                  myProvider.id = id;
                  myProvider.name = name;

                  //
                  Navigator.of(context).pushNamed('/SubTransactionScreen');
                },
                label: const Text(
                  'View',
                  style: TextStyle(fontSize: 13),
                ),
                icon: const Icon(
                  Icons.view_agenda,
                  size: 9,
                ),
                backgroundColor: Color.fromARGB(255, 212, 120, 7),
              ),
            ),
            ////
            type == 'admin'
                ? Container(
                    child: IconButton(
                      color: Colors.red,
                      icon: Icon(Icons.delete), // specify the icon to use
                      onPressed: () {
                        //
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                'Delete Alert',
                                style: TextStyle(color: Colors.redAccent),
                              ),
                              content: Text(
                                'Do you want to delete ' +
                                    '"' +
                                    name +
                                    '"' +
                                    ' ?',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 4, 66, 117)),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('No'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text('Yes'),
                                  onPressed: () {
                                    provi2
                                        .deletRentersWithAllData(id)
                                        .then((_) {
                                      Navigator.of(context).pop();
                                    });
                                  },
                                ),
                              ],
                            );
                          },
                        );

                        //
                        //     provi2.deletRentersWithAllData(id);
                        print('Button pressed!');
                      },
                    ),
                  )
                : Padding(padding: EdgeInsets.all(0.1)),
            ////
            //
          ],
        ),
      );
      //
    } else {
      return Text('gg');
    }
  }
}
