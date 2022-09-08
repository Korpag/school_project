import 'dart:math';

import 'package:flutter/material.dart';
import 'package:school_project/theme/app_color.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

abstract class CustomShimmer {
  /// Заготовка для всех шиммеров
  static Shimmer mainMask(
      {double borderRadius = 12,
      Color color = AppColor.shimmerOne,
      double height = 10,
      double width = 10}) {
    return Shimmer(
      child: DecoratedBox(
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(borderRadius)),
        child: SizedBox(height: height, width: width),
      ),
      duration: const Duration(seconds: 2),
    );
  }

  /// Шиммер для карточки задач на главной
  static Container taskCard = Container(
    height: 91,
    margin: const EdgeInsets.symmetric(horizontal: 12),
    child: Row(
      children: [
        mainMask(width: 90, height: 90),
        const SizedBox(width: 15),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            mainMask(
                height: 20,
                width: 80,
                borderRadius: 10,
                color: AppColor.shimmerThree),
            const SizedBox(height: 2),
            mainMask(
                height: 20,
                width: double.infinity,
                borderRadius: 10,
                color: AppColor.shimmerTwo),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                mainMask(
                    height: 20,
                    width: 120,
                    borderRadius: 10,
                    color: AppColor.shimmerTwo),
                mainMask(
                    height: 20,
                    width: 40,
                    borderRadius: 10,
                    color: AppColor.shimmerThree),
              ],
            ),
          ],
        ))
      ],
    ),
  );

  /// Шиммер для карточки новостей на главной
  static Container newsCard = Container(
    margin: const EdgeInsets.symmetric(horizontal: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        mainMask(height: 182, width: double.infinity),
        const SizedBox(height: 13),
        mainMask(color: AppColor.shimmerThree, width: 200, height: 20)
      ],
    ),
  );

  /// Шиммер для карточки Изучай и отвечай на главной
  static Container lessonCard = Container(
    margin: const EdgeInsets.symmetric(horizontal: 12),
    child: mainMask(width: double.infinity),
  );

  /// Шиммер для карточки проектов на странице поиска
  static Column projectCard(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _intValue = Random().nextInt(20) + 20;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        mainMask(height: _height * (_intValue / 100), width: double.infinity),
        const SizedBox(height: 10),
        mainMask(height: 20, width: 100, color: AppColor.shimmerThree),
        const SizedBox(height: 6),
        mainMask(
            color: AppColor.shimmerTwo, width: double.infinity, height: 20),
      ],
    );
  }

  /// Шиммер для окна новостей
  static Scaffold newsWindow(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          mainMask(
              height: 340 + MediaQuery.of(context).padding.top,
              width: double.infinity,
              borderRadius: 0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                mainMask(height: 20, width: 100, color: AppColor.shimmerThree),
                const SizedBox(height: 25),
                mainMask(
                    color: AppColor.shimmerTwo,
                    width: double.infinity,
                    height: 40),
                const SizedBox(height: 25),
                Column(
                  children: List.generate(
                      4,
                      (index) => Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: mainMask(width: double.infinity, height: 25),
                          )),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  /// Шиммер для окна проектов
  static Scaffold projectWindow(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            mainMask(
                height: 340 + MediaQuery.of(context).padding.top,
                width: double.infinity,
                borderRadius: 0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      mainMask(
                          height: 20, width: 80, color: AppColor.shimmerThree),
                      mainMask(
                          height: 20, width: 20, color: AppColor.shimmerThree),
                    ],
                  ),
                  const SizedBox(height: 25),
                  mainMask(
                      height: 40,
                      width: double.infinity,
                      color: AppColor.shimmerTwo),
                  const SizedBox(height: 10),
                  mainMask(width: double.infinity, height: 20),
                  const SizedBox(height: 10),
                  mainMask(width: 100, height: 20),
                  const SizedBox(height: 25),
                  Column(
                    children: List.generate(
                        4,
                        (index) => Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: mainMask(width: double.infinity, height: 25),
                            )),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Шиммер для окна задач
  static Padding taskWindow = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 22),
          mainMask(height: 20, width: 150, color: AppColor.shimmerThree),
          const SizedBox(height: 15),
          mainMask(height: 40, width: double.infinity),
          const SizedBox(height: 75),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              mainMask(
                  borderRadius: 100,
                  height: 20,
                  width: 20,
                  color: AppColor.shimmerTwo),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    mainMask(
                        height: 20, width: 200, color: AppColor.shimmerTwo),
                    const SizedBox(height: 5),
                    mainMask(height: 20, width: 125),
                  ],
                ),
              )
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: mainMask(
                  color: AppColor.shimmerTwo,
                  width: 2,
                  height: double.infinity),
            ),
          ),
        ],
      ));
}
