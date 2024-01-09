import 'package:flutter/material.dart';
import 'package:todo_tracker/colors.dart';
import 'package:todo_tracker/data/database.dart';
import 'package:todo_tracker/data/globle_variable.dart';
import 'package:todo_tracker/decoration_container/dec_dialog_box_category_selection_container.dart';

// ignore: must_be_immutable
class UtilCreateTaskDialogBox extends StatefulWidget {
  final TextEditingController textAddController;
  VoidCallback onSave;
  VoidCallback onCancel;

  UtilCreateTaskDialogBox(
      {super.key,
      required this.textAddController,
      required this.onSave,
      required this.onCancel});

  @override
  State<UtilCreateTaskDialogBox> createState() =>
      _UtilCreateTaskDialogBoxState();
}

class _UtilCreateTaskDialogBoxState extends State<UtilCreateTaskDialogBox> {
  ToDoDataBase db = ToDoDataBase();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      backgroundColor: backgroundColor,
      surfaceTintColor: backgroundColor,
      elevation: 10,
      content: Container(
        height: 270,
        width: 270,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // task input
            TextField(
              controller: widget.textAddController, // Use your own controller
              decoration: InputDecoration(
                hintText: 'Add new Task!!', // Placeholder text
                filled: true, // Add background color
                fillColor: Colors.grey[200], // Background color
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.grey, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                      color: db.categoryColorList[SELECTEDCATEGORYINDEX],
                      width: 2),
                ),
              ),
              style: const TextStyle(color: Colors.black), // Text color
              cursorColor:
                  db.categoryColorList[SELECTEDCATEGORYINDEX], // Cursor color
            ),

            // catagory selector
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      SELECTEDCATEGORYINDEX = 0;
                    });
                  },
                  child: DecDialogCategorySelectionContainer(
                    categoryColor: db.categoryColorList[0],
                    categoryIndex: 0,
                    categoryIcon: db.categoryIconsList[0],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      SELECTEDCATEGORYINDEX = 1;
                    });
                  },
                  child: DecDialogCategorySelectionContainer(
                    categoryColor: db.categoryColorList[1],
                    categoryIndex: 1,
                    categoryIcon: db.categoryIconsList[1],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      SELECTEDCATEGORYINDEX = 2;
                    });
                  },
                  child: DecDialogCategorySelectionContainer(
                    categoryColor: db.categoryColorList[2],
                    categoryIndex: 2,
                    categoryIcon: db.categoryIconsList[2],
                  ),
                )
              ],
            ),
            // bottom button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: widget.onSave,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: 90,
                    decoration: BoxDecoration(
                        // border: Border.all(color: mainColor),
                        // boxShadow: const [
                        //   BoxShadow(
                        //     color: Colors.green,
                        //     blurRadius: 2,
                        //   )
                        // ],
                        color: db.categoryColorList[SELECTEDCATEGORYINDEX],
                        borderRadius: BorderRadius.circular(12)),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          "Save",
                          style:
                              TextStyle(color: backgroundColor, fontSize: 19),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: widget.onCancel,
                  child: Container(
                    width: 90,
                    decoration: BoxDecoration(
                        // border: Border.all(color: mainColor),
                        // boxShadow: const [
                        //   BoxShadow(
                        //     color: Color.fromARGB(255, 220, 89, 80),
                        //     blurRadius: 2,
                        //   )
                        // ],
                        color: Color.fromARGB(255, 244, 84, 73),
                        borderRadius: BorderRadius.circular(12)),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          "Cancel",
                          style:
                              TextStyle(color: backgroundColor, fontSize: 19),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
