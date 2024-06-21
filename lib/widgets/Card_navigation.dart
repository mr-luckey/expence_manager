import 'package:expence_manager/Components/helpers/theme_provider.dart';
import 'package:expence_manager/Components/theme/custom_theme.dart';
import 'package:expence_manager/Views/total_Expense.dart';
import 'package:expence_manager/widgets/buttom_navfun.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tab_container/tab_container.dart';

class CardNavigation extends StatefulWidget {
  CardNavigation({super.key});

  @override
  _CardNavigationState createState() => _CardNavigationState();
}

class _CardNavigationState extends State<CardNavigation>
    with SingleTickerProviderStateMixin {
  late final TabController _controller;
  late TextTheme textTheme;

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 3);
  }

  @override
  void didChangeDependencies() {
    textTheme = Theme.of(context).textTheme;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dark = ThemeProvider().isDarkMode(context);

    return Padding(
      padding: const EdgeInsets.only(
        right: 20.0,
        left: 20.0,
      ),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 8 / 3,
            child: Card(
              color: dark ? Colors.blue.shade900 : Colors.white,
              child: TabContainer(
                  borderRadius: BorderRadius.circular(20),
                  tabEdge: TabEdge.bottom,
                  curve: Curves.easeIn,
                  transitionBuilder: (child, animation) {
                    animation = CurvedAnimation(
                        curve: Curves.easeIn, parent: animation);
                    return SlideTransition(
                      position: Tween(
                        begin: const Offset(0.2, 0.0),
                        end: const Offset(0.0, 0.0),
                      ).animate(animation),
                      child: FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                    );
                  },
                  color: dark
                      ? Color.fromARGB(255, 255, 255, 255)
                      : Colors.blue.shade900,
                  selectedTextStyle: TextStyle(
                      color: dark ? Colors.blue.shade900 : Colors.white,

                      ///TODO: dark mode fixes required
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                  unselectedTextStyle: TextStyle(
                      color: dark ? Colors.white : Colors.blue.shade900,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                  tabs: [
                    Tab(
                      text: 'Total Salary',
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Tab(text: 'Total Expanse'),
                    ),
                    Tab(text: 'Monthly Expanse'),
                  ],
                  children: [
                    SingleChildScrollView(
                      child: Column(children: [
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 110,
                            ),
                            Text(
                              '  \$ 1000',
                              style: TextStyle(
                                  color: dark
                                      ? Colors.blue.shade900
                                      : Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        )
                      ]),
                    ),
                    SingleChildScrollView(
                      child: Column(children: [
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 110,
                            ),
                            Text(
                              '  \$ 1000',
                              style: TextStyle(
                                  color: dark
                                      ? Colors.blue.shade900
                                      : Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        )
                      ]),
                    ),
                    SingleChildScrollView(
                      child: Column(children: [
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 110,
                            ),
                            Text(
                              '  \$ 1000',
                              style: TextStyle(
                                  color: dark
                                      ? Colors.blue.shade900
                                      : Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        )
                      ]),
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
