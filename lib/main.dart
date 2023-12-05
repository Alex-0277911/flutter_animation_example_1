import 'package:flutter/material.dart';
import 'dart:math' show pi;

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.dark),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

/* контролер анімації
  0 - початкова точка положення об'єкта
  1 - кінцева точка положення об'єкта
  контролер анімації дозволяє провести об'єкт з точки 0 в точку 1 за
  деякий час, тобто час анімації об'єкта (переміщення з точки 0 в точку 1)

  в нашому випадку:
  початок 0.0 = в градусах це 0 градусів
  середина 0.5 = в градусах це 180 градусів (середина повороту - середина анімації)
  кінець 1.0 = в градусах це 360 градусів (тобто повний оберт об'єкта навколо ОСІ) 

  */

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  // змінна контроллер анімації
  late AnimationController _controller;
  //змінна самої анімаціі
  late Animation<double> _animation;

  @override
  // викликається при створенні віджета сторінки
  void initState() {
    super.initState();
    _controller = AnimationController(
        // параметр відповідає за те з чим буде синхронізуватися анімація
        // в нашому випадку додаємо до _HomePageState with SingleTickerProviderStateMixin
        vsync: this,
        duration: const Duration(seconds: 2));
    // створюємо анімацію
    _animation = Tween<double>(begin: 0.0, end: 2 * pi).animate(_controller);
    // запуcкаємо контроллер анімації в постійний повтор
    _controller.repeat();
  }

  // вікликається при знищенні віджета сторінки
  @override
  void dispose() {
    // знищуємо контроллер анімації
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform(
              // анімація трансформується навколо центра фігури віджета
              alignment: Alignment.center,
              transform: Matrix4.identity()..rotateY(_animation.value),
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ]),
              ),
            );
          },
        ),
      ),
    );
  }
}
