import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/blocs/app_cubit.dart';
import 'package:shop_app/components/separator_divider.dart';
import 'package:shop_app/models/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return ListView.separated(
          itemBuilder: (context, index) =>
              buildCategoryItem(cubit.categoriesModel.data.data[index]),
          separatorBuilder: (context, index) => separatorDivider(),
          itemCount: cubit.categoriesModel.data.data.length,
        );
      },
    );
  }

  Widget buildCategoryItem(DataModel model) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(model.image),
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              model.name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
            ),
          ],
        ),
      );
}
