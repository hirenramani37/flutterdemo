/// status : "OK"
/// code : 200
/// message : "Agreement verified successfully"
/// body : {}
/// pagination : []

class AgreementVerified {
  AgreementVerified({
      String? status,
      num? code,
      String? message,
      dynamic body,
      List<dynamic>? pagination,}){
    _status = status;
    _code = code;
    _message = message;
    _body = body;
    _pagination = pagination;
}

  AgreementVerified.fromJson(dynamic json) {
    _status = json['status'];
    _code = json['code'];
    _message = json['message'];
    _body = json['body'];
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
  dynamic _body;
  List<dynamic>? _pagination;

  String? get status => _status;
  num? get code => _code;
  String? get message => _message;
  dynamic get body => _body;
  List<dynamic>? get pagination => _pagination;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['code'] = _code;
    map['message'] = _message;
    map['body'] = _body;
    if (_pagination != null) {
      map['pagination'] = _pagination?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}