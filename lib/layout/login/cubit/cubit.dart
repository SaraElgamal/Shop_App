import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/login/cubit/state.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/network/end_point.dart';
import 'package:shop_app/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<StatesLogin>{
  LoginCubit() : super(StateInitialLogin());

static LoginCubit get(context) => BlocProvider.of(context);
  LoginModel loginModel ;
void userLogin ({
  @required String email,
  @required String password,
}){
  emit(StateLoadingLogin());
DioHelper.postData(url: LOGIN,
    data: {
  'email': email,
  'password': password,
    },).then((value) {
      print(value.data);

      loginModel =  LoginModel.fromJson(value.data);

      emit(StateSuccessLogin(loginModel));
} ).catchError((error){
  print ('errorrrrrrr here');
  print (error.toString());
  emit(StateErrorLogin( error.toString()));
} );
}
   IconData suffix = Icons.visibility_outlined;
bool isPassword = true;
  void changePasswordVisibility (){

    isPassword = ! isPassword;
    suffix = isPassword ?   Icons.visibility_outlined : Icons.visibility_off_outlined;
 emit(StatePasswordVisibilityLogin());
  }
}