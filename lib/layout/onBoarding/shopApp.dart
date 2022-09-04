import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/layout/login/login.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/styles/colors.dart';
import 'package:shop_app/styles/components/components.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class onBoardingModel {
  final String image;
  final String title;
  final String body;

  onBoardingModel({
    @required this.image,
    @required   this.title,
    @required this.body});

}
class onBoardingScreen extends StatefulWidget {
  @override
  _onBoardingScreenState createState() => _onBoardingScreenState();
}

class _onBoardingScreenState extends State<onBoardingScreen> {
  var PageControl = PageController();

  List <onBoardingModel> onBoard = [
  onBoardingModel(
    image: 'https://s.tmimgcdn.com/scr/800x500/207600/family-online-shopping-free-vector-illustration-concept_207629-original.jpg',
    title: 'onBoarding title 1' ,
    body: 'onBoarding body 1',

  ),
  onBoardingModel(
    image: 'https://s.tmimgcdn.com/scr/800x500/207600/family-online-shopping-free-vector-illustration-concept_207629-original.jpg',
    title: 'onBoarding title 2' ,
    body: 'onBoarding body 2',),
  onBoardingModel(
    image: 'https://s.tmimgcdn.com/scr/800x500/207600/family-online-shopping-free-vector-illustration-concept_207629-original.jpg',
    title: 'onBoarding title 3' ,
    body: 'onBoarding body 3',

  ),
];

bool isLast = false;
void submit(){
CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
  navigateFinish(context, ShopLogin());
});

}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
        defaultTextButton(
    function : (){ submit();},
      text: 'Skip',
    ),



        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [

            Expanded(
              child: PageView.builder(itemBuilder: (context,index) => onBoardBuilder(onBoard[index],),
              itemCount: onBoard.length,
                controller: PageControl,
                physics: BouncingScrollPhysics(),
                onPageChanged: (int index){
                if (index == onBoard.length-1) {
                  setState(() {
                    isLast = true;
                  });
                }else {
                  setState(() {
                    isLast = false;
                  });
                }
                },
              ),
            ),
            SizedBox(height: 40.0,),
            Row(
          children: [
            //مهم مهم مهم
                SmoothPageIndicator(controller: PageControl,
                   effect: ExpandingDotsEffect(
                     dotColor: Colors.grey,
                     activeDotColor: defaultColor ,
                     expansionFactor: 4,
                     spacing: 5.0,
                     dotHeight: 10.0,
                     dotWidth: 10.0,
                   ),
                    count: onBoard.length),
                Spacer(),
            FloatingActionButton(onPressed: (){
              if (isLast){
                submit();
              } else {
                PageControl.nextPage(duration: Duration(
                  milliseconds: 750,
                ),
                  curve: Curves.fastLinearToSlowEaseIn,);
              }

            },
            child: Icon(Icons.arrow_forward_ios),),
          ],
        ),
   ],   ),
      ),
    );
  }

  Widget onBoardBuilder(onBoardingModel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(child: Image(image: NetworkImage('${model.image}'),

        )),

      Text('${model.title}',
        style: TextStyle(color: Colors.black,

          fontSize: 24.0,),),
      SizedBox(height: 20.0,),
      Text('${model.body}',
        style: TextStyle(color: Colors.black,

          fontSize: 16.0,),),
    ],
  );
}
