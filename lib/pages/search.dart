import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_project/blocs/project_search_bloc.dart';
import 'package:school_project/pages/project.dart';
import 'package:school_project/theme/app_color.dart';
import 'package:school_project/widgets/card_project.dart';
import 'package:school_project/widgets/custom_form.dart';
import 'package:school_project/widgets/custom_gridview.dart';
import 'package:school_project/widgets/custom_shimmer.dart';
import 'package:school_project/widgets/flash.dart';
import 'package:school_project/widgets/main_layout.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> _projectList = [];
  bool? _loadedList;

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      horizontalPadding: 14,
      verticalPadding: 35,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Строка поиска с autocomplete
          CustomForm.text(
              hintText: 'Введите ключевое слово:',
              clearTap: () => _search(context: context, value: ''),
              onSubmitted: (value) => _search(context: context, value: value),
              onChanged: (value) {
                if (_loadedList != true) {
                  setState(() {
                    _loadedList = true;
                  });
                }
              },
              autoCompleteList: _projectList),

          /// Всплывающее окно
          Flash(
              title: 'Выполняй задания!',
              description:
                  'Получай стикеры и меняй их на призы, тебя ждет множество призов',
              close: true,
              onRedirect: () {}),
          BlocBuilder<ProjectsSearchBloc, ProjectsSearchState>(
            builder: (context, state) {
              if (state is ProjectsSearchLoadingState) {
                return CustomGridView(
                    itemCount: 6,
                    itemBuilder: (ctx, index) {
                      return CustomShimmer.projectCard(context);
                    });
              }
              if (state is ProjectsSearchLoadedState) {
                _projectList =
                    state.projects.map((e) => e.title ?? '').toList();
                return CustomGridView(
                    itemCount: state.projects.length,
                    itemBuilder: (ctx, index) {
                      final _item = state.projects[index];
                      return ProjectCard(
                        titleLabel: AppColor.testString[index],
                        colorLabel: AppColor.testColor[index],
                        image: _item.photoUrl,
                        description: _item.title,
                        date: _item.dateOfFinish.toString(),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProjectPage(
                                        id: _item.id,
                                      )));
                        },
                      );
                    });
              }
              return const SizedBox();
            },
          )
        ],
      ),
    );
  }
}

void _search({required BuildContext context, required String value}) {
  final _provider = BlocProvider.of<ProjectsSearchBloc>(context);
  _provider.searchText = value;
  _provider.add(ProjectsSearchLoadApiEvent());
}
