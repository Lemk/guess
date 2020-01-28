import 'package:guess/guess.dart' as guess;

void main(List<String> arguments) {
  guess.welcome();
  while (guess.attempt()){};
  guess.bye();
}
