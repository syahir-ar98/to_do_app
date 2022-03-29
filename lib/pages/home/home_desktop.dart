import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_app/components/nav_rail.dart';
import 'package:to_do_app/pages/home/home.dart';
import 'package:to_do_app/pages/overview/overview_desktop.dart';
import 'package:to_do_app/pages/tasks/task_desktop.dart';

class HomeDesktop extends ConsumerWidget {
  HomeDesktop({Key? key}) : super(key: key);

  final List<Widget> _listMenuPage = [
    const OverviewDesktop(),
    const TaskDesktop(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('Home - Desktop build');
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Row(
        children: [
          const CustomNavigationRail(),
          Expanded(
            child: PageView.builder(
              controller: pageController,
              itemCount: listMenu.length,
              itemBuilder: (_, index) {
                return _listMenuPage[index];
              },
            ),
          )
        ],
      ),
    );
  }
}
