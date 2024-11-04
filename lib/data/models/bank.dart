// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Bank {
  int id;
  String name;
  String code;
  String bin;
  String shortName;
  String logo;
  Bank({
    required this.id,
    required this.name,
    required this.code,
    required this.bin,
    required this.shortName,
    required this.logo,
  });

  Bank copyWith({
    int? id,
    String? name,
    String? code,
    String? bin,
    String? shortName,
    String? logo,
  }) {
    return Bank(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      bin: bin ?? this.bin,
      shortName: shortName ?? this.shortName,
      logo: logo ?? this.logo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'code': code,
      'bin': bin,
      'shortName': shortName,
      'logo': logo,
    };
  }

  factory Bank.fromMap(Map<String, dynamic> map) {
    return Bank(
      id: map['id'] as int,
      name: map['name'] as String,
      code: map['code'] as String,
      bin: map['bin'] as String,
      shortName: map['shortName'] as String,
      logo: map['logo'] as String,
    );
  }

  factory Bank.template() {
    return Bank(
      id: 0,
      name: "",
      code: "",
      bin: "",
      shortName: "",
      logo: "",
    );
  }

  String toJson() => json.encode(toMap());

  factory Bank.fromJson(String source) => Bank.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Bank(id: $id, name: $name, code: $code, bin: $bin, shortName: $shortName, logo: $logo)';
  }

  @override
  bool operator ==(covariant Bank other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.code == code && other.bin == bin && other.shortName == shortName && other.logo == logo;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ code.hashCode ^ bin.hashCode ^ shortName.hashCode ^ logo.hashCode;
  }
}
