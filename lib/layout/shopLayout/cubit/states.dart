import 'package:shop_app/models/favorite_change_model.dart';
import 'package:shop_app/models/login_model.dart';

abstract class ShopHomeStates {}
class ShopInitialState extends ShopHomeStates {}
class ShopChangeState extends ShopHomeStates {}

class ShopLoadingState extends ShopHomeStates {}
class ShopSuccessState extends ShopHomeStates {}
class ShopErrorState extends ShopHomeStates {
  final String error ;

  ShopErrorState(this.error);
}

class ShopSuccessCategoriesState extends ShopHomeStates {}
class ShopErrorCategoriesState extends ShopHomeStates {
  final String error ;

  ShopErrorCategoriesState(this.error);

}



class ShopSuccessFavoritesState extends ShopHomeStates {
  final ChangeFavoriteModel model ;

  ShopSuccessFavoritesState(this.model);
}
class ShopChangeFavoritesState extends ShopHomeStates {}
class ShopFavoriteErrorState extends ShopHomeStates {
  final String error ;
  ShopFavoriteErrorState(this.error);

}

class ShopGetFavoritesLoadingState extends ShopHomeStates {}
class ShopGetFavoritesSuccessState extends ShopHomeStates {}
class ShopGetFavouritesErrorState extends ShopHomeStates {
  final String error ;

  ShopGetFavouritesErrorState(this.error);
}

class ShopGetUserDataLoadingState extends ShopHomeStates {}
class ShopGetUserDataSuccessState extends ShopHomeStates {
  final LoginModel loginModel ;

  ShopGetUserDataSuccessState(this.loginModel);
}
class ShopGetUserDataErrorState extends ShopHomeStates {
  final String error ;

  ShopGetUserDataErrorState(this.error);}

class ShopUpdateUserDataLoadingState extends ShopHomeStates {}
class ShopUpdateUserDataSuccessState extends ShopHomeStates {
  final LoginModel loginModel ;

  ShopUpdateUserDataSuccessState(this.loginModel);
}
class ShopUpdateUserDataErrorState extends ShopHomeStates {
  final String error ;

  ShopUpdateUserDataErrorState(this.error);}