import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../model/sub_transactions_renter.dart';
import '../provider/detect_renters_IDandName.dart';
import '../provider/sub_transaction_all_data.dart';
import 'Sub_transaction_table_row.dart';
import 'customScrollbarWithSingleChildScrollView.dart';

class SubTransactionTable extends StatelessWidget {
  int rentersId;
  double screenWith;
  SubTransactionTable({required this.rentersId, required this.screenWith});

  @override
  Widget build(BuildContext context) {
    var provi = Provider.of<DetectRentersIdandName>(context, listen: true);
    String type = provi.type;
    ScrollController con = ScrollController();
////////////////////////////////////// for big screen ///////////////////////////////////////////
    if (screenWith > 800) {
      return Container(
        margin: EdgeInsets.only(left: 40, right: 40, bottom: 60, top: 1),
        width: double.infinity,
        padding: EdgeInsets.all(30),
        child: Card(
          color: Colors.white38,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            //

            children: [
              //
              Container(
                padding: EdgeInsets.only(top: 30, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Total Amount= ',
                      style: GoogleFonts.roboto(
                          fontSize: 22,
                          color: Color.fromARGB(255, 10, 27, 56),
                          fontWeight: FontWeight.bold),
                    ),
                    //
                    Consumer<SubTransactionAlldata>(
                        builder: ((context, value, child) {
                      // check
                      var sum = value.SumAmount(rentersId);
                      //
                      return Container(
                        // width: 100,
                        //color: Colors.amber,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(5),
                        child: AutoSizeText(
                          maxFontSize: 22,
                          sum.toString(),
                          style: GoogleFonts.roboto(
                              fontSize: 22,
                              color: sum <= -1 ? Colors.red : Colors.green,
                              fontWeight: FontWeight.bold),
                          maxLines: 1,
                        ),
                      );
                    })),
                    //
                  ],
                ),
              ),
              //
              Column(
                children: [
                  /////////////////////////////////
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                    child: Wrap(
                      direction: Axis.horizontal,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(5),
                          //  color: Color.fromARGB(255, 159, 11, 164),
                          width: 60,
                          child: AutoSizeText(
                            maxFontSize: 22,
                            overflow: TextOverflow.ellipsis,
                            'ID',
                            style: GoogleFonts.roboto(
                                fontSize: 22,
                                color: Color.fromARGB(255, 10, 27, 56),
                                fontWeight: FontWeight.bold),
                            maxLines: 1,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(5),
                          width: 140,
                          //  color: Colors.amber,
                          child: AutoSizeText(
                            maxFontSize: 22,
                            'DATE',
                            style: GoogleFonts.roboto(
                                fontSize: 22,
                                color: Color.fromARGB(255, 10, 27, 56),
                                fontWeight: FontWeight.bold),
                            maxLines: 1,
                          ),
                        ),

                        Container(
                          alignment: Alignment.center,
                          width: 100,
                          // color: Color.fromARGB(255, 67, 64, 55),
                          padding: EdgeInsets.all(5),
                          child: AutoSizeText(
                            maxFontSize: 22,
                            'AMOUNT',
                            style: GoogleFonts.roboto(
                                fontSize: 22,
                                color: Color.fromARGB(255, 10, 27, 56),
                                fontWeight: FontWeight.bold),
                            maxLines: 1,
                          ),
                        ),
                        //
                        Container(
                          alignment: Alignment.center,
                          width: 260,
                          //  color: Color.fromARGB(96, 240, 198, 198),
                          padding: EdgeInsets.all(5),
                          child: AutoSizeText(
                            maxFontSize: 22,
                            'Type',
                            style: GoogleFonts.roboto(
                                fontSize: 22,
                                color: Color.fromARGB(255, 10, 27, 56),
                                fontWeight: FontWeight.bold),
                            maxLines: 3,
                          ),
                        ),
                        //
                        Container(
                          alignment: Alignment.center,
                          width: 260,
                          //  color: Color.fromARGB(96, 240, 198, 198),
                          padding: EdgeInsets.all(5),
                          child: AutoSizeText(
                            maxFontSize: 22,
                            'NOTE',
                            style: GoogleFonts.roboto(
                                fontSize: 22,
                                color: Color.fromARGB(255, 10, 27, 56),
                                fontWeight: FontWeight.bold),
                            maxLines: 3,
                          ),
                        ),

                        //
                        type == 'admin'
                            ? Container(
                                alignment: Alignment.center,
                                width: 100,
                                //  color: Color.fromARGB(96, 225, 43, 43),
                                padding: EdgeInsets.all(5),
                                child: AutoSizeText(
                                  maxFontSize: 22,
                                  'ACTION',
                                  style: GoogleFonts.roboto(
                                      fontSize: 22,
                                      color: Color.fromARGB(255, 10, 27, 56),
                                      fontWeight: FontWeight.bold),
                                  maxLines: 3,
                                ),
                              )
                            : Padding(padding: EdgeInsets.all(.1)),
                        //
                      ],
                    ),
                  ),
                  ////////////////////////////////
                  Consumer<SubTransactionAlldata>(
                      builder: ((context, value, child) {
                    List<SubTransRenter> filterdrData =
                        value.filtertransaction(rentersId);
                    // check
                    var sum = value.SumAmount(rentersId);

                    //
                    return Container(
                      child: ListView.builder(
                          reverse: true,
                          padding: const EdgeInsets.all(8),
                          shrinkWrap: true,
                          itemCount: filterdrData.length,
                          itemBuilder: (BuildContext context, int index) {
                            return SubTransactionTableRow(
                              rentetId: filterdrData[index].rentetId,
                              id: filterdrData[index].iD,
                              date: filterdrData[index].date,
                              amount: filterdrData[index].amount,
                              type: filterdrData[index].type,
                              note: filterdrData[index].note,
                              screenWith: screenWith,
                            );
                          }),
                    );
                  })),
                ],
              ),
            ],
          ),
        ),
      );
      //

      ////////////////////////////////// for mobile /////////////////////////////////////////////////////
    } else if (screenWith <= 800) {
      return Container(
        margin: EdgeInsets.only(left: 20, right: 0, bottom: 30, top: 1),
        width: double.infinity,
        padding: EdgeInsets.only(bottom: 15, top: 2),
        child: CustomScrollbarWithSingleChildScrollView(
          controller: con,
          scrollDirection: Axis.horizontal,
          child: Container(
            width: 840,
            child: Card(
              color: Colors.white38,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                //

                children: [
                  //
                  Container(
                    padding: EdgeInsets.only(top: 20, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Total Amount= ',
                          style: GoogleFonts.roboto(
                              fontSize: 20,
                              color: Color.fromARGB(255, 10, 27, 56),
                              fontWeight: FontWeight.bold),
                        ),
                        //
                        Consumer<SubTransactionAlldata>(
                            builder: ((context, value, child) {
                          // check
                          var sum = value.SumAmount(rentersId);
                          //
                          return Container(
                            // width: 100,
                            //color: Colors.amber,
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(5),
                            child: AutoSizeText(
                              maxFontSize: 20,
                              sum.toString(),
                              style: GoogleFonts.roboto(
                                  fontSize: 22,
                                  color: sum <= -1 ? Colors.red : Colors.green,
                                  fontWeight: FontWeight.bold),
                              maxLines: 1,
                            ),
                          );
                        })),
                        //
                      ],
                    ),
                  ),
                  //
                  Column(
                    children: [
                      /////////////////////////////////
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                        child: Wrap(
                          direction: Axis.horizontal,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          alignment: WrapAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(5),
                              //  color: Color.fromARGB(255, 159, 11, 164),
                              width: 50,
                              child: AutoSizeText(
                                maxFontSize: 22,
                                overflow: TextOverflow.ellipsis,
                                'ID',
                                style: GoogleFonts.roboto(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 10, 27, 56),
                                    fontWeight: FontWeight.bold),
                                maxLines: 1,
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(5),
                              width: 130,
                              //  color: Colors.amber,
                              child: AutoSizeText(
                                maxFontSize: 22,
                                'DATE',
                                style: GoogleFonts.roboto(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 10, 27, 56),
                                    fontWeight: FontWeight.bold),
                                maxLines: 1,
                              ),
                            ),

                            Container(
                              alignment: Alignment.center,
                              width: 90,
                              // color: Color.fromARGB(255, 67, 64, 55),
                              padding: EdgeInsets.all(5),
                              child: AutoSizeText(
                                maxFontSize: 22,
                                'AMOUNT',
                                style: GoogleFonts.roboto(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 10, 27, 56),
                                    fontWeight: FontWeight.bold),
                                maxLines: 1,
                              ),
                            ),
                            //
                            Container(
                              alignment: Alignment.center,
                              width: 80,
                              //  color: Color.fromARGB(96, 240, 198, 198),
                              padding: EdgeInsets.all(5),
                              child: AutoSizeText(
                                maxFontSize: 22,
                                'Type',
                                style: GoogleFonts.roboto(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 10, 27, 56),
                                    fontWeight: FontWeight.bold),
                                maxLines: 3,
                              ),
                            ),
                            //
                            Container(
                              alignment: Alignment.center,
                              width: 250,
                              //  color: Color.fromARGB(96, 240, 198, 198),
                              padding: EdgeInsets.all(5),
                              child: AutoSizeText(
                                maxFontSize: 22,
                                'NOTE',
                                style: GoogleFonts.roboto(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 10, 27, 56),
                                    fontWeight: FontWeight.bold),
                                maxLines: 3,
                              ),
                            ),

                            //
                            type == 'admin'
                                ? Container(
                                    alignment: Alignment.center,
                                    width: 100,
                                    //  color: Color.fromARGB(96, 225, 43, 43),
                                    padding: EdgeInsets.all(5),
                                    child: AutoSizeText(
                                      maxFontSize: 22,
                                      'ACTION',
                                      style: GoogleFonts.roboto(
                                          fontSize: 18,
                                          color:
                                              Color.fromARGB(255, 10, 27, 56),
                                          fontWeight: FontWeight.bold),
                                      maxLines: 3,
                                    ),
                                  )
                                : Padding(padding: EdgeInsets.all(.1)),
                            //
                          ],
                        ),
                      ),
                      ////////////////////////////////
                      Consumer<SubTransactionAlldata>(
                          builder: ((context, value, child) {
                        List<SubTransRenter> filterdrData =
                            value.filtertransaction(rentersId);
                        // check
                        var sum = value.SumAmount(rentersId);

                        //
                        return Container(
                          child: ListView.builder(
                              reverse: true,
                              padding: const EdgeInsets.all(8),
                              shrinkWrap: true,
                              itemCount: filterdrData.length,
                              itemBuilder: (BuildContext context, int index) {
                                return SubTransactionTableRow(
                                  rentetId: filterdrData[index].rentetId,
                                  id: filterdrData[index].iD,
                                  date: filterdrData[index].date,
                                  amount: filterdrData[index].amount,
                                  type: filterdrData[index].type,
                                  note: filterdrData[index].note,
                                  screenWith: screenWith,
                                );
                              }),
                        );
                      })),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return Text('kk');
    }
  }
}
