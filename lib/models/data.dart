import 'dart:convert';

WidgetData widgetDataFromJson(String str) => WidgetData.fromJson(json.decode(str));

String widgetDataToJson(WidgetData data) => json.encode(data.toJson());

class WidgetData {
  List<WidgetDataItem> items;
  int totalCount;

  WidgetData({
    this.items,
    this.totalCount,
  });

  factory WidgetData.fromJson(Map<String, dynamic> json) => WidgetData(
    items: List<WidgetDataItem>.from(json["items"].map((x) => WidgetDataItem.fromJson(x))),
    totalCount: json["total_count"],
  );

  Map<String, dynamic> toJson() => {
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "total_count": totalCount,
  };
}

class WidgetDataItem {
  String type;
  String title;
  int id;
  int layoutType;
  int subtitle;
  int answerId;
  int questionId;
  Data data;
  int subLayoutType;
  List<ItemItem> items;

  WidgetDataItem({
    this.type,
    this.title,
    this.layoutType,
    this.id,
    this.subtitle,
    this.answerId,
    this.questionId,
    this.data,
    this.subLayoutType,
    this.items,
  });

  factory WidgetDataItem.fromJson(Map<String, dynamic> json) => WidgetDataItem(
    type: json["type"] == null ? null : json["type"],
    title: json["title"],
    layoutType: json["layout_type"],
    id: json["id"],
    subtitle: json["subtitle"],
    answerId: json["answer_id"],
    questionId: json["question_id"],
    data: Data.fromJson(json["data"]),
    subLayoutType: json["sub_layout_type"] == null ? null : json["sub_layout_type"],
    items: json["items"] == null ? null : List<ItemItem>.from(json["items"].map((x) => ItemItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "type": type == null ? null : type,
    "title": title,
    "layout_type": layoutType,
    "id": id,
    "subtitle": subtitle,
    "answer_id": answerId,
    "question_id": questionId,
    "data": data.toJson(),
    "sub_layout_type": subLayoutType == null ? null : subLayoutType,
    "items": items == null ? null : List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class Data {
  int reputation;
  int userId;
  UserType userType;
  int status;
  String profileImage;
  String displayName;
  String title;

  Data({
    this.reputation,
    this.userId,
    this.userType,
    this.status,
    this.profileImage,
    this.displayName,
    this.title
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    reputation: json["reputation"],
    userId: json["user_id"],
    userType: userTypeValues.map[json["user_type"]],
    status: json["accept_rate"],
    profileImage: json["profile_image"],
    displayName: json["display_name"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "reputation": reputation,
    "user_id": userId,
    "user_type": userTypeValues.reverse[userType],
    "accept_rate": status,
    "profile_image": profileImage,
    "display_name": displayName,
    "title": title,
  };
}

enum DisplayName { TOM_FENECH }

final displayNameValues = EnumValues({
  "Tom Fenech": DisplayName.TOM_FENECH
});

enum UserType { REGISTERED }

final userTypeValues = EnumValues({
  "registered": UserType.REGISTERED
});

class ItemItem {
  Data data;
  String title;
  int layoutType;
  int subtitle;
  int answerId;
  int questionId;
  String value;

  ItemItem({
    this.data,
    this.title,
    this.layoutType,
    this.subtitle,
    this.answerId,
    this.questionId,
    this.value
  });

  factory ItemItem.fromJson(Map<String, dynamic> json) => ItemItem(
    data: Data.fromJson(json["data"]),
    title: json["title"],
    layoutType: json["layout_type"],
    subtitle: json["subtitle"],
    answerId: json["answer_id"],
    questionId: json["question_id"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "title": title,
    "layout_type": layoutType,
    "subtitle": subtitle,
    "answer_id": answerId,
    "question_id": questionId,
    "value": value,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
