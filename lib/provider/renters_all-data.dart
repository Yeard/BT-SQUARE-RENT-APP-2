import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/Renter.dart';
//import 'package:encrypt/encrypt.dart'as encrypt;

//import 'Renter.dart';

class RentersAllData extends ChangeNotifier {
  List<Renter> allRenters = [];

  // add data apps and database

  Future<int> addRenters(
    String name,
    String number,
    DateTime date,
    double amount,
    String note,
    int id,
  ) {
    const url = 'https://btsquarebhola.com/renteradd.php';
    return http.post(
      Uri.parse(url),
      body: {
        'name': name,
        'number': number,
        'date': date.toIso8601String(),
        'amount': amount.toString(),
        'note': note
      },
    ).then((response) {
      ////////////////////
      final jsonString = response.body;

      final jsonData = json.decode(jsonString);

      if (jsonData['status'] == 'success') {
        final lastId = jsonData['last_id'];

        allRenters.add(Renter(
            name: name,
            number: number,
            date: date,
            amount: amount,
            note: note,
            id: lastId));

        notifyListeners();
        return lastId as int;
        //return lastId;
      } else {
        throw throw Exception('Failed to add renters');
      }
    }).catchError((e) {
      print('gg error=================');
      print(e.toString());
      return 0;
    });
  }

  // add data apps and database ends

  //////////////////////////////////////

// fetch data from database
  /* Future<void> fetchRenterData() async {
    print('rent DB');
    try {
      final response = await http
          .get(Uri.parse('https://btsquarebhola.com/fetchrenter.php'));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        // print(data);
        List<Renter> renterDataList = [];
        data.forEach((element) {
          Renter renterData = Renter.fromJson(element);
          renterDataList.add(renterData);
        });
        allRenters = renterDataList;
        //print(allRenters.toString());

        notifyListeners();
        //  return renterDataList;
      } else {
        throw Exception('Failed to fetch renter data');
      }
    } catch (e) {
      print(e.toString());
    }
  }*/
  Future<void> fetchRenterData() async {
    print('rent DB');
    try {
      final response =
          await http.get(Uri.https('btsquarebhola.com', '/fetchrenter.php'));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<Renter> renterDataList = [];
        data.forEach((element) {
          Renter renterData = Renter.fromJson(element);
          renterDataList.add(renterData);
        });
        allRenters = renterDataList;
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

//gg
  /* List showAllRentersData() {
    return allRenters;
  }*/

  //
  Future<void> deletRentersWithAllData(int rentID) {
//

    return http.post(
        Uri.parse('https://btsquarebhola.com/deletrenterandallsubrentar.php'),
        body: {
          'renter_id': rentID.toString(),
        }).then((_) {
      allRenters.removeWhere((element) => element.id == rentID);
      notifyListeners();
    });
  }
  //
}
