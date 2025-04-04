import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:to_do_app/models/todo.dart';
import 'package:to_do_app/utils/colors.dart';

class HomeScreenWidgets {
  //! To Do container
  Widget toDoContainer({
    required List<Todo> todos,
    required void Function(Todo) onEdit,
    required void Function(String id) onDelete,
    required void Function(Todo) toggleButton,
  }) {
    log('todo is ${todos.length}');
    if (todos.isEmpty) {
      return emptyContainer();
    } else {
      return SizedBox(
        height: 450,
        child: ListView.builder(
          padding: EdgeInsets.all(25),
          itemBuilder: (context, index) {
            final todo = todos[index];

            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Container(
                    height: 80,
                    width: 370,
                    decoration: BoxDecoration(
                      color: AppColors.darkGrey,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Row(
                        children: [
                          SizedBox(width: 15),
                          SizedBox(
                            width: 200,
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () => toggleButton(todo),
                                  child: SvgPicture.asset(
                                    !todo.isCompleted == true
                                        ? 'asset/Ellipse 15.svg'
                                        : 'asset/Layer 1.svg',
                                    height: todo.isCompleted == true ? 20 : 21,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    todo.title,
                                    maxLines: 1,

                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      decoration:
                                          todo.isCompleted == true
                                              ? TextDecoration.lineThrough
                                              : null,
                                      decorationThickness: 1.5,
                                      decorationColor: AppColors.text2,
                                      color: AppColors.text2,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //! Edit and Delete button
                Positioned(
                  right: 10,
                  bottom: 10,
                  top: 10,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () => onEdit(todo),
                        icon: SvgPicture.asset('asset/edit-2.svg', height: 18),
                      ),
                      IconButton(
                        onPressed: () => onDelete(todo.id),
                        icon: SvgPicture.asset('asset/trash.svg', height: 24),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
          itemCount: todos.length,
        ),
      );
    }
  }

  //!Empty Todo List
  Widget emptyContainer() {
    return Padding(
      padding: const EdgeInsets.all(26.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border(top: BorderSide(width: 1, color: AppColors.text2)),
        ),
        height: 250,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('asset/Clipboard.png', height: 80),
            Text(
              'You don’t have any tasks yet.',
              style: TextStyle(
                color: AppColors.text2,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Start adding tasks and manage your',
                  style: TextStyle(
                    color: AppColors.text2,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    ' time effectively.',
                    style: TextStyle(
                      color: AppColors.text2,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ! CircularProgressIndicator
  Widget showCircularProgressIndicator() {
    return SizedBox(
      height: 250,
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
