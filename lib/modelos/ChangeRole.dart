// To parse this JSON data, do
//
//     final changeRole = changeRoleFromJson(jsonString);

import 'dart:convert';

ChangeRole changeRoleFromJson(String str) => ChangeRole.fromJson(json.decode(str));
String changeRoleToJson(ChangeRole data) => json.encode(data.toJson());

class ChangeRole {
  ChangeRole({
    this.id,
    this.username,
    this.name,
    this.firstName,
    this.lastName,
    this.email,
    this.url,
    this.description,
    this.link,
    this.locale,
    this.nickname,
    this.slug,
    this.roles,
    this.registeredDate,
    this.capabilities,
    this.extraCapabilities,
    this.avatarUrls,
    this.meta,
    this.woocommerceMeta,
    this.links,
  });

  int id;
  String username;
  String name;
  String firstName;
  String lastName;
  String email;
  String url;
  String description;
  String link;
  String locale;
  String nickname;
  String slug;
  List<dynamic> roles;
  DateTime registeredDate;
  Capabilities capabilities;
  Capabilities extraCapabilities;
  Map<String, String> avatarUrls;
  List<dynamic> meta;
  WoocommerceMeta woocommerceMeta;
  Links links;

  factory ChangeRole.fromJson(Map<String, dynamic> json) => ChangeRole(
    id: json["id"],
    username: json["username"],
    name: json["name"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    url: json["url"],
    description: json["description"],
    link: json["link"],
    locale: json["locale"],
    nickname: json["nickname"],
    slug: json["slug"],
    roles: List<dynamic>.from(json["roles"].map((x) => x)),
    registeredDate: DateTime.parse(json["registered_date"]),
    capabilities: Capabilities.fromJson(json["capabilities"]),
    extraCapabilities: Capabilities.fromJson(json["extra_capabilities"]),
    avatarUrls: Map.from(json["avatar_urls"]).map((k, v) => MapEntry<String, String>(k, v)),
    meta: List<dynamic>.from(json["meta"].map((x) => x)),
    woocommerceMeta: WoocommerceMeta.fromJson(json["woocommerce_meta"]),
    links: Links.fromJson(json["_links"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "name": name,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "url": url,
    "description": description,
    "link": link,
    "locale": locale,
    "nickname": nickname,
    "slug": slug,
    "roles": List<dynamic>.from(roles.map((x) => x)),
    "registered_date": registeredDate.toIso8601String(),
    "capabilities": capabilities.toJson(),
    "extra_capabilities": extraCapabilities.toJson(),
    "avatar_urls": Map.from(avatarUrls).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "meta": List<dynamic>.from(meta.map((x) => x)),
    "woocommerce_meta": woocommerceMeta.toJson(),
    "_links": links.toJson(),
  };
}

class Capabilities {
  Capabilities({
    this.dcVendors,
  });

  bool dcVendors;

  factory Capabilities.fromJson(Map<String, dynamic> json) => Capabilities(
    dcVendors: json["dc_vendors"],
  );
  Map<String, dynamic> toJson() => {
    "dc_vendors": dcVendors,
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

class WoocommerceMeta {
  WoocommerceMeta({
    this.activityPanelInboxLastRead,
    this.activityPanelReviewsLastRead,
    this.categoriesReportColumns,
    this.couponsReportColumns,
    this.customersReportColumns,
    this.ordersReportColumns,
    this.productsReportColumns,
    this.revenueReportColumns,
    this.taxesReportColumns,
    this.variationsReportColumns,
    this.dashboardSections,
    this.dashboardChartType,
    this.dashboardChartInterval,
    this.dashboardLeaderboardRows,
    this.homepageStats,
  });

  String activityPanelInboxLastRead;
  String activityPanelReviewsLastRead;
  String categoriesReportColumns;
  String couponsReportColumns;
  String customersReportColumns;
  String ordersReportColumns;
  String productsReportColumns;
  String revenueReportColumns;
  String taxesReportColumns;
  String variationsReportColumns;
  String dashboardSections;
  String dashboardChartType;
  String dashboardChartInterval;
  String dashboardLeaderboardRows;
  String homepageStats;

  factory WoocommerceMeta.fromJson(Map<String, dynamic> json) => WoocommerceMeta(
    activityPanelInboxLastRead: json["activity_panel_inbox_last_read"],
    activityPanelReviewsLastRead: json["activity_panel_reviews_last_read"],
    categoriesReportColumns: json["categories_report_columns"],
    couponsReportColumns: json["coupons_report_columns"],
    customersReportColumns: json["customers_report_columns"],
    ordersReportColumns: json["orders_report_columns"],
    productsReportColumns: json["products_report_columns"],
    revenueReportColumns: json["revenue_report_columns"],
    taxesReportColumns: json["taxes_report_columns"],
    variationsReportColumns: json["variations_report_columns"],
    dashboardSections: json["dashboard_sections"],
    dashboardChartType: json["dashboard_chart_type"],
    dashboardChartInterval: json["dashboard_chart_interval"],
    dashboardLeaderboardRows: json["dashboard_leaderboard_rows"],
    homepageStats: json["homepage_stats"],
  );

  Map<String, dynamic> toJson() => {
    "activity_panel_inbox_last_read": activityPanelInboxLastRead,
    "activity_panel_reviews_last_read": activityPanelReviewsLastRead,
    "categories_report_columns": categoriesReportColumns,
    "coupons_report_columns": couponsReportColumns,
    "customers_report_columns": customersReportColumns,
    "orders_report_columns": ordersReportColumns,
    "products_report_columns": productsReportColumns,
    "revenue_report_columns": revenueReportColumns,
    "taxes_report_columns": taxesReportColumns,
    "variations_report_columns": variationsReportColumns,
    "dashboard_sections": dashboardSections,
    "dashboard_chart_type": dashboardChartType,
    "dashboard_chart_interval": dashboardChartInterval,
    "dashboard_leaderboard_rows": dashboardLeaderboardRows,
    "homepage_stats": homepageStats,
  };
}