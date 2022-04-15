import 'dart:convert' as convert;
import 'package:http/http.dart' as http;


Future login(String email) async {
  var url = Uri.parse(
      'https://newandnicer.com/admin/process/mainProcess.php?action=query&email=$email');

  // Await the http get response, then decode the json-formatted response.
  var response = await http.get(url, headers: {'Accept': "application/json"});

  var decodedBody = convert.jsonDecode(response.body) as Map<String, dynamic>;

  if (response.statusCode == 200) {
    if (decodedBody['message'] == 'success')
      return decodedBody;
    else
      throw 'Invalid credentials';
  } else {
    throw 'Failed to Login';
  }
}


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