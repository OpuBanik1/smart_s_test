// To parse this JSON data, do
//
//     final blogModel = blogModelFromJson(jsonString);

import 'dart:convert';

List<BlogModel> blogModelFromJson(String str) => List<BlogModel>.from(json.decode(str).map((x) => BlogModel.fromJson(x)));

String blogModelToJson(List<BlogModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BlogModel {
  int? id;
  int? categoryId;
  String? title;
  String? subTitle;
  String? slug;
  String? description;
  dynamic image;
  dynamic video;
  DateTime? date;
  String? status;
  int? createdBy;
  int? updatedBy;
  DateTime? createdAt;
  DateTime? updatedAt;

  BlogModel({
    this.id,
    this.categoryId,
    this.title,
    this.subTitle,
    this.slug,
    this.description,
    this.image,
    this.video,
    this.date,
    this.status,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) => BlogModel(
    id: json["id"],
    categoryId: json["category_id"],
    title: json["title"],
    subTitle: json["sub_title"],
    slug: json["slug"],
    description: json["description"],
    image: json["image"],
    video: json["video"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    status: json["status"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "title": title,
    "sub_title": subTitle,
    "slug": slug,
    "description": description,
    "image": image,
    "video": video,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "status": status,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
