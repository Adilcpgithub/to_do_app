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
      body: Stack(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Text(
                                    '1',
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
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.darkGrey,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Text(
                                    '2/2',
                                    style: TextStyle(color: AppColors.text1),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 100),

                      Stack(
                        children: [
                          Container(
                            height: 90,
                            width: 370,
                            color: AppColors.darkGrey,
                            child: Center(
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 200,
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          isCompleted == true
                                              ? 'asset/Ellipse 15.svg'
                                              : 'asset/Layer 1.svg',
                                          height: isCompleted == true ? 20 : 21,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          'Do Math HomeWork',
                                          style: TextStyle(
                                            color: AppColors.text1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
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
                                  onPressed: () {},
                                  icon: SvgPicture.asset(
                                    'asset/edit-2.svg',
                                    height: 18,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
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
                    ],
                  ),
                ),
              ),
            ],
          ),
          //! Search Bar
          Positioned(
            left: 15,
            right: 110,
            top: 220,
            child: Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                color: AppColors.darkGrey,
                // Background color
                borderRadius: BorderRadius.circular(8), // Rounded corners
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  style: TextStyle(
                    color: const Color.fromARGB(255, 155, 23, 23),
                  ),
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelStyle: TextStyle(color: AppColors.text2),
                    labelText: "🚀 Search...",

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: InputBorder.none, // No border when focused
                    enabledBorder:
                        InputBorder.none, // No border when not focused
                    disabledBorder: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),

          //! Add Button
          Positioned(
            right: 15,

            top: 220,
            child: Container(
              height: 60,
              width: 85,
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
        ],
      ),
    );
  }
}
