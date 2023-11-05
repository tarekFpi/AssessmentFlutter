class LoginResponse {
  LoginResponse({
      this.result, 
      this.token,});

  LoginResponse.fromJson(dynamic json) {
    result = json['result'];
    token = json['token'];
  }
  bool? result;
  String? token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['result'] = result;
    map['token'] = token;
    return map;
  }

}