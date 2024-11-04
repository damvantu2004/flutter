import 'dart:convert';

class Area {
  String code;
  String? parentCode;
  String name;
  String nameWithType;
  String? pathWithType;
  Area({
    required this.code,
    this.parentCode,
    required this.name,
    required this.nameWithType,
    required this.pathWithType,
  });

  Area copyWith({
    String? code,
    String? parent_code,
    String? name,
    String? nameWithType,
    String? pathWithType,
  }) {
    return Area(
      code: code ?? this.code,
      parentCode: parent_code ?? this.parentCode,
      name: name ?? this.name,
      nameWithType: nameWithType ?? this.nameWithType,
      pathWithType: pathWithType ?? this.pathWithType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'parent_code': parentCode,
      'name': name,
      'name_with_type': nameWithType,
      'path_with_type': pathWithType,
    };
  }

  factory Area.fromMap(Map<String, dynamic> map) {
    return Area(
      code: map['code'] as String,
      parentCode:
          map['parent_code'] != null ? map['parent_code'] as String : null,
      name: map['name'] as String,
      nameWithType: map['name_with_type'] as String,
      pathWithType: map['path_with_type'] != null
          ? map['path_with_type'] as String
          : null,
    );
  }

  factory Area.template() {
    return Area(
      code: "",
      parentCode: null,
      name: "",
      nameWithType: "",
      pathWithType: "",
    );
  }

  String toJson() => json.encode(toMap());

  factory Area.fromJson(String source) =>
      Area.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Area(code: $code, parentCode: $parentCode, name: $name, nameWithType: $nameWithType, pathWithType: $pathWithType)';
  }

  @override
  bool operator ==(covariant Area other) {
    if (identical(this, other)) return true;

    return other.code == code &&
        other.parentCode == parentCode &&
        other.name == name &&
        other.nameWithType == nameWithType &&
        other.pathWithType == pathWithType;
  }

  @override
  int get hashCode {
    return code.hashCode ^
        parentCode.hashCode ^
        name.hashCode ^
        nameWithType.hashCode ^
        pathWithType.hashCode;
  }
}
