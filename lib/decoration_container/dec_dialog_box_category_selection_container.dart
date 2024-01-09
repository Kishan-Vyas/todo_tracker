import 'package:flutter/material.dart';
import 'package:todo_tracker/colors.dart';
import 'package:todo_tracker/data/database.dart';

import '../data/globle_variable.dart';

class DecDialogCategorySelectionContainer extends StatelessWidget {
  Color categoryColor;
  int categoryIndex;
  IconData categoryIcon;
  DecDialogCategorySelectionContainer({
    super.key,
    required this.categoryColor,
    required this.categoryIndex,
    required this.categoryIcon,
  });

  ToDoDataBase db = ToDoDataBase();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 45,
            width: 45,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: categoryColor,
                border: SELECTEDCATEGORYINDEX == categoryIndex
                    ? Border.all(
                        color: const Color.fromARGB(255, 7, 176, 12)
                            .withOpacity(.75),
                        width: 3.5)
                    : null),
            child: Icon(
              categoryIcon,
              color: mainColor,
              size: SELECTEDCATEGORYINDEX == categoryIndex ? 25 : 20,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            db.categoryNameList[categoryIndex],
            style: TextStyle(color: mainColor),
          )
        ],
      ),
    );
  }
}
