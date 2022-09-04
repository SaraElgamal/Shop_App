import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/login/cubit/state.dart';
import 'package:shop_app/layout/shopLayout/register/cubit/state.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/network/end_point.dart';
import 'package:shop_app/network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<StatesRegister>{
  RegisterCubit() : super(StateInitialRegister());

static RegisterCubit get(context) => BlocProvider.of(context);
  LoginModel loginModel ;
void userRegister ({
  @required String name,
  @required String phone,
  @required String email,
  @required String password,
}){
  emit(StateLoadingRegister());
DioHelper.postData(url: REGISTER,
    data: {
      'name': name,
      'phone': phone,
     'email': email,
     'password': password,
    },).then((value) {
      print(value.data);

      loginModel =  LoginModel.fromJson(value.data);

      emit(StateSuccessRegister(loginModel));
} ).catchError((error){
  print ('errorrrrrrr here');
  print (error.toString());
  emit(StateErrorRegister( error.toString()));
} );
}
   IconData suffix = Icons.visibility_outlined;
bool isPassword = true;
  void changePasswordVisibility (){

    isPassword = ! isPassword;
    suffix = isPassword ?   Icons.visibility_outlined : Icons.visibility_off_outlined;
 emit(StatePasswordVisibilityRegister());
  }
}