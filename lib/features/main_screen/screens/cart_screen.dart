import '../../../core/exports.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';
import 'widgets/cart_item_widget.dart';

class MyCartScreen extends StatefulWidget {
  const MyCartScreen({super.key});

  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  @override
  void initState() {
    context.read<MainCubit>().loadCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
        centerTitle: true,
      ),
      body: BlocConsumer<MainCubit, MainState>(
        listener: (context, state) {
          if (state is CartError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CartLoaded) {
            final cartProducts = state.products;

            if (cartProducts.isEmpty) {
              return const Center(child: Text('Your cart is empty.'));
            }
            // Calculate total price
            double totalPrice = cartProducts.fold(
              0.0,
              (sum, product) => sum + (product.price! * product.myCount),
            );

            return Column(
              children: [
                Flexible(
                  fit: FlexFit.tight, // Cart Items List
                  child: ListView.builder(
                    itemCount: cartProducts.length,
                    itemBuilder: (context, index) {
                      final product = cartProducts[index];
                      return CartItemWidget(
                        onUpdateQuantity: (newQuantity) {
                          context
                              .read<MainCubit>()
                              .updateQuantity(product, newQuantity);
                        },
                        product: product,
                        onRemove: () {
                          context.read<MainCubit>().removeProduct(product);
                        },
                      );
                    },
                  ),
                ), // Total Price Section
                Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.grey[200],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '\$${totalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (state is CartError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('Unknown state'));
          }
        },
      ),
    );
  }
}
