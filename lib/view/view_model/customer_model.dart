import 'package:fin/models/BaseClients.dart';

class CustomerModel {
  static saveCustomer(
    name,
    contactNo,
    address,
    dailyDueAmount,
    loanAmount,
    loanDuration,
    startingDate,
  ) async {
    Map<dynamic, String> body = {
      "name": name.toString(),
      "contact_no": contactNo.toString(),
      "address": address.toString(),
      "loan_amount": loanAmount.toString(),
      "daily_due_amount": dailyDueAmount.toString(),
      "loan_duration": loanDuration.toString(),
      "starting_date": startingDate.toString(),
    };
    var response = await BaseClient().post('/customer', body);
    return response;
  }
}
