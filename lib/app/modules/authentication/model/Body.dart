class Body {
  Body({
      this.applicantName, 
      this.bankName, 
      this.bankAccNo, 
      this.bankAccType, 
      this.loanAmount, 
      this.mandateMaxLimit,});

  Body.fromJson(dynamic json) {
    applicantName = json['applicantName'];
    bankName = json['bankName'];
    bankAccNo = json['bankAccNo'];
    bankAccType = json['bankAccType'];
    loanAmount = json['loanAmount'];
    mandateMaxLimit = json['mandateMaxLimit'];
  }
  String? applicantName;
  String? bankName;
  String? bankAccNo;
  String? bankAccType;
  int? loanAmount;
  String? mandateMaxLimit;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['applicantName'] = applicantName;
    map['bankName'] = bankName;
    map['bankAccNo'] = bankAccNo;
    map['bankAccType'] = bankAccType;
    map['loanAmount'] = loanAmount;
    map['mandateMaxLimit'] = mandateMaxLimit;
    return map;
  }

}