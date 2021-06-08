import 'package:flutter/material.dart';
import 'package:shop_app/blocs/app_cubit.dart';
import 'package:shop_app/src/colors.dart';

Widget buildProductListItem({
  BuildContext context,
  model,
  bool isOldPrice = true,
}) {
  var product = model;
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 120.0,
      child: Row(
        children: [
          Row(
            children: [
              Container(
                height: 120.0,
                width: 120.0,
                child: Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Image(
                      image: NetworkImage(product.image),
                      width: 120.0,
                      height: 120.0,
                    ),
                    if (product.discount != 0 && isOldPrice)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        color: Colors.red,
                        child: Text(
                          'DISCOUNT',
                          style: TextStyle(
                            fontSize: 8.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.0,
                    height: 1.3,
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      product.price.toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: defaultColor,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    if (product.discount != 0 && isOldPrice)
                      Text(
                        product.oldPrice.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    Spacer(),
                    IconButton(
                        onPressed: () {
                          AppCubit.get(context).changeFavorites(product.id);
                        },
                        icon: CircleAvatar(
                          radius: 15.0,
                          backgroundColor:
                              AppCubit.get(context).favorites[product.id]
                                  ? defaultColor
                                  : Colors.grey,
                          child: Icon(
                            Icons.favorite_border_outlined,
                            size: 15.0,
                            color: Colors.white,
                          ),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
