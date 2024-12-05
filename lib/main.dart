import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';




// import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 3; // Índice de la página principal

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Multitask',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: Colors.greenAccent,
        scaffoldBackgroundColor: Colors.lightBlue.shade50,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.teal),
          bodyLarge: TextStyle(color: Colors.teal),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.lightBlue,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.white70,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Multitask',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          elevation: 4,
        ),
        body: Center(
          child: _buildCurrentView(), // Mostrar la vista actual según el índice
        ),
        bottomNavigationBar: MyBottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }

  Widget _buildCurrentView() {
    switch (_currentIndex) {
      case 0:
        return const GenderView();
      case 1:
        return const AgeView();
      case 2:
        return const UniversityView();
      case 3:
        return const HomeView();
      case 4:
        return const WeatherView();
      case 5:
        return const NewsView();
      case 6:
        return AboutView(
          onTabTapped: (int index) {},
        );
      default:
        return Container();
    }
  }
}


class GenderView extends StatefulWidget {
  const GenderView({super.key});

  @override
  _GenderViewState createState() => _GenderViewState();
}

class _GenderViewState extends State<GenderView> {
  final List<String> tasks = []; // Lista de tareas
  final TextEditingController taskController = TextEditingController();

  void addTask() {
    if (taskController.text.isNotEmpty) {
      setState(() {
        tasks.add(taskController.text);
        taskController.clear(); // Limpiar el campo de texto
      });
    }
  }

  void removeTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Reminder'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: taskController,
                    decoration: const InputDecoration(
                      hintText: 'Enter a task',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: addTask,
                  child: const Text('Add'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(tasks[index]),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Color.fromARGB(255, 10, 255, 235)),
                      onPressed: () => removeTask(index),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class AgeView extends StatefulWidget {
  const AgeView({super.key});

  @override
  _AgeViewState createState() => _AgeViewState();
}

class _AgeViewState extends State<AgeView> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  String _bmiResult = '';
  String _bmiCategory = '';

  void calculateBMI() {
    final double? height = double.tryParse(_heightController.text);
    final double? weight = double.tryParse(_weightController.text);

    if (height == null || weight == null || height <= 0 || weight <= 0) {
      setState(() {
        _bmiResult = 'Please enter valid values.';
        _bmiCategory = '';
      });
      return;
    }

    final double bmi = weight / ((height / 100) * (height / 100));
    setState(() {
      _bmiResult = 'Your BMI is ${bmi.toStringAsFixed(1)}';
      _bmiCategory = getBMICategory(bmi);
    });
  }

  String getBMICategory(double bmi) {
    if (bmi < 18.5) {
      return 'Underweight';
    } else if (bmi >= 18.5 && bmi < 24.9) {
      return 'Normal weight';
    } else if (bmi >= 25 && bmi < 29.9) {
      return 'Overweight';
    } else {
      return 'Obesity';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Enter your height (cm):',
              style: TextStyle(fontSize: 16),
            ),
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Height in centimeters',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Enter your weight (kg):',
              style: TextStyle(fontSize: 16),
            ),
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Weight in kilograms',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateBMI,
              child: const Text('Calculate BMI'),
            ),
            const SizedBox(height: 20),
            Text(
              _bmiResult,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            if (_bmiCategory.isNotEmpty)
              Text(
                _bmiCategory,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue,
                ),
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}



class UniversityView extends StatefulWidget {
  const UniversityView({super.key});

  @override
  State<UniversityView> createState() => _UniversityViewState();
}

class _UniversityViewState extends State<UniversityView> {
  final Map<String, List<Map<String, String>>> muscleExercises = {
  "Pecho": [
    {
      "name": "Press de banca",
      "description": "Un ejercicio compuesto que trabaja principalmente los músculos del pecho.",
      "imageUrl": "https://via.placeholder.com/150"
      },
    {
      "name": "Aperturas con mancuernas",
      "description": "Ejercicio de aislamiento que se enfoca en el desarrollo del pecho.",
      "imageUrl": "https://via.placeholder.com/150"
      },
    {
      "name": "Flexiones",
      "description": "Un clásico ejercicio corporal que fortalece el pecho.",
      "imageUrl": "https://via.placeholder.com/150"
      },
    {
      "name": "Press inclinado",
      "description": "Trabaja la parte superior del pecho para un desarrollo completo.",
      "imageUrl": "https://via.placeholder.com/150"
    },
  ],
  "Cuádriceps": [
    {
      "name": "Sentadillas",
      "description": "El rey de los ejercicios para piernas, ideal para cuádriceps.",
      "imageUrl": "https://via.placeholder.com/150"
    },
    {
      "name": "Prensa de piernas",
      "description": "Un ejercicio excelente para trabajar los cuádriceps con seguridad.",
      "imageUrl": "https://via.placeholder.com/150"
    },
    {
      "name": "Estocadas",
      "description": "Ayuda a fortalecer y tonificar los cuádriceps.",
      "imageUrl": "https://via.placeholder.com/150"
    },
    {
      "name": "Extensiones de pierna",
      "description": "Un movimiento de aislamiento para los cuádriceps.",
      "imageUrl": "https://via.placeholder.com/150"
    },
  ],
  "Femorales": [
    {
      "name": "Peso muerto",
      "description": "Trabaja los femorales y glúteos, ideal para fuerza y masa muscular.",
      "imageUrl": "https://via.placeholder.com/150"
    },
    {
      "name": "Curl femoral",
      "description": "Ejercicio de aislamiento para fortalecer los músculos femorales.",
      "imageUrl": "https://via.placeholder.com/150"
    },
    {
      "name": "Buenos días",
      "description": "Ejercicio avanzado que estira y fortalece los femorales.",
      "imageUrl": "https://via.placeholder.com/150"
    },
  ],
  "Pantorrillas": [
    {
      "name": "Elevaciones de talones",
      "description": "Ejercicio básico para fortalecer las pantorrillas.",
      "imageUrl": "https://via.placeholder.com/150"
    },
    {
      "name": "Elevación de talones sentado",
      "description": "Se enfoca en las fibras más profundas de las pantorrillas.",
      "imageUrl": "https://via.placeholder.com/150"
    },
  ],
  "Espalda": [
    {
      "name": "Dominadas",
      "description": "Un ejercicio clave para trabajar la espalda y los bíceps.",
      "imageUrl": "https://via.placeholder.com/150"
    },
    {
      "name": "Remo con barra",
      "description": "Fortalece toda la musculatura de la espalda media.",
      "imageUrl": "https://via.placeholder.com/150"
    },
    {
      "name": "Pulldown en polea",
      "description": "Alternativa a las dominadas para la espalda alta.",
      "imageUrl": "https://via.placeholder.com/150"
    },
  ],
  "Hombro": [
    {
      "name": "Press militar",
      "description": "El mejor ejercicio para desarrollar los hombros.",
      "imageUrl": "https://via.placeholder.com/150"
    },
    {
      "name": "Elevaciones laterales",
      "description": "Se enfoca en el deltoides medio para ancho de hombros.",
      "imageUrl": "https://via.placeholder.com/150"
    },
    {
      "name": "Elevaciones frontales",
      "description": "Trabaja el deltoides frontal.",
      "imageUrl": "https://via.placeholder.com/150"
    },
  ],
  "Bíceps": [
    {
      "name": "Curl con barra",
      "description": "El ejercicio clásico para desarrollar los bíceps.",
      "imageUrl": "https://via.placeholder.com/150"
    },
    {
      "name": "Curl con mancuernas",
      "description": "Permite trabajar cada brazo de forma independiente.",
      "imageUrl": "https://via.placeholder.com/150"
    },
    {
      "name": "Curl martillo",
      "description": "Se enfoca en el braquioradial y el braquial.",
      "imageUrl": "https://via.placeholder.com/150"
    },
  ],
  "Tríceps": [
    {
      "name": "Fondos en paralelas",
      "description": "Un ejercicio compuesto ideal para los tríceps.",
      "imageUrl": "https://via.placeholder.com/150"
    },
    {
      "name": "Extensiones en polea",
      "description": "Ejercicio de aislamiento para los tríceps.",
      "imageUrl": "https://via.placeholder.com/150"
    },
    {
      "name": "Press francés",
      "description": "Trabaja intensamente la cabeza larga del tríceps.",
      "imageUrl": "https://via.placeholder.com/150"
    },
  ],
};


  String selectedMuscle = "Pecho"; // Músculo seleccionado por defecto

  @override
  Widget build(BuildContext context) {
    final exercises = muscleExercises[selectedMuscle]!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercises by Muscle'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButton<String>(
              value: selectedMuscle,
              isExpanded: true,
              items: muscleExercises.keys.map((muscle) {
                return DropdownMenuItem(
                  value: muscle,
                  child: Text(muscle),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedMuscle = value!;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: exercises.length,
              itemBuilder: (context, index) {
                final exercise = exercises[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: ListTile(
                    title: Text(exercise["name"]!),
                    leading: const Icon(Icons.fitness_center),
                    onTap: () {
                      showExerciseDetails(
                        context,
                        exercise["name"]!,
                        exercise["description"]!,
                        exercise["imageUrl"]!,
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void showExerciseDetails(
      BuildContext context, String name, String description, String imageUrl) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(name),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(imageUrl),
              const SizedBox(height: 10),
              Text(description),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}


class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.asset(
              'assets/images/logo.webp', // Ruta dentro de la carpeta 'assets'
              width: 350,
              height: 350,
            ),
          ),
          const SizedBox(height: 25),
          const Text(
            'Multitask app get inform get in form',
            style: TextStyle(fontSize: 24),
          ),
        ],
      ),
    );
  }
}




class WeatherView extends StatefulWidget {
  const WeatherView({super.key});

  @override
  _WeatherViewState createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  String cityName = '';
  String countryAbbreviation = '';
  String weatherMain = '';
  String weatherDescription = '';
  String weatherIcon = '';
  double temperature = 0.0;

  Future<void> fetchWeather() async {
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=Santo+Domingo,Dominican+Republic&APPID=2287f61ff3dfa5855c50d1726c3c361c');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      setState(() {
        cityName = data['name'];
        countryAbbreviation = data['sys']['country'];
        weatherMain = data['weather'][0]['main'];
        weatherDescription = data['weather'][0]['description'];
        weatherIcon = data['weather'][0]['icon'];
        temperature = (data['main']['temp'] - 273.15); // Convert to Celsius
      });
    } else {
      setState(() {
        cityName = '';
        countryAbbreviation = '';
        weatherMain = '';
        weatherDescription = '';
        weatherIcon = '';
        temperature = 0.0;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Weather'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                cityName,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    countryAbbreviation,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    getCountryFlag(countryAbbreviation),
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                weatherMain,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Image.network(
                getWeatherIconUrl(weatherIcon),
                width: 64,
                height: 64,
              ),
              const SizedBox(height: 8),
              Text(
                weatherDescription,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '${temperature.toStringAsFixed(1)}°C',
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ));
  }

  String getCountryFlag(String countryCode) {
    const flagOffset = 0x1F1E6;
    const asciiOffset = 0x41;

    final firstChar = countryCode.codeUnitAt(0) - asciiOffset + flagOffset;
    final secondChar = countryCode.codeUnitAt(1) - asciiOffset + flagOffset;

    return String.fromCharCode(firstChar) + String.fromCharCode(secondChar);
  } 
}
String getWeatherIconUrl(String iconCode) {
  if (iconCode.isEmpty) {
    return 'https://via.placeholder.com/64'; // Imagen de marcador en caso de error
  }
  return 'https://openweathermap.org/img/wn/$iconCode@2x.png';
}


class NewsView extends StatefulWidget {
  const NewsView({super.key});

  @override
  _NewsViewState createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  List<NewsItem> newsItems = [];
  String errorMessage = '';
  bool isLoading = true;

  Future<void> fetchNews() async {
    final url = Uri.parse('https://elnuevodiario.com.do/wp-json/wp/v2/posts');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        List<NewsItem> fetchedNewsItems = [];

        for (var newsData in data) {
          if (newsData['yoast_head_json'] != null) {
            final title = newsData['yoast_head_json']['title'] ?? 'No Title';
            final description = newsData['yoast_head_json']['og_description'] ?? 'No Description';
            final url = newsData['yoast_head_json']['og_url'] ?? '';
            final imageUrl = (newsData['yoast_head_json']['og_image'] != null &&
                    newsData['yoast_head_json']['og_image'].isNotEmpty)
                ? newsData['yoast_head_json']['og_image'][0]['url']
                : 'https://via.placeholder.com/150';

            final newsItem = NewsItem(
              title: title,
              description: description,
              url: url,
              imageUrl: imageUrl,
            );

            fetchedNewsItems.add(newsItem);
          }
        }

        setState(() {
          newsItems = fetchedNewsItems;
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Failed to load news. Status code: ${response.statusCode}';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error fetching news: $e';
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  void openNewsURL(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(
                  child: Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
                )
              : ListView.builder(
                  itemCount: newsItems.length,
                  itemBuilder: (context, index) {
                    final newsItem = newsItems[index];

                    return Card(
                      margin: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: Image.network(
                          newsItem.imageUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(newsItem.title),
                        subtitle: Text(
                          newsItem.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        onTap: () {
                          openNewsURL(newsItem.url);
                        },
                      ),
                    );
                  },
                ),
    );
  }
}

class NewsItem {
  final String title;
  final String description;
  final String url;
  final String imageUrl;

  NewsItem({
    required this.title,
    required this.description,
    required this.url,
    required this.imageUrl,
  });
}

class AboutView extends StatefulWidget {
  final Function(int) onTabTapped;

  const AboutView({super.key, required this.onTabTapped});

  @override
  _AboutViewState createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView> {
  String username = '';
  String fullName = '';
  String email = '';
  String avatarUrl = '';
  List<String> repositories = [];

  Future<void> fetchGitHubProfile() async {
    const username = 'SoyZequi'; // Reemplaza con tu nombre de usuario de GitHub
    final url = Uri.parse('https://api.github.com/users/SoyZequi');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      setState(() {
        this.username = data['login'];
        fullName = data['name'];
        email = data['email'] ?? 'N/A';
        avatarUrl = data['avatar_url'];
      });

      await fetchGitHubRepositories(username);
    } else {
      setState(() {
        this.username = '';
        fullName = '';
        email = '';
        avatarUrl = '';
        repositories = [];
      });
    }
  }

  Future<void> fetchGitHubRepositories(String username) async {
    final url = Uri.parse('https://api.github.com/users/$username/repos');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      setState(() {
        repositories = data
            .where((repo) =>
                repo['name'] != null) // Filtrar repositorios sin nombre
            .map((repo) =>
                repo['name'] as String) // Asignar nombre del repositorio
            .toList();
      });
    } else {
      setState(() {
        repositories = [];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchGitHubProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('About'),
        ),
        body: SingleChildScrollView(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 80,
                backgroundImage: NetworkImage(avatarUrl),
              ),
              const SizedBox(height: 16),
              Text(
                username,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                fullName,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.email),
                  const SizedBox(width: 8),
                  Text(email),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Repositories',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              if (repositories.isNotEmpty)
                Column(
                  children: repositories
                      .map(
                        (repo) => ListTile(
                          leading: const Icon(Icons.code),
                          title: Text(repo),
                        ),
                      )
                      .toList(),
                )
              else
                const Text(
                  'No repositories found.',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
            ],
          ),
        )));
  }
}

class MyBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const MyBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color.fromARGB(255, 18, 198, 45),
      currentIndex: currentIndex,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.check_box, color: Color.fromARGB(255, 21, 149, 45)),
          label: 'Task',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.monitor_weight, color:Color.fromARGB(255, 21, 149, 45)),
          label: 'IMC',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.sports_gymnastics, color: Color.fromARGB(255, 21, 149, 45)),
          label: 'EJERCICIOS',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home,
              color: Color.fromARGB(255, 54, 179, 182), size: 40),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.sunny, color: Color.fromARGB(255, 21, 149, 45)),
          label: 'Weather',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.article, color: Color.fromARGB(255, 21, 149, 45)),
          label: 'News',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.info, color: Color.fromARGB(255, 21, 149, 45)),
          label: 'About',
        ),
      ],
      selectedItemColor: const Color.fromARGB(255, 255, 255, 255),
    );
  }
}

class University {
  final String name;
  final String domain;
  final String webPage;

  University({
    required this.name,
    required this.domain,
    required this.webPage,
  });
}

