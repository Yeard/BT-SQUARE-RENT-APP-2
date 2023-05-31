import 'dart:html';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../provider/detect_renters_IDandName.dart';
import '../provider/renters_all-data.dart';
import '../provider/sub_transaction_all_data.dart';
import 'custom_toast.dart';
import 'dart:async';

class AddAccount extends StatefulWidget {
  var screenWith;
  AddAccount(this.screenWith);

  @override
  State<AddAccount> createState() => _AddAccountState();
}

class _AddAccountState extends State<AddAccount> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerphoneNumber = TextEditingController();
  final TextEditingController _controllerInitialAmount =
      TextEditingController();
  final TextEditingController _controllerNote = TextEditingController();

  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    // default selected date
  }

  @override
  void dispose() {
    _controllerName.dispose();
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
    final myProvider =
        Provider.of<DetectRentersIdandName>(context, listen: false);
    String type = myProvider.type;
    //String name;
    DateTime selectedDate = DateTime.now();
    var renters = Provider.of<RentersAllData>(context, listen: false);
    var subtransaction =
        Provider.of<SubTransactionAlldata>(context, listen: false);
    //
    FocusNode _focusNode = FocusNode();
    //for big screen
    if (widget.screenWith > 540) {
      return Container(
        width: 600,
        child: Card(
          elevation: 1,
          margin: EdgeInsets.all(20),
          color: Colors.white30,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    //
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(
                          bottom: 2, top: 20, left: 15, right: 15),
                      child: Text(
                        'Renter Name:',
                        style: GoogleFonts.roboto(
                            fontSize: 21,
                            color: Color.fromARGB(255, 24, 92, 209),
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 50,
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Name',
                        ),
                        cursorColor: Colors.blue,
                        style: GoogleFonts.rubik(
                            fontSize: 20, color: Colors.black),
                        controller: _controllerName,
                      ),
                    ),
                    //
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(
                          bottom: 2, top: 10, left: 15, right: 15),
                      child: Text(
                        'Phone Number:',
                        style: GoogleFonts.roboto(
                            fontSize: 21,
                            color: Color.fromARGB(255, 24, 92, 209),
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter a search term',
                          ),
                          cursorColor: Colors.blue,
                          style: GoogleFonts.rubik(
                              fontSize: 20, color: Colors.black),
                          controller: _controllerphoneNumber),
                    ),
                    //
                  ],
                ),
              ),

              ////////////
              //date
              Container(
                width: double.infinity,
                padding:
                    EdgeInsets.only(bottom: 2, top: 10, left: 15, right: 15),
                child: Text(
                  'Date:',
                  style: GoogleFonts.roboto(
                      fontSize: 21,
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

              ///////////

              //
              Container(
                width: double.infinity,
                padding:
                    EdgeInsets.only(bottom: 2, top: 10, left: 15, right: 15),
                child: Text(
                  'Initial Amount:',
                  style: GoogleFonts.roboto(
                      fontSize: 21,
                      color: Color.fromARGB(255, 24, 92, 209),
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ),
              Container(
                height: 50,
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
                padding:
                    EdgeInsets.only(bottom: 2, top: 10, left: 15, right: 15),
                child: Text(
                  'Note:',
                  style: GoogleFonts.roboto(
                      fontSize: 21,
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

              //
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(bottom: 20),
                child: FloatingActionButton.extended(
                  onPressed: () {
                    //t
                    try {
                      String name = _controllerName.text;
                      String number = _controllerphoneNumber.text;
                      double amount =
                          double.parse(_controllerInitialAmount.text);
                      String note = _controllerNote.text;
                      DateTime dateTime = _selectedDate;
                      Random random = new Random();
                      int id = random.nextInt(100);
                      _controllerInitialAmount.clear();
                      _controllerName.clear();
                      _controllerNote.clear();
                      _controllerphoneNumber.clear();

                      renters
                          .addRenters(name, number, dateTime, amount, note, id)
                          .then((dids) {
                        CustomToast.showToast(context, 'Add Successfully', 1);
                        subtransaction.addNewSubTransaction(
                            dids, id, dateTime, amount, note, type);
                      });
                      // sub Transaction
                      /*  subtransaction.addNewSubTransaction(
                        id, id, dateTime, amount, note, type);*/

                      //
                      // CustomToast.showToast(context, 'Add Successfully', 1);
                      //
                    } catch (e) {
                      _controllerInitialAmount.clear();
                      _controllerName.clear();
                      _controllerNote.clear();
                      _controllerphoneNumber.clear();
                      CustomToast.showToast(
                          context, 'Something is wrong; please try again!', 2);

                      print(e.toString());
                    }
                    //t
                  },
                  label: const Text('Submit'),
                  icon: const Icon(
                    Icons.done,
                    size: 25,
                  ),
                  backgroundColor: Color.fromARGB(255, 24, 92, 209),
                ),
              ),
            ],
          ),
        ),
      );

      //////////////////////////////////// for mobile screen ////////////////////////////////////////////////////////////////////////////////////////////////
    } else if (widget.screenWith <= 540) {
      //
      return Container(
        width: 430,
        child: Card(
          // elevation: 1,
          margin: EdgeInsets.all(20),
          color: Colors.white30,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    //
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(
                          bottom: 2, top: 20, left: 15, right: 15),
                      child: Text(
                        'Renter Name:',
                        style: GoogleFonts.roboto(
                            fontSize: 18,
                            color: Color.fromARGB(255, 24, 92, 209),
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 40,
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Name',
                        ),
                        cursorColor: Colors.blue,
                        style: GoogleFonts.rubik(
                            fontSize: 16, color: Colors.black),
                        controller: _controllerName,
                      ),
                    ),
                    //
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(
                          bottom: 2, top: 10, left: 15, right: 15),
                      child: Text(
                        'Phone Number:',
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
                            hintText: 'Number',
                          ),
                          cursorColor: Colors.blue,
                          style: GoogleFonts.rubik(
                              fontSize: 16, color: Colors.black),
                          controller: _controllerphoneNumber),
                    ),
                    //
                  ],
                ),
              ),

              ////////////
              //date
              Container(
                width: double.infinity,
                padding:
                    EdgeInsets.only(bottom: 2, top: 10, left: 15, right: 15),
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
                height: 42,
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

              ///////////

              //
              Container(
                width: double.infinity,
                padding:
                    EdgeInsets.only(bottom: 2, top: 10, left: 15, right: 15),
                child: Text(
                  'Initial Amount:',
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
                padding:
                    EdgeInsets.only(bottom: 2, top: 10, left: 15, right: 15),
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

              //
              Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(bottom: 3),
                child: FloatingActionButton.extended(
                  onPressed: () {
                    //t
                    try {
                      String name = _controllerName.text;
                      String number = _controllerphoneNumber.text;
                      double amount =
                          double.parse(_controllerInitialAmount.text);
                      String note = _controllerNote.text;
                      DateTime dateTime = _selectedDate;
                      Random random = new Random();
                      int id = random.nextInt(100);
                      _controllerInitialAmount.clear();
                      _controllerName.clear();
                      _controllerNote.clear();
                      _controllerphoneNumber.clear();

                      renters
                          .addRenters(name, number, dateTime, amount, note, id)
                          .then((dids) {
                        CustomToast.showToast(context, 'Add Successfully', 1);
                        subtransaction.addNewSubTransaction(
                            dids, id, dateTime, amount, note, type);
                      });
                      _focusNode.unfocus();
                    } catch (e) {
                      _controllerInitialAmount.clear();
                      _controllerName.clear();
                      _controllerNote.clear();
                      _controllerphoneNumber.clear();
                      CustomToast.showToast(
                          context, 'Something is wrong; please try again!', 2);

                      print(e.toString());
                    }

                    //t
                  },
                  label: const Text('Submit'),
                  icon: const Icon(
                    Icons.done,
                    size: 18,
                  ),
                  backgroundColor: Color.fromARGB(255, 24, 92, 209),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Text('g');
    }
  }
}
