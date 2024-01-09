// import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';

import '../colors.dart';

class ToDoDataBase {
  // todo list
  List toDoList = [];

  // category color list
  List categoryColorList = [
    techCategoryColor,
    foodCategoryColor,
    studyCategoryColor
  ];

  List categoryIconsList = [
    Icons.code,
    Icons.restaurant_menu,
    Icons.book,
  ];

  // category name list
  List categoryNameList = ['Tech', 'Food', 'Study'];

  // category card list
  // List categoryCardList = [
  //   [Icons.code, .73, 'Ui/Ux Design', 0],
  //   [Icons.restaurant_menu, .60, 'Food', 1],
  //   [Icons.book, .95, 'Study', 2],
  // ];

  // reference to our box
  // final _myBox = Hive.box('mybox');

  // for 1st time ever opening app
  void createInitialData() {
    toDoList = [
      ["Build app", false, techCategoryColor],
      ["Assignment", false, studyCategoryColor],
      ["Eat Bhel...", false, foodCategoryColor]
    ];
  }

  void loadData() {
    toDoList = [
      ["Build app", false, techCategoryColor],
      ["Assignment", false, studyCategoryColor],
      ["Eat Bhel...", false, foodCategoryColor]
    ];
    // toDoList = _myBox.get("TODOLIST");
  }

  void updateDataBase() {
    // _myBox.put("TODOLIST", toDoList);
  }
}
