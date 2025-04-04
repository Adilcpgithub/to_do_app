import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/models/todo.dart';
import 'package:to_do_app/utils/colors.dart';
import 'package:to_do_app/viewmodels/todo_view_model.dart';
import 'package:to_do_app/widgets/todo_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TodoViewModel>(context);
    HomeScreenWidgets homeScreenWidgets = HomeScreenWidgets();
    TextEditingController addTodoController = TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: AppColors.onSurfaceColor,
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(color: AppColors.dark, height: 250),
                    Expanded(
                      child: Container(
                        color: AppColors.surfaceColor,
                        child: Column(
                          children: [
                            SizedBox(height: 100),
                            //!Pending and Completed
                            homeScreenWidgets.pendingAndCompleteContainer(
                              viewModel,
                            ),
                            SizedBox(height: 25),
                            viewModel.isLoading
                                ? homeScreenWidgets
                                    .showCircularProgressIndicator()
                                : viewModel.error != null
                                ? homeScreenWidgets.errorText(viewModel)
                                : homeScreenWidgets.toDoContainer(
                                  todos: viewModel.todos,
                                  onDelete: (id) {
                                    viewModel.deleteTodo(id);
                                  },
                                  onEdit: (todo) {},
                                  toggleButton: (todo) {
                                    viewModel.toggleCompleted(todo);
                                  },
                                ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                //! Search Bar
                Positioned(
                  left: 15,
                  right: 120,
                  top: 220,
                  child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },

                    child: Container(
                      height: 60,
                      width: 70,
                      decoration: BoxDecoration(
                        color: AppColors.darkGrey,

                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          child: TextFormField(
                            style: TextStyle(color: AppColors.text2),
                            decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              labelStyle: TextStyle(color: AppColors.text2),
                              labelText: "🚀 Search...",

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                //! Add Button
                Positioned(
                  right: 15,

                  top: 220,
                  child: GestureDetector(
                    onTap:
                        () => addTaskButton(
                          context: context,
                          addTodoController: addTodoController,
                          viewModel: viewModel,
                          formKey: _formKey,
                        ),
                    child: Container(
                      height: 60,
                      width: 95,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Add',
                            style: TextStyle(
                              color: AppColors.text1,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SvgPicture.asset('asset/plus.svg', height: 18),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//! Add Task Bottom sheet
addTaskButton({
  required BuildContext context,
  required TextEditingController addTodoController,
  required TodoViewModel viewModel,
  required GlobalKey<FormState> formKey,
}) {
  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Container(
            height: 260,
            width: double.maxFinite,

            decoration: BoxDecoration(
              color: AppColors.darkGrey,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Text(
                      'Add Task',
                      style: TextStyle(
                        color: AppColors.text1,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Form(
                    key: formKey,

                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Title cannot be emptpy';
                        }
                        return null;
                      },
                      controller: addTodoController,
                      style: TextStyle(color: AppColors.text2),
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelStyle: TextStyle(color: AppColors.text2),
                        labelText: "eg :Do math homework",

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            width: 1,
                            color: AppColors.text2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            width: 1,
                            color: AppColors.text2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            width: 1,
                            color: AppColors.text2,
                          ),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            width: 1,
                            color: AppColors.text2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          viewModel.addTodo(
                            Todo(
                              id: '',
                              title: addTodoController.text,
                              description: '',
                              dueDate: DateTime.now(),
                              isCompleted: false,
                            ),
                          );
                          Navigator.pop(context);
                        } else {
                          log('Validation failed');
                        }
                      },
                      icon: SvgPicture.asset('asset/send.svg', height: 24),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
