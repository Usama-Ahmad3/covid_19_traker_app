import 'dart:convert';
import 'package:covid_19/services/uttlities/api_url.dart';
import 'package:http/http.dart' as http;

import '../Models/WorldSTateModels.dart';

class StateServices{
  Future<WorldSTateModels> getWorldStateRecords ()async{
    final response = await http.get(Uri.parse(ApiUrl.worldState));
    if(response.statusCode == 200){
      var data = jsonDecode(response.body.toString());
      return WorldSTateModels.fromJson(data);
    }
    else{
      throw Exception('Error');
    }
  }
 }