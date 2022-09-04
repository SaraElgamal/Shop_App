import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/login/cubit/cubit.dart';
import 'package:shop_app/layout/shopLayout/cubit/cubit.dart';
import 'package:shop_app/layout/shopLayout/cubit/states.dart';
import 'package:shop_app/styles/components/components.dart';
import 'package:shop_app/styles/components/constans.dart';

class SettingsScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit,ShopHomeStates>
      (
      listener:  (context , state) {

      },
      builder: (context , state){
    var model = ShopHomeCubit.get(context).userModel;
        nameController.text = model.data.name;
        emailController.text = model.data.email;
        phoneController.text = model.data.phone;
        return   ConditionalBuilder(
          condition: ShopHomeCubit.get(context).userModel != null  ,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  defaultField
                    (controller: nameController,
                      validate: (String value){
                        if(value.isEmpty) {
                          return 'name must not be empty ';
                        }
                        return null ;
                      },
                      label: 'Name',
                      prefix: Icons.person,
                      keyboard: TextInputType.text
                  ),

                  SizedBox(height: 20.0,),

                  defaultField
                    (controller: emailController,
                    validate: (String value){
                      if(value.isEmpty) {
                        return 'email must not be empty ';
                      }
                      return null ;
                    },
                    label: 'Email',
                    prefix: Icons.email_outlined,
                    keyboard: TextInputType.emailAddress,
                  ),

                  SizedBox(height: 20.0,),

                  defaultField
                    (controller: phoneController,
                    validate: (String value){
                      if(value.isEmpty) {
                        return 'phone must not be empty ';
                      }
                      return null ;
                    },
                    label: 'Phone',
                    prefix: Icons.phone,
                    keyboard: TextInputType.phone,
                  ),
                  SizedBox(height: 24.0,),
                  defaultButton(text: 'LogOut',
                      function:(){ signOut(context);} ) ,

                  SizedBox(height: 24.0,),
                  defaultButton(text: 'Update',
                      function:(){
                    if(formKey.currentState.validate()){
                      ShopHomeCubit.get(context).UpdateUserData(
                        name: nameController.text,
                        email: emailController.text,
                        phone: phoneController.text,);

                    }


                      } ) ,
                ],
              ),
            ),
          ),
          fallback:  (context) => Center(child: CircularProgressIndicator()),
        );
      } ,
    );
  }
}
