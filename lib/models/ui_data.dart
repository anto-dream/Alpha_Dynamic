// To parse this JSON data, do
//
//     final uiData = uiDataFromJson(jsonString);

import 'dart:convert';

UiData uiDataFromJson(String str) => UiData.fromJson(json.decode(str));

String uiDataToJson(UiData data) => json.encode(data.toJson());

class UiData {
  int status;
  dynamic exception;
  DateTime requestTimestamp;
  DateTime responseTimestamp;
  Payload payload;

  UiData({
    this.status,
    this.exception,
    this.requestTimestamp,
    this.responseTimestamp,
    this.payload,
  });

  factory UiData.fromJson(Map<String, dynamic> json) => UiData(
    status: json["status"],
    exception: json["exception"],
    requestTimestamp: DateTime.parse(json["requestTimestamp"]),
    responseTimestamp: DateTime.parse(json["responseTimestamp"]),
    payload: Payload.fromJson(json["payload"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "exception": exception,
    "requestTimestamp": requestTimestamp.toIso8601String(),
    "responseTimestamp": responseTimestamp.toIso8601String(),
    "payload": payload.toJson(),
  };
}

class Payload {
  dynamic pagingResult;
  List<Datum> data;

  Payload({
    this.pagingResult,
    this.data,
  });

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
    pagingResult: json["pagingResult"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "pagingResult": pagingResult,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  int formTemplateId;
  int formTemplateVersionId;
  String name;
  String description;
  List<Status> types;
  Status status;
  List<FieldConfiguration> fieldConfiguration;
  bool canDeactivate;
  int version;
  CreatedBy createdBy;
  DateTime createdTimestamp;
  dynamic lastModifiedBy;
  dynamic lastModifiedTimestamp;

  Datum({
    this.formTemplateId,
    this.formTemplateVersionId,
    this.name,
    this.description,
    this.types,
    this.status,
    this.fieldConfiguration,
    this.canDeactivate,
    this.version,
    this.createdBy,
    this.createdTimestamp,
    this.lastModifiedBy,
    this.lastModifiedTimestamp,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    formTemplateId: json["formTemplateId"],
    formTemplateVersionId: json["formTemplateVersionId"],
    name: json["name"],
    description: json["description"],
    types: List<Status>.from(json["types"].map((x) => Status.fromJson(x))),
    status: Status.fromJson(json["status"]),
    fieldConfiguration: List<FieldConfiguration>.from(json["fieldConfiguration"].map((x) => FieldConfiguration.fromJson(x))),
    canDeactivate: json["canDeactivate"],
    version: json["version"],
    createdBy: CreatedBy.fromJson(json["createdBy"]),
    createdTimestamp: DateTime.parse(json["createdTimestamp"]),
    lastModifiedBy: json["lastModifiedBy"],
    lastModifiedTimestamp: json["lastModifiedTimestamp"],
  );

  Map<String, dynamic> toJson() => {
    "formTemplateId": formTemplateId,
    "formTemplateVersionId": formTemplateVersionId,
    "name": name,
    "description": description,
    "types": List<dynamic>.from(types.map((x) => x.toJson())),
    "status": status.toJson(),
    "fieldConfiguration": List<dynamic>.from(fieldConfiguration.map((x) => x.toJson())),
    "canDeactivate": canDeactivate,
    "version": version,
    "createdBy": createdBy.toJson(),
    "createdTimestamp": createdTimestamp.toIso8601String(),
    "lastModifiedBy": lastModifiedBy,
    "lastModifiedTimestamp": lastModifiedTimestamp,
  };
}

class CreatedBy {
  int userId;
  String firstName;
  String lastName;

  CreatedBy({
    this.userId,
    this.firstName,
    this.lastName,
  });

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
    userId: json["userId"],
    firstName: json["firstName"],
    lastName: json["lastName"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "firstName": firstName,
    "lastName": lastName,
  };
}

class FieldConfiguration {
  String formGroupId;
  int type;
  double order;
  dynamic description;
  List<Conditional> conditionals;
  List<DisplayGroup> displayGroups;

  FieldConfiguration({
    this.formGroupId,
    this.type,
    this.order,
    this.description,
    this.conditionals,
    this.displayGroups,
  });

  factory FieldConfiguration.fromJson(Map<String, dynamic> json) => FieldConfiguration(
    formGroupId: json["formGroupId"],
    type: json["type"],
    order: json["order"].toDouble(),
    description: json["description"],
    conditionals: List<Conditional>.from(json["conditionals"].map((x) => Conditional.fromJson(x))),
    displayGroups: List<DisplayGroup>.from(json["displayGroups"].map((x) => DisplayGroup.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "formGroupId": formGroupId,
    "type": type,
    "order": order,
    "description": description,
    "conditionals": List<dynamic>.from(conditionals.map((x) => x.toJson())),
    "displayGroups": List<dynamic>.from(displayGroups.map((x) => x.toJson())),
  };
}

class Conditional {
  String formGroupId;
  List<ConditionalField> fields;
  dynamic displayGroups;

  Conditional({
    this.formGroupId,
    this.fields,
    this.displayGroups,
  });

  factory Conditional.fromJson(Map<String, dynamic> json) => Conditional(
    formGroupId: json["formGroupId"],
    fields: List<ConditionalField>.from(json["fields"].map((x) => ConditionalField.fromJson(x))),
    displayGroups: json["displayGroups"],
  );

  Map<String, dynamic> toJson() => {
    "formGroupId": formGroupId,
    "fields": List<dynamic>.from(fields.map((x) => x.toJson())),
    "displayGroups": displayGroups,
  };
}

class ConditionalField {
  String formFieldId;
  String value;

  ConditionalField({
    this.formFieldId,
    this.value,
  });

  factory ConditionalField.fromJson(Map<String, dynamic> json) => ConditionalField(
    formFieldId: json["formFieldId"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "formFieldId": formFieldId,
    "value": value,
  };
}

class DisplayGroup {
  int type;
  double order;
  dynamic description;
  List<DisplayGroupField> fields;

  DisplayGroup({
    this.type,
    this.order,
    this.description,
    this.fields,
  });

  factory DisplayGroup.fromJson(Map<String, dynamic> json) => DisplayGroup(
    type: json["type"],
    order: json["order"],
    description: json["description"],
    fields: List<DisplayGroupField>.from(json["fields"].map((x) => DisplayGroupField.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "order": order,
    "description": description,
    "fields": List<dynamic>.from(fields.map((x) => x.toJson())),
  };
}

class DisplayGroupField {
  String formFieldId;
  int labelType;
  String label;
  String details;
  double order;
  int controlType;
  String placeholder;
  int controlWidth;
  dynamic validators;
  dynamic ruleConfiguration;
  dynamic conditionals;
  List<Option> options;

  DisplayGroupField({
    this.formFieldId,
    this.labelType,
    this.label,
    this.details,
    this.order,
    this.controlType,
    this.placeholder,
    this.controlWidth,
    this.validators,
    this.ruleConfiguration,
    this.conditionals,
    this.options,
  });

  factory DisplayGroupField.fromJson(Map<String, dynamic> json) => DisplayGroupField(
    formFieldId: json["formFieldId"],
    labelType: json["labelType"],
    label: json["label"],
    details: json["details"] == null ? null : json["details"],
    order: json["order"],
    controlType: json["controlType"],
    placeholder: json["placeholder"] == null ? null : json["placeholder"],
    controlWidth: json["controlWidth"],
    validators: json["validators"],
    ruleConfiguration: json["ruleConfiguration"],
    conditionals: json["conditionals"],
    options: json["options"] == null ? null : List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "formFieldId": formFieldId,
    "labelType": labelType,
    "label": label,
    "details": details == null ? null : details,
    "order": order,
    "controlType": controlType,
    "placeholder": placeholder == null ? null : placeholder,
    "controlWidth": controlWidth,
    "validators": validators,
    "ruleConfiguration": ruleConfiguration,
    "conditionals": conditionals,
    "options": options == null ? null : List<dynamic>.from(options.map((x) => x.toJson())),
  };
}

class Option {
  String value;
  String display;

  Option({
    this.value,
    this.display,
  });

  factory Option.fromJson(Map<String, dynamic> json) => Option(
    value: json["value"],
    display: json["display"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "display": display,
  };
}

/*enum Display { YES, NO, MAY_BE }

final displayValues = EnumValues({
  "May be": Display.MAY_BE,
  "No": Display.NO,
  "Yes": Display.YES
});*/

class Status {
  int value;
  String display;

  Status({
    this.value,
    this.display,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
    value: json["value"],
    display: json["display"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "display": display,
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
