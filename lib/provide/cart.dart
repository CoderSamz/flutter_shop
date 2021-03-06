import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/cartInfo.dart';

class CartProvide with ChangeNotifier {
  String cartString = "[]";
  // 商品列表对象
  List<CartInfoModel> cartList = [];

  // 总价格
  double allPrice = 0;
  // 商品总数量
  int allGoodsCount = 0;
  // 是否全选
  bool isAllCheck = true;


  // 添加商品到购物车
  save(goodsId, goodsName, count, price, images) async {
    // 初始化SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // 获取持久化存储的值
    cartString = prefs.getString('cartInfo');
    // 判断cartString是否为空，为空说明是第一次添加，或者key被清除了。
    // 如果有值进行decode操作
    var temp = cartString == null ? [] : json.decode(cartString.toString());
    // 把获得值转变成List
    List<Map> tempList = (temp as List).cast();
    // 声明变量，用于判断购物车中是否已经存在该商品ID
    // 默认为没有
    var isHave = false;
    // 用于进行循环的索引使用
    int ival = 0;
    allPrice = 0;
    // 把商品总数量设置为0
    allGoodsCount = 0;

    // 进行循环，找出是否已经存在该商品
    tempList.forEach((item){
      // 如果存在，数量进行+1操作
      if(item['goodsId'] == goodsId) {
        tempList[ival]['count'] = item['count'] + 1;
        cartList[ival].count += 1;
        isHave = true;
      }

      if(item['isCheck']){
        allPrice += (cartList[ival].price * cartList[ival].count);
        allGoodsCount += cartList[ival].count;
      }

      ival += 1;
    });

    // 如果没有，进行增加
    if(!isHave) {

      Map<String, dynamic> newGoods = {
        'goodsId':goodsId,
        'goodsName':goodsName,
        'count':count,
        'price':price,
        'images':images,
        'isCheck': true  //是否已经选择
      };
      tempList.add(newGoods);
      cartList.add(new CartInfoModel.fromJson(newGoods));

      allPrice += (count * price);
      allGoodsCount += count;


    }

    // 把字符串进行encode操作
    cartString = json.encode(tempList).toString();
    print(cartString);
    print(cartString.toString());
    // 进行持久化
    prefs.setString('cartInfo', cartString);
    notifyListeners();
  }

  // 得到购物车中的商品
  getCartInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // 获得购物车中的商品，这时候是一个字符串
    cartString = prefs.getString('cartInfo');
    // 把cartList进行初始化，防止数据混乱
    cartList = [];
    // 判断得到的字符串是否有值，如果不判断会报错
    if(cartString == null) {
      cartList = [];
    }else{
      List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
      allPrice = 0;
      allGoodsCount = 0;
      isAllCheck = true;

      tempList.forEach((item){

        if(item['isCheck']){
          allPrice += (item['count'] * item['price']);
          allGoodsCount += item['count'];
        }else{
          isAllCheck = false;
        }

        cartList.add(new CartInfoModel.fromJson(item));
      });
    }
    notifyListeners();
  }

  // 清空购物车
  remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.clear();//清空键值对
    prefs.remove('cartInfo');
    print('清空完成...........');
    notifyListeners();
  }

  // 删除单个购物车商品
  deleteOneGoods(String goodsId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();

    int tempIndex = 0;
    int delIndex = 0;
    tempList.forEach((item){
      if(item['goodsId'] == goodsId) {
        delIndex = tempIndex;
      }
      tempIndex += 1;
    });
    tempList.removeAt(delIndex);
    cartString = json.encode(tempList).toString();
    // 给本地化数据重新赋值
    prefs.setString('cartInfo', cartString);
    await getCartInfo();
  }

  changeCheckState(CartInfoModel cartItem) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    // 声明临时List，用于循环
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    // 循环使用索引
    int tempIndex = 0;
    // 需要修改的索引
    int changeIndex = 0;

    tempList.forEach((item){
      if(item['goodsId'] == cartItem.goodsId) {
        // 找到索引进行复制
        changeIndex = tempIndex;
      }
      tempIndex += 1;
    });

    // 把对象变成Map值
    tempList[changeIndex] = cartItem.toJson();
    // 变成字符串
    cartString = json.encode(tempList).toString();
    // 进行持久化
    prefs.setString('cartInfo', cartString);
    // 重新读取列表
    await getCartInfo();

  }

  // 点击全选按钮操作
  changeAllCheckButtonState(bool isCheck) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    // 新建一个List, 用于组成新的持久化数据。
    List<Map> newList = [];

    for(var item in tempList) {
      // 复制新的变量，因为Dart不让循环时改变原值
      var newItem = item;
      // 改变选择状态
      newItem['isCheck'] = isCheck;
      newList.add(newItem);
    }

    // 形成字符串
    cartString = json.encode(newList).toString();
    // 进行持久化
    prefs.setString('cartInfo', cartString);
    await getCartInfo();
  }

  // 商品数量加减
  addOrReduceAction(var cartItem, String todo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    int tempIndex = 0;
    int changeIndex = 0;
    tempList.forEach((item){
      if(item['goodsId'] == cartItem.goodsId) {
        changeIndex = tempIndex;
      }
      tempIndex += 1;
    });

    if(todo == 'add') {
      cartItem.count += 1;
    }else if(cartItem.count > 1){
      cartItem.count -= 1;
    }

    tempList[changeIndex] = cartItem.toJson();
    cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString);
    await getCartInfo();

  }

}