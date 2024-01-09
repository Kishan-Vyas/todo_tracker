import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_tracker/colors.dart';
import 'package:todo_tracker/data/database.dart';
import 'package:todo_tracker/data/globle_variable.dart';
import 'package:todo_tracker/decoration_container/dec_catagory_card.dart';
import 'package:todo_tracker/decoration_container/dec_home_page_navagation_bar.dart';
import 'package:todo_tracker/util/dialog_box.dart';
import 'package:todo_tracker/util/fab_home.dart';

import '../decoration_container/dec_todo_title.dart';

class HomePageToDoTracker extends StatefulWidget {
  const HomePageToDoTracker({super.key});

  @override
  State<HomePageToDoTracker> createState() => _HomePageToDoTrackerState();
}

class _HomePageToDoTrackerState extends State<HomePageToDoTracker>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> mainScreenSlidAnimation;

  // refrence to the hive box
  // final _myBox = Hive.box('mybox');

  // text controller
  final TextEditingController _textAddController = TextEditingController();

  // database class
  ToDoDataBase db = ToDoDataBase();
  List<dynamic> filteredList = [];

  // list of ToDo Task
  // List toDoList = [
  //   ["Build app", false, techCategoryColor],
  //   ["Assignment", false, studyCategoryColor],
  //   ["Write Code!!!", false, techCategoryColor],
  //   ["Eat Bhel...", false, foodCategoryColor],
  //   ["Run App on iphon", false, techCategoryColor]
  // ];

  // animation drawerbar

  @override
  void initState() {
    // if (_myBox.get("TODOLIST") == null) {
    //   db.createInitialData();
    // } else {
    //   db.loadData();
    // }
    db.loadData();
    filteredList = db.toDoList;

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    mainScreenSlidAnimation =
        Tween(begin: const Offset(0, 0.3), end: Offset.zero).animate(
            CurvedAnimation(
                parent: animationController, curve: Curves.easeOut));

    animationController.forward();
    super.initState();
  }

  // *** functions *** //

  // check box is checked?
  void taskCheckBoxChanged(bool? value, int index) {
    print("taskCheckBoxChanged");
    setState(() {
      if (db.toDoList[index][1] == false) {
        COMPLEDTASKCOUNT[db.categoryColorList.indexOf(db.toDoList[index][2])]++;
      } else {
        COMPLEDTASKCOUNT[db.categoryColorList.indexOf(db.toDoList[index][2])]--;
      }
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  void saveNewTask() {
    if (_textAddController.text != '') {
      setState(() {
        db.toDoList.add([
          _textAddController.text,
          false,
          db.categoryColorList[SELECTEDCATEGORYINDEX]
        ]);
        _textAddController.clear();
        TOTALTASKCOUNT[SELECTEDCATEGORYINDEX]++;
      });
    }
    Navigator.of(context).pop();
    db.updateDataBase();
    print("task saved successfully");
  }

  // creating new task
  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return UtilCreateTaskDialogBox(
            textAddController: _textAddController,
            onSave: () => saveNewTask(),
            onCancel: () => Navigator.of(context).pop(),
          );
        });
  }

  //delete the task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
      TOTALTASKCOUNT[db.categoryColorList.indexOf(db.toDoList[index][2])]--;
      COMPLEDTASKCOUNT[db.categoryColorList.indexOf(db.toDoList[index][2])]--;
    });
    db.updateDataBase();
  }

  //searching function
  void filterTasks(String query) {
    List<dynamic> filteredTasks = [];
    if (query.isNotEmpty) {
      filteredTasks = db.toDoList.where((task) {
        // Customize this condition based on your filtering logic
        return task[0].toLowerCase().contains(query.toLowerCase());
      }).toList();
    } else {
      filteredTasks = db.toDoList;
    }

    setState(() {
      filteredList = filteredTasks;
    });
  }

  // *** over *** //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      floatingActionButton: UtilFABHome(onPressed: createNewTask),
      // main body................................
      body: SafeArea(
        child: SlideTransition(
          position: mainScreenSlidAnimation,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // navagation bar

              DecHomepageNavagationBar(
                  textChange: filterTasks,
                  textFilterController: _textAddController),
              // main page
              const Padding(
                padding:
                    EdgeInsets.only(left: 16, right: 16, top: 5, bottom: 6),
                child: Text(
                  "What's Up, Kishan!",
                  style: TextStyle(
                    color: mainColor,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'catagory',
                  style: TextStyle(color: mainColor),
                ),
              ),
              // card container
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 16, left: 4, top: 8, bottom: 8),
                  child: Row(
                    children: [
                      DecCatagoryCard(
                        catagoryIcon: db.categoryIconsList[0],
                        progress: COMPLEDTASKCOUNT[0] / TOTALTASKCOUNT[0],
                        catagoryName: db.categoryNameList[0],
                        tempColor: db.categoryColorList[0],
                      ),
                      DecCatagoryCard(
                        catagoryIcon: db.categoryIconsList[1],
                        progress: .60,
                        catagoryName: db.categoryNameList[1],
                        tempColor: db.categoryColorList[1],
                      ),
                      DecCatagoryCard(
                        catagoryIcon: db.categoryIconsList[2],
                        progress: .95,
                        catagoryName: db.categoryNameList[2],
                        tempColor: db.categoryColorList[2],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    return ToDoTitle(
                      taskIndex: index,
                      taskText: filteredList[index][0],
                      taskIsChecked: filteredList[index][1],
                      taskCatagoryColor: filteredList[index][2],
                      taskOnChange: (value) =>
                          taskCheckBoxChanged(value, index),
                      taskDeleteFunction: (context) => deleteTask(index),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
