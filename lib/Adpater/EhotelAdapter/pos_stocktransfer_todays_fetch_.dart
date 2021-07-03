import 'package:retailerp/NetworkHelper/network_helper_hotel.dart';

class StockTarnsferDataFetch {

  Future <dynamic> getStockTarnsferDataFetch(String ActionId,String Todays_date) async
  {
    var map = new Map<String, dynamic>();
    map['actionId'] = ActionId;
    map['stedate'] = Todays_date;

    String apifile = 'Fetch_StockTransferEnteries.php';
    NetworkHelperHotel networkHelper = new NetworkHelperHotel(apiname: apifile,data: map);
    var stocktarnsferdatafetch = await networkHelper.getData();
    return stocktarnsferdatafetch;
  }

}