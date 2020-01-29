import 'dart:io';
import 'dart:convert';
import 'dart:math';
import 'package:dart_console/dart_console.dart';

final console = Console();
const maxNum = 50;
const maxGuessesTaken = 6;
var firstGame = true;
var namePlayer = '';
var random = Random();
var quantity = 0;

String line(int width) {
  var str = StringBuffer();
  for (var i = 0; i < width; i++) {
    str.write('-');
  }
  return str.toString();
}

var listGames = <String, dynamic>{};

String loadFromFile() {
  /*var file = File('playerData.json');
  return await file.readAsString();*/
  try {
    return File('playerData.json').readAsStringSync();
  } on FileSystemException {
    return '';
  }

}

void saveToFile(String str) {
  var file = File('playerData.json');
  var sink = file.openWrite();
  sink.write(str);
  sink.close();
}

void welcome() {
  console.setBackgroundColor(ConsoleColor.blue);
  console.clearScreen();
  var stringLine = line(console.windowWidth);
  console.writeLine(stringLine);
  console.writeLine('');
  console.writeLine(
      'Игра "Угадай число". Программа загадует число.', TextAlignment.center);
  console.writeLine(
      'Необходимо угадать задуманное число за $maxGuessesTaken попыток.',
      TextAlignment.center);
  console.writeLine('');
  console.writeLine(stringLine);
  console.writeLine('');
}

void printMessage(String str) {
  console.write('Твое число ');
  console.setForegroundColor(ConsoleColor.brightYellow);
  console.write(str);
  console.setForegroundColor(ConsoleColor.brightWhite);
  console.writeLine(' загаданного!');
}

bool attempt() {
  if (firstGame) {
    do {
      console.write('Привет! Как тебя зовут?!');
      console.setForegroundColor(ConsoleColor.brightYellow);
      namePlayer = console.readLine(cancelOnBreak: true);

    } while (namePlayer.toString() == '');
    console.setForegroundColor(ConsoleColor.brightWhite);
    firstGame = false;
    var objString = loadFromFile();
    if (objString != '') {
      listGames.addAll(jsonDecode(objString));
      quantity = listGames[namePlayer];
    }
    if (quantity != null && quantity > 0) {
      console.setForegroundColor(ConsoleColor.brightGreen);
      console.writeLine(
          '\nС возвращение в игру $namePlayer! Количество твоих игр = $quantity. Удачи и вперед к победам!\n');
      console.setForegroundColor(ConsoleColor.brightWhite);
    } else {
      quantity = 0;
    }
  }

  var rndNum = random.nextInt(maxNum);
  var num = 0;
  quantity++;
  listGames[namePlayer] = quantity;
  console.writeLine(
      'Уважаемый $namePlayer, я загадал число от 1 до ' + maxNum.toString());
  console.writeLine('Попробуй угадать!');
  for (var i = 0; i < maxGuessesTaken; i++) {
    String inputNum;
    do {
      console.write('Выбери число: ');
      console.setForegroundColor(ConsoleColor.brightYellow);
      inputNum = console.readLine(cancelOnBreak: true);
    } while (inputNum.isEmpty || int.tryParse(inputNum) == null);

    num = int.parse(inputNum);
    console.setForegroundColor(ConsoleColor.brightWhite);
    if (num > rndNum) {
      printMessage('больше');
    } else if (num < rndNum) {
      printMessage('меньше');
    } else if (num == rndNum) {
      console.write('Отлично! $namePlayer, ты справился за ${i + 1}');
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
  console.setForegroundColor(ConsoleColor.brightWhite);
  if (answer == 'n') {
    saveToFile(jsonEncode(listGames));
    return false;
  } else {
    welcome();
    return true;
  }
}

void bye() {
  console.setForegroundColor(ConsoleColor.brightYellow);
  console.writeLine('Bye $namePlayer!');
  console.resetColorAttributes();
  console.clearScreen();
}
