import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ApiMethods {
  static post(String url, Map<String, String> body) async {
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiNWIxMjRkNmEzMGE4NmQ5ZjhiNjJhMThjYzJjNjBjMWY4Y2VmZWFiNzcxMWZjZmU3OTNhMjdiNjExNmE3NmM0OWJjZDAwNDA3NDUzNmUwN2MiLCJpYXQiOjE2ODczNjQ3NjQuMjA3MzA5MDA3NjQ0NjUzMzIwMzEyNSwibmJmIjoxNjg3MzY0NzY0LjIwNzMxMDkxNDk5MzI4NjEzMjgxMjUsImV4cCI6MTcxODk4NzE2NC4yMDU5MzgxMDA4MTQ4MTkzMzU5Mzc1LCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.opTV2q_BHig6OW9Pf-NcuJrSx65GGsmRC2zTpVidbIMTyxB5zwQQ7bDld3pe38fsbgzEcPXFGsKaxVbz9Ul3xA9VCHLJ_XqCqbeF2FqDlEyTjDZ16J5ndflUZGmRwncOR29Tug6TvAED38ZdEF2ub5zaS6I3YPLDdXPjcGfvHwJZKv15f1kfRBkazIziQkJdwmiiMupSAErLZuWIk0GLLb8cANtljQJMD3uGrM8fwBeGA5XwF6X-L3A2vIX8c43EuaVuzlTY_uaEGJcTrgOrB3wL3iOwXH4fig6xLmE-otiT38LXujeKCFMlKYJaoMdQIhgkIMbZw-d0Vxc_cz5UZckW6lTTHLXGj-V-_nvr1y3s3127TcnDedkconf1xqvzHxFllfsj192Hg5S_s6-RL8KTPsdr-uSGdb3ZwGuL-7Iefa8qHPryKs81RfM1lc5uG8rmg1WkZZBEnqyq8kheYRB5uMqhugwzHzJyfttbo3veuvS8o7MQhPTr52VtOYIPVWrTXvoHEf3X5lFIXkA-VnYUR6jrIeQWnGfAhaXDP7-uN9NTtx1sZYSqOUC3zxIrqqYevJaUPYbQ_HJnYzF4i7catPecwJtCKaYWsWz6oPZpKVvoPCycjSxiq-Y723mv_wWnV3_7PtmgE_dvjzN1uAfN6fFzefc98vobMImbWJc'
    };
    final jsonBody = jsonEncode(body);
    var response =
        await http.post(Uri.parse(url), headers: headers, body: jsonBody);
    return response;
  }

  static get(String url) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    var response = await http.get(Uri.parse(url), headers: headers);
    return response;
  }
}
