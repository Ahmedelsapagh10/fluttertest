import 'package:fluttertest/core/exports.dart';
import 'package:fluttertest/features/main_screen/cubit/cubit.dart';
import 'package:fluttertest/features/main_screen/cubit/state.dart';

import '../../../../core/preferences/product_model.dart';
import '../../data/model/product_model.dart' as myModel;

class CustomProductCard extends StatelessWidget {
  final myModel.MainProductModel model;
  const CustomProductCard({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        var cubit = context.read<MainCubit>();
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(1, 1),
                    spreadRadius: 0,
                    blurRadius: 5,
                  )
                ]),
            child: Column(
              children: [
                Flexible(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        // top: 50,
                        left: 5,
                        bottom: 0,
                        child: Text(
                          model.title!.substring(0, 10),
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 12,
                        right: 12,
                        bottom: 20,
                        child: Image.network(
                          model.image ?? '',
                          height: 100,
                          width: 100,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Divider(
                  color: Colors.black,
                  height: 1,
                  indent: 10,
                  endIndent: 10,
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                        fit: FlexFit.tight,
                        child: Text(
                          '\$${model.price.toString()}',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            cubit.addProduct(ProductModel(
                              id: model.id,
                              title: model.title,
                              price: model.price,
                              image: model.image,
                              myCount: model.myCount,
                              rating: Rating(
                                count: model.rating?.count,
                                rate: model.rating?.rate,
                              ),
                              category: model.category,
                              description: model.description,
                            ));
                          },
                          icon: Icon(model.myCount == 1
                              ? Icons.add_circle_outline
                              : Icons.remove_circle_outline))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
