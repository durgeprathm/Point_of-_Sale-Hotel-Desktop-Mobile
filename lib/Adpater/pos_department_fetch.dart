import 'package:retailerp/NetworkHelper/network_helper.dart';

class DepartmentFetch {

  Future <dynamic> getDepartmentFetch (String DepartmentId) async
  {
    var map = new Map<String, dynamic>();
    map['DepartmentId'] = DepartmentId;

    String apifile = 'Fetch_Department.php';
    NetworkHelper networkHelper = new NetworkHelper(apiname: apifile,data: map);
    var departmentdata = await networkHelper.getData();
    return departmentdata;
  }

}