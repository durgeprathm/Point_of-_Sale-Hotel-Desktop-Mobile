import 'package:retailerp/NetworkHelper/network_helper.dart';

class DepartmentDelete {

  Future <dynamic> getDepartmentDelete (String Department_Id) async
  {
    var map = new Map<String, dynamic>();
    map['DeleteDepartmentId'] = Department_Id;

    String apifile = 'Delete_Department.php';
    NetworkHelper networkHelper = new NetworkHelper(apiname: apifile,data: map);
    var departmentdata = await networkHelper.getData();
    return departmentdata;
  }

}