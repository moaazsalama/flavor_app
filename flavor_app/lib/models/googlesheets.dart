import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';

class UserSheetApi {
  static final _spreedSheetId = "1FLbzQRiVmJV4Xiw0JgMSSb554heYVAAXmGJpPgKSTEM";
  static const _credentials = r'''
  {
  "type": "service_account",
  "project_id": "gsheets-325114",
  "private_key_id": "c8f8696f94d08f9578a504f04865454ec60a1e48",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQC8E2I9e3SAJiju\nnN/9lslmQFWLwxcx+cvMirKxmSyuFJazaiOp+CZVMFkLhfLMtAgKKh8ohQ0JsXDN\nUGJDxoXXBpV+za0GSb3wAc09LTtMIsGYYY5LBCaiNkS6p7+SJ2biM2OIJ4UvRSio\nFfh426xKt/NBBP1S3RzwK98VuEfOMxUPfkNN+a/4b1Jy8AAcnxhVE3yxbe1rPVsd\nJL2bsG780PJFNwFs5KGQtDOnkQR7t/hyoByKUNgtPJ26VOitsIuc/rQICT01SJKn\nUqMH/V1ymZ9SMKR9SmcUzBFVnXs0+9k1uz34p6/Oz8WgFiiG8OCa9Hw/RGOkhR0L\nhcEDRKirAgMBAAECggEALdlJ2zQj5/Olidnbbv4Z1d/8Gsix+GBtcs0jF9GAB2YE\ngPNwg0h3y8+v/XOnh4ih5xxyoRWiYokLtzmP4vbb/NnhitqIAh7q+z3tMys6J+rX\nKBcsMZRu+J9jLN+k/3O0jJM7gd8khCwHZ8aHXqsqusJSPjkBqng1zETdqvVUJ+t3\nB514m3XCUjp0CHaS/0qWUka8f/dLUTiuXGmfU8Pta5r2lmD0RBRqeoNwYH6cuICV\nbXqwtlDzFb3wuvnRX4YVV49WBzfiLzCDJ0wiIfU4tIakvM4StIlTHrt/Fh2zG7Ma\n1cFDdR7TTU9DQbtNC5q8pO6kRgdS/Oy8NfJc3j7voQKBgQD74CapJ0JZtF77SWSW\npBNO8FEHfmdvoiBSwelN4+M/CqFJLBKJRlRAt7KAhUVDPbg7La/St08l7z9RhHzD\nhH6Hav/7Dh4ZEBJKHqG/C/VmDcSPKGPu890i4V+87fdptQAEAsDeK2q0My76mNJk\nQRF0UU4ilkrS3iAx3F0TD51ISwKBgQC/J8l+bn7n1PXTSjkNOb2N0f25dNJABcto\nTcXNxRjSyu4tYg6QFtmYz55AXdDFUX6npP9xjfNbVd9DFAiswzr1rPkIZWG7oXST\nzK6oCftglZw/Wnli9z5e+7k2qdRPBh8PW9o8UcfFnU0wcQDKuVNnxjx4r9ju7uwT\nNUVM7XKlIQKBgDnv5pS0TiPaRJri1/t6xGI9DzZ9EgfwsCS5LBRZnjUrGcx+Ecl3\n3vuABdRgU31THiSmrrH2roMYVGVI53YF7SDzMOyr46p6MurPvv72Hj2aXyNa9BnM\nCIr0cpQ/3NB47Qb/JyQzsni+6UiFjKe4++3YofN8xLtakudFPDedON2fAoGAaf9x\nDwfMnVeM3RY6XqgXAW5hSJaMA+5ypasCtaDGrBTVUBsgwiu5i7ANK9oZ62DOX73x\n3BD/0jTi8bpJOSulJRg+m7ZEJJxaHZ8RdqLaXut3UfYke4lob5kcUkCINy3IyWaA\ntJQQt/cLF4KCEugDZPcbDz1LiOq5w8j1XbwJp6ECgYBmlV/ZNzkGono7fGkdVPVb\nzaVbT3jFPRquWdAu1fGIilDqaKdjKI9ttKTLNryo6wW1q6/70DPibbALjjC3j3UK\nWiYw8Nh821NEnpiOE95iRSdYA4SuLtqXpYlZ/5GSYPLIXWcxotv1vtwKV9ZSmLHd\n7oRoBG0dFKR7oQxEwmXddA==\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheets@gsheets-325114.iam.gserviceaccount.com",
  "client_id": "115327385754198164239",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheets%40gsheets-325114.iam.gserviceaccount.com"
}

  ''';

  static Worksheet _userSheet;
  static Worksheet _userSheet2;
  static Worksheet _userSheet3;
  static final _gsheets = GSheets(_credentials);

  static Future init() async {
    try {
      final spreadsheet = await _gsheets.spreadsheet(_spreedSheetId);
      _userSheet = await _getWorkSheet(spreadsheet, title: 'Orders');
      _userSheet.values.insertRow(1, UserFields.getFields());
      _userSheet2 = await _getWorkSheet(spreadsheet, title: 'Products');
      _userSheet3 = await _getWorkSheet(spreadsheet, title: 'Admins');
    } catch (e) {
      print(e.toString());
    }
  }

  static Future insert(Map<String, dynamic> rowList) async {
    if (_userSheet == null) return;
    _userSheet.values.map.appendRow(rowList);
  }

  static Future<List<Map<String, String>>> fetchData() async {
    List<Map<String, String>> products =
    await _userSheet2.values.map.allRows(fromRow: 1);

    return products;
  }static Future<List<Map<String, String>>> fetchadmins() async {
    List<Map<String, String>> admins =
    await _userSheet3.values.map.allRows(fromRow: 1);

    return admins;
  }

  static Future<Worksheet> _getWorkSheet(Spreadsheet spreedSheet,
      {@required String title}) async {
    try {
      return await spreedSheet.addWorksheet(title);
    } catch (e) {
      return spreedSheet.worksheetByTitle(title);
    }
  }
}

class UserFields {
  static final String productsName = "Products";
  static final String userPhoneNumber = "User PhoneNumber";
  static final String userName = "UserName";
  static final String userAdress = "User Address";
  static final String date = "Date";
  static final String totalPrice = "Total Price";

  static List<String> getFields() =>
      [productsName, userName, userPhoneNumber, userAdress, date, totalPrice];
}
