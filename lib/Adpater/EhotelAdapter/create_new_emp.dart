import 'package:retailerp/NetworkHelper/network_helper_hotel.dart';

class CreateNewEmp {

  Future <dynamic> insertnewemp(
      String empname,
      String emptype,
      String empaddhar,
      String empsalary,
      String empjoindate) async
  {
    var map = new Map<String, dynamic>();

    map['actionid'] = "0";
    map['empname'] = empname;
    map['emptype'] = emptype;
    map['empaddhr'] = empaddhar;
    map['empsal'] = empsalary;
    map['empdate'] = empjoindate;


    String apifile = 'Create_new_emp.php';
    NetworkHelperHotel networkHelper = new NetworkHelperHotel(apiname: apifile,data: map);
    var insertusercreate = await networkHelper.getData();
    return insertusercreate;
  }

}