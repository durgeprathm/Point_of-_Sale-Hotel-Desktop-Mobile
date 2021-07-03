
import 'package:retailerp/NetworkHelper/network_helper_hotel.dart';

class PhramaShopUpdate {

  Future <dynamic> getphramashopUpdate(String Shopid,String Shop_name,String Shop_Mobile_Number,String Shop_Owner_Name,String Shop_Email,String Shop_GST,String Shop_CIN,String Shop_PAN,String Shop_SSIN,String Shop_Address) async
  {
    var map = new Map<String, dynamic>();
    map['UpdatedShopId'] = Shopid;
    map['ShopName'] = Shop_name;
    map['ShopMobileNumber'] = Shop_Mobile_Number;
    map['ShopOwnerName'] = Shop_Owner_Name;
    map['ShopEmail'] = Shop_Email;
    map['ShopGSTNumber'] = Shop_GST;
    map['ShopCINNumber'] = Shop_CIN;
    map['ShopPANNumber'] = Shop_PAN;
    map['ShopSSINNumber'] = Shop_SSIN;
    map['ShopAddress'] = Shop_Address;

    String apifile = 'Update_Shop.php';
    NetworkHelperHotel networkHelper = new NetworkHelperHotel(apiname: apifile,data: map);
    var updateshop = await networkHelper.getData();
    return updateshop;
  }

}