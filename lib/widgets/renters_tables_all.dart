import 'package:auto_size_text/auto_size_text.dart';
import 'package:bt_square_rent_app/widgets/renters_table_row.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../provider/detect_renters_IDandName.dart';
import '../provider/renters_all-data.dart';
import 'customScrollbarWithSingleChildScrollView.dart';

class RentersTable extends StatelessWidget {
  var screenWith;
  RentersTable(this.screenWith);

  @override
  Widget build(BuildContext context) {
    var provi = Provider.of<DetectRentersIdandName>(context, listen: true);
    String typee = provi.type;
    ScrollController con = ScrollController();

    //
    //////////////////////////////////////////////////////// // for big screen ////////////////////////////////////////////
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
                      width: 250,
                      //  color: Color.fromARGB(255, 141, 115, 187),
                      padding: EdgeInsets.all(5),
                      child: AutoSizeText(
                        maxFontSize: 22,
                        'NAME',
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
                      //  color: Color.fromARGB(255, 22, 171, 74),
                      child: AutoSizeText(
                        maxFontSize: 22,
                        'NUMBER',
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
                    typee != 'admin'
                        ? Container(
                            alignment: Alignment.center,
                            width: 100,
                            margin: EdgeInsets.only(right: 40),
                            //color: Color.fromARGB(96, 225, 43, 43),
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
                        : Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(right: 30),
                            width: 150,
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
                    //
                  ],
                ),
              ),
              ////////////////////////////////
              Consumer<RentersAllData>(builder: ((context, value, child) {
                return Container(
                  child: ListView.builder(
                      reverse: true,
                      padding: const EdgeInsets.all(8),
                      shrinkWrap: true,
                      itemCount: value.allRenters.length,
                      itemBuilder: (BuildContext context, int index) {
                        return RentersTableRow(
                            amount: value.allRenters[index].amount,
                            date: value.allRenters[index].date,
                            id: value.allRenters[index].id,
                            name: value.allRenters[index].name,
                            note: value.allRenters[index].note,
                            number: value.allRenters[index].number,
                            screenWith: screenWith);
                      }),
                );
              })),
            ],
          ),
        ),
      );
      //
      //////////////////////////////////////////////////////// // for phone ////////////////////////////////////////////
    } else if (screenWith <= 800) {
      return Container(
        margin: EdgeInsets.only(left: 20, right: 0, bottom: 40, top: 1),
        width: double.infinity,
        padding: EdgeInsets.all(1),
        child: CustomScrollbarWithSingleChildScrollView(
          controller: con,
          scrollDirection: Axis.horizontal,
          child: Container(
            width: 1210,
            child: Card(
              color: Colors.white38,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
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
                                fontSize: 16,
                                color: Color.fromARGB(255, 10, 27, 56),
                                fontWeight: FontWeight.bold),
                            maxLines: 1,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 240,
                          //  color: Color.fromARGB(255, 141, 115, 187),
                          padding: EdgeInsets.all(5),
                          child: AutoSizeText(
                            maxFontSize: 22,
                            'NAME',
                            style: GoogleFonts.roboto(
                                fontSize: 16,
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
                                fontSize: 16,
                                color: Color.fromARGB(255, 10, 27, 56),
                                fontWeight: FontWeight.bold),
                            maxLines: 1,
                          ),
                        ),

                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(5),
                          width: 120,
                          //  color: Color.fromARGB(255, 22, 171, 74),
                          child: AutoSizeText(
                            maxFontSize: 22,
                            'NUMBER',
                            style: GoogleFonts.roboto(
                                fontSize: 16,
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
                                fontSize: 16,
                                color: Color.fromARGB(255, 10, 27, 56),
                                fontWeight: FontWeight.bold),
                            maxLines: 1,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 190,
                          //  color: Color.fromARGB(96, 240, 198, 198),
                          padding: EdgeInsets.all(5),
                          child: AutoSizeText(
                            maxFontSize: 22,
                            'NOTE',
                            style: GoogleFonts.roboto(
                                fontSize: 16,
                                color: Color.fromARGB(255, 10, 27, 56),
                                fontWeight: FontWeight.bold),
                            maxLines: 3,
                          ),
                        ),

                        //
                        typee != 'admin'
                            ? Container(
                                alignment: Alignment.center,
                                width: 90,
                                margin: EdgeInsets.only(right: 40),
                                //color: Color.fromARGB(96, 225, 43, 43),
                                padding: EdgeInsets.all(5),
                                child: AutoSizeText(
                                  maxFontSize: 22,
                                  ' ACTION',
                                  style: GoogleFonts.roboto(
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 10, 27, 56),
                                      fontWeight: FontWeight.bold),
                                  maxLines: 3,
                                ),
                              )
                            : Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(right: 30),
                                width: 140,
                                //  color: Color.fromARGB(96, 225, 43, 43),
                                padding: EdgeInsets.all(5),
                                child: AutoSizeText(
                                  maxFontSize: 22,
                                  ' ACTION',
                                  style: GoogleFonts.roboto(
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 10, 27, 56),
                                      fontWeight: FontWeight.bold),
                                  maxLines: 3,
                                ),
                              )
                        //
                      ],
                    ),
                  ),
                  ////////////////////////////////
                  Consumer<RentersAllData>(builder: ((context, value, child) {
                    return Container(
                      child: ListView.builder(
                          reverse: true,
                          padding: const EdgeInsets.all(8),
                          shrinkWrap: true,
                          itemCount: value.allRenters.length,
                          itemBuilder: (BuildContext context, int index) {
                            return RentersTableRow(
                                amount: value.allRenters[index].amount,
                                date: value.allRenters[index].date,
                                id: value.allRenters[index].id,
                                name: value.allRenters[index].name,
                                note: value.allRenters[index].note,
                                number: value.allRenters[index].number,
                                screenWith: screenWith);
                          }),
                    );
                  })),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return Text('gg');
    }
  }
}
