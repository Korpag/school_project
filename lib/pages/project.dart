import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_project/blocs/project_bloc.dart';
import 'package:school_project/pages/tasks.dart';
import 'package:school_project/pages/tasks_moderation.dart';
import 'package:school_project/services/project.dart';
import 'package:school_project/theme/app_color.dart';
import 'package:school_project/theme/app_image.dart';
import 'package:school_project/widgets/custom_appbar.dart';
import 'package:school_project/widgets/custom_shimmer.dart';
import 'package:school_project/widgets/description.dart';
import 'package:school_project/widgets/html_content.dart';
import 'package:school_project/widgets/label.dart';
import 'package:school_project/widgets/main_layout.dart';
import 'package:school_project/widgets/coin.dart';
import 'package:school_project/widgets/favourites.dart';
import 'package:school_project/widgets/popup_window.dart';

class ProjectPage extends StatelessWidget {
  final int? id;

  const ProjectPage({Key? key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProjectBloc(RepositoryProvider.of<ProjectService>(context), id: id)
            ..add(ProjectLoadApiEvent()),
      child: BlocBuilder<ProjectBloc, ProjectState>(
        builder: (context, state) {
          /// Окно загрузки проекта
          if (state is ProjectLoadingState) {
            return CustomShimmer.projectWindow(context);
          }

          /// Окно загруженной новости
          if (state is ProjectLoadedState) {
            final _item = state.project;
            return MainLayout(
              horizontalPadding: 12,
              appBar: CustomAppBar.project(
                  url: _item.photoUrl,
                  count: _item.points.toString(),
                  selected: _item.isFavorite,
                  topPaddingDevice: MediaQuery.of(context).padding.top),

              /// Настройки выезжаюего окна
              popUp: () => showModal(
                  context: context,
                  title: 'Заинтересовало задание?',
                  titleButton: 'Приступить к заданиям',
                  description: _item.tasks!.isNotEmpty
                      ? 'Это отличный способ пополнить баланс своего счета! Да не просто пополнить, а получить отличные эмоции и опыт!'
                      : 'Как только мы наполним шагами, вы сможете перейти! А пока попробуйте другие задания - "Научиться плавать", например.',
                  onTap: () {
                    if (_item.tasks!.isNotEmpty) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TasksPage(
                                  tasks: _item.tasks!, projectId: _item.id!)
                              // TasksModerationPage(tasks: _item.tasks!)
                              ));
                    }
                  }),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Стоимость проекта
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 26),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Coin(
                            count: _item.points.toString(),
                            offset: 5,
                            iconSize: 26),
                        Favourites(
                            border: true,
                            selected: _item.isFavorite,
                            onTap: () {
                              //TODO запрос !_item.isFavorite
                            }),
                      ],
                    ),
                  ),

                  /// Красткое описание
                  Description(
                    fontSizeTitle: 20,
                    distanceBetweenItems: 9,
                    title: _item.title,
                    description: _item.shortDescription,
                  ),
                  const SizedBox(height: 20),

                  /// Лейбл
                  const Label(title: 'Математика', color: AppColor.button),
                  const SizedBox(height: 30),

                  /// Виджет принимающий хтмл контент (описание)
                  HtmlContent(
                    data: _item.description,
                  ),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
