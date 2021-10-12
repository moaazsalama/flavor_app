import 'package:flutter/material.dart';
import 'package:ver2/models/googlesheets.dart';


class Admins with ChangeNotifier{
     List<String> admins=[];


    fetechAdmins()async{
      List<Map<String, String>> res = await UserSheetApi.fetchadmins();

      List<String> loaded=[];
      res.forEach((element) {loaded.add(element['email']);});
      admins=loaded;
      notifyListeners();

    }
    bool  isAdmin(String email)  {


      return admins.contains(email);
    }
}