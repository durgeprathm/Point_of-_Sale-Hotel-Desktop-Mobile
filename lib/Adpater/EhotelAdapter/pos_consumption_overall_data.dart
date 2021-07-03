import 'package:retailerp/NetworkHelper/network_helper_hotel.dart';

class ConsumptionOverAllFetch {

  Future <dynamic> getConsumptionDataFetch() async
  {
    var map = new Map<String, dynamic>();
    map['actionId'] = "2";


    String apifile = 'fetch_consumption_data.php';
    NetworkHelperHotel networkHelper = new NetworkHelperHotel(apiname: apifile,data: map);
    var consumptionoverallfetch = await networkHelper.getData();
    return consumptionoverallfetch;
  }

}