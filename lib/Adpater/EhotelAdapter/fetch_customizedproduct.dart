import 'package:retailerp/NetworkHelper/network_helper_hotel.dart';

class FetchCustomizedProduct {

  Future <dynamic> getCustomizedProduct() async
  {
    var map = new Map<String, dynamic>();

    map['actionId'] = "0";

    String apifile = 'Fetch_Customized_Product_Enteries.php';
    NetworkHelperHotel networkHelper = new NetworkHelperHotel(apiname: apifile,data: map);
    var insertusercreate = await networkHelper.getData();
    return insertusercreate;
  }

}