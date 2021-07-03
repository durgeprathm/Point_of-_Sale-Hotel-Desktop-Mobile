import 'package:retailerp/NetworkHelper/network_helper.dart';

class AllDebitCreditPaymentModeFetch {

  Future <dynamic> getAllDebitCreditPaymentModeFetch(String PaymentMode) async
  {
    var map = new Map<String, dynamic>();
    map['actionId'] = "1";
    map['SalesPaymentCardType'] = PaymentMode;

    String apifile = 'Fetch_card_Details_from_Sales.php';
    NetworkHelper networkHelper = new NetworkHelper(apiname: apifile,data: map);
    var alldebitpaymentmodefetch = await networkHelper.getData();
    return alldebitpaymentmodefetch;
  }

}