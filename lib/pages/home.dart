import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_project/pages/project.dart';
import 'package:school_project/services/news.dart';
import 'package:school_project/services/project.dart';
import 'package:school_project/services/user.dart';
import 'package:school_project/theme/app_color.dart';
import 'package:school_project/widgets/custom_appbar.dart';
import 'package:school_project/widgets/custom_shimmer.dart';
import 'package:school_project/widgets/main_layout.dart';
import 'package:school_project/widgets/custom_list_item_block.dart';
import 'package:school_project/widgets/flash.dart';
import 'package:school_project/widgets/card_lesson.dart';
import 'package:school_project/widgets/card_news.dart';
import 'package:school_project/widgets/news_window.dart';
import 'package:school_project/widgets/card_tasks.dart';
import 'package:school_project/blocs/home_projects_bloc.dart';
import 'package:school_project/blocs/home_news_bloc.dart';
import 'package:school_project/blocs/home_user_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// Переменные для AppBar
  String? name;
  String? countCoin;
  String? countSticker;
  String? avatar;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                HomeProjectsBloc(RepositoryProvider.of<ProjectService>(context))
                  ..add(HomeProjectsLoadApiEvent())),
        BlocProvider(
            create: (context) =>
                HomeNewsBloc(RepositoryProvider.of<NewsService>(context))
                  ..add(HomeNewsLoadApiEvent())),
        BlocProvider(
          create: (context) =>
              HomeUserBloc(RepositoryProvider.of<HomeUserService>(context))
                ..add(HomeUserLoadApiEvent()),
        )
      ],
      child: BlocListener<HomeUserBloc, HomeUserState>(
        listener: (context, state) {
          if (state is HomeUserLoadedState) {
            final _user = state.user;

            /// Передаем значения из стейта блока для AppBar
            name = '${_user.firstName} ${_user.patronymic}';
            countCoin = _user.points.toString();
            avatar = _user.avatarUrl;
            setState(() {});
          }
        },
        child: MainLayout(
            appBar: CustomAppBar.main(
              topPaddingDevice: MediaQuery.of(context).padding.top,
              name: name,
              countCoin: countCoin,
              countSticker: '225',
              url: avatar,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Временные кнопки для демонстрации возможностей проекта
                const SizedBox(height: 30),

                /// Всплывающее окно
                Flash(
                    title: 'Выполняй задания!',
                    description:
                        'Получай стикеры и меняй их на призы, тебя ждет множество стикеров',
                    close: true,
                    onRedirect: () {}),

                /// Задания на сегодня
                BlocBuilder<HomeProjectsBloc, HomeProjectsState>(
                    builder: (context, state) {
                  if (state is HomeProjectsLoadingState) {
                    return CustomListBlock(
                        countList: 4,
                        type: 'vertical',
                        title: 'Задания на сегодня',
                        itemBuilder: (BuildContext context, index) =>
                            CustomShimmer.taskCard);
                  }
                  if (state is HomeProjectsLoadedState) {
                    return CustomListBlock(
                        countList: state.projects.length,
                        type: 'vertical',
                        title: 'Задания на сегодня',
                        itemBuilder: (BuildContext context, index) {
                          final _item = state.projects[index];
                          return TasksCard(
                            titleLabel: AppColor.testString[index],
                            colorLabel: AppColor.testColor[index],
                            description: _item.title,
                            date: _item.dateOfFinish.toString(),
                            count: _item.points.toString(),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ProjectPage(id: _item.id)));
                            },
                          );
                        });
                  }
                  return const SizedBox();
                }),
                const SizedBox(height: 30),

                /// Факты дня
                BlocBuilder<HomeNewsBloc, HomeNewsState>(
                    builder: (context, state) {
                  if (state is HomeNewsLoadingState) {
                    return CustomListBlock(
                        height: 229,
                        title: 'Факты дня',
                        viewportFraction: 0.72,
                        pageSnapping: false,
                        countList: 2,
                        itemBuilder: (BuildContext context, index) =>
                            CustomShimmer.newsCard);
                  }
                  if (state is HomeNewsLoadedState) {
                    return CustomListBlock(
                        height: 229,
                        title: 'Факты дня',
                        viewportFraction: 0.72,
                        pageSnapping: false,
                        countList: state.news.length,
                        moreChallengeTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      NewsWindow(news: state.news, id: 0)));
                        },
                        itemBuilder: (BuildContext context, index) {
                          final _item = state.news[index];
                          return NewsCard(
                            image: _item.pictureUrl,
                            description: _item.title,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NewsWindow(
                                            news: state.news,
                                            id: index,
                                          )));
                            },
                          );
                        });
                  }
                  return const SizedBox();
                }),
                const SizedBox(height: 30),

                /// Изучай и отвечай
                BlocBuilder<HomeNewsBloc, HomeNewsState>(
                    builder: (context, state) {
                  if (state is HomeNewsLoadingState) {
                    return CustomListBlock(
                        countList: 1,
                        height: 166,
                        title: 'Изучай и отвечай',
                        itemBuilder: (BuildContext context, index) =>
                            CustomShimmer.lessonCard);
                    // CustomImage.loading;
                  }
                  if (state is HomeNewsLoadedState) {
                    return CustomListBlock(
                      height: 166,
                      title: 'Изучай и отвечай',
                      itemBuilder: (BuildContext context, index) {
                        final _item = state.news[index];
                        return LessonCard(
                          image: _item.pictureUrl,
                          date: _item.createdAt.toString(),
                          title: 'Образование',
                          colorCard: AppColor.progressBarGradientFirstColor,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NewsWindow(
                                        news: state.news,
                                        id: index,
                                        toProject: true)));
                          },
                        );
                      },
                      countList: state.news.length,
                    );
                  }
                  return const SizedBox();
                }),
              ],
            )),
      ),
    );
  }
}
