import 'package:http/http.dart' as http;
import 'dart:convert';

class DataService {
  List<Map<String, dynamic>> _recordList = [];
  List<String> _columnName = [];
  final String ipPortUrl = '192.168.29.50:8080';
  final String path = '/tscm/records/vehicle';
  final String userName = 'admin';
  final String password = 'admin';

  List<Map<String, dynamic>> get recordList {
    if(_recordList.isEmpty){
      return [];
    }
    else{
      return [..._recordList];
    }
  }

  List<String> get columnNameList{
    if(_columnName.isEmpty){
      return[];
    }
    else{
      return [..._columnName];
    }
  }

    Future<void> initData() async{
      final url = Uri.http(ipPortUrl,path);
      final response = await http.get(url,
      headers: <String , String > {'Authorization' : 'Basic ${base64Encode(utf8.encode('$userName:$password'))}' });

      print("status is ${response.statusCode}");
      print("Body is : ${response.body}");
      var jsonObject = jsonDecode(response.body);
      transformData(jsonObject["records"]);
      print("recordsList is $_recordList");
  }

  void transformData(List<dynamic> records){
      bool isFirstRecord = true;

      for(var recordItem in records){
        if(isFirstRecord){
          for(String key in recordItem.keys){
            _columnName.add(key);
          }
          isFirstRecord = false;
        }
        _recordList.add(recordItem);
      }
  }
}