import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/shopLayout/cubit/cubit.dart';
import 'package:shop_app/styles/colors.dart';

void navigateTo(context, widget) => Navigator.push(context, MaterialPageRoute(
  builder:
      (context) => widget, ));

void navigateFinish(context, widget) => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
  builder:
      (context) => widget,
      ),
        (route){
      return false;
    }
);
Widget defaultField( {
  @required TextEditingController controller,
  Function onSubmitted,
  bool isPassword = false ,
  @required Function validate,
  @required  String label,
  Function onChange,
  @required IconData prefix,
  IconData suffix,
  Function onpressed,
  @required TextInputType keyboard,
}) => TextFormField(

  controller: controller,
  keyboardType: keyboard,
  obscureText: isPassword,
  onChanged: onChange,
  onFieldSubmitted: onSubmitted,
  validator: validate,
  decoration: InputDecoration(

    labelText: label,
    prefixIcon: Icon(prefix),
    suffixIcon: suffix != null ? IconButton(icon : Icon (suffix) , onPressed: onpressed,) : null ,
    border: OutlineInputBorder(),


  ),
);
Widget defaultButton({
  double width =  double.infinity,
  double height = 40.0,
  double radius = 0.0,
  Color color= Colors.blue,
  bool isUpperCase = true,
  @required String text,
  @required Function function,
}) =>  Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadiusDirectional.all(Radius.circular(radius), ),
    color: color,
  ),
  width: width,
  height: height,

  child: MaterialButton(
    onPressed: function,
    child: Text(isUpperCase ? text.toUpperCase() : text,
      style: TextStyle(color: Colors.white,
          fontSize: 16.0),),

  ),
);
Widget defaultTextButton ({
  @required String text,
  @required Function function,
})=>
     TextButton(onPressed: function, child: Text(text.toUpperCase()),);
 void showToast ({
  @required String text,
  @required ToastStates state,
}) =>  Fluttertoast.showToast(
     msg: text,
     toastLength: Toast.LENGTH_LONG,
     gravity: ToastGravity.BOTTOM,
     timeInSecForIosWeb: 5,
     backgroundColor: colorToastChoose(state),
     textColor: Colors.white,
     fontSize: 16.0
 );
 //لما يكون عندك كذا اختيار من حاجه
 enum ToastStates {SUCCESS, ERROR, WARNING}
Color colorToastChoose (ToastStates state){
   Color color;
   switch (state) {
     case ToastStates.SUCCESS :
       color = Colors.green;
       break;
     case ToastStates.ERROR :
       color = Colors.red;
       break;
     case ToastStates.WARNING :
       color = Colors.amber;
       break;
   }
     return color;

}
void printLongString(String text) {
  final RegExp pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((RegExpMatch match) =>   print(match.group(0)));
}
Widget myDivider ()=>Padding(
  padding: const EdgeInsetsDirectional.only(start: 20.0),
  child: Container(
    width: double.infinity,
    color: Colors.grey[400],

    height: 1.0,
  ),
);
Widget buildListItem ( model , context , {bool isOldPrice = false}) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120.0,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [ Image(
            image: NetworkImage(model.image),
            width: 120.0,
            height: 120.0,

          ),
            if(model.discount != 0 && isOldPrice)
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
        SizedBox(width: 20.0,),
        Expanded(
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
              Spacer(),
              Row(
                children: [
                  Text(
                    model.price.toString(),

                    style: TextStyle(
                      fontSize: 12.0,
                      color: defaultColor,

                    ),
                  ),
                  SizedBox(width: 5.0,),
                  if(model.discount != 0 && isOldPrice)
                    Text(
                      model.oldPrice.toString(),

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
                      //  print(model.id);
                    },
                    icon: CircleAvatar(
                      radius: 15.0,
                      backgroundColor:
                      ShopHomeCubit.get(context).favorites[model.id]
                          ? Colors.red
                          : Colors.grey,
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
  ),
);