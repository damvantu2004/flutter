import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:furniture_app/data/models/bank.dart';
import 'package:furniture_app/data/servers/bank_api_server.dart';
import 'package:http/http.dart' as http;

class BankRepository {
  Future<List<Bank>> downloadBankApiVietQr() async {
    String url = "https://api.vietqr.io/v2/banks";
    final response = await http.get(Uri.parse(url));
    var responseData = json.decode(response.body);
    List<Bank> banks = [];
    for (var singleBank in responseData['data']) {
      Bank bank = Bank.fromMap(singleBank as Map<String, dynamic>);
      banks.add(bank);
    }
    return banks;
  }

  Future<void> addBankToFirebase() async {
    List<Bank> banks = await downloadBankApiVietQr();
    for (int i = 0; i < banks.length; i++) await BankAPIServer().addBank(banks[i].toMap());
  }

  Future<List<Bank>> getBank() async {
    CollectionReference collection = FirebaseFirestore.instance.collection('bank');
    List<Bank> bank = [];
    await collection.get().then((QuerySnapshot querySnapshot) {
      bank = querySnapshot.docs.map((doc) {
        if (doc.exists) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          Bank a = Bank.fromMap(data);
          return a;
        }
        return Bank.template();
      }).toList();
    });
    return bank;
  }
}
