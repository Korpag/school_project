import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_project/blocs/project_bloc.dart';
import 'package:school_project/models/task.dart';
import 'package:school_project/services/project.dart';
import 'package:school_project/widgets/custom_appbar.dart';
import 'package:school_project/widgets/task_view.dart';

class TasksPage extends StatefulWidget {
  final List<TaskClass> tasks;
  final int projectId;

  const TasksPage({Key? key, required this.tasks, required this.projectId})
      : super(key: key);

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  final PageController _controller = PageController();
  int _countDone = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProjectBloc(
          RepositoryProvider.of<ProjectService>(context),
          id: widget.projectId)
        ..add(ProjectLoadApiEvent()),
      child: Scaffold(
        body: BlocListener<ProjectBloc, ProjectState>(
          listener: (context, state) {
            /// Получаем актуальное кол-во выполненных заданий при попадании на окно "Выполнения тасков"
            if (state is ProjectLoadedState) {
              if (state.project.tasks != null) {
                _countDone = state.project.tasks!
                    .map((e) => e.report)
                    .where((element) => element != null)
                    .length;
                setState(() {});
              }

              /// После загрузки данных, переходим на первый невыполненный таск
              if (_countDone > 0) {
                _controller.animateToPage(_countDone,
                    curve: Curves.easeInOut,
                    duration: const Duration(milliseconds: 500));
              }
            }
          },
          child: Column(
            children: [
              CustomAppBar.mini(
                  count: widget.tasks.length,
                  countDone: _countDone,
                  progressBar: true),
              Expanded(
                child: PageView.builder(
                    controller: _controller,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: widget.tasks.length + 1,
                    itemBuilder: (BuildContext context, int index) {
                      final _tasks = widget.tasks;
                      final _check = index > _tasks.length - 1;
                      return TaskView(
                        //TODO пока так, подумать над выводом для последнего индекса
                        task: _check ? _tasks.first : _tasks[index],
                        previewStatus:
                            (index != 0 && _tasks[index - 1].report != null)
                                ? _tasks[index - 1].report!.status!
                                : '',
                        controller: _controller,
                        index: index,
                        itemCount: _tasks.length,
                        callback: () {
                          ++_countDone;
                          setState(() {});
                        },
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
