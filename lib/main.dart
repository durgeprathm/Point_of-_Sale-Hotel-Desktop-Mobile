import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retailerp/EhotelModel/StockTransfer.dart';
import 'package:retailerp/LedgerManagement/Models/ledgermodel.dart';
import 'package:retailerp/Pagination_notifier/Manage_Customize_Product_datanotifier.dart';
import 'package:retailerp/Pagination_notifier/Manage_Product_Category_datanotifier.dart';
import 'package:retailerp/Pagination_notifier/Manage_Product_Rate_datanotifier.dart';
import 'package:retailerp/Pagination_notifier/Manage_Product_datanotifier.dart';
import 'package:retailerp/Pagination_notifier/Manage_Purchase_datanotifier.dart';
import 'package:retailerp/Pagination_notifier/Manage_Supplier_datanotifier.dart';
import 'package:retailerp/Pagination_notifier/Menu_Reports_datanotifier.dart';
import 'package:retailerp/Pagination_notifier/Monthly_Wise_Menu_Reports_datanotifier.dart';
import 'package:retailerp/Pagination_notifier/Stock_Category_Reports_datanotifier.dart';
import 'package:retailerp/Pagination_notifier/Stock_Reports_datanotifier.dart';
import 'package:retailerp/Pagination_notifier/Supplier_Wise_Report_datanotifier.dart';
import 'package:retailerp/Pagination_notifier/Todays_Oil_Sales_Reports_datanotifier.dart';
import 'package:retailerp/Pagination_notifier/view_Todays_bill_datanotifier.dart';
import 'package:retailerp/Pagination_notifier/view_cash_bill_datanotifier.dart';
import 'package:retailerp/Pagination_notifier/view_debit_bill_datanotifier.dart';
import 'package:retailerp/Pagination_notifier/view_salesbook_bill_datanotifier.dart';
import 'package:retailerp/Pagination_notifier/view_upi_bill_Datanotifier.dart';
import 'package:retailerp/editPOSUI/EditbillProviders/edit_billprovider.dart';
import 'package:retailerp/models/purchase_model.dart';
import 'package:retailerp/models/sales_model.dart';
import 'package:retailerp/models/shop_bank_detail.dart';
import 'package:retailerp/pages/splashscreen.dart';
import 'package:retailerp/providers/recipe.dart';
import 'package:retailerp/utils/MobilePOSProviders/billing_productMobile.dart';
import 'package:retailerp/utils/POSProviders/billing_productdata.dart';
import 'package:retailerp/utils/POSProviders/billing_productdatatwo.dart';
import './utils/material_color_generator.dart';
import './utils/const.dart';
import 'package:retailerp/POSUIThree/billing_productdata_trial_three.dart';
import 'package:retailerp/POSUIFour/billing_productdata_trial_four.dart';
import 'package:retailerp/POSUIFive/billing_productdata_trial_five.dart';
import 'package:retailerp/POSUIONE/billing_productdata_trial.dart';
import 'package:retailerp/POSUITwo/billing_productdata_trial_two.dart';

void main() {
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MaterialColor primarySwatch = generateMaterialColor(primary);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductData()),
        ChangeNotifierProvider(create: (context) => ProductDataTwo()),
        ChangeNotifierProvider(create: (context) => ProductDataMobile()),
        ChangeNotifierProvider(create: (context) => PurchaseModel()),
        ChangeNotifierProvider(create: (context) => SalesModel()),
        ChangeNotifierProvider(create: (context) => Recipe()),
        ChangeNotifierProvider(create: (context) => SupplierProvider()),
        ChangeNotifierProvider(create: (context) => StockTranferProvider()),
        ChangeNotifierProvider(create: (context) => OrderItemProviderEdit()),
        ChangeNotifierProvider(create: (context) => SupplierProvider()),
        ChangeNotifierProvider(create: (context) => ShopBankDetails()),
        ChangeNotifierProvider(create: (context) => ProductDataTrial()),
        ChangeNotifierProvider(create: (context) => ProductDataTrialTwo()),
        ChangeNotifierProvider(create: (context) => ProductDataTrialThree()),
        ChangeNotifierProvider(create: (context) => ProductDataTrialFour()),
        ChangeNotifierProvider(create: (context) => ProductDataTrialFive()),


        //------------------------------pagination -------------------------------------------
        ChangeNotifierProvider(create: (context) => ViewTodayBillDataNotifier()),
        ChangeNotifierProvider(create: (context) => ViewCashBillDataNotifier()),
        ChangeNotifierProvider(create: (context) => ViewUPIBillDataNotifier()),
        ChangeNotifierProvider(create: (context) => ViewDebitBillDataNotifier()),
        ChangeNotifierProvider(create: (context) => ViewSalesBookDataNotifier()),
        ChangeNotifierProvider(create: (context) => ManagePurchaseDataNotifier()),
        ChangeNotifierProvider(create: (context) => ManageSupplierDataNotifier()),
        ChangeNotifierProvider(create: (context) => ManageProductsDataNotifier()),
        ChangeNotifierProvider(create: (context) => ManageProductCategoryDataNotifier()),
        ChangeNotifierProvider(create: (context) => SupplierWiseReportDataNotifier()),
        ChangeNotifierProvider(create: (context) => StockReportsDataNotifier()),
        ChangeNotifierProvider(create: (context) => StockCategoryReportsDataNotifier()),
        ChangeNotifierProvider(create: (context) => MonthlyWiseMenuReportsDataNotifier()),
        ChangeNotifierProvider(create: (context) => TodaysOilSalesReportsDataNotifier()),
        ChangeNotifierProvider(create: (context) => MenuReportsDataNotifier()),
        ChangeNotifierProvider(create: (context) => ManageCustomizeProductDataNotifier()),
        ChangeNotifierProvider(create: (context) => ManageProductRateDataNotifier()),
      ],
      child: MaterialApp(
        title: 'Arun  Telgirni',
        theme: ThemeData(
            primarySwatch: primarySwatch,
            accentColor: PrimaryColor,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            fontFamily: 'Poppins-Medium'),
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
