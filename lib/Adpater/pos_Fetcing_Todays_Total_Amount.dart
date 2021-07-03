import 'package:retailerp/NetworkHelper/network_helper.dart';

class TodaysTotalAmountFetch {

  Future <dynamic> getTodaysTotalAmountFetch(String Date) async
  {
    var map = new Map<String, dynamic>();
    map['actionId'] = "0";
    map['SalesDate'] = Date;


    String apifile = 'Fetching_Todays_Total_Amount.php';
    NetworkHelper networkHelper = new NetworkHelper(apiname: apifile,data: map);
    var todaystotalamountfetch = await networkHelper.getData();
    return todaystotalamountfetch;
  }

}