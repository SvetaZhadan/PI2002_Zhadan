import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(PredictionApp());

class PredictionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Шар предсказаний',
      theme: ThemeData.dark(), // Темная тема
      home: PredictionScreen(),
    );
  }
}

class PredictionScreen extends StatefulWidget {
  @override
  _PredictionScreenState createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  List<String> predictions = [
    'Сегодня будет прекрасный день!',
    'Вам предстоит встретить интересного человека.',
    'Удача сопутствует вам в деловых начинаниях.',
    'Будьте осторожны, предстоит испытание.',
    'Ваше творческое начинание принесет успех.',
    'Ваша жизнь наполнена радостью и счастьем.',
    'Вас ожидает волнующее путешествие, которое принесет вам массу положительных впечатлений.',
    'Вы встретите верных и преданных друзей, которые всегда будут рядом в трудные моменты.',
    'Ваш талант и труд будут вознаграждены успешной карьерой.',
    'Вы обретете гармонию в своих отношениях и будете окружены любовью.',
    'Ваше стремление к саморазвитию приведет к новым возможностям и достижениям.',
    'Вы сможете преодолеть любые трудности и справиться со всеми испытаниями, которые поставит перед вами жизнь.',
    'Вас ждет приятное событие, которое принесет вам ощущение глубокого удовлетворения.',
    'Вы найдете вдохновение и станете источником вдохновения для других.',
    'Ваше семейное счастье будет стабильным и долгосрочным.',
    'Вам предстоит пережить неприятное разочарование, но это будет важный урок для вашего личного роста.',
    'В ближайшем будущем вас ожидает некоторая финансовая нестабильность, но вы сможете преодолеть это испытание.',
    'Вы столкнетесь с непредвиденными преградами на пути к достижению ваших целей, но ваше настойчивое усилие приведет к их преодолению.'
  ];

  List<String> predictionImages = [
    '../android/app/src/assets/magic_ball1.png',
    '../android/app/src/assets/magic_ball2.png',
    '../android/app/src/assets/magic_ball3.png',
    '../android/app/src/assets/magic_ball4.png',
    '../android/app/src/assets/magic_ball5.png',
  ];

  List<String> unusedPredictions = []; // Список неиспользованных предсказаний
  List<String> unusedImages = []; // Список неиспользованных картинок
  List<String> favoritePredictions = [];
  List<String> allPredictions = [];

  TextEditingController predictionController = TextEditingController();

  void initState() {
    super.initState();
    unusedPredictions = List.from(predictions); // Копирование предсказаний
    unusedImages = List.from(predictionImages); // Копирование картинок
    allPredictions = List.from(predictions); // Копирование предсказаний
  }

  String currentPrediction = '';
  String currentImage = '../android/app/src/assets/magic_ball-empty.png';

  void generatePrediction() {
    setState(() {
      if (unusedPredictions.isEmpty) {
        unusedPredictions =
            List.from(predictions); // Восстановление списка предсказаний
      }

      if (unusedImages.isEmpty) {
        unusedImages =
            List.from(predictionImages); // Восстановление списка картинок
      }

      // Генерация уникального предсказания и картинки
      int randomIndex = Random().nextInt(unusedPredictions.length);
      currentPrediction = unusedPredictions[randomIndex];
      currentImage = unusedImages[randomIndex];

      unusedPredictions
          .removeAt(randomIndex); // Удаление использованного предсказания
      unusedImages.removeAt(randomIndex); // Удаление использованной картинки
    });
  }

  void addToFavorites() {
    if (currentPrediction.isNotEmpty &&
        !favoritePredictions.contains(currentPrediction)) {
      setState(() {
        favoritePredictions.add(currentPrediction);
      });
    }
  }

  void removeFromFavorites(String prediction) {
    setState(() {
      favoritePredictions.remove(prediction);
    });
  }

  void addNewPrediction(String prediction) {
    if (prediction.isNotEmpty) {
      setState(() {
        if (!allPredictions.contains(prediction)) {
          allPredictions.add(prediction);
          unusedPredictions.add(prediction);
        }
      });
      predictionController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Шар предсказаний'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black45,
              ),
              child: Text(
                'Меню',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
            ListTile(
              title: Text('Избранные предсказания'),
              onTap: () {
                Navigator.pop(context); // Закрываем боковое меню
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Избранные предсказания'),
                      content: Container(
                        width: double.maxFinite,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: favoritePredictions.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(favoritePredictions[index]),
                              trailing: IconButton(
                                icon: Icon(Icons.star),
                                onPressed: () => removeFromFavorites(
                                    favoritePredictions[index]),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            ListTile(
              title: Text('Все предсказания'),
              onTap: () {
                Navigator.pop(context); // Закрываем боковое меню
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Все предсказания'),
                      content: Container(
                        width: double.maxFinite,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: allPredictions.length,
                          itemBuilder: (context, index) {
                            final prediction = allPredictions[index];
                            final isFavorite =
                                favoritePredictions.contains(prediction);

                            return ListTile(
                              title: Row(
                                children: [
                                  Expanded(
                                    child: Text(prediction),
                                  ),
                                  if (isFavorite) Icon(Icons.star),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            ListTile(
              title: Text('Добавить новое предсказание'),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: predictionController,
                decoration: InputDecoration(
                  hintText: 'Введите предсказание',
                ),
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                ),
                child: Text('Добавить', style: TextStyle(color: Colors.white)),
                onPressed: () => addNewPrediction(predictionController.text),
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              currentPrediction,
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                ),
                child: Text(
                  'Сгенерировать предсказание',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: generatePrediction,
              ),
            ),
            Image.asset(currentImage),
            SizedBox(height: 16),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black),
              ),
              child: Text(
                'Добавить в избранное',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: addToFavorites,
            ),
          ],
        ),
      ),
    );
  }
}
