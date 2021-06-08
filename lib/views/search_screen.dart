import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/blocs/search/search_cubit.dart';
import 'package:shop_app/components/build_list_product.dart';
import 'package:shop_app/components/default_form_field.dart';
import 'package:shop_app/components/separator_divider.dart';

class SearchScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SearchCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    defaultFormField(
                      controller: searchController,
                      inputType: TextInputType.text,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return ' enter text to search';
                        }
                        return null;
                      },
                      labelText: 'Search',
                      prefix: Icons.search,
                      radius: 40,
                      onFieldSubmitted: (String text) {
                        cubit.search(text);
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (state is SearchLoadingState) LinearProgressIndicator(),
                    if (state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) => buildProductListItem(
                            context: context,
                            model: cubit.searchModel.data.data[index],
                            isOldPrice: false,
                          ),
                          separatorBuilder: (context, index) =>
                              separatorDivider(),
                          itemCount: cubit.searchModel.data.data.length,
                        ),
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
