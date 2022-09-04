import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shopLayout/shop_layout.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/styles/components/constans.dart';
import 'package:shop_app/styles/theme.dart';

import 'layout/login/login.dart';
import 'layout/onBoarding/shopApp.dart';
import 'layout/shopLayout/cubit/cubit.dart';

void main()
 async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.Init();
  await CacheHelper.init();
  Bloc.observer= MyBlocObserver();
  Widget widget;
  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
   token = CacheHelper.getData(key: 'token');
  print(token);
  print(onBoarding);
  if (onBoarding != null ) {
    if (token != null ) {
      widget = ShopLayout();
    }else  widget = ShopLogin();
  } else {
    widget = onBoardingScreen();
  }
runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
 final Widget startWidget;

   MyApp({this.startWidget}) ;



  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
       BlocProvider(create: (BuildContext context) => ShopHomeCubit()..getHomeData()..getCategoriesData()..getFavorites()..getUserData() ),
  ],
    child :
      MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,

      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
      home: startWidget,
    ), );
  }
}

