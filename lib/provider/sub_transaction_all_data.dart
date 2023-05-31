import 'package:bt_square_rent_app/model/sub_transactions_renter.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SubTransactionAlldata extends ChangeNotifier {
  List<SubTransRenter> SubTransRenterAllData = [];
  Future<void> addNewSubTransaction(
    int rentetId,
    int iD,
    DateTime date,
    double amount,
    String note,
    String type,
  ) {
    ////////////////////////

    const url = 'https://btsquarebhola.com/subtransactionadd.php';
    return http.post(
      Uri.parse(url),
      body: {
        'renters_ids': rentetId.toString(),
        'dates': date.toIso8601String(),
        'amounts': amount.toString(),
        'notes': note,
        'types': type
      },
    ).then((response) {
      ////////////////////
      final jsonString = response.body;

      final jsonData = json.decode(jsonString);
      // print('jsonData============');
      //  print(jsonData);

      if (jsonData['status'] == 'success') {
        final lastId = jsonData['last_ids'];

        SubTransRenterAllData.add(SubTransRenter(
            rentetId: rentetId,
            iD: lastId,
            date: date,
            amount: amount,
            note: note,
            type: type));
        notifyListeners();
        return Future.value();
      } else {
        throw throw Exception('Failed to add renters');
      }
    }).catchError((e) {
      print('gg error=================');
      print(e.toString());
    });

    ////////////////////////
  }

  // fetch data from database
  /* Future<void> fetchSubtransactionData() async {
    try {
      final response = await http
          .get(Uri.parse('https://btsquarebhola.com/fetchsubtransaction.php'));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);

        List<SubTransRenter> subtransactionDataList = [];
        data.forEach((element) {
          SubTransRenter subtransactionData = SubTransRenter.fromJson(element);
          subtransactionDataList.add(subtransactionData);
        });
        SubTransRenterAllData = subtransactionDataList;

        notifyListeners();
      } else {
        throw Exception('Failed to fetch renter data');
      }
    } catch (e) {
      print(e.toString());
    }
  } */

  Future<void> fetchSubtransactionData() async {
    try {
      final response = await http
          .get(Uri.https('btsquarebhola.com', '/fetchsubtransaction.php'));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);

        List<SubTransRenter> subtransactionDataList = [];
        data.forEach((element) {
          SubTransRenter subtransactionData = SubTransRenter.fromJson(element);
          subtransactionDataList.add(subtransactionData);
        });
        SubTransRenterAllData = subtransactionDataList;

        notifyListeners();
      } else {
        throw Exception('Failed to fetch renter data');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to fetch renter data');
    }
  }

// fetch data from database ends
  //////////////////////////////////////

  List<SubTransRenter> filtertransaction(int id) {
    List<SubTransRenter> filterdSubTransRenterData = [];
    SubTransRenterAllData.forEach((element) {
      if (element.rentetId == id) {
        filterdSubTransRenterData.add(element);
      }
    });

    return filterdSubTransRenterData;
  }

//sum
  double SumAmount(int id) {
    double sum = 0;
    SubTransRenterAllData.forEach((element) {
      if (element.rentetId == id) {
        sum += element.amount;
      }
    });
    return sum;
  }

  Future<void> deleteSubTransaction(int id) {
    return http.post(
        Uri.parse('https://btsquarebhola.com/deletesubtransactiononly.php'),
        body: {
          'id': id.toString(),
        }).then((_) {
      SubTransRenterAllData.removeWhere((element) => element.iD == id);
      notifyListeners();
    });
  }
  //
}
