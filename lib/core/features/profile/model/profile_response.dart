class ProfileResponse {
  ProfileResponse({
      this.address, 
      this.balance, 
      this.city, 
      this.country, 
      this.currency, 
      this.currentTradesCount, 
      this.currentTradesVolume, 
      this.equity, 
      this.freeMargin, 
      this.isAnyOpenTrades, 
      this.isSwapFree, 
      this.leverage, 
      this.name, 
      this.phone, 
      this.totalTradesCount, 
      this.totalTradesVolume, 
      this.type, 
      this.verificationLevel, 
      this.zipCode,});

  ProfileResponse.fromJson(dynamic json) {
    address = json['address'];
    balance = json['balance'];
    city = json['city'];
    country = json['country'];
    currency = json['currency'];
    currentTradesCount = json['currentTradesCount'];
    currentTradesVolume = json['currentTradesVolume'];
    equity = json['equity'];
    freeMargin = json['freeMargin'];
    isAnyOpenTrades = json['isAnyOpenTrades'];
    isSwapFree = json['isSwapFree'];
    leverage = json['leverage'];
    name = json['name'];
    phone = json['phone'];
    totalTradesCount = json['totalTradesCount'];
    totalTradesVolume = json['totalTradesVolume'];
    type = json['type'];
    verificationLevel = json['verificationLevel'];
    zipCode = json['zipCode'];
  }
  String? address;
  double? balance;
  String? city;
  String? country;
  int? currency;
  int? currentTradesCount;
  double? currentTradesVolume;
  double? equity;
  double? freeMargin;
  bool? isAnyOpenTrades;
  bool? isSwapFree;
  int? leverage;
  String? name;
  String? phone;
  int? totalTradesCount;
  double? totalTradesVolume;
  int? type;
  int? verificationLevel;
  String? zipCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address'] = address;
    map['balance'] = balance;
    map['city'] = city;
    map['country'] = country;
    map['currency'] = currency;
    map['currentTradesCount'] = currentTradesCount;
    map['currentTradesVolume'] = currentTradesVolume;
    map['equity'] = equity;
    map['freeMargin'] = freeMargin;
    map['isAnyOpenTrades'] = isAnyOpenTrades;
    map['isSwapFree'] = isSwapFree;
    map['leverage'] = leverage;
    map['name'] = name;
    map['phone'] = phone;
    map['totalTradesCount'] = totalTradesCount;
    map['totalTradesVolume'] = totalTradesVolume;
    map['type'] = type;
    map['verificationLevel'] = verificationLevel;
    map['zipCode'] = zipCode;
    return map;
  }

}