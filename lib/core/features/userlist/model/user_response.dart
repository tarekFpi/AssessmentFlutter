class UserResponse {
  UserResponse({
      this.currentPrice, 
      this.comment, 
      this.digits, 
      this.login, 
      this.openPrice, 
      this.openTime, 
      this.profit, 
      this.sl, 
      this.swaps, 
      this.symbol, 
      this.tp, 
      this.ticket, 
      this.type, 
      this.volume,});

  UserResponse.fromJson(dynamic json) {
    currentPrice = json['currentPrice'];
    comment = json['comment'];
    digits = json['digits'];
    login = json['login'];
    openPrice = json['openPrice'];
    openTime = json['openTime'];
    profit = json['profit'];
    sl = json['sl'];
    swaps = json['swaps'];
    symbol = json['symbol'];
    tp = json['tp'];
    ticket = json['ticket'];
    type = json['type'];
    volume = json['volume'];
  }
  double? currentPrice;
  dynamic comment;
  int? digits;
  int? login;
  double? openPrice;
  String? openTime;
  double? profit;
  double? sl;
  double? swaps;
  String? symbol;
  double? tp;
  int? ticket;
  int? type;
  double? volume;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['currentPrice'] = currentPrice;
    map['comment'] = comment;
    map['digits'] = digits;
    map['login'] = login;
    map['openPrice'] = openPrice;
    map['openTime'] = openTime;
    map['profit'] = profit;
    map['sl'] = sl;
    map['swaps'] = swaps;
    map['symbol'] = symbol;
    map['tp'] = tp;
    map['ticket'] = ticket;
    map['type'] = type;
    map['volume'] = volume;
    return map;
  }

}