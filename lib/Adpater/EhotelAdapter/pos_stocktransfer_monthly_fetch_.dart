import 'package:retailerp/NetworkHelper/network_helper_hotel.dart';

class StockTarnsferMonthlyFetch {

  Future <dynamic> getStockTarnsferMonthlyFetch() async
  {
    var map = new Map<String, dynamic>();
    map['actionId'] = "2";


    String apifile = 'Fetch_StockTransferEnteries.php';
    NetworkHelperHotel networkHelper = new NetworkHelperHotel(apiname: apifile,data: map);
    var stocktarnsfermonthlyfetch = await networkHelper.getData();
    return stocktarnsfermonthlyfetch;
  }

}