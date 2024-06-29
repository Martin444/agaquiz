import 'package:agaquiz/features/on_boarding/presentation/state/on_boardin_game_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnBoardingGameController extends StateNotifier<OnBoardinGameState> {
  OnBoardingGameController() : super(OnBoardinGameState()) {}
}
