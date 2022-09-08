import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_project/blocs/home_news_bloc.dart';
import 'package:school_project/blocs/project_search_bloc.dart';
import 'package:school_project/pages/home.dart';
import 'package:school_project/pages/search.dart';
import 'package:school_project/services/news.dart';
import 'package:school_project/services/project.dart';
import 'package:school_project/theme/app_image.dart';
import 'package:school_project/widgets/custom_navbar.dart';
import 'package:school_project/widgets/custom_shimmer.dart';
import 'package:school_project/widgets/news_window.dart';

class MainWindow extends StatefulWidget {
  const MainWindow({Key? key}) : super(key: key);

  @override
  State<MainWindow> createState() => _MainWindowState();
}

class _MainWindowState extends State<MainWindow> {
  final PageController _controller = PageController(initialPage: 0);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                HomeNewsBloc(RepositoryProvider.of<NewsService>(context))
                  ..add(HomeNewsLoadApiEvent())),
      ],
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Stack(
          children: [
            PageView(
              controller: _controller,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                /// Главная страница
                const HomePage(),

                /// Раздел поиска задач
                BlocProvider(
                  create: (context) => ProjectsSearchBloc(
                      RepositoryProvider.of<ProjectService>(context),
                      searchText: '')
                    ..add(ProjectsSearchLoadApiEvent()),
                  child: const SearchPage(),
                ),

                /// Раздел новостей
                BlocBuilder<HomeNewsBloc, HomeNewsState>(
                  builder: (context, state) {
                    if (state is HomeNewsLoadedState) {
                      return Column(
                        children: [
                          Expanded(
                            child: NewsWindow(
                              news: state.news,
                              id: 0,
                              backButton: false,
                            ),
                          ),
                          const SizedBox(height: 88)
                        ],
                      );
                    }
                    return CustomShimmer.newsWindow(context);
                  },
                ),

                /// Временная заглушка
                Scaffold(
                    body: Stack(
                  children: [
                    const Center(child: Text('Тут скоро будут призы!!!')),
                    Center(
                        child: Image.asset(
                      CustomImage.background,
                      color: Colors.black.withOpacity(0.1),
                    ))
                  ],
                )),
              ],
            ),
            CustomNavBar(
              onTap: (index) {
                _controller.jumpToPage(index);
              },
            )
          ],
        ),
      ),
    );
  }
}
