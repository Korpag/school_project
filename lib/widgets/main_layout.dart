import 'package:flutter/material.dart';

class MainLayout extends StatefulWidget {
  /// AppBar, если нужен
  final SliverPersistentHeaderDelegate? appBar;

  /// Содержимое страницы
  final Widget child;

  /// Горизонтальный паддинг для содержимого страницы
  final double horizontalPadding;

  /// Вертикальный паддинг для содержимого страницы
  final double verticalPadding;

  /// PopUp, если такой нужен
  final VoidCallback? popUp;

  /// Высота пустого контейнера снизу, если такой необходим (0-1)
  final double heightClearSizedBox;

  const MainLayout({
    Key? key,
    this.appBar,
    required this.child,
    this.verticalPadding = 0,
    this.horizontalPadding = 0,
    this.popUp,
    this.heightClearSizedBox = 0.3,
  }) : super(key: key);

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    if (widget.popUp != null) {
      _controller.addListener(() {
        if (_controller.position.pixels ==
            _controller.position.maxScrollExtent) {
          widget.popUp!();
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: CustomScrollView(
        controller: _controller,
        scrollBehavior: const ScrollBehavior().copyWith(overscroll: false),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        slivers: [
          /// AppBar
          if (widget.appBar != null)
            SliverPersistentHeader(pinned: true, delegate: widget.appBar!),

          /// Содержимое страницы
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: widget.horizontalPadding,
                    vertical: widget.verticalPadding),
                child: widget.child,
              ),

              /// Временное отображение, требуется пояснение
              SizedBox(
                  height: _height * widget.heightClearSizedBox, child: null),
            ]),
          ),
        ],
      ),
    );
  }
}
