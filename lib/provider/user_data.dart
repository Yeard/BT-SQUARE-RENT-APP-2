import 'package:bt_square_rent_app/model/user.dart';
import 'package:flutter/cupertino.dart';

class userData extends ChangeNotifier {
//?

//?
// Password was changeable
  List<User> udata = [
    User(
        useremail: 'yeard00@gmail.com',
        password: '00000000',
        userType: 'admin'),
    User(
        useremail: 'admin00@gmail.com',
        password: '000000000',
        userType: 'admin'),
    User(
        useremail: '00000@gmail.com',
        password: '0000000000',
        userType: 'operator'),
  ];

  //
  String userChacking(String useremail, String pass) {
//

//

    String usertype = 'No';
    udata.forEach((e) {
      if (e.useremail == useremail && e.password == pass) {
        usertype = e.userType;
      }
    });

    return usertype;
  }
}
