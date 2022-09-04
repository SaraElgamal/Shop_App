import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/shopLayout/register/Register.dart';
import 'package:shop_app/layout/login/cubit/state.dart';
import 'package:shop_app/layout/shopLayout/shop_layout.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/styles/colors.dart';
import 'package:shop_app/styles/components/components.dart';
import 'package:shop_app/styles/components/constans.dart';

import 'cubit/cubit.dart';

class ShopLogin extends StatelessWidget {

var emailcontroller = TextEditingController();
var passwordcontroller = TextEditingController();
var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(

      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit,StatesLogin>(
     listener:  (context , state) {
       if(state is StateSuccessLogin)
       {
         if (state.loginModel.status)
         {

          print(state.loginModel.message);
           print(state.loginModel.data.token);
        CacheHelper.saveData(key: 'token',
            value: state.loginModel.data.token ).
        then((value){
          token = state.loginModel.data.token;
          navigateFinish(context, ShopLayout(),);
        } );

         } else
         {
          print (state.loginModel.message);

          showToast(
            text: state.loginModel.message,
            state: ToastStates.ERROR,

          );
         }
       }
     },
        builder: (context , state ) {
       return  Scaffold(
         appBar: AppBar(),
         body:Center(
             child: SingleChildScrollView(
               child:  Padding(
                 padding: const EdgeInsets.all(20.0),
                 child: Form(
                 key : formKey,
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text('LOGIN' , style:
                     //to design text
                     Theme.of(context).textTheme.headline4.copyWith(
                       color: defaultColor,
                     ) ,

                 ),
                     SizedBox(height: 15.0,),
                     Text('Login now to browse our hot offer ' , style:
                     //to design text
                     Theme.of(context).textTheme.bodyText1.copyWith(
                       color: Colors.grey[600],) ,),
                     SizedBox(height: 30.0,),
                     defaultField(controller: emailcontroller,
                       validate: (String value){
                         if (value.isEmpty){
                           return 'email must not be empty';
                         }
                       },
                       label: 'Email Address',
                       prefix: Icons.email_outlined,
                       keyboard: TextInputType.emailAddress,),
                     SizedBox(height: 15.0,),

                     defaultField(controller: passwordcontroller,
                         onSubmitted: (value){
    if (formKey.currentState.validate()){
    LoginCubit.get(context).userLogin(email: emailcontroller.text,
    password: passwordcontroller.text); }
                         },
                         validate: (String value){
                           if (value.isEmpty){
                             return 'password must not be empty';
                           }
                         },
                         label: 'Password',
                         isPassword :   LoginCubit.get(context).isPassword,
                         prefix: Icons.lock_outline,
                         keyboard: TextInputType.visiblePassword,
                         suffix:   LoginCubit.get(context).suffix,
                         onpressed: (){
                    LoginCubit.get(context).changePasswordVisibility();

                         }

                     ),
                     SizedBox(height: 20.0,),
                     ConditionalBuilder(
                       condition: state is! StateLoadingLogin ,

                       builder: (context) =>  defaultButton(text: 'LOGIN',

                         function: (){
                         if (formKey.currentState.validate()){
                           LoginCubit.get(context).userLogin(email: emailcontroller.text,
                               password: passwordcontroller.text);

                         }

                         }
                         ,
                         isUpperCase: true,

                       ),
                       fallback: (context) => Center(child: CircularProgressIndicator()),
                     ),


                     SizedBox(height: 20.0,),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Text('Don\'t have an account ? '),
                         defaultTextButton(
                           function : (){ navigateTo(context, Register());},
                           text: 'register ',),
                       ],
                     ),
                   ],
                 ),
               ),
             ),
           ),
         ),
       );
        },
      ),
    );
  }
}
