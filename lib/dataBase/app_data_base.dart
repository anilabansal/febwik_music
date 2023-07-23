import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../app/models/login_modal.dart';


class AppLocalStorage extends GetxController{

  static final AppLocalStorage _singleton = AppLocalStorage._internal();

  factory AppLocalStorage() {
    return _singleton;
  }

  AppLocalStorage._internal();

  final appDb = GetStorage();


  LoginDetail? _userDetail;
  // int? _userId;
  final _userId = 0.obs;
  bool _isLogin=false;
  get isLogin => _isLogin;
  LoginDetail? get userDetail => _userDetail;
  int get userId => _userId.value;


  init(){
    _userId.value = readUserId();
    _isLogin=readIsLogin();

  }


  setIsLoginUser(isLogin){
    _isLogin=isLogin;
    appDb.write('isLogin',isLogin);
  }

  readIsLogin(){
    return appDb.read('isLogin') ?? false;
  }

  setUserId(loginId) {
    _userId.value = loginId;
    appDb.write('userId', loginId);
  }
  readUserId() {
    return appDb.read('userId') ?? 0;
  }



  readLoginToken(){
    return appDb.read('auth_token') ?? "";
  }

  setUserData(LoginDetail userDetail){
    _userDetail=userDetail;
    appDb.write('user', jsonEncode(userDetail));
    update();
  }

  dynamic readUserData(){
    String userData= appDb.read('user') ?? "";
    return userData!="" ? LoginDetail.fromJson(jsonDecode(userData)) : null;
  }


  clearData(){
    appDb.erase();
  }







}