class Address {
  String? name;
  String? phoneNumber;
  String? city;
  String? flatNumber;
  String? state;
  String? fullAddress;
  double? lat;
  double? lng;

  Address({
    this.name,
    this.phoneNumber,
    this.city,
    this.flatNumber,
    this.state,
    this.fullAddress,
    this.lat,
    this.lng,
  });

  Address.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    city = json['city'];
    state = json['state'];
    flatNumber = json['flatNumber'];
    fullAddress = json['fullAddress'];
    lat = json['lat'];
    lng = json['lng'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['phoneNumber'] = phoneNumber;
    data['flatNumber'] = flatNumber;
    data['city'] = city;
    data['state'] = state;
    data[' fullAddress'] = fullAddress;
    data[' lat'] = lat;
    data[' lng'] = lng;
    return data;
  }
}
