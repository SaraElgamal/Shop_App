

class HomeModel {
  bool status ;
  HomeDataModel data ;
  HomeModel.fromJson(Map <String,dynamic> json){
     status = json['status'];
     data = json['data'] != null ?  HomeDataModel.fromJson(json['data']) : null ;
  }
}
class HomeDataModel {

  List <BannerModel> banners = [];
  List<ProductsModel> products = [];


   HomeDataModel.fromJson(Map < String , dynamic> json)
   {
   /* banners.add(BannerModel.fromJson(json['banners'].forEach((value){
      banners.add(value);
    }),));*/
/*     json['products'] = (json['products'] as List);
     products.add(ProductsModel.fromJson(json['products'] ));

     products = List<Map<String, dynamic>>.ProductsModel.fromjson(json['products']);*/


   // json['products'] = (json['products'] as List<ProductsModel>);

   banners =   ( json['banners'] as List).map((e) => BannerModel.fromJson(e)).toList();
  products =   ( json['products'] as List).map((e) => ProductsModel.fromJson(e)).toList();

}
}
class BannerModel {
  int id;
  String image;
  BannerModel.fromJson(Map <String, dynamic> json)
  {
   id = json['id'];
    image = json['image'];
  }
}
class ProductsModel {
   int id ;
   dynamic price;
   dynamic old_price;
   dynamic discount;
   String image;
   String name;
   bool in_cart;
   bool in_favorites;
  ProductsModel.fromJson(Map <String,dynamic> json)
  {
   id =  json ['id'];
   price =  json ['price'];
   old_price =  json ['old_price'];
   discount =  json ['discount'];
   image =  json ['image'];
   name =  json ['name'];
   in_cart =  json ['in_cart'];
   in_favorites =  json ['in_favorites'];
  }
}