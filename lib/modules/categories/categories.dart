import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shopLayout/cubit/cubit.dart';
import 'package:shop_app/layout/shopLayout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/styles/components/components.dart';

class CategoriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit,ShopHomeStates>(
    listener: (context , state) {},
    builder: (context , state) {
      return ListView.separated(itemBuilder: (context , index) => buildCatItem(ShopHomeCubit.get(context).categoriesModel.data.data[index]),
        separatorBuilder: (context , index) => myDivider () ,
        itemCount: ShopHomeCubit.get(context).categoriesModel.data.data.length,);

    } ,

    );
  }
}
Widget buildCatItem(DataModel model ) => Padding(
  padding: const EdgeInsets.all(12.0),
  child: Row(
    children: [
      Image(image:
      NetworkImage(model.image),
        fit: BoxFit.cover,
        width: 100.0,


      ),
      Text(model.name,
        style: TextStyle(
          fontSize: 20.0,
        ),

      ),
      Spacer(),
      Icon(Icons.arrow_forward_ios),


    ],
  ),
);
