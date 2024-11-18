import 'package:flutter/material.dart';

import '../../../theme/luckit_colors.dart';
import '../../../theme/luckit_typos.dart';

class FortuneCardWidget extends StatelessWidget {
  const FortuneCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: LuckitColors.shadow2.withOpacity(0.15),
                blurRadius: 10,
              )
            ],
            borderRadius: BorderRadius.circular(16),
            color: LuckitColors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '전력질주하기 좋은 날',
                style: LuckitTypos.suitSB16.copyWith(
                  color: LuckitColors.main,
                  leadingDistribution: TextLeadingDistribution.even,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '''겸손을 익혔을 때에 사람들은 당신에게 호감을 표시할 것입니다. 남을 배려하지 않고 당신만을 위해서 일했다면 그로 인해 얻는 것은 불리한 상황뿐일 것입니다. 조금은 당신이 생각하는 일을 진행함에 있어서 그날 하루의 전체적인 모습을 체크하는 것이 가장 중요합니다. 당신이 스스로 낮추고 노력하는 모습을 보이는 만큼 좋은 것은 없습니다. 그리고 당신 역시 혼자서 뭐든지 잘하던 때보다도 좀더 따스하고 즐겁고 느긋한, 행복한 분위기 속에서 즐겁게 하루를 마감할 수 있으니 염두에 두시기 바랍니다.''',
                style: LuckitTypos.suitR12.copyWith(
                  color: LuckitColors.gray80,
                  leadingDistribution: TextLeadingDistribution.even,
                ),
              ),
            ],
          ),
        ),
      );
}
