import 'package:retailerp/NetworkHelper/network_helper_hotel.dart';

class StockTransferFetch {

  Future <dynamic> getStockTransferFetch() async
  {
    var map = new Map<String, dynamic>();
    map['actionId'] = "0";

    String apifile = 'Fetch_StockTransferEnteries.php';
    NetworkHelperHotel networkHelper = new NetworkHelperHotel(apiname: apifile,data: map);
    var stocktransferdata = await networkHelper.getData();
    return stocktransferdata;
  }

}