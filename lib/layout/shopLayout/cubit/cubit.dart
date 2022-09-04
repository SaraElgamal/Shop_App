import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shopLayout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/favorite_change_model.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/categories/categories.dart';
import 'package:shop_app/modules/favourits/favourites.dart';
import 'package:shop_app/modules/products/products.dart';
import 'package:shop_app/modules/settings/settings.dart';
import 'package:shop_app/network/end_point.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/styles/components/components.dart';

import '../../../styles/components/constans.dart';

class ShopHomeCubit extends Cubit<ShopHomeStates>{
  ShopHomeCubit() : super(ShopInitialState());
  static ShopHomeCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
   List<Widget> bottomScreens = [
     ProductsScreen(),
     CategoriesScreen(),
   FavouritesScreen(),
     SettingsScreen(),
   ];
void changeBottomScreen (int index){
  currentIndex = index ;
  emit(ShopChangeState());
}
  ChangeFavoriteModel changeFavoriteModel;
void changeFavorites(int productId)
{
  favorites[productId] = ! favorites[productId];
  emit(ShopChangeFavoritesState());
  DioHelper.postData(
      url: FAVORITES,
      data: { 'product_id': productId , },
    token: token,
  ).then((value){
    changeFavoriteModel = ChangeFavoriteModel.fromJson(value.data);
    print(value.data);
    if(! changeFavoriteModel.status) {
      favorites[productId] = ! favorites[productId];
    } else {
      getFavorites();
    }
    emit(ShopSuccessFavoritesState(changeFavoriteModel));
  }).catchError((error){
    favorites[productId] = ! favorites[productId];
    print(error.toString());
    emit(ShopFavoriteErrorState(error));
  });
}
   HomeModel homeModel;
  Map<int,bool> favorites = {} ;
void getHomeData (){
  emit(ShopLoadingState());
  DioHelper.getData(
      url: HOME ,
     token: token,
  ).then((value){
    homeModel = HomeModel.fromJson(value.data);
  /*  printLongString(homeModel.data.banners[0].image);
    print(homeModel.status);*/

    homeModel.data.products.forEach((element) {
      favorites.addAll({
        element.id : element.in_favorites,
      });
    });

    emit(ShopSuccessState());
  }).catchError((error){
    print(error.toString());
    emit(ShopErrorState(error.toString()));
  });

}

  CategoriesModel categoriesModel;
  void getCategoriesData (){

    DioHelper.getData(
      url: GET_CATEGORIES ,
      token: token,
    ).then((value){
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopSuccessCategoriesState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorCategoriesState(error.toString()));
    });

  }

  FavoritesModel favoritesModel;
  void getFavorites (){
   emit(ShopGetFavoritesLoadingState());
    DioHelper.getData(
      url: FAVORITES ,
      token: token,
    ).then((value){
      favoritesModel = FavoritesModel.fromJson(value.data);
      printLongString(value.data.toString());
      emit(ShopGetFavoritesSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(ShopGetFavouritesErrorState(error.toString()));
    });

  }

  LoginModel userModel;
  void getUserData (){
    emit(ShopGetUserDataLoadingState());
    DioHelper.getData(
      url: PROFILE ,
      token: token,
    ).then((value){
      userModel = LoginModel.fromJson(value.data);
   //   print(userModel.data.name);
      emit(ShopGetUserDataSuccessState(userModel));
    }).catchError((error){
      print(error.toString());
      emit(ShopGetUserDataErrorState(error.toString()));
    });

  }

  void UpdateUserData ({
  @required String name,
  @required String email,
  @required String phone,
}){
    emit(ShopUpdateUserDataLoadingState());
    DioHelper.putData(
      url: UPDATE_PROFILE ,
      token: token,
      data : {
        'name' : name,
        'email' : email,
        'phone' : phone,
      },
    ).then((value){
      userModel = LoginModel.fromJson(value.data);
      print(userModel.data.name);
      emit(ShopUpdateUserDataSuccessState(userModel));
    }).catchError((error){
      print(error.toString());
      emit(ShopUpdateUserDataErrorState(error.toString()));
    });

  }
}