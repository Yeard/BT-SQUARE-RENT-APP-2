import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../provider/detect_renters_IDandName.dart';
import '../provider/sub_transaction_all_data.dart';
import '../screen/login_page.dart';

class SubTransactionTableRow extends StatelessWidget {
  int rentetId;
  int id;
  DateTime date;
  double amount;
  String note;
  String type;
  double screenWith;
  SubTransactionTableRow(
      {required this.rentetId,
      required this.id,
      required this.date,
      required this.amount,
      required this.note,
      required this.type,
      required this.screenWith});

  @override
  Widget build(BuildContext context) {
    var provi = Provider.of<DetectRentersIdandName>(context, listen: false);
    String typee = provi.type;
    var provi2 = Provider.of<SubTransactionAlldata>(context, listen: false);

/////////////////////////////// for big screen //////////////////////////////////////////////////
    if (screenWith > 800) {
      return Card(
        //color: Colors.black54,

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
              width: 100,
              //color: Colors.amber,
              alignment: Alignment.center,
              padding: EdgeInsets.all(5),
              child: AutoSizeText(
                maxFontSize: 18,
                amount.toString(),
                style: GoogleFonts.roboto(
                    fontSize: 18,
                    color: amount <= -1 ? Colors.red : Colors.green,
                    fontWeight: FontWeight.bold),
                maxLines: 1,
              ),
            ),
            //
            Container(
              width: 260,
              //color: Colors.black38,
              alignment: Alignment.center,
              padding: EdgeInsets.all(5),
              child: AutoSizeText(
                maxFontSize: 16,
                type,
                style: GoogleFonts.roboto(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                maxLines: 3,
              ),
            ),
            //
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

            typee == 'admin'
                ? Container(
                    alignment: Alignment.center,
                    width: 100,
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
                                'Do you want to delete ID: ' +
                                    id.toString() +
                                    ' ?',
                                style: TextStyle(color: Colors.blue),
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
                                    provi2.deleteSubTransaction(id).then((_) {
                                      Navigator.of(context).pop();
                                    });
                                  },
                                ),
                              ],
                            );
                          },
                        );
                        //
                        // provi2.deleteSubTransaction(id);
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
      /////////////////////////////// for mobile //////////////////////////////////////////////////
    } else if (screenWith <= 800) {
      return Card(
        //color: Colors.black54,

        child: Wrap(
          direction: Axis.horizontal,
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(5),
              //color: Colors.amber,
              width: 50,
              child: AutoSizeText(
                maxFontSize: 18,
                overflow: TextOverflow.ellipsis,
                id.toString(),
                style: GoogleFonts.roboto(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                maxLines: 1,
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(5),
              width: 120,
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
              width: 100,
              //color: Colors.amber,
              alignment: Alignment.center,
              padding: EdgeInsets.all(5),
              child: AutoSizeText(
                maxFontSize: 15,
                amount.toString(),
                style: GoogleFonts.roboto(
                    //  fontSize: 15,
                    color: amount <= -1 ? Colors.red : Colors.green,
                    fontWeight: FontWeight.bold),
                maxLines: 1,
              ),
            ),
            //
            Container(
              width: 80,
              //color: Colors.black38,
              alignment: Alignment.center,
              padding: EdgeInsets.all(5),
              child: AutoSizeText(
                maxFontSize: 16,
                type,
                style: GoogleFonts.roboto(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                maxLines: 1,
              ),
            ),
            //
            Container(
              width: 250,
              //color: Colors.black38,
              alignment: Alignment.center,
              padding: EdgeInsets.all(5),
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

            typee == 'admin'
                ? Container(
                    alignment: Alignment.center,
                    width: 90,
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
                                'Do you want to delete ID: ' +
                                    id.toString() +
                                    ' ?',
                                style: TextStyle(color: Colors.blue),
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
                                    provi2.deleteSubTransaction(id).then((_) {
                                      Navigator.of(context).pop();
                                    });
                                  },
                                ),
                              ],
                            );
                          },
                        );
                        //
                        // provi2.deleteSubTransaction(id);
                      },
                    ),
                  )
                : Padding(padding: EdgeInsets.all(0.1)),
            ////
            //
          ],
        ),
      );
    } else {
      return Text('kk');
    }
  }
}
