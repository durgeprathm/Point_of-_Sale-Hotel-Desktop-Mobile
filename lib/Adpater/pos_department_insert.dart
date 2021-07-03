import 'package:retailerp/NetworkHelper/network_helper.dart';

class DepartmentInsert {

  Future <dynamic> getDepartmentInsert (String Department_Name,String Department_Narration) async
  {
    var map = new Map<String, dynamic>();
    map['DepartmentName'] = Department_Name;
    map['DepartmentNarration'] = Department_Narration;

    String apifile = 'Insert_Department.php';
    NetworkHelper networkHelper = new NetworkHelper(apiname: apifile,data: map);
    var insertdepartment = await networkHelper.getData();
    return insertdepartment;
  }

}