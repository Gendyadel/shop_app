import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/blocs/app_cubit.dart';
import 'package:shop_app/components/build_list_product.dart';
import 'package:shop_app/components/separator_divider.dart';

class FavouritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return ConditionalBuilder(
          builder: (context) => ListView.separated(
            itemBuilder: (context, index) => buildProductListItem(
                context: context,
                model: cubit.favoritesModel.data.data[index].product),
            separatorBuilder: (context, index) => separatorDivider(),
            itemCount: cubit.favoritesModel.data.data.length,
          ),
          condition: state is! LoadingGetFavoritesState,
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
