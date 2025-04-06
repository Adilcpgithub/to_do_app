import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/utils/colors.dart';
import 'package:to_do_app/viewmodels/todo_view_model.dart';
import 'package:to_do_app/widgets/home_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeScreenWidgets homeScreenWidgets = HomeScreenWidgets();
  final FocusNode titleFocusNode = FocusNode();

  @override
  void dispose() {
    titleFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TodoViewModel>(context);

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
                            homeScreenWidgets.sizedBoxCustom(100),
                            //!Pending and Completed
                            homeScreenWidgets.pendingAndCompleteContainer(
                              viewModel,
                            ),
                            homeScreenWidgets.sizedBoxCustom(25),
                            //! Todo UI parts
                            viewModel.isLoading
                                ? homeScreenWidgets
                                    .showCircularProgressIndicator()
                                : viewModel.error != null
                                ? homeScreenWidgets.errorText(viewModel)
                                : homeScreenWidgets.toDoContainer(
                                  viewModel: viewModel,
                                  todos: viewModel.filteredTodos,
                                  onDelete: (id) async {
                                    titleFocusNode.unfocus();
                                    final result = await homeScreenWidgets
                                        .showDeleteDialog(context);
                                    if (result) {
                                      viewModel.deleteTodo(id);
                                    }
                                  },
                                  onEdit: (todo) {
                                    titleFocusNode.unfocus();
                                    homeScreenWidgets.onEditButton(
                                      context: context,
                                      todo: todo,
                                      viewModel: viewModel,
                                    );
                                  },
                                  toggleButton: (todo) {
                                    titleFocusNode.unfocus();
                                    viewModel.toggleCompleted(todo);
                                  },
                                  onTap: (todo) {
                                    titleFocusNode.unfocus();
                                    homeScreenWidgets.showTodoDetailDialog(
                                      context,
                                      todo,
                                    );
                                  },
                                ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                //! Search Bar
                homeScreenWidgets.searchContainer(context, titleFocusNode),
                // ! On Add Button
                homeScreenWidgets.onAddButton(context, viewModel),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
