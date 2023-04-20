class DownloadMandateResponse {
  DownloadMandateResponse({
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

  DownloadMandateResponse.fromJson(dynamic json) {
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

class Body {
  Body({
      String? base64,}){
    _base64 = base64;
}

  Body.fromJson(dynamic json) {
    _base64 = json['base64'];
  }
  String? _base64;

  String? get base64 => _base64;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['base64'] = _base64;
    return map;
  }

}