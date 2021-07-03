import 'package:retailerp/NetworkHelper/network_helper_hotel.dart';

class PhramaCreateNewUserInsert {

  Future <dynamic> getPhramaCreateNewUserInsert(
      String user_name,
      String user_password,
      String user_user_type,
      String user_person_name,
      String user_contact_no,
      String User_permission) async
  {
    var map = new Map<String, dynamic>();
    map['action'] = "0";
    map['username'] = user_name;
    map['password'] = user_password;
    map['usertype'] = user_user_type;
    map['name'] = user_person_name;
    map['contactno'] = user_contact_no;
    map['permission'] = User_permission;


    String apifile = 'Create_New_User.php';
    NetworkHelperHotel networkHelper = new NetworkHelperHotel(apiname: apifile,data: map);
    var insertusercreate = await networkHelper.getData();
    return insertusercreate;
  }

}