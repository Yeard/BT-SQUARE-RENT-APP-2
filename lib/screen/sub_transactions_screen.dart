import 'package:bt_square_rent_app/provider/detect_renters_IDandName.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../provider/renters_all-data.dart';
import '../provider/sub_transaction_all_data.dart';
import '../widgets/custom_toast.dart';
import '../widgets/sub_transaction_add.dart';
import '../widgets/sub_transactions_table.dart';

class SubTransactionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWith = MediaQuery.of(context).size.width;
    try {
      //e
      Future<void> _refreshRentersData(BuildContext context) async {
        await Provider.of<RentersAllData>(context, listen: false)
            .fetchRenterData()
            .then((_) {
          // CustomToast.showToast(context, 'Reload Done!!', 1);
        });
        print('rrf');
      }

      Future<void> _refreshSubtransactionData(BuildContext context) async {
        await Provider.of<SubTransactionAlldata>(context, listen: false)
            .fetchSubtransactionData()
            .then((_) {
          CustomToast.showToast(context, 'Reload Done!!', 1);
        });
        print('ssrf');
      }

      //e
      final myProvider =
          Provider.of<DetectRentersIdandName>(context, listen: true);
      int rentersID = myProvider.id;
      String name = myProvider.name;
      String type = myProvider.type;
////////////////////////////////////// for big screen  ////////////////////////////////////
      if (screenWith > 700) {
        return type != ''
            ? Scaffold(
                appBar: AppBar(
                  title: Text(
                    'BT SQUARE RENT APP',
                    style:
                        GoogleFonts.roboto(fontSize: 20, color: Colors.white),
                  ),
                  actions: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      width: 150,
                      // color: Colors.deepPurpleAccent,
                      padding: EdgeInsets.all(5),
                      child: FloatingActionButton.extended(
                        heroTag: null,
                        onPressed: () {
                          CustomToast.showToast(context, 'Reloading...!!', 2);
                          _refreshRentersData(context);
                          _refreshSubtransactionData(context);
                        },
                        label: const Text('Reload'),
                        icon: const Icon(
                          Icons.refresh,
                          size: 20,
                        ),
                        backgroundColor: Color.fromARGB(255, 212, 120, 7),
                      ),
                    ),

                    //
                    Container(
                      alignment: Alignment.center,
                      width: 150,
                      // color: Colors.deepPurpleAccent,
                      padding: EdgeInsets.all(5),
                      child: FloatingActionButton.extended(
                        heroTag: null,
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/login', (route) => false);
                        },
                        label: const Text('Logout'),
                        icon: const Icon(
                          Icons.logout,
                          size: 20,
                        ),
                        backgroundColor: Color.fromARGB(255, 212, 120, 7),
                      ),
                    ),
                    //
                  ],
                ),
                body: SingleChildScrollView(
                  child: Container(
                    color: Color.fromARGB(179, 246, 244, 244),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 30, bottom: 20),
                          alignment: Alignment.center,
                          width: double.infinity,
                          child: Text(
                            'Welcome To Sub Transaction Page!',
                            style: GoogleFonts.roboto(
                                fontSize: 24,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          child: Text('Renters Name: ' + name.toString(),
                              style: GoogleFonts.roboto(
                                  fontSize: 22,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold)),
                        ),
                        //Add
                        SubTransactionAdd(
                          renterID: rentersID,
                          type: type,
                          screenWith: screenWith,
                        ),

                        //table
                        Container(
                          child: SubTransactionTable(
                            rentersId: rentersID,
                            screenWith: screenWith,
                          ),
                        ),
                      ],
                      //
                    ),
                  ),
                ),
                //gg
              )
            : Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  title: Text(
                    'BT SQUARE RENT APP',
                    style:
                        GoogleFonts.roboto(fontSize: 20, color: Colors.white),
                  ),
                  actions: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      width: 150,
                      // color: Colors.deepPurpleAccent,
                      padding: EdgeInsets.all(5),
                      child: FloatingActionButton.extended(
                        heroTag: null,
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/login', (route) => false);
                        },
                        label: const Text('Logout'),
                        icon: const Icon(
                          Icons.logout,
                          size: 20,
                        ),
                        backgroundColor: Color.fromARGB(255, 212, 120, 7),
                      ),
                    ),
                    //
                  ],
                ),
                body: Container(
                  child: Text('Please Login Again..'),
                ),
              );

        //l
        ////////////////////////////////////// for mobile  ////////////////////////////////////
      } else if (screenWith <= 700) {
        return type != ''
            ? Scaffold(
                appBar: AppBar(
                  title: Text(
                    'BT SQUARE RENT APP',
                    style:
                        GoogleFonts.roboto(fontSize: 13, color: Colors.white),
                  ),
                  actions: <Widget>[
                    Container(
                      margin: EdgeInsets.all(2),
                      alignment: Alignment.center,
                      width: 90,
                      // color: Colors.deepPurpleAccent,
                      padding: EdgeInsets.all(2),
                      child: FloatingActionButton.extended(
                        heroTag: null,
                        onPressed: () {
                          CustomToast.showToast(context, 'Reloading...!!', 2);
                          _refreshRentersData(context);
                          _refreshSubtransactionData(context);
                        },
                        label: const Text('Reload'),
                        icon: const Icon(
                          Icons.refresh,
                          size: 15,
                        ),
                        backgroundColor: Color.fromARGB(255, 212, 120, 7),
                      ),
                    ),

                    //
                    Container(
                      margin: EdgeInsets.all(2),
                      alignment: Alignment.center,
                      width: 90,
                      // color: Colors.deepPurpleAccent,
                      padding: EdgeInsets.all(2),
                      child: FloatingActionButton.extended(
                        heroTag: null,
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/login', (route) => false);
                        },
                        label: const Text('Logout'),
                        icon: const Icon(
                          Icons.logout,
                          size: 15,
                        ),
                        backgroundColor: Color.fromARGB(255, 212, 120, 7),
                      ),
                    ),
                    //
                  ],
                ),
                body: SingleChildScrollView(
                  child: Container(
                    color: Color.fromARGB(179, 246, 244, 244),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 30, bottom: 20),
                          alignment: Alignment.center,
                          width: double.infinity,
                          child: Text(
                            'Welcome To Sub Transaction Page!',
                            style: GoogleFonts.roboto(
                                fontSize: 18,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          child: Text('Renters Name: ' + name.toString(),
                              style: GoogleFonts.roboto(
                                  fontSize: 17,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold)),
                        ),
                        //Add
                        SubTransactionAdd(
                          renterID: rentersID,
                          type: type,
                          screenWith: screenWith,
                        ),

                        //table
                        Container(
                          child: SubTransactionTable(
                            rentersId: rentersID,
                            screenWith: screenWith,
                          ),
                        ),
                      ],
                      //
                    ),
                  ),
                ),
                //gg
              )
            : Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  title: Text(
                    'BT SQUARE RENT APP',
                    style:
                        GoogleFonts.roboto(fontSize: 15, color: Colors.white),
                  ),
                  actions: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      width: 150,
                      // color: Colors.deepPurpleAccent,
                      padding: EdgeInsets.all(5),
                      child: FloatingActionButton.extended(
                        heroTag: null,
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/login', (route) => false);
                        },
                        label: const Text('Logout'),
                        icon: const Icon(
                          Icons.logout,
                          size: 20,
                        ),
                        backgroundColor: Color.fromARGB(255, 212, 120, 7),
                      ),
                    ),
                    //
                  ],
                ),
                body: Container(
                  child: Text('Please Login Again..'),
                ),
              );
      } else {
        return Text('hh');
      }

      /////////////////////////////////////////////////////////////////////////////////////////////

    } catch (e) {
      print(e.toString());
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'BT SQUARE RENT APP',
            style: GoogleFonts.roboto(fontSize: 20, color: Colors.white),
          ),
        ),
        body: Container(
          child: Text('somthing wrong please logein again===' + e.toString()),
        ),
      );
    }
    //gg
  }
}
