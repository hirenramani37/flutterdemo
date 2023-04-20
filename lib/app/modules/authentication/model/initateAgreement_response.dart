/// status : "OK"
/// code : 200
/// message : "OTP Generated Successfully"
/// body : {"email":"hirenramani37@gmail.com","ltsNumber":"NJ1012441","mobile":"######8864","token":"OVzydGqSx3sYNLDMYAI9PF1ypVYXDvDkfUrcsnGzBfc_WOOP_3D","otp":528591}
/// pagination : []

class InitateAgreementResponse {
  InitateAgreementResponse({
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

  InitateAgreementResponse.fromJson(dynamic json) {
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

/// email : "hirenramani37@gmail.com"
/// ltsNumber : "NJ1012441"
/// mobile : "######8864"
/// token : "OVzydGqSx3sYNLDMYAI9PF1ypVYXDvDkfUrcsnGzBfc_WOOP_3D"
/// otp : 528591

class Body {
  Body({
      String? email, 
      String? ltsNumber, 
      String? mobile, 
      String? token, 
      num? otp,}){
    _email = email;
    _ltsNumber = ltsNumber;
    _mobile = mobile;
    _token = token;
    _otp = otp;
}

  Body.fromJson(dynamic json) {
    _email = json['email'];
    _ltsNumber = json['ltsNumber'];
    _mobile = json['mobile'];
    _token = json['token'];
    _otp = json['otp'];
  }
  String? _email;
  String? _ltsNumber;
  String? _mobile;
  String? _token;
  num? _otp;

  String? get email => _email;
  String? get ltsNumber => _ltsNumber;
  String? get mobile => _mobile;
  String? get token => _token;
  num? get otp => _otp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = _email;
    map['ltsNumber'] = _ltsNumber;
    map['mobile'] = _mobile;
    map['token'] = _token;
    map['otp'] = _otp;
    return map;
  }

}