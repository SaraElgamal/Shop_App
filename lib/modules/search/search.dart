import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/cubit/cubit.dart';
import 'package:shop_app/modules/search/cubit/state.dart';
import 'package:shop_app/styles/components/components.dart';

class SearchScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(

      create: (BuildContext context) => SearchCubit() ,
      child: BlocConsumer<SearchCubit,SearchState>(
        listener: (context , state) {},
        builder: (context , state){
          return Scaffold(
            appBar: AppBar(

            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    defaultField(controller: searchController,
                      validate: (String value){
                        if(value.isEmpty) {
                          return 'please type to search';
                        }
                      },
                      onSubmitted: (String text){
                      SearchCubit.get(context).getSearch(text);
                      },
                      label: 'Search',
                      prefix: Icons.search_outlined,
                      keyboard: TextInputType.text,),

                    SizedBox(height: 10.0,),
                    if(state is SearchLoadingState)
                    LinearProgressIndicator(),
                    SizedBox(height: 10.0,),
                    if(state is SearchSuccessState)
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context , index) =>
                            buildListItem(SearchCubit.get(context).model.data.data[index], context),
                        separatorBuilder: (context , index) => myDivider () ,
                        itemCount: SearchCubit.get(context).model.data.data.length,),
                    ),
                  ],


                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
