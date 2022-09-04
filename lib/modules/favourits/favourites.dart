import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shopLayout/cubit/cubit.dart';
import 'package:shop_app/layout/shopLayout/cubit/states.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/styles/components/components.dart';

import '../../styles/colors.dart';

class FavouritesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopHomeCubit,ShopHomeStates>(
      listener: (context , state) {},
      builder: (context , state) {
        return ConditionalBuilder(
          condition: state  is ! ShopGetFavoritesLoadingState,
          builder: (context) => ListView.separated(
            itemBuilder: (context , index) =>
                buildListItem(ShopHomeCubit.get(context).favoritesModel.data.data[index].product, context),
            separatorBuilder: (context , index) => myDivider () ,
            itemCount: ShopHomeCubit.get(context).favoritesModel.data.data.length,),
          fallback: (context) => Center(child: CircularProgressIndicator()) ,
        );

      } ,

    ); ;
  }

}
