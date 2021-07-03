import 'package:retailerp/NetworkHelper/network_helper.dart';
import 'package:retailerp/NetworkHelper/network_helper_hotel.dart';

class StockTransferInsert {
  Future<dynamic> getStockTransferInsert(
      String StockTransfer_Department_Name,
      String StockTransfer_Date,
      String StockTransferProductId,
      String StockTransfer_ProductName,
      String StockTransfer_ProductQty,
      String StockTransfer_Narration) async {
    var map = new Map<String, dynamic>();

    map['StockTransferDepartmentName'] = StockTransfer_Department_Name;
    map['StockTransferDate'] = StockTransfer_Date;
    map['productid'] = StockTransferProductId;
    // map['StockTransferProductName'] = StockTransfer_ProductName;
    map['productquntity'] = StockTransfer_ProductQty;
    map['StockTransferNarration'] = StockTransfer_Narration;

    String apifile = 'Insert_stock_transfer_enteries.php';
    NetworkHelperHotel networkHelper =
        new NetworkHelperHotel(apiname: apifile, data: map);
    var insertstocktranfer = await networkHelper.getData();
    return insertstocktranfer;
  }
}
