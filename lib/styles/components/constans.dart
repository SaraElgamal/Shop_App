import 'package:flutter/material.dart';
import 'package:shop_app/styles/components/components.dart';

import '../../layout/login/login.dart';
import '../../network/local/cache_helper.dart';

void signOut (context){

   CacheHelper.removeData(key: 'token',).then((value) {
   if(value ){
   navigateFinish(context, ShopLogin());
} });
}
    String token = '';