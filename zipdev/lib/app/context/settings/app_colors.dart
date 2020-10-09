class AppColors {
  static AppColors _singleton;
  // final Color primaryColor = Color.fromRGBO(0x00,0x35,0xE4,1);

  factory AppColors(){
    if(_singleton == null) _singleton = new AppColors._();
    return _singleton;
  }

  AppColors._();
}