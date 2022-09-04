import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/login/cubit/cubit.dart';
import 'package:shop_app/layout/shopLayout/register/cubit/cubit.dart';
import 'package:shop_app/layout/shopLayout/register/cubit/state.dart';
import 'package:shop_app/layout/shopLayout/shop_layout.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/styles/colors.dart';
import 'package:shop_app/styles/components/components.dart';
import 'package:shop_app/styles/components/constans.dart';

class Register extends StatelessWidget {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(

      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit,StatesRegister>(
        listener: (context , state) {
          if(state is StateSuccessRegister)
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
        builder: (context , state) {
          return    Scaffold(
          appBar: AppBar(),
          body: Center(
          child: SingleChildScrollView(
          child:  Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
          key : formKey,
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text('REGISTER' , style:
          //to design text
          Theme.of(context).textTheme.headline4.copyWith(
          color: defaultColor,
          ) ,

          ),
          SizedBox(height: 15.0,),
          Text('Register now to browse our hot offer ' , style:
          //to design text
          Theme.of(context).textTheme.bodyText1.copyWith(
          color: Colors.grey[600],) ,),
          SizedBox(height: 30.0,),
          defaultField(controller: nameController,
          validate: (String value){
          if (value.isEmpty){
          return 'name must not be empty';
          }
          },
          label: 'User Name',
          prefix: Icons.person_outlined,
          keyboard: TextInputType.name,),
          SizedBox(height: 15.0,),

          defaultField(controller: phoneController,
          validate: (String value){
          if (value.isEmpty){
          return 'Phone must not be empty';
          }
          },
          label: 'User Phone',
          prefix: Icons.phone,
          keyboard: TextInputType.phone,),
          SizedBox(height: 15.0,),

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
          RegisterCubit.get(context).userRegister(
              name: nameController.text,
              phone: phoneController.text,
              email: emailcontroller.text,
          password: passwordcontroller.text, ); }
          },
          validate: (String value){
          if (value.isEmpty){
          return 'password must not be empty';
          }
          },
          label: 'Password',
          isPassword :   RegisterCubit.get(context).isPassword,
          prefix: Icons.lock_outline,
          keyboard: TextInputType.visiblePassword,
          suffix:   RegisterCubit.get(context).suffix,
          onpressed: (){
            RegisterCubit.get(context).changePasswordVisibility();

          }

          ),
          SizedBox(height: 20.0,),
          ConditionalBuilder(
          condition: true ,

          builder: (context) =>  defaultButton(text: 'Sign Up',

          function: (){

          if (formKey.currentState.validate()){
            RegisterCubit.get(context).userRegister(
              name: nameController.text,
              phone: phoneController.text,
              email: emailcontroller.text,
          password: passwordcontroller.text,);

          }

          }
          ,
          isUpperCase: true,

          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
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
