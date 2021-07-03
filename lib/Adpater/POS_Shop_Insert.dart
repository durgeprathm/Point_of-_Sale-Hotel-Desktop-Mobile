import 'package:retailerp/NetworkHelper/network_helper.dart';
import 'package:retailerp/NetworkHelper/network_helper_hotel.dart';

class ShopInsert {

  Future <dynamic> getposshopinsert (String Shop_name,String Shop_Mobile_Number,String Shop_Owner_Name,String Shop_Email,String Shop_GST,String Shop_CIN,String Shop_PAN,String Shop_SSIN,String Shop_Address) async
  {
    var map = new Map<String, dynamic>();
    map['ShopName'] = Shop_name;
    map['ShopMobile'] = Shop_Mobile_Number;
    map['ShopOwnerName'] = Shop_Owner_Name;
    map['ShopEmail'] = Shop_Email;
    map['ShopGST'] = Shop_GST;
    map['ShopCIN'] = Shop_CIN;
    map['ShopPAN'] = Shop_PAN;
    map['ShopSSIN'] = Shop_SSIN;
    map['ShopAddress'] = Shop_Address;

    String apifile = 'Shop_Insert.php';
    NetworkHelper networkHelper = new NetworkHelper(apiname: apifile,data: map);
    var insertshop = await networkHelper.getData();
    return insertshop;
  }

}