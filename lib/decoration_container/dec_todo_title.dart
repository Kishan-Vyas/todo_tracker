import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_tracker/colors.dart';
import 'package:todo_tracker/data/database.dart';

import '../data/globle_variable.dart';

class ToDoTitle extends StatefulWidget {
  Color taskCatagoryColor;
  bool taskIsChecked;
  String taskText;
  Function(bool?)? taskOnChange;
  Function(BuildContext?)? taskDeleteFunction;
  int taskIndex;

  ToDoTitle({
    super.key,
    required this.taskText,
    required this.taskIsChecked,
    required this.taskCatagoryColor,
    required this.taskOnChange,
    required this.taskDeleteFunction,
    required this.taskIndex,
  });

  @override
  State<ToDoTitle> createState() => _ToDoTitleState();
}

class _ToDoTitleState extends State<ToDoTitle> {
  ToDoDataBase db = ToDoDataBase();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const BehindMotion(),
          children: [
            SlidableAction(
              onPressed: widget.taskDeleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(15),
              autoClose: true,
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () {
            // widget.taskOnChange;
            setState(() {
              widget.taskIsChecked = !widget.taskIsChecked;
              print(widget.taskIndex);
            });
            if (db.toDoList[widget.taskIndex][1] == false) {
              COMPLEDTASKCOUNT[db.categoryColorList
                  .indexOf(db.toDoList[widget.taskIndex][2])]++;
            } else {
              COMPLEDTASKCOUNT[db.categoryColorList
                  .indexOf(db.toDoList[widget.taskIndex][2])]--;
            }
            if (TOTALTASKCOUNT[0] + TOTALTASKCOUNT[1] + TOTALTASKCOUNT[2] >
                widget.taskIndex) {
              db.toDoList[widget.taskIndex][1] =
                  !db.toDoList[widget.taskIndex][1];
            }
            db.updateDataBase();
          },
          child: Container(
            decoration: BoxDecoration(
                color: mainFillColor,
                border: Border.all(color: backgroundColor.withOpacity(0.50)),
                borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  AnimatedContainer(
                    curve: Curves.easeInOutBack,
                    duration: const Duration(milliseconds: 400),
                    width: 26,
                    height: 26,
                    decoration: BoxDecoration(
                      color: widget.taskIsChecked ? backgroundColor : null,
                      border: Border.all(
                          color: widget.taskIsChecked
                              ? backgroundColor
                              : widget.taskCatagoryColor,
                          width: 2.5),
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: widget.taskIsChecked
                        ? const Center(
                            child: Icon(
                              Icons.check,
                              color: mainFillColor,
                              size: 20,
                            ),
                          )
                        : null,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      widget.taskText,
                      style: TextStyle(
                        color:
                            widget.taskIsChecked ? textLightColor : mainColor,
                        fontSize: widget.taskIsChecked ? 16 : 18,
                        decoration: widget.taskIsChecked
                            ? TextDecoration.lineThrough
                            : null,
                        decorationColor:
                            widget.taskIsChecked ? textLightColor : null,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
