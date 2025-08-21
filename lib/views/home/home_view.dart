import 'package:cumpri/views/home/widgets/home_app_bar.dart';
import 'package:cumpri/views/home/widgets/task_widget.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        itemBuilder: (context, index) {
          return TaskWidget(
            title: 'Um titulo',
            description: 'fazer tal coisa',
            isDone: false,
            onCheckPressed: () {},
            onTaskPressed: () {},
          );
        },
        separatorBuilder: (context, index) => SizedBox(height: 24),
        itemCount: 2,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
      ),
    );
  }
}
