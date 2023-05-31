import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'dart:math';

import '../provider/sub_transaction_all_data.dart';
import 'custom_toast.dart';

class SubTransactionAdd extends StatefulWidget {
  int renterID;
  String type;
  double screenWith;
  SubTransactionAdd(
      {required this.renterID, required this.type, required this.screenWith});
  @override
  State<SubTransactionAdd> createState() => _SubTransactionAddState();
}

class _SubTransactionAddState extends State<SubTransactionAdd> {
  final TextEditingController _controllerInitialAmount =
      TextEditingController();
  final TextEditingController _controllerNote = TextEditingController();
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now(); // default selected date
  }

  @override
  void dispose() {
    _controllerInitialAmount.dispose();
    _controllerNote.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    var subTransaction =
        Provider.of<SubTransactionAlldata>(context, listen: false);
    FocusNode _focusNode = FocusNode();
////////////////////////////////// for big screen  ///////////////////////////////////////////////////
    if (widget.screenWith > 800) {
      return Container(
        width: 480,
        child: Card(
          shadowColor: Colors.black,
          elevation: 1,
          margin: EdgeInsets.all(20),
          color: Colors.white54,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Wrap(children: [
            //
            //date
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(bottom: 2, top: 10, left: 15, right: 15),
              child: Text(
                'Date:',
                style: GoogleFonts.roboto(
                    fontSize: 22,
                    color: Color.fromARGB(255, 24, 92, 209),
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 15, right: 15),
              child: InkWell(
                onTap: () => _selectDate(context),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}',
                        style: GoogleFonts.alike(
                            fontSize: 20,
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold),
                      ),
                      const Icon(
                        Icons.calendar_today,
                        color: Color.fromARGB(255, 24, 92, 209),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //
            //
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(bottom: 2, top: 10, left: 15, right: 15),
              child: Text(
                'Amount:',
                style: GoogleFonts.roboto(
                    fontSize: 22,
                    color: Color.fromARGB(255, 24, 92, 209),
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 15, right: 15),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter a search term',
                ),
                cursorColor: Colors.blue,
                style: GoogleFonts.rubik(fontSize: 20, color: Colors.black),
                controller: _controllerInitialAmount,
              ),
            ),
            //

            //
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(bottom: 2, top: 10, left: 15, right: 15),
              child: Text(
                'Note:',
                style: GoogleFonts.roboto(
                    fontSize: 22,
                    color: Color.fromARGB(255, 24, 92, 209),
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: TextField(
                maxLines: null, // allow unlimited lines
                keyboardType: TextInputType.multiline,
                minLines: 2,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter a search term',
                ),
                cursorColor: Colors.blue,
                style: GoogleFonts.rubik(fontSize: 20, color: Colors.black),
                controller: _controllerNote,
              ),
            ),
            //
            //////////////

            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(bottom: 20),
              child: FloatingActionButton.extended(
                onPressed: () {
                  try {
                    double amount = double.parse(_controllerInitialAmount.text);
                    String note = _controllerNote.text;
                    DateTime date = _selectedDate;
                    Random randomm = Random();
                    int rentetId = widget.renterID;

                    int iD = randomm.nextInt(100);
                    _controllerInitialAmount.clear();
                    _controllerNote.clear();

                    subTransaction
                        .addNewSubTransaction(
                            rentetId, iD, date, amount, note, widget.type)
                        .then((p) {
                      CustomToast.showToast(context, 'Add Successfully', 1);
                      print('sub added+');
                    });
                    //
                    //CustomToast.showToast(context, 'Add Successfully', 1);

                  } catch (e) {
                    _controllerInitialAmount.clear();
                    _controllerNote.clear();

                    CustomToast.showToast(
                        context, 'Something is wrong; please try again!', 2);
                  }
                },
                label: const Text('Add'),
                icon: const Icon(
                  Icons.done,
                  size: 25,
                ),
                backgroundColor: Color.fromARGB(255, 24, 92, 209),
              ),
            ),
            //////////////
          ]),
        ),
      );
      //
    }
/////////////////////////////////////// for mobile //////////////////////////////////////////////////////////
    else if (widget.screenWith <= 800) {
      return Container(
        alignment: Alignment.center,
        width: 340,
        child: Card(
          shadowColor: Colors.black,
          //elevation: 1,
          margin: EdgeInsets.all(20),
          color: Colors.white54,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Wrap(children: [
            //
            //date
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(bottom: 2, top: 10, left: 15, right: 15),
              child: Text(
                'Date:',
                style: GoogleFonts.roboto(
                    fontSize: 18,
                    color: Color.fromARGB(255, 24, 92, 209),
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
            ),
            Container(
              height: 40,
              width: double.infinity,
              padding: EdgeInsets.only(left: 15, right: 15),
              child: InkWell(
                onTap: () => _selectDate(context),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}',
                        style: GoogleFonts.alike(
                            fontSize: 16,
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold),
                      ),
                      const Icon(
                        Icons.calendar_today,
                        color: Color.fromARGB(255, 24, 92, 209),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //
            //
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(bottom: 2, top: 10, left: 15, right: 15),
              child: Text(
                'Amount:',
                style: GoogleFonts.roboto(
                    fontSize: 18,
                    color: Color.fromARGB(255, 24, 92, 209),
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
            ),
            Container(
              height: 40,
              width: double.infinity,
              padding: EdgeInsets.only(left: 15, right: 15),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Amount',
                ),
                cursorColor: Colors.blue,
                style: GoogleFonts.rubik(fontSize: 16, color: Colors.black),
                controller: _controllerInitialAmount,
              ),
            ),
            //

            //
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(bottom: 2, top: 10, left: 15, right: 15),
              child: Text(
                'Note:',
                style: GoogleFonts.roboto(
                    fontSize: 18,
                    color: Color.fromARGB(255, 24, 92, 209),
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: TextField(
                // allow unlimited lines
                keyboardType: TextInputType.multiline,
                focusNode: _focusNode,
                minLines: 2,
                maxLines: 3,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Note',
                ),
                cursorColor: Colors.blue,
                style: GoogleFonts.rubik(fontSize: 16, color: Colors.black),
                controller: _controllerNote,
              ),
            ),
            //
            //////////////

            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(bottom: 20),
              child: FloatingActionButton.extended(
                onPressed: () {
                  try {
                    double amount = double.parse(_controllerInitialAmount.text);
                    String note = _controllerNote.text;
                    DateTime date = _selectedDate;
                    Random randomm = Random();
                    int rentetId = widget.renterID;

                    int iD = randomm.nextInt(100);
                    _controllerInitialAmount.clear();
                    _controllerNote.clear();

                    subTransaction
                        .addNewSubTransaction(
                            rentetId, iD, date, amount, note, widget.type)
                        .then((p) {
                      CustomToast.showToast(context, 'Add Successfully', 1);
                      print('sub added+');
                    });
                    //
                    _focusNode.unfocus();
                  } catch (e) {
                    _controllerInitialAmount.clear();
                    _controllerNote.clear();

                    CustomToast.showToast(
                        context, 'Something is wrong; please try again!', 2);
                  }
                },
                label: const Text('Add'),
                icon: const Icon(
                  Icons.done,
                  size: 25,
                ),
                backgroundColor: Color.fromARGB(255, 24, 92, 209),
              ),
            ),
            //////////////
          ]),
        ),
      );
    } else {
      return Text('hh');
    }
  }
}
