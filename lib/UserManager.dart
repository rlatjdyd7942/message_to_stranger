import 'package:http/http.dart' as http;

import 'FirebaseSignManager.dart';
import 'Server.dart';

class UserManager {
  static final UserManager _userManager = UserManager();
  static UserManager get instance => _userManager;

  final FirebaseSignManager _signManager = FirebaseSignManager.instance;
  String get uid => _signManager.uid;
  int gender = 0;
  String countryCode = 'KR';

  Future<bool> signIn() async {
    await _signManager.autoSignIn();
    var response = await http.post(Server.url + '/v1/users/sign', body: { 'user_uid': _signManager.uid });
    if (response.statusCode == 200)
      return true;
    return false;
  }
}