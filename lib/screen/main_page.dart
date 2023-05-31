import 'dart:html';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../provider/detect_renters_IDandName.dart';
import '../provider/renters_all-data.dart';
import '../provider/sub_transaction_all_data.dart';
import '../widgets/add_account.dart';
import '../widgets/custom_toast.dart';
import '../widgets/renters_tables_All.dart';

class MainPageScreen extends StatefulWidget {
  // MainPageScreen(this.screenWith);

  @override
  State<MainPageScreen> createState() => _MainPageScreenState();
}

class _MainPageScreenState extends State<MainPageScreen> {
//e

  Future<void> _refreshRentersData(BuildContext context) async {
    await Provider.of<RentersAllData>(context, listen: false)
        .fetchRenterData()
        .then((_) {})
        .catchError(
          () => CustomToast.showToast(context, 'not Reload!!', 2),
        );
  }

  Future<void> _refreshSubtransactionData(BuildContext context) async {
    await Provider.of<SubTransactionAlldata>(context, listen: false)
        .fetchSubtransactionData()
        .then((_) {
      CustomToast.showToast(context, 'Reload Done!!', 1);
    }).catchError(
      () => CustomToast.showToast(context, 'not Reload!!', 2),
    );
  }

  //e

  @override
  void initState() {
    //
    final myProvider =
        Provider.of<DetectRentersIdandName>(context, listen: false);
    String type = myProvider.type;
    //

    if (type != '') {
      Provider.of<RentersAllData>(context, listen: false)
          .fetchRenterData()
          .catchError(
            () => CustomToast.showToast(context, 'not Reload!!', 2),
          );
      Provider.of<SubTransactionAlldata>(context, listen: false)
          .fetchSubtransactionData()
          .catchError(
            () => CustomToast.showToast(context, 'not Reload!!', 2),
          );
    } else {
      print('user error');
    }

    super.initState();
  }

  void logout(ctx) {
    Navigator.pushNamedAndRemoveUntil(ctx, '/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    double screenWith = MediaQuery.of(context).size.width;

    //
    final myProvider =
        Provider.of<DetectRentersIdandName>(context, listen: false);
    String type = myProvider.type;
/////////////////////////// for big screen ////////////////////////////////////////////////
    if (screenWith > 700) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,

          //'Add Renter Account! ='
          title: Container(
            width: double.infinity,
            child: Text(
              'Add Renter Account',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ),
          //
          actions: <Widget>[
            type != ''
                ? Container(
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
                  )
                : Container(
                    child: Text(''),
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
                  logout(context);
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
          //
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white70,
            child: type != ''
                ? Column(
                    children: [
                      AddAccount(screenWith),
                      RentersTable(screenWith),
                    ],
                  )
                : Text('boss'),
          ),
        ),
      );
      //
    }
/////////////////////////// for mobile ////////////////////////////////////////////////
    else if (screenWith <= 700) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,

          //'Add Renter Account! ='
          title: Container(
            width: double.infinity,
            child: Text(
              'Add Renter Account',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
          //
          actions: <Widget>[
            type != ''
                ? Container(
                    margin: EdgeInsets.all(2),
                    alignment: Alignment.center,
                    width: 80,
                    // color: Colors.deepPurpleAccent,
                    padding: EdgeInsets.all(2),
                    child: FloatingActionButton.extended(
                      heroTag: null,
                      onPressed: () {
                        CustomToast.showToast(context, 'Reloading...!!', 2);
                        _refreshRentersData(context);
                        _refreshSubtransactionData(context);
                      },
                      label: const Text(
                        'Reload',
                        style: TextStyle(fontSize: 11),
                      ),
                      icon: const Icon(
                        Icons.refresh,
                        size: 15,
                      ),
                      backgroundColor: Color.fromARGB(255, 212, 120, 7),
                    ),
                  )
                : Container(
                    child: Text(''),
                  ),
            //
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(2),
              width: 80,
              // color: Colors.deepPurpleAccent,
              padding: EdgeInsets.all(2),
              child: FloatingActionButton.extended(
                heroTag: null,
                onPressed: () {
                  logout(context);
                },
                label: const Text(
                  'Logout',
                  style: TextStyle(fontSize: 11),
                ),
                icon: const Icon(
                  Icons.logout,
                  size: 15,
                ),
                backgroundColor: Color.fromARGB(255, 212, 120, 7),
              ),
            ),
            //
          ],
          //
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white70,
            child: type != ''
                ? Column(
                    children: [
                      AddAccount(screenWith),
                      RentersTable(screenWith),
                    ],
                  )
                : Text('boss'),
          ),
        ),
      );
    } else {
      return Text('gg');
    }
  }
}
