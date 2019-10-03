import 'package:flutter/material.dart';
import 'package:flutter_shop/pages/cart_page/cart_item.dart';
import 'package:provide/provide.dart';
import '../provide/cart.dart';
import './cart_page/cart_bottom.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  List<String> testList = [];

  @override
  Widget build(BuildContext context) {
//    _show(); // 每次进入前进行显示
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
      ),
      body: FutureBuilder(
        future: _getCartInfo(context),
        builder: (context, snapshot){
          List cartList = Provide.value<CartProvide>(context).cartList;
          if(snapshot.hasData && cartList != null){

            return Stack(
              children: <Widget>[
                ListView.builder(
                  itemCount: cartList.length,
                  itemBuilder: (context, index){
                    return CartItem(cartList[index]);
                  },
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: CartBottom(),
                )
              ],
            );

          }else{
            return Text('正在加载');
          }
        },
      ),
    );
  }

  Future<String> _getCartInfo(BuildContext context) async {
    await Provide.value<CartProvide>(context).getCartInfo();
    return 'end';
  }
}


