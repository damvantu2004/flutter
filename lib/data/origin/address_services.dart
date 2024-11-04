// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Address {
  String code;
  String? parent_code;
  String name;
  String nameWithType;
  String? pathWithType;
  Address({
    required this.code,
    this.parent_code,
    required this.name,
    required this.nameWithType,
    required this.pathWithType,
  });

  Address copyWith({
    String? code,
    String? parent_code,
    String? name,
    String? nameWithType,
    String? pathWithType,
  }) {
    return Address(
      code: code ?? this.code,
      parent_code: parent_code ?? this.parent_code,
      name: name ?? this.name,
      nameWithType: nameWithType ?? this.nameWithType,
      pathWithType: pathWithType ?? this.pathWithType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'parent_code': parent_code,
      'name': name,
      'nameWithType': nameWithType,
      'pathWithType': pathWithType,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      code: map['code'] as String,
      parent_code: map['parent_code'] != null ? map['parent_code'] as String : null,
      name: map['name'] as String,
      nameWithType: map['name_with_type'] as String,
      pathWithType: map['path_with_type'] != null ? map['path_with_type'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Address.fromJson(String source) => Address.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'address(code: $code, parent_code: $parent_code, name: $name, nameWithType: $nameWithType, pathWithType: $pathWithType)';
  }

  @override
  bool operator ==(covariant Address other) {
    if (identical(this, other)) return true;

    return other.code == code && other.parent_code == parent_code && other.name == name && other.nameWithType == nameWithType && other.pathWithType == pathWithType;
  }

  @override
  int get hashCode {
    return code.hashCode ^ parent_code.hashCode ^ name.hashCode ^ nameWithType.hashCode ^ pathWithType.hashCode;
  }
}

class NetworkRequest {
  static const String urlProvice = "https://vn-public-apis.fpo.vn/provinces/getAll?limit=-1";
  static const String urlDistrict = "https://vn-public-apis.fpo.vn/districts/getAll?limit=-1";
  static const String urlWards = "https://vn-public-apis.fpo.vn/wards/getAll?limit=-1";

  Future<void> parsePost(String reponseBody, String path) async {
    var map = json.decode(reponseBody) as Map<String, dynamic>;
    List<dynamic> list = map['data']['data'];
    if (path == 'province') {
      for (int i = 0; i < list.length; i++) {
        Map<String, String> data = {
          'code': (list[i] as Map<String, dynamic>)['code'],
          'name': (list[i] as Map<String, dynamic>)['name'],
          'name_with_type': (list[i] as Map<String, dynamic>)['name_with_type'],
        };
        await add(data: data, path: path);
      }
    } else {
      for (int i = 0; i < list.length; i++) {
        Map<String, String> data = {
          'code': (list[i] as Map<String, dynamic>)['code'],
          'parent_code': (list[i] as Map<String, dynamic>)['parent_code'],
          'name': (list[i] as Map<String, dynamic>)['name'],
          'name_with_type': (list[i] as Map<String, dynamic>)['name_with_type'],
        };
        await add(data: data, path: path);
      }
    }
  }

  Future<void> fetchPosts(String url, String path) async {
    final reponse = await http.get(Uri.parse(url));
    if (reponse.statusCode == 200) {
      await parsePost(reponse.body, path);
    } else if (reponse.statusCode == 404) {
      throw Exception('Not Found');
    } else {
      throw Exception('Can\'t not get post');
    }
  }

  Future<void> reloadAddress() async {
    await fetchPosts(urlProvice, 'province');
    await fetchPosts(urlDistrict, 'district');
    await fetchPosts(urlWards, 'ward');
  }

  Future<void> add({required String path, required Map<String, dynamic> data}) async {
    CollectionReference collectionReference = FirebaseFirestore.instance.collection('address_vietname').doc(path).collection('lists');
    return collectionReference.doc(data['code']).set(data).then((value) => print("Added successfully")).catchError((error) => print("Failed to add: $error"));
  }
}
