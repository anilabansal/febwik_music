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
  // bool get isDark => appDb.read('darkmode') ?? false;
  //
  // ThemeData get theme => isDark ? ThemeData.dark() : ThemeData.light();
  // void changeTheme(bool val) => appDb.write('darkmode', val);

  LoginDetail? _userDetail;
  int? _userId;
  bool _isLogin=false;
  // bool _isOpenAppRewardTaken=false;
  // bool _isProfileCreated=false;
  // String _token="";
  // String _lastLoginTime="";
  // String _userTempEmail="";
  // int _userIdTemp=0;

  get isLogin => _isLogin;
  // get isOpenAppRewardTaken => _isOpenAppRewardTaken;
  // get lastLoginTime => _lastLoginTime;
  // get isProfileCreated => _isProfileCreated;
  // get token => _token;
  // get userIdTemp => _userIdTemp;
  // get userTempEmail => _userTempEmail;
  LoginDetail? get userDetail => _userDetail;
  int? get userId => _userId;


  init(){
    _userId = readUserId();
    _isLogin=readIsLogin();
    // _token=readLoginToken();
    // _isProfileCreated=readIsProfileCreated();
    // _userIdTemp=readUserId();
    // _isOpenAppRewardTaken=readOpenAppIn24Hrs();
    // _lastLoginTime=readLastLoginTime();

    // if(readUserData()!=null){
    //   _userDetail=readUserData();
    // }
  }


  setIsLoginUser(isLogin){
    _isLogin=isLogin;
    appDb.write('isLogin',isLogin);
  }

  readIsLogin(){
    return appDb.read('isLogin') ?? false;
  }
  //
  // readOpenAppIn24Hrs(){
  //   return appDb.read('is24hoursPass') ?? false;
  // }


  // setIsProfileCreated(isProfile){
  //   _isProfileCreated=true;
  //   appDb.write('isProfile',isProfile);
  // }
  // readLastLoginTime(){
  //   return appDb.read('lastLoginTime') ?? "";
  // }
  //
  // setLastLoginTime(time){
  //   _lastLoginTime=time;
  //   appDb.write('lastLoginTime',time);
  //   update();
  // }


  // setIsOpenAppPassTime(yesOrNo){
  //   _isOpenAppRewardTaken=yesOrNo;
  //   appDb.write('is24hoursPass',yesOrNo);
  // }
  //
  // readIsProfileCreated(){
  //   return appDb.read('isProfile') ?? false;
  // }
  //
  setUserId(loginId) {
    _userId = loginId;
    appDb.write('userId', loginId);
  }
  readUserId() {
    return appDb.read('userId') ?? 0;
  }
  //
  //
  // setLoginToken(token){
  //   _token=token;
  //   appDb.write('auth_token',token);
  // }
  //
  // setUserId(userIdTemp,userEmail){
  //   _userIdTemp=userIdTemp;
  //   _userTempEmail=userEmail;
  //   appDb.write('userId',userIdTemp);
  // }


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