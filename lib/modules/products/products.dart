import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shopLayout/cubit/cubit.dart';
import 'package:shop_app/layout/shopLayout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/styles/colors.dart';
import 'package:shop_app/styles/components/components.dart';

class ProductsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit,ShopHomeStates>(
        listener:  (context , state ) {
          if(state is ShopSuccessFavoritesState) {
            if( ! state.model.status) {
              showToast(text: state.model.message,
                  state: ToastStates.ERROR, );
            }
          }
        },
        builder: (context , state ) {
          return ConditionalBuilder(
              condition: ShopHomeCubit.get(context).homeModel != null && ShopHomeCubit.get(context).categoriesModel != null,
              builder: (context) => productsBuilder(ShopHomeCubit.get(context).homeModel, ShopHomeCubit.get(context).categoriesModel, context) ,
          fallback: (context) => Center(child: CircularProgressIndicator()),
          );



        },
         ) ;
  }
  Widget productsBuilder (HomeModel model , CategoriesModel categoriesModel, context) => SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
            items: //عشان يرجع ليسته من الحاجه اللي عاوزاها واللي هي هنا الصور
               model.data.banners.map((e) =>  Image(image: NetworkImage('${e.image}'),
    width: double.infinity,
    fit: BoxFit.cover,
               ), ).toList(),
            options: CarouselOptions(
              height: 250.0,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              viewportFraction: 1.0,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(seconds: 1),
              //the best shape
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            )),
       SizedBox(height: 10.0,),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Categories',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
            ),
     Container(
             height: 100.0,
             child: ListView.separated(
               scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
               itemBuilder: (context , index) =>  categoriesBuilder (categoriesModel.data.data[index]),
                 separatorBuilder:(context , index) => SizedBox(width: 10.0,),
                 itemCount: categoriesModel.data.data.length,),
     ),
            SizedBox(height: 20.0,),
              Text('New Products',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
        SizedBox(height: 10.0,),
        Container(
          color: Colors.grey[300],
          child: GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            mainAxisSpacing: 1.0,
            crossAxisSpacing: 1.0,
            childAspectRatio: 1/ 1.72,
            crossAxisCount: 2, //number of them
            children:
              List.generate(
                  model.data.products.length,
                      (index) => builderGridView(model.data.products[index],context ),
              ),

     ),
        ),
      ],
    ),
  );
}
Widget categoriesBuilder (DataModel model) =>  Stack(
  alignment: AlignmentDirectional.bottomCenter,
  children: [
    Image(image: NetworkImage(model.image),
      height: 100.0,
      width: 100.0,
      fit: BoxFit.cover,
    ),
    Container(
      color: Colors.black.withOpacity(.8),
      width: 100.0,
      child: Text(model.name,
        maxLines: 1,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,

        style: TextStyle(
          color: Colors.white,
        ),
      ),
    ),
  ],
);
Widget builderGridView (ProductsModel model , context) =>
  Container(
    color: Colors.white,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [ Image(image: NetworkImage(model.image),
          width: double.infinity,
            height: 200.0,
          ),
            if(model.discount != 0)
            Container(
              color: Colors.red,
              padding: EdgeInsets.symmetric(horizontal: 5.0,),
              child: Text('DISCOUNT',
              style: TextStyle(fontSize: 12.0,
              color: Colors.white,
              ),
              ),
            ),
       ], ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                model.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14.0,
                  //بيخلي الكلام قريب من بعضه
                  height: 1.3,

                ),
              ),
              Row(
                children: [
                  Text(
                    '${model.price.round()}',

                    style: TextStyle(
                      fontSize: 12.0,
                      color: defaultColor,

                    ),
                  ),
                  SizedBox(width: 5.0,),
                  if(model.discount != 0)
                  Text(
                    '${model.old_price.round()}',

                    style: TextStyle(
                      fontSize: 11.0,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,

                    ),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: (){
                      ShopHomeCubit.get(context).changeFavorites(model.id);
                      print(model.id);
                    },
                    icon: CircleAvatar(
                      radius: 15.0,
                      backgroundColor:ShopHomeCubit.get(context).favorites[model.id] ? Colors.red : Colors.grey,
                      child: Icon(Icons.favorite_border_outlined,
                  size: 14.0,

                      color: Colors.white,),
                    ),),
                ],
              ),

            ],
          ),
        ),

      ],
    ),
  );


