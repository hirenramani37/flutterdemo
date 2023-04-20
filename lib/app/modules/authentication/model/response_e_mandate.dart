/// status : "OK"
/// code : 200
/// message : "Data Fetched Successfully"
/// body : {"applicantName":"PARTH DHARMESHBHAI KALANI","bankName":"AXIS Bank","bankAccNo":"12345678","bankAccType":"Current","loanAmount":256348,"mandateMaxLimit":"100000.0"}
/// pagination : []

class ResponseEMandate {
  ResponseEMandate({
      String? status, 
      num? code, 
      String? message, 
      Body? body, 
      List<dynamic>? pagination,}){
    _status = status;
    _code = code;
    _message = message;
    _body = body;
    _pagination = pagination;
}

  ResponseEMandate.fromJson(dynamic json) {
    _status = json['status'];
    _code = json['code'];
    _message = json['message'];
    _body = json['body'] != null ? Body.fromJson(json['body']) : null;
    if (json['pagination'] != null) {
      _pagination = [];
      // json['pagination'].forEach((v) {
      //   _pagination?.add(Dynamic.fromJson(v));
      // });
    }
  }
  String? _status;
  num? _code;
  String? _message;
  Body? _body;
  List<dynamic>? _pagination;

  String? get status => _status;
  num? get code => _code;
  String? get message => _message;
  Body? get body => _body;
  List<dynamic>? get pagination => _pagination;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['code'] = _code;
    map['message'] = _message;
    if (_body != null) {
      map['body'] = _body?.toJson();
    }
    if (_pagination != null) {
      map['pagination'] = _pagination?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// applicantName : "PARTH DHARMESHBHAI KALANI"
/// bankName : "AXIS Bank"
/// bankAccNo : "12345678"
/// bankAccType : "Current"
/// loanAmount : 256348
/// mandateMaxLimit : "100000.0"

class Body {
  Body({
      String? applicantName, 
      String? bankName, 
      String? bankAccNo, 
      String? bankAccType, 
      num? loanAmount, 
      String? mandateMaxLimit,}){
    _applicantName = applicantName;
    _bankName = bankName;
    _bankAccNo = bankAccNo;
    _bankAccType = bankAccType;
    _loanAmount = loanAmount;
    _mandateMaxLimit = mandateMaxLimit;
}

  Body.fromJson(dynamic json) {
    _applicantName = json['applicantName'];
    _bankName = json['bankName'];
    _bankAccNo = json['bankAccNo'];
    _bankAccType = json['bankAccType'];
    _loanAmount = json['loanAmount'];
    _mandateMaxLimit = json['mandateMaxLimit'];
  }
  String? _applicantName;
  String? _bankName;
  String? _bankAccNo;
  String? _bankAccType;
  num? _loanAmount;
  String? _mandateMaxLimit;

  String? get applicantName => _applicantName;
  String? get bankName => _bankName;
  String? get bankAccNo => _bankAccNo;
  String? get bankAccType => _bankAccType;
  num? get loanAmount => _loanAmount;
  String? get mandateMaxLimit => _mandateMaxLimit;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['applicantName'] = _applicantName;
    map['bankName'] = _bankName;
    map['bankAccNo'] = _bankAccNo;
    map['bankAccType'] = _bankAccType;
    map['loanAmount'] = _loanAmount;
    map['mandateMaxLimit'] = _mandateMaxLimit;
    return map;
  }

}