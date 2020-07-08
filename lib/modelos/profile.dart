// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'dart:convert';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
  Profile({
    this.id,
    this.login,
    this.firstName,
    this.lastName,
    this.niceName,
    this.displayName,
    this.email,
    this.url,
    this.registered,
    this.status,
    this.roles,
    this.allcaps,
    this.timezoneString,
    this.gmtOffset,
    this.shop,
    this.address,
    this.social,
    this.payment,
    this.messageToBuyers,
    this.ratingCount,
    this.avgRating,
    this.links,
  });

  int id;
  String login;
  String firstName;
  String lastName;
  String niceName;
  String displayName;
  String email;
  String url;
  DateTime registered;
  String status;
  List<String> roles;
  Map<String, bool> allcaps;
  String timezoneString;
  String gmtOffset;
  Shop shop;
  Address address;
  Social social;
  Payment payment;
  String messageToBuyers;
  int ratingCount;
  String avgRating;
  Links links;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    id: json["id"],
    login: json["login"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    niceName: json["nice_name"],
    displayName: json["display_name"],
    email: json["email"],
    url: json["url"],
    registered: DateTime.parse(json["registered"]),
    status: json["status"],
    roles: List<String>.from(json["roles"].map((x) => x)),
    allcaps: Map.from(json["allcaps"]).map((k, v) => MapEntry<String, bool>(k, v)),
    timezoneString: json["timezone_string"],
    gmtOffset: json["gmt_offset"],
    shop: Shop.fromJson(json["shop"]),
    address: Address.fromJson(json["address"]),
    social: Social.fromJson(json["social"]),
    payment: Payment.fromJson(json["payment"]),
    messageToBuyers: json["message_to_buyers"],
    ratingCount: json["rating_count"],
    avgRating: json["avg_rating"],
    links: Links.fromJson(json["_links"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "login": login,
    "first_name": firstName,
    "last_name": lastName,
    "nice_name": niceName,
    "display_name": displayName,
    "email": email,
    "url": url,
    "registered": registered.toIso8601String(),
    "status": status,
    "roles": List<dynamic>.from(roles.map((x) => x)),
    "allcaps": Map.from(allcaps).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "timezone_string": timezoneString,
    "gmt_offset": gmtOffset,
    "shop": shop.toJson(),
    "address": address.toJson(),
    "social": social.toJson(),
    "payment": payment.toJson(),
    "message_to_buyers": messageToBuyers,
    "rating_count": ratingCount,
    "avg_rating": avgRating,
    "_links": links.toJson(),
  };
}

class Address {
  Address({
    this.address1,
    this.address2,
    this.city,
    this.state,
    this.country,
    this.postcode,
    this.phone,
  });

  String address1;
  String address2;
  String city;
  String state;
  String country;
  String postcode;
  String phone;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    address1: json["address_1"],
    address2: json["address_2"],
    city: json["city"],
    state: json["state"],
    country: json["country"],
    postcode: json["postcode"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "address_1": address1,
    "address_2": address2,
    "city": city,
    "state": state,
    "country": country,
    "postcode": postcode,
    "phone": phone,
  };
}

class Links {
  Links({
    this.self,
    this.collection,
  });

  List<Collection> self;
  List<Collection> collection;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    self: List<Collection>.from(json["self"].map((x) => Collection.fromJson(x))),
    collection: List<Collection>.from(json["collection"].map((x) => Collection.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "self": List<dynamic>.from(self.map((x) => x.toJson())),
    "collection": List<dynamic>.from(collection.map((x) => x.toJson())),
  };
}

class Collection {
  Collection({
    this.href,
  });

  String href;

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
    href: json["href"],
  );

  Map<String, dynamic> toJson() => {
    "href": href,
  };
}

class Payment {
  Payment({
    this.paymentMode,
    this.bankAccountType,
    this.bankName,
    this.bankAccountNumber,
    this.bankAddress,
    this.accountHolderName,
    this.abaRoutingNumber,
    this.destinationCurrency,
    this.iban,
    this.paypalEmail,
  });

  String paymentMode;
  String bankAccountType;
  String bankName;
  String bankAccountNumber;
  String bankAddress;
  String accountHolderName;
  String abaRoutingNumber;
  String destinationCurrency;
  String iban;
  String paypalEmail;

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
    paymentMode: json["payment_mode"],
    bankAccountType: json["bank_account_type"],
    bankName: json["bank_name"],
    bankAccountNumber: json["bank_account_number"],
    bankAddress: json["bank_address"],
    accountHolderName: json["account_holder_name"],
    abaRoutingNumber: json["aba_routing_number"],
    destinationCurrency: json["destination_currency"],
    iban: json["iban"],
    paypalEmail: json["paypal_email"],
  );

  Map<String, dynamic> toJson() => {
    "payment_mode": paymentMode,
    "bank_account_type": bankAccountType,
    "bank_name": bankName,
    "bank_account_number": bankAccountNumber,
    "bank_address": bankAddress,
    "account_holder_name": accountHolderName,
    "aba_routing_number": abaRoutingNumber,
    "destination_currency": destinationCurrency,
    "iban": iban,
    "paypal_email": paypalEmail,
  };
}

class Shop {
  Shop({
    this.url,
    this.title,
    this.slug,
    this.description,
    this.image,
    this.banner,
  });

  String url;
  String title;
  String slug;
  String description;
  String image;
  String banner;

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
    url: json["url"],
    title: json["title"],
    slug: json["slug"],
    description: json["description"],
    image: json["image"],
    banner: json["banner"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "title": title,
    "slug": slug,
    "description": description,
    "image": image,
    "banner": banner,
  };
}

class Social {
  Social({
    this.facebook,
    this.twitter,
    this.googlePlus,
    this.linkdin,
    this.youtube,
    this.instagram,
  });
  String facebook;
  String twitter;
  String googlePlus;
  String linkdin;
  String youtube;
  String instagram;

  factory Social.fromJson(Map<String, dynamic> json) => Social(
    facebook: json["facebook"],
    twitter: json["twitter"],
    googlePlus: json["google_plus"],
    linkdin: json["linkdin"],
    youtube: json["youtube"],
    instagram: json["instagram"],
  );

  Map<String, dynamic> toJson() => {
    "facebook": facebook,
    "twitter": twitter,
    "google_plus": googlePlus,
    "linkdin": linkdin,
    "youtube": youtube,
    "instagram": instagram,
  };
}
