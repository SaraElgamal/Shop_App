import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/login/login.dart';
import 'package:shop_app/layout/shopLayout/cubit/cubit.dart';
import 'package:shop_app/layout/shopLayout/cubit/states.dart';
import 'package:shop_app/modules/search/search.dart';
import 'package:shop_app/styles/components/components.dart';

import '../../network/local/cache_helper.dart';

class ShopLayout extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit,ShopHomeStates>(
      listener: (context , state)  {},
      builder: (context , state) {
        var cubit = ShopHomeCubit.get(context);
        return    Scaffold(
          appBar: AppBar(
            title:  Text('Salla'),
          actions: [
            IconButton(onPressed: (){
              navigateTo(context, SearchScreen());
            }, icon: Icon(Icons.search,),),
          ],),
          body : cubit.bottomScreens[cubit.currentIndex]  ,

          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index){
            cubit.changeBottomScreen(index);
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home,),
              label: 'Home',
              ),
              BottomNavigationBarItem(icon: Icon(Icons.apps,),
                label: 'Categories',
              ),
              BottomNavigationBarItem(icon: Icon(Icons.favorite,),
                label: 'Favourites',
              ),
              BottomNavigationBarItem(icon: Icon(Icons.settings,),
                label: 'Settings',
              ),
            ],
          ),

  );


    },
    );

  }
}
