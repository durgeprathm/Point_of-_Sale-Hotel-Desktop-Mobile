class Emp{
   String get Empsal => _Empsal;

  set Empsal(String value) {
    _Empsal = value;
  }

  String get Empaddharno => _Empaddharno;

  set Empaddharno(String value) {
    _Empaddharno = value;
  }

  String _Empid;
   String _Empname;
   String _acctype;
   String _Empdate;
   String _Empaddharno;
   String _Empsal;

  Emp(this._Empid, this._Empname, this._acctype,this._Empdate,this._Empaddharno,this._Empsal);


   String get Empdate => _Empdate;

  set Empdate(String value) {
    _Empdate = value;
  }

  String get acctype => _acctype;

  set acctype(String value) {
    _acctype = value;
  }

  String get Empname => _Empname;

  set Empname(String value) {
    _Empname = value;
  }

  String get Empid => _Empid;

  set Empid(String value) {
    _Empid = value;
  }

   factory Emp.fromJson(Map<String, dynamic> json) {
     if (json == null) return null;
     return Emp(
         json["empid"],
         json["empname"],
         json["acctype"],
       json["date"],
       json["aadharno"],
       json["empsal"]);
   }

   static List<Emp> fromJsonList(List list) {
     if (list == null) return null;
     return list.map((item) => Emp.fromJson(item)).toList();
   }

   ///this method will prevent the override of toString
   String userAsString() {
     return '#${this.Empid} ${this.Empname}';
   }

   ///custom comparing function to check if two users are equal
   bool isEqual(Emp model) {
     return this?.Empid == model?.Empid;
   }


}