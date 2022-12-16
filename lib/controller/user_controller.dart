import 'package:get/get.dart';
import 'package:sentra_mobile/model/user_model.dart';
import 'package:sentra_mobile/repositories/user_repository.dart';

class UserController extends GetxController {
  var allUser = <UserModel>[].obs;
  UserRepository userRepository = UserRepository();

  @override
  void onInit() {
    super.onInit();
    fetchAllUser();
  }

  fetchAllUser() async {
    var user = await userRepository.getUser();
    print("Get all User ..");
    print(user);
    allUser.value = user;
  }

  addUser(UserModel userModel) {
    userRepository.add(userModel);
    fetchAllUser();
  }

  updateUser(UserModel userModel) {
    userRepository.update(userModel);
    fetchAllUser();
  }

  deleteUser(int id) {
    userRepository.delete(id);
    fetchAllUser();
  }
}
