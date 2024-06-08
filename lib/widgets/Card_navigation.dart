import 'package:flutter/material.dart';
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
    return Padding(
      padding: const EdgeInsets.only(
        right: 20.0,
        left: 20.0,
      ),
      child: Column(
        children: [
          // const Spacer(),
          AspectRatio(
            aspectRatio: 8 / 3,
            child: Card(
              // elevation: 10,
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
                  colors: const <Color>[
                    Colors.blue,
                    Colors.blue,
                    Colors.blue,
                  ],
                  selectedTextStyle: textTheme.bodyMedium?.copyWith(
                      fontSize: 13.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  unselectedTextStyle:
                      textTheme.bodyMedium?.copyWith(fontSize: 10.0),
                  tabs: const [
                    Tab(
                      text: 'Total Salary',
                    ),
                    Tab(text: 'Total Expanse'),
                    Tab(text: 'Monthly Expanse'),
                  ],
                  // _getTabs1(),
                  children: [
                    Column(children: [
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 110,
                          ),
                          Icon(
                            Icons.account_balance_wallet_outlined,
                            size: 20,
                            color: Colors.white,
                          ),
                          Text(
                            '  \$ 1000',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    ]),
                    Column(children: [
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 110,
                          ),
                          Icon(
                            Icons.account_balance_wallet_outlined,
                            size: 20,
                            color: Colors.white,
                          ),
                          Text(
                            '  \$ 1000',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: Get.width * 0.18,
                          ),
                          TextButton(
                              onPressed: () {},
                              child: Container(
                                height: 30,
                                width: 80,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black54),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Text(
                                    'View More',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                ),
                              ))
                        ],
                      )
                    ]),
                    Column(children: [
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 110,
                          ),
                          Icon(
                            Icons.account_balance_wallet_outlined,
                            size: 20,
                            color: Colors.white,
                          ),
                          Text(
                            '  \$ 1000',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    ]),
                  ]
                  //  _getChildren1(),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
