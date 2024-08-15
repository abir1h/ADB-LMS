import 'package:flutter/cupertino.dart';

@immutable
class CourseModel {
  final String id;
  final String title;
  final String description;
  final String imagePath;
  final int rating;
  final int noOfRating;
  final bool published;
  final bool bookmarked;
  final int progress;

  const CourseModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.rating,
    required this.noOfRating,
    required this.published,
    required this.bookmarked,
    required this.progress,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) => CourseModel(
    id: json["Id"]??"",
    title: json["Title"]??"",
    description: json["Description"]??"",
    imagePath: json["ImagePath"]??"",
    rating: json["Rating"]??-1,
    noOfRating: json["NoOfRating"]??-1,
    published: json["Published"]??false,
    bookmarked: json["Bookmarked"]??false,
    progress: json["Progress"]??-1,
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Title": title,
    "Description": description,
    "ImagePath": imagePath,
    "Rating": rating,
    "NoOfRating": noOfRating,
    "Published": published,
    "Bookmarked": bookmarked,
    "Progress": progress,
  };
}