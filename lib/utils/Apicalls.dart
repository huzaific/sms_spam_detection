import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

Future saveContactsToDB(Map<String, dynamic> body) async {
  var url = Uri.parse('https://bawlio.neben.dev/api/storecontacts');

  var response = await http.post(url, body: convert.jsonEncode(body), headers: {
    "Accept": "application/json",
    "Content-Type": "application/json"
  });

  var decodedBody = convert.jsonDecode(response.body) as Map<String, dynamic>;

  if (response.statusCode == 200) {
    return decodedBody;
  } else {
    throw 'Failed to store contacts';
  }
}