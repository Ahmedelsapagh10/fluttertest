import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertest/config/routes/app_routes.dart';
import 'package:fluttertest/core/utils/app_colors.dart';
import 'package:fluttertest/core/widgets/show_loading_indicator.dart';
import 'package:fluttertest/features/main_screen/cubit/cubit.dart';
import 'package:fluttertest/features/main_screen/cubit/state.dart';

import 'widgets/custom_cart_widget.dart';
import 'widgets/item_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    context.read<MainCubit>().getAllProducts(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(builder: (context, state) {
      MainCubit cubit = context.read<MainCubit>();

      return Scaffold(
        appBar: AppBar(
          title: Text('Flutter Test'),
          centerTitle: true,
          actions: [
            ShoppingCartIconWithBadge(
              itemCount: cubit.cartProducts.length,
              onTap: () {
                Navigator.pushNamed(context, Routes.cartScreenRoute);
              },
            ),
          ],
          leading: IconButton(
            onPressed: () {
              cubit.logOut(context);
            },
            icon: Icon(
              Icons.login,
              color: AppColors.primary,
            ),
          ),
        ),
        body: (state is LoadingState || cubit.allProducts.isEmpty)
            ? Center(
                child: CustomLoadingIndicator(),
              )
            : Column(
                children: [
                  Flexible(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        cubit.allProducts = [];
                        cubit.getAllProducts(context);
                      },
                      child: GridView.builder(
                        itemCount: cubit.allProducts.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 3 / 4,
                        ),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return InkWell(
                              onTap: () {},
                              child: CustomProductCard(
                                  model: cubit.allProducts[index]));
                        },
                      ),
                    ),
                  ),
                ],
              ),
      );
    });
  }
}
