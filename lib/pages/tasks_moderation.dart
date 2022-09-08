import 'package:flutter/material.dart';
import 'package:school_project/models/task.dart';
import 'package:school_project/widgets/custom_appbar.dart';
import 'package:school_project/widgets/task_view_moderation.dart';

class TasksModerationPage extends StatefulWidget {
  final List<TaskClass> tasks;

  const TasksModerationPage({Key? key, required this.tasks}) : super(key: key);

  @override
  State<TasksModerationPage> createState() => _TasksModerationPageState();
}

class _TasksModerationPageState extends State<TasksModerationPage> {
  final PageController _controller = PageController();
  int _countDone = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar.mini(
              count: widget.tasks.length,
              countDone: _countDone,
              moderator: true,
              progressBar: true),
          Expanded(
            child: PageView.builder(
                controller: _controller,
                scrollDirection: Axis.vertical,
                itemCount: widget.tasks.length,
                itemBuilder: (BuildContext context, int index) {
                  return TaskViewModeration(
                    controller: _controller,
                    index: index,
                    typeTask: widget.tasks[index].taskType,
                    itemCount: widget.tasks.length,
                    callback: () {
                      ++_countDone;
                      setState(() {});
                    },
                    taskId: widget.tasks[index].id,
                  );
                }),
          )
        ],
      ),
    );
  }
}
