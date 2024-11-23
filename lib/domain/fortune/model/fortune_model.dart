import 'package:equatable/equatable.dart';

import '../../../data/fortune/entity/fortune_entity.dart';

class FortuneModel extends Equatable {
  final List<String> fortuneKeywords;
  final String shortFortune;
  final String fullFortune;
  final List<CategoryFortuneScores> categoryFortuneScores;
  final List<TimeOfDayFortuneScores> timeOfDayFortuneScores;

  const FortuneModel({
    required this.fortuneKeywords,
    required this.shortFortune,
    required this.fullFortune,
    required this.categoryFortuneScores,
    required this.timeOfDayFortuneScores,
  });

  factory FortuneModel.fromEntity({
    required FortuneEntity entity,
  }) =>
      FortuneModel(
        fortuneKeywords: entity.fortuneKeywords,
        shortFortune: entity.shortFortune,
        fullFortune: entity.fullFortune,
        categoryFortuneScores: [
          CategoryFortuneScores(
            category: 'all_luck',
            score: entity.overallFortuneScore,
          ),
          CategoryFortuneScores(
            category: 'Money',
            score: entity.categoryFortuneScores.money,
          ),
          CategoryFortuneScores(
            category: 'Study',
            score: entity.categoryFortuneScores.study,
          ),
          CategoryFortuneScores(
            category: 'Health',
            score: entity.categoryFortuneScores.health,
          ),
          CategoryFortuneScores(
            category: 'Love',
            score: entity.categoryFortuneScores.love,
          ),
          CategoryFortuneScores(
            category: 'Work',
            score: entity.categoryFortuneScores.work,
          ),
        ],
        timeOfDayFortuneScores: [
          TimeOfDayFortuneScores(
            time: 'Morning',
            score: entity.timeOfDayFortuneScores.morning,
          ),
          TimeOfDayFortuneScores(
            time: 'Afternoon',
            score: entity.timeOfDayFortuneScores.afternoon,
          ),
          TimeOfDayFortuneScores(
            time: 'Night',
            score: entity.timeOfDayFortuneScores.night,
          ),
        ],
      );

  @override
  List<Object?> get props => <Object?>[
        fortuneKeywords,
        shortFortune,
        fullFortune,
        categoryFortuneScores,
        timeOfDayFortuneScores,
      ];
}

class CategoryFortuneScores {
  final String category;
  final int score;

  CategoryFortuneScores({required this.category, required this.score});
}

class TimeOfDayFortuneScores {
  final String time;
  final int score;

  TimeOfDayFortuneScores({required this.time, required this.score});
}
