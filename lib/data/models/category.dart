class MyCategory {
  String? id;
  String? name;
  String? path;
  String? imagePath;
  MyCategory({this.id, this.name, this.path, this.imagePath});

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "path": path,
      "image_path": imagePath,
    };
  }

  factory MyCategory.fromJson(Map<String, dynamic> data, String? id) {
    return MyCategory(
      id: id,
      name: data["name"],
      path: data["path"],
      imagePath: data["image_path"],
    );
  }
}
