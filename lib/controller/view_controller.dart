import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ViewController extends GetxController{
  RxString currentTab = ''.obs;
  var page = [].obs;

  void pushPage(current){
    if(page.length>=10){
      page.removeAt(0);
    }
    page.add(current);
  }
  Future<bool> setPrevPage()async{
    if(page.isEmpty || page.length==1){
      SystemNavigator.pop();
      return true;
    }else{
      page.removeLast();
      return false;
    }
  }
}