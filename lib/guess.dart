import 'dart:math';
import 'package:dart_console/dart_console.dart';

final console = Console();
const maxNum = 50;
const maxGuessesTaken = 6;
var firstGame = true;
var namePlayer = '';
var random = Random();

String line(int width) {
  var str = '';
  for (var i = 0; i < width; i++) {
    str += '-';
  };
  return str;
}

void welcome() {
    
    console.clearScreen();
    console.writeLine(line(console.windowWidth));
    console.writeLine('');
    console.writeLine('Игра "Угадай число". Программа загадует число.', TextAlignment.center);
    console.writeLine('Необходимо угадать задуманное число за $maxGuessesTaken попыток.', TextAlignment.center);
    console.writeLine('');
    console.writeLine(line(console.windowWidth));
    console.writeLine('');
}

bool attempt() {
  if (firstGame) {
    console.write('Привет! Как тебя зовут?!');
    console.setForegroundColor(ConsoleColor.brightYellow);
    namePlayer = console.readLine(cancelOnBreak: true);
    console.resetColorAttributes();
    firstGame = false;
  }

  var rndNum = random.nextInt(maxNum);
  var num = 0;
  console.writeLine('Уважаемый $namePlayer, я загадал число от 1 до ' + maxNum.toString());
  console.writeLine('Попробуй угадать!');
  for (var i = 0; i < maxGuessesTaken; i++) {
    console.write('Выбери число: ');
    console.setForegroundColor(ConsoleColor.brightYellow);
    num = int.parse(console.readLine(cancelOnBreak: true));
    console.resetColorAttributes();
    if (num > rndNum) {
      console.writeLine('Твое число больше загаданного!');
    } else if (num < rndNum) {
      console.writeLine('Твое число меньше загаданного!');
    } else if (num == rndNum) {
      console.write('Отлично! $namePlayer ты справился за ${i + 1}');
      if ((i + 1) < 5) {
        console.writeLine(' попытки!');
      } else {
        console.writeLine(' попыток!');
      }
      break;
    }
  }
  if (num != rndNum) {
    console.writeLine('Я загадал число : $rndNum.');
    console.writeLine('$namePlayer, ты не угадал. Пробуй еще!');
  }
  console.write('Играем еще? (y/n)?');
  console.setForegroundColor(ConsoleColor.brightYellow);
  var answer = console.readLine(cancelOnBreak: true);
  console.resetColorAttributes();
  if (answer == 'n'){
    return false;
  } else {
    welcome();
    return true;
  }
}

void bye(){
  console.setForegroundColor(ConsoleColor.brightYellow);
  console.writeLine('Bye $namePlayer!');
  console.resetColorAttributes();
}