import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:furniture_app/data/models/Area.dart';

class AreaRepository {
  Future<List<Area>> getProvinces() async {
    return _getArea('province');
  }

  Future<List<Area>> getDistricts(String codeProvince) async {
    return _getArea('district', parentCode: codeProvince);
  }

  Future<List<Area>> getWards(String codeDistrict) async {
    return _getArea('ward', parentCode: codeDistrict);
  }

  Future<List<Area>> _getArea(String areaName, {String parentCode = ""}) async {
    CollectionReference collection = FirebaseFirestore.instance.collection('address_vietname').doc(areaName).collection('lists');
    var query;
    if (parentCode != "") {
      query = collection.where('parent_code', isEqualTo: parentCode);
    } else {
      query = collection;
    }
    List<Area> categories = [];
    await query.get().then((QuerySnapshot querySnapshot) {
      categories = querySnapshot.docs.map((doc) {
        if (doc.exists) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          Area a = Area.fromMap(data);
          return a;
        }
        return Area.template();
      }).toList();
    });
    return categories;
  }
}
