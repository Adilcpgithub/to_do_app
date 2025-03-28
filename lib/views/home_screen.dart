import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:to_do_app/utils/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isCompleted = true;
    return Scaffold(
      backgroundColor: AppColors.onSurfaceColor,
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SizedBox(
            height: double.maxFinite,
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
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  //!Pending and Completed
                                  Row(
                                    children: [
                                      Text(
                                        'Pending  ',
                                        style: TextStyle(
                                          color: AppColors.primaryColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.darkGrey,
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                        ),
                                        child: Text(
                                          '1',
                                          style: TextStyle(
                                            color: AppColors.text1,
                                          ),
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
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.darkGrey,
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                        ),
                                        child: Text(
                                          '2/2',
                                          style: TextStyle(
                                            color: AppColors.text1,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 25),
                            //!Empty Todo List
                            Padding(
                              padding: const EdgeInsets.all(26.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border(
                                    top: BorderSide(
                                      width: 1,
                                      color: AppColors.text2,
                                    ),
                                  ),
                                ),
                                height: 250,

                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'asset/Clipboard.png',
                                      height: 80,
                                    ),
                                    Text(
                                      'You don’t have any tasks yet.',
                                      style: TextStyle(
                                        color: AppColors.text2,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
                            ),

                            //! To Do container
                            // SizedBox(
                            //   height: 450,
                            //   child: ListView.builder(
                            //     padding: EdgeInsets.all(25),
                            //     itemBuilder: (context, index) {
                            //       return Stack(
                            //         children: [
                            //           Padding(
                            //             padding: const EdgeInsets.symmetric(
                            //               vertical: 5,
                            //             ),
                            //             child: Container(
                            //               height: 80,
                            //               width: 370,
                            //               decoration: BoxDecoration(
                            //                 color: AppColors.darkGrey,
                            //                 borderRadius: BorderRadius.circular(
                            //                   4,
                            //                 ),
                            //               ),
                            //               child: Center(
                            //                 child: Row(
                            //                   children: [
                            //                     SizedBox(width: 15),
                            //                     SizedBox(
                            //                       width: 200,
                            //                       child: Row(
                            //                         children: [
                            //                           SvgPicture.asset(
                            //                             isCompleted == true
                            //                                 ? 'asset/Ellipse 15.svg'
                            //                                 : 'asset/Layer 1.svg',
                            //                             height:
                            //                                 isCompleted == true
                            //                                     ? 20
                            //                                     : 21,
                            //                           ),
                            //                           SizedBox(width: 10),
                            //                           Expanded(
                            //                             child: Text(
                            //                               'Do Math HomeWork',
                            //                               maxLines: 1,
                            //                               overflow:
                            //                                   TextOverflow
                            //                                       .ellipsis,
                            //                               style: TextStyle(
                            //                                 decoration:
                            //                                     TextDecoration
                            //                                         .lineThrough,
                            //                                 decorationThickness:
                            //                                     1.5,
                            //                                 decorationColor:
                            //                                     AppColors.text2,
                            //                                 color:
                            //                                     AppColors.text2,
                            //                               ),
                            //                             ),
                            //                           ),
                            //                         ],
                            //                       ),
                            //                     ),
                            //                   ],
                            //                 ),
                            //               ),
                            //             ),
                            //           ),
                            //           //! Edit and Delete button
                            //           Positioned(
                            //             right: 10,
                            //             bottom: 10,
                            //             top: 10,
                            //             child: Row(
                            //               mainAxisSize: MainAxisSize.min,
                            //               children: [
                            //                 IconButton(
                            //                   onPressed: () {},
                            //                   icon: SvgPicture.asset(
                            //                     'asset/edit-2.svg',
                            //                     height: 18,
                            //                   ),
                            //                 ),
                            //                 IconButton(
                            //                   onPressed: () {},
                            //                   icon: SvgPicture.asset(
                            //                     'asset/trash.svg',
                            //                     height: 24,
                            //                   ),
                            //                 ),
                            //               ],
                            //             ),
                            //           ),
                            //         ],
                            //       );
                            //     },
                            //     itemCount: 5,
                            //   ),
                            // ),
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
                        // Background color
                        borderRadius: BorderRadius.circular(
                          8,
                        ), // Rounded corners
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
                              focusedBorder:
                                  InputBorder.none, // No border when focused
                              enabledBorder:
                                  InputBorder
                                      .none, // No border when not focused
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
                    onTap: () => addTask(context),
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
addTask(BuildContext context) {
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
            height: 240,
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
                  child: TextFormField(
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
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      onPressed: () {},
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
