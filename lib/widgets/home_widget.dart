import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/models/todo.dart';
import 'package:to_do_app/utils/colors.dart';
import 'package:to_do_app/viewmodels/todo_view_model.dart';

class HomeScreenWidgets {
  //! To Do container
  Widget toDoContainer({
    required List<Todo> todos,
    required void Function(Todo) onEdit,
    required void Function(String id) onDelete,
    required void Function(Todo) toggleButton,
    required void Function(Todo) onTap,
    required TodoViewModel viewModel,
  }) {
    log('todo is ${todos.length}');
    if (todos.isEmpty) {
      if (viewModel.filteredTodos.isEmpty && viewModel.searchQuery.isNotEmpty) {
        return searchIsEmptyContainer();
      } else {
        return emptyContainer();
      }
    } else {
      return FadeInUp(
        child: SizedBox(
          height: 450,
          child: ListView.builder(
            padding: EdgeInsets.all(25),
            itemBuilder: (context, index) {
              final todo = todos[index];

              return GestureDetector(
                onTap: () => onTap(todo),
                child: Stack(
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
                                        height: 20,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 15,
                                        ),
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
                                            color:
                                                todo.isCompleted == true
                                                    ? AppColors.text2
                                                    : AppColors.text1,
                                          ),
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
                            icon: SvgPicture.asset(
                              'asset/edit-2.svg',
                              height: 18,
                            ),
                          ),
                          IconButton(
                            onPressed: () => onDelete(todo.id),
                            icon: SvgPicture.asset(
                              'asset/trash.svg',
                              height: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            itemCount: todos.length,
          ),
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

  //!Empty Search Todo List
  Widget searchIsEmptyContainer() {
    return Padding(
      padding: const EdgeInsets.all(26.0),
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border(top: BorderSide(width: 1, color: AppColors.text2)),
        ),
        height: 250,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('asset/Clipboard.png', height: 80),
            Text(
              'No Todo found !',
              style: TextStyle(
                color: AppColors.text2,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
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

  //!Pending and Completed
  Widget pendingAndCompleteContainer(TodoViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () async {
                  log('touched');
                },
                child: Text(
                  'Pending  ',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.darkGrey,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  viewModel.pendingTodos(),
                  style: TextStyle(color: AppColors.text1),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'Completed  ',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.darkGrey,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  '${viewModel.completedTodos()}/${viewModel.todosCount}',
                  style: TextStyle(color: AppColors.text1),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  //!  Error Text
  Widget errorText(TodoViewModel viewModel) {
    return Center(
      child: Text(
        'Error ${viewModel.error}',
        style: TextStyle(color: Colors.amber),
      ),
    );
  }

  //! Show Delete Dialoge
  Future<bool> showDeleteDialog(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder:
          (ctx) => AlertDialog(
            backgroundColor: AppColors.darkGrey,
            title: Center(
              child: Text(
                "Delete Todo",
                style: TextStyle(
                  color: AppColors.text1,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            content: Text(
              "Are you sure you want to delete this todo?",
              style: TextStyle(color: AppColors.text2),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(false), // Dismiss dialog
                child: Text("Cancel", style: TextStyle(color: AppColors.text1)),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.dark,
                ),
                onPressed: () {
                  Navigator.of(ctx).pop(true); // Close the dialog
                },
                child: Text("Delete", style: TextStyle(color: AppColors.text1)),
              ),
            ],
          ),
    );

    return result ?? false;
  }

  // ! On Add Button
  Widget onAddButton(BuildContext context, TodoViewModel viewModel) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Positioned(
      right: 15,

      top: 220,
      child: GestureDetector(
        onTap:
            () => addTaskBottomSheet(
              context: context,
              titleController: titleController,
              descriptionController: descriptionController,
              viewModel: viewModel,
              formKey: formKey,
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
    );
  }

  //! Add Task Bottom sheet
  addTaskBottomSheet({
    required BuildContext context,
    required TextEditingController titleController,
    required TextEditingController descriptionController,

    required TodoViewModel viewModel,
    required GlobalKey<FormState> formKey,
  }) {
    context.read<TodoViewModel>().clearDateAndTime();
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Consumer<TodoViewModel>(
          builder: (context, value, child) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SingleChildScrollView(
                child: Container(
                  height: 300,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: AppColors.darkGrey,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
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

                          // ! Title Field
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Title cannot be empty';
                                }
                                return null;
                              },
                              textCapitalization: TextCapitalization.sentences,
                              controller: titleController,
                              style: TextStyle(
                                color: AppColors.text1,
                                fontWeight: FontWeight.w400,
                              ),
                              decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
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

                          sizedBoxCustom(10),

                          //! Description Field
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              textCapitalization: TextCapitalization.sentences,
                              controller: descriptionController,
                              style: TextStyle(
                                color: AppColors.text1,
                                fontWeight: FontWeight.w400,
                              ),
                              minLines: 3,
                              maxLines: 5,
                              decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                labelStyle: TextStyle(color: AppColors.text2),
                                labelText: "eg: Description of the task",
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

                          //! Date Picker
                          sizedBoxCustom(10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: InkWell(
                              onTap: () async {
                                final picked = await showDatePicker(
                                  context: context,
                                  initialDate:
                                      value.selectedDate ?? DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2100),
                                );
                                if (picked != null) {
                                  value.selectDate(picked);
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 16,
                                  horizontal: 12,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.text2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      color: AppColors.text2,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      value.selectedDate != null
                                          ? '${value.selectedDate!.day}/${value.selectedDate!.month}/${value.selectedDate!.year}'
                                          : 'Select Date',
                                      style: TextStyle(
                                        color: AppColors.text1,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          // !Time Picker
                          sizedBoxCustom(10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: InkWell(
                              onTap: () async {
                                final picked = await showTimePicker(
                                  context: context,
                                  initialTime:
                                      value.selectedTime ?? TimeOfDay.now(),
                                );
                                if (picked != null) {
                                  value.selectTime(picked);
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 16,
                                  horizontal: 12,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.text2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.access_time,
                                      color: AppColors.text2,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      value.selectedTime != null
                                          ? value.selectedTime!.format(context)
                                          : 'Select Time',
                                      style: TextStyle(
                                        color: AppColors.text1,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          sizedBoxCustom(10),

                          //! Submit Button
                          Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: IconButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    value.addTodo(
                                      Todo(
                                        id: '',
                                        title: titleController.text.trim(),
                                        description:
                                            descriptionController.text.trim(),
                                        dueDate: DateTime(
                                          value.selectedDate?.year ??
                                              DateTime.now().year,
                                          value.selectedDate?.month ??
                                              DateTime.now().month,
                                          value.selectedDate?.day ??
                                              DateTime.now().day,
                                          value.selectedTime?.hour ??
                                              TimeOfDay.now().hour,
                                          value.selectedTime?.minute ??
                                              TimeOfDay.now().minute,
                                        ),
                                        isCompleted: false,
                                      ),
                                    );
                                    Navigator.pop(context);
                                  } else {
                                    log('Validation failed');
                                  }
                                },
                                icon: SvgPicture.asset(
                                  'asset/send.svg',
                                  height: 24,
                                ),
                              ),
                            ),
                          ),

                          sizedBoxCustom(10),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  //! On Edit Button
  onEditButton({
    required BuildContext context,
    required Todo todo,
    required TodoViewModel viewModel,
  }) {
    final TextEditingController editTitleController = TextEditingController();
    final TextEditingController editDescriptionController =
        TextEditingController();

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return editTaskBottomSheet(
      context: context,
      editTitleController: editTitleController,
      editDescriptionController: editDescriptionController,
      todo: todo,
      viewModel: viewModel,
      formKey: formKey,
    );
  }

  //! Edit Task Bottom sheet
  editTaskBottomSheet({
    required BuildContext context,
    required TextEditingController editTitleController,
    required TextEditingController editDescriptionController,
    required Todo todo,
    required TodoViewModel viewModel,
    required GlobalKey<FormState> formKey,
  }) {
    editTitleController.text = todo.title;
    editDescriptionController.text = todo.description;
    viewModel.selectDate(todo.dueDate);
    viewModel.selectTime(
      TimeOfDay(hour: todo.dueDate.hour, minute: todo.dueDate.minute),
    );
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Consumer<TodoViewModel>(
          builder: (context, value, child) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SingleChildScrollView(
                child: Container(
                  height: 300,
                  width: double.maxFinite,

                  decoration: BoxDecoration(
                    color: AppColors.darkGrey,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: Text(
                                'Edit Task',
                                style: TextStyle(
                                  color: AppColors.text1,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          //! Title Form Field
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Title cannot be emptpy';
                                }
                                return null;
                              },
                              textCapitalization: TextCapitalization.sentences,
                              controller: editTitleController,
                              style: TextStyle(
                                color: AppColors.text1,
                                fontWeight: FontWeight.w400,
                              ),
                              decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
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
                          sizedBoxCustom(10),
                          //! Description Form Field
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,

                              textCapitalization: TextCapitalization.sentences,
                              controller:
                                  editDescriptionController, // Make sure to define this controller
                              style: TextStyle(
                                color: AppColors.text1,
                                fontWeight: FontWeight.w400,
                              ),
                              minLines: 3,
                              maxLines: 5,
                              decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                labelStyle: TextStyle(color: AppColors.text2),
                                labelText: "eg: Description of the task",
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

                          //! Date Picker
                          sizedBoxCustom(10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: InkWell(
                              onTap: () async {
                                final picked = await showDatePicker(
                                  context: context,
                                  initialDate:
                                      value.selectedDate ?? DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2100),
                                );
                                if (picked != null) {
                                  value.selectDate(picked);
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 16,
                                  horizontal: 12,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.text2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      color: AppColors.text2,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      value.selectedDate != null
                                          ? '${value.selectedDate!.day}/${value.selectedDate!.month}/${value.selectedDate!.year}'
                                          : 'Select Date',
                                      style: TextStyle(
                                        color: AppColors.text1,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          // !Time Picker
                          sizedBoxCustom(10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: InkWell(
                              onTap: () async {
                                final picked = await showTimePicker(
                                  context: context,
                                  initialTime:
                                      value.selectedTime ?? TimeOfDay.now(),
                                );
                                if (picked != null) {
                                  value.selectTime(picked);
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 16,
                                  horizontal: 12,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.text2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.access_time,
                                      color: AppColors.text2,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      value.selectedTime != null
                                          ? value.selectedTime!.format(context)
                                          : 'Select Time',
                                      style: TextStyle(
                                        color: AppColors.text1,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          sizedBoxCustom(10),

                          //!  Submit Button
                          Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: IconButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    value.updateTodo(
                                      Todo(
                                        id: todo.id,
                                        title: editTitleController.text,
                                        description:
                                            editDescriptionController.text
                                                .trim(),
                                        dueDate: DateTime(
                                          value.selectedDate?.year ??
                                              DateTime.now().year,
                                          value.selectedDate?.month ??
                                              DateTime.now().month,
                                          value.selectedDate?.day ??
                                              DateTime.now().day,
                                          value.selectedTime?.hour ??
                                              TimeOfDay.now().hour,
                                          value.selectedTime?.minute ??
                                              TimeOfDay.now().minute,
                                        ),
                                        isCompleted: todo.isCompleted,
                                      ),
                                    );
                                    Navigator.pop(context);
                                  } else {
                                    log('Validation failed');
                                  }
                                },
                                icon: SvgPicture.asset(
                                  'asset/send.svg',
                                  height: 24,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  //! Custom SizedBox
  Widget sizedBoxCustom(double height) {
    return SizedBox(height: height);
  }

  //! Search Container
  Widget searchContainer(BuildContext context, FocusNode titleFocusNode) {
    return Positioned(
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
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: TextFormField(
                focusNode: titleFocusNode,
                style: TextStyle(color: AppColors.text1),
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
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
                onChanged: (value) {
                  context.read<TodoViewModel>().setSearchQuery(value);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  //! Show Todo DetailDialoge
  void showTodoDetailDialog(BuildContext context, Todo todo) {
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            backgroundColor: AppColors.darkGrey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            title: Text(
              todo.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.text1,
              ),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (todo.description.isNotEmpty) ...[
                    Text(
                      todo.description,
                      style: TextStyle(color: AppColors.text1, fontSize: 17),
                    ),
                    SizedBox(height: 22),
                  ],
                  Text(
                    "Due Date:",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.text2,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    _formatDate(todo.dueDate), // Custom formatted date
                    style: TextStyle(color: AppColors.text2),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: Text(
                  "Close",
                  style: TextStyle(color: AppColors.primaryColor),
                ),
              ),
            ],
          ),
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy  hh:mm a').format(date);
  }
}
