import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpFunctions{

  registerUser(
      {String? name,
      String? username,
      String? email,
      String ?password,
      String ?passwordConfirm,
      String ?role,
      String ?activationToken,
      int ?phoneNumber,
      String ?companyName,
      String? companyEmail,
      int ?companyNumber,
      String ?companyDescription,
      String ?address}) async{
    print("register user called");
    var url=Uri.parse("https://ems-heroku.herokuapp.com/register");
    var dataToSend={
      "name":name,
      "username":username,
      "email":email,
      "password":password,
     "passwordConfirm":passwordConfirm,
      "role":role,
      "activation_token":activationToken,
      "phoneNumber":phoneNumber,
      "companyName":companyName,
      "companyEmail":companyEmail,
      "companyNumber":companyNumber,
      "companyDescription":companyDescription,
      "address":address

    };
    var finalData=jsonEncode(dataToSend);
    http.Response response=await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: finalData
    );
    print("this is response");
    print(response.body);
  }

  signInUser({
    String? username,String? password
}) async{
    print("signInUser called with $username and $password");
    var url=Uri.parse("https://ems-heroku.herokuapp.com/login");
    var dataToSend={
      "username":username,
      "password":password,
    };
    var finalData=jsonEncode(dataToSend);
    http.Response response=await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: finalData
    );
    print("this is response");
    print(response.body);
    return response.body;
  }
}