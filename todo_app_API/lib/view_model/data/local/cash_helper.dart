import 'package:shared_preferences/shared_preferences.dart';
   //cachehelper connect data to talk to local database
class CacheHelper{
  static late SharedPreferences sharedPreferences;

//here intialize of cache
static init() async {
  sharedPreferences = await SharedPreferences.getInstance();
}
// this fun to put data in local data base using key
 static Future<bool> put({

    required String key,
   required dynamic value,

})async{
  if(value is String){

    return await sharedPreferences.setString(key, value);
  }else if (value is bool){
    return await sharedPreferences.setBool(key, value);
  }
  else{
    return await sharedPreferences.setInt(key, value);
  }

 }

 static dynamic get({
    required String key,
})   {
    return sharedPreferences.get(key);
 }

 static Future<bool> removeData({required key}) async{
  return await sharedPreferences.remove(key);
 }
 static Future<bool> clearData()async{
  return await sharedPreferences.clear();
 }





}