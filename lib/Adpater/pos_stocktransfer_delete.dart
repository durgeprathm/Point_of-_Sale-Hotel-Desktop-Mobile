import 'package:retailerp/NetworkHelper/network_helper.dart';

class StockTransferDelete {

  Future <dynamic> getStockTransferDelete (String StockTransfer_Id) async
  {
    var map = new Map<String, dynamic>();
    map['DeleteStockTransferId'] = StockTransfer_Id;

    String apifile = 'Delete_Stock_Transfer.php';
    NetworkHelper networkHelper = new NetworkHelper(apiname: apifile,data: map);
    var stocktransferdata = await networkHelper.getData();
    return stocktransferdata;
  }

}