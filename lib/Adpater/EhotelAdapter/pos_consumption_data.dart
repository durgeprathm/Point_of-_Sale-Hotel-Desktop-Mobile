import 'package:retailerp/NetworkHelper/network_helper_hotel.dart';

class ConsumptionDataFetch {

  Future <dynamic> getConsumptionDataFetch(String ActionId,String Todays_date) async
  {
    var map = new Map<String, dynamic>();
    map['actionId'] = ActionId;
    map['todaysdate'] = Todays_date;

    String apifile = 'fetch_consumption_data.php';
    NetworkHelperHotel networkHelper = new NetworkHelperHotel(apiname: apifile,data: map);
    var consumptiondatafetch = await networkHelper.getData();
    return consumptiondatafetch;
  }

}