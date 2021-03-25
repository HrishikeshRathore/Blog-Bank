import 'package:blog_bank/models/user_model.dart';

class Utils {

  static UserModel toUserModel(Map<String, dynamic> userMap) {
    return UserModel(
      userId: userMap['userId'],
      userInfo: userMap['userInfo'],
      userName: userMap['userName'],
    );
  }

}