import 'package:guess/guess.dart' as guess;

void main(List<String> arguments) {
  guess.welcome();
  do {
    guess.attempt();
  } while (guess.isExit);
  guess.bye();
}
