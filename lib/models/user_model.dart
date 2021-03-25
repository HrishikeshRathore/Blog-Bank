class UserModel {
  final String userId;
  final String userName;
  final String userInfo;

  UserModel({
    this.userId,
    this.userName,
    this.userInfo,
  });


  Map<String, dynamic> toMap() {
    return {
      'userId' : userId,
      'userName': userName,
      'userInfo': userInfo,
    };
  }
}