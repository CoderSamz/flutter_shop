import 'package:flutter/material.dart';
import '../model/category.dart';

// ChangeNotifier的混入是不用管理听众
class ChildCategory with ChangeNotifier {

  // 商品列表
  List<BxMallSubDto> childCategoryList = [];
  // 子类索引值
  int childIndex = 0;
  // 大类ID
  String categoryId = '4';
  // 小类ID
  String subId = '';
  // 列表页数，当改变大类或者小类时进行改变
  int page = 1;
  String noMoreText = '';
  bool isNewCategory = false;

  // 点击大类时更换
  getChildCategory(List<BxMallSubDto> list, String id) {

    isNewCategory = true;
    categoryId = id;
    childIndex = 0;

    page = 1;
    noMoreText = '';

    // 点击大类时，把子类ID清空
    subId = '';

    BxMallSubDto all = BxMallSubDto();
    all.mallSubId = '';
    all.mallCategoryId = '00';
    all.mallSubName = '全部';
    all.comments = 'null';
    childCategoryList = [all];
    childCategoryList.addAll(list);
    notifyListeners();
  }

  // 改变子类索引
  changeChildIndex(int index, String id) {

    isNewCategory = true;
    // 传递两个参数，使用新传递的参数给状态赋值
    childIndex = index;
    subId = id;

    page = 1;
    // 显示更多的表示
    noMoreText = '';

    notifyListeners();
  }

  // 增加Page的方法
  addPage() {
    page += 1;
  }

  // 改变noMoreText数据
  changeNoMore(String text) {
    noMoreText = text;
    notifyListeners();
  }
}