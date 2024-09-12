import '../../data/models/user_model.dart';

class User {
  final int id;
  final String name;

  User({
    required this.id,
    required this.name,
  });

  factory User.fromUserModel(UserModel userModel) {
    return User(
      id: userModel.id,
      name: userModel.name,
    );
  }
}
