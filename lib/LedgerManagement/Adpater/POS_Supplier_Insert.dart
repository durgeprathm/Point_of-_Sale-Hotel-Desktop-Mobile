import 'package:retailerp/NetworkHelper/network_helper.dart';
import 'package:retailerp/NetworkHelper/network_helper_hotel.dart';

class SupplierInsert {
  Future<dynamic> getpossupplierinsert(
      String Supplier_CompanyName,
      String Supplier_CompanyPersonName,
      String Supplier_CompanyMobile,
      String Supplier_CompanyEmail,
      String Supplier_CompanyAddress,
      String Supplier_UdyogAadhar,
      String Supplier_CIN,
      String Supplier_GSTType,
      String Supplier_GSTNumber,
      String Supplier_Fax,
      String Supplier_PAN,
      String Supplier_LicenseType,
      String Supplier_LicenseNumber,
      String Supplier_BankName,
      String Supplier_BankBranchName,
      String Supplier_AccountType,
      String Supplier_AccountNumber,
      String Supplier_IFSCCode,
      String Supplier_UPINumber,
      String Account_Type) async {
    var map = new Map<String, dynamic>();
    map['SupplierCompanyName'] = Supplier_CompanyName;
    map['SupplierCompanyPersonName'] = Supplier_CompanyPersonName;
    map['SupplierCompanyMobile'] = Supplier_CompanyMobile;
    map['SupplierCompanyEmail'] = Supplier_CompanyEmail;
    map['SupplierCompanyAddress'] = Supplier_CompanyAddress;
    map['SupplierCompanyUdyogAadhaar'] = Supplier_UdyogAadhar;
    map['SupplierCompanyCIN'] = Supplier_CIN;
    map['SupplierCompanyGSTType'] = Supplier_GSTType;
    map['SupplierCompanyGSTNumber'] = Supplier_GSTNumber;
    map['SupplierCompanyFAXNumber'] = Supplier_Fax;
    map['SupplierCompanyPANNumber'] = Supplier_PAN;
    map['SupplierCompanyLicenseType'] = Supplier_LicenseType;
    map['SupplierCompanyLicenseNumber'] = Supplier_LicenseNumber;
    map['SupplierCompanyBankName'] = Supplier_BankName;
    map['SupplierCompanyBankBranchName'] = Supplier_BankBranchName;
    map['SupplierCompanyAccountType'] = Supplier_AccountType;
    map['SupplierCompanyAccountNumber'] = Supplier_AccountNumber;
    map['SupplierCompanyIFSCCode'] = Supplier_IFSCCode;
    map['SupplierCompanyUPINumber'] = Supplier_UPINumber;
    map['accounttype'] = Account_Type;

    String apifile = 'Supplier_Insert.php';
    NetworkHelperHotel networkHelper =
        new NetworkHelperHotel(apiname: apifile, data: map);
    var insertsupplier = await networkHelper.getData();
    print("Inside supplier POS:$insertsupplier");
    return insertsupplier;
  }
}
