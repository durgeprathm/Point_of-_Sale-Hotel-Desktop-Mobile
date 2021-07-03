import 'package:retailerp/NetworkHelper/network_helper.dart';

class ShopUpdate {

  Future <dynamic> getposshopupdate (int Shop_id,String Shop_name,String Shop_Mobile_Number,String Shop_Owner_Name,String Shop_Email,String Shop_GST,String Shop_CIN,String Shop_PAN,String Shop_SSIN,String Shop_Address) async
  {
    var map = new Map<String, dynamic>();
    map['UpdatedShopId'] = Shop_id;
    map['ShopName'] = Shop_name;
    map['ShopMobile'] = Shop_Mobile_Number;
    map['ShopOwnerName'] = Shop_Owner_Name;
    map['ShopEmail'] = Shop_Email;
    map['ShopGST'] = Shop_GST;
    map['ShopCIN'] = Shop_CIN;
    map['ShopPAN'] = Shop_PAN;
    map['ShopSSIN'] = Shop_SSIN;
    map['ShopAddress'] = Shop_Address;

    String apifile = 'Update_Shop.php';
    NetworkHelper networkHelper = new NetworkHelper(apiname: apifile,data: map);
    var updateshop = await networkHelper.getData();
    return updateshop;
  }

}