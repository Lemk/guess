import 'dart:io';
import 'dart:math';
import 'package:dart_console/dart_console.dart';

final console = Console();
const maxNum = 50;
const maxGuessesTaken = 6;
var isExit = false;
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
}

void attempt() {
  if (firstGame) {
    console.write('Привет! Как тебя зовут?!');
    namePlayer = console.readLine(cancelOnBreak: true);
    firstGame = false;
  } else {

  }

  var rndNum = random.nextInt(maxNum);

  console.writeLine('$namePlayer , я загадал число от 1 до ' + maxNum.toString());
  console.writeLine('Попробуй угадать!');
  for (var i = 0; i < maxGuessesTaken; i++){
    console.write('Выбери число: ');
    var num = int.parse(console.readLine(cancelOnBreak: true));
    if (num > rndNum){
      console.writeLine('Твое число больше загаданного!');
    } else if (num < rndNum){
      console.writeLine('Твое число меньше загаданного!');
    } else if (num == rndNum){
      console.write('Отлично! $namePlayer ты справился за ${i + 1}');
      if ((i + 1) < 5){
        console.writeLine(' попытки!');
      } else {
        console.writeLine(' попыток!');
      }
      break;
    }
  }
  console.writeLine('Я загадал число : $rndNum.');
  console.writeLine('$namePlayer, ты не угадал. Пробуй еще!');
}

void bye(){
  console.setForegroundColor(ConsoleColor.brightYellow);
  console.writeLine('Bye $namePlayer!');
}