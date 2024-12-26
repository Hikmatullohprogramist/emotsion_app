import 'package:flutter/material.dart';

void main() => runApp(const EmotionsApp());

class EmotionsApp extends StatelessWidget {
  const EmotionsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: const LoginPage(),
    );
  }
}

class EmotionsListPage extends StatelessWidget {
  const EmotionsListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.indigo[100]!, Colors.white],
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: const Text(
                  'Emotsiyalar',
                  style: TextStyle(color: Colors.black87),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.person, color: Colors.black87),
                    onPressed: () {
                      // Implement profile page
                    },
                  ),
                ],
              ),
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.85,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      final emotion = emotions[index];
                      return EmotionCard(emotion: emotion);
                    },
                    childCount: emotions.length,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

}
}

class EmotionCard extends StatelessWidget {
  final Emotion emotion;

  const EmotionCard({Key? key, required this.emotion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EmotionDetailPage(emotion: emotion),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: emotion.color.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              emotion.icon,
              size: 48,
              color: emotion.color,
            ),
            const SizedBox(height: 12),
            Text(
              emotion.nameUz,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              emotion.nameEn,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class EmotionDetailPage extends StatelessWidget {
  final Emotion emotion;

  const EmotionDetailPage({Key? key, required this.emotion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [emotion.color.withOpacity(0.2), Colors.white],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Icon(
                        emotion.icon,
                        size: 80,
                        color: emotion.color,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        emotion.nameUz,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            LanguageRow(
                              language: '🌐',
                              text: emotion.nameEn,
                            ),
                            const Divider(),
                            LanguageRow(
                              language: '🇷🇺',
                              text: emotion.nameRu,
                            ),
                            const Divider(),
                            LanguageRow(
                              language: '🇹🇷',
                              text: emotion.nameTr,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Text(
                          emotion.description,
                          style: const TextStyle(
                            fontSize: 16,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LanguageRow extends StatelessWidget {
  final String language;
  final String text;

  const LanguageRow({
    Key? key,
    required this.language,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(
            language,
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Emotion {
  final int id;
  final String nameEn;
  final String nameRu;
  final String nameUz;
  final String nameTr;
  final Color color;
  final IconData icon;
  final String description;

  const Emotion({
    required this.id,
    required this.nameEn,
    required this.nameRu,
    required this.nameUz,
    required this.nameTr,
    required this.color,
    required this.icon,
    required this.description,
  });
}

// Emotsiyalar ro'yxati
final List<Emotion> emotions = [
  Emotion(
    id: 1,
    nameEn: 'Admiration',
    nameRu: 'Восхищение',
    nameUz: 'Shavq',
    nameTr: 'Hayranlık',
    color: Colors.amber,
    icon: Icons.star,
    description: 'Kimningdir yoki nimanidir yuqori baholash, qoyil qolish hissi. Bu his ijobiy motivatsiya beradi va yangi maqsadlarga ilhomlantiradi.',
  ),
  Emotion(
    id: 2,
    nameEn: 'Terror',
    nameRu: 'Ужас',
    nameUz: 'Dahshat',
    nameTr: 'Dehşet',
    color: Colors.purple[900]!,
    icon: Icons.warning_rounded,
    description: 'Kuchli qo\'rquv hissi. Juda katta xavf yoki tahdid oldida paydo bo\'ladi. Yurak urishi tezlashadi va adrenalin ko\'payadi.',
  ),
  Emotion(
    id: 3,
    nameEn: 'Amazement',
    nameRu: 'Изумление',
    nameUz: 'Hayrat',
    nameTr: 'Şaşkınlık',
    color: Colors.cyan,
    icon: Icons.emoji_emotions,
    description: 'Kutilmagan voqea yoki hodisa oldidagi hayratlanish hissi. Miyada dopamin ishlab chiqarilishini oshiradi.',
  ),
  Emotion(
    id: 4,
    nameEn: 'Grief',
    nameRu: 'Горе',
    nameUz: 'Qayg\'u',
    nameTr: 'Keder',
    color: Colors.grey[800]!,
    icon: Icons.sentiment_very_dissatisfied,
    description: 'Chuqur qayg\'u va yo\'qotish hissi. Og\'ir yo\'qotish yoki muvaffaqiyatsizlik natijasida paydo bo\'ladi.',
  ),
  Emotion(
    id: 5,
    nameEn: 'Loathing',
    nameRu: 'Глубокое отвращение',
    nameUz: 'Nafratlanish',
    nameTr: 'Tiksinti',
    color: Colors.brown,
    icon: Icons.mood_bad,
    description: 'Kuchli nafrat va jirkanish hissi. Noxush hodisa yoki vaziyatlarga nisbatan paydo bo\'ladi.',
  ),
  Emotion(
    id: 6,
    nameEn: 'Rage',
    nameRu: 'Гнев',
    nameUz: 'Qahr',
    nameTr: 'Hiddet',
    color: Colors.red[900]!,
    icon: Icons.whatshot,
    description: 'Kuchli g\'azab va jahllanish. Adolatsizlik yoki haqorat oldida paydo bo\'ladigan kuchli salbiy his.',
  ),
  Emotion(
    id: 7,
    nameEn: 'Vigilance',
    nameRu: 'Настороженность',
    nameUz: 'Hushyorlik',
    nameTr: 'Uyanıklık',
    color: Colors.orange,
    icon: Icons.visibility,
    description: 'Sergaklik va ehtiyotkorlik hissi. Xavfli vaziyatlarda paydo bo\'ladigan himoya mexanizmi.',
  ),
  Emotion(
    id: 8,
    nameEn: 'Ecstasy',
    nameRu: 'Восторг',
    nameUz: 'Zavq',
    nameTr: 'Coşku',
    color: Colors.pink,
    icon: Icons.celebration,
    description: 'Kuchli quvonch va hayajon hissi. Miyada endorfin va serotonin ishlab chiqarilishini oshiradi.',
  ),
  Emotion(
    id: 9,
    nameEn: 'Joy',
    nameRu: 'Радость',
    nameUz: 'Quvonch',
    nameTr: 'Neşe',
    color: Colors.yellow,
    icon: Icons.sentiment_very_satisfied,
    description: 'Yoqimli va ijobiy his-tuyg\'u. Muvaffaqiyat va baxt paytida paydo bo\'ladi.',
  ),
  Emotion(
    id: 10,
    nameEn: 'Trust',
    nameRu: 'Доверие',
    nameUz: 'Ishonch',
    nameTr: 'Güven',
    color: Colors.green,
    icon: Icons.handshake,
    description: 'Ishonch va xotirjamlik hissi. Boshqalar bilan mustahkam munosabatlar o\'rnatishga yordam beradi.',
  ),
  Emotion(
    id: 11,
    nameEn: 'Fear',
    nameRu: 'Страх',
    nameUz: 'Qo\'rquv',
    nameTr: 'Korku',
    color: Colors.purple,
    icon: Icons.close_fullscreen,
    description: 'Xavf yoki tahdid oldidagi himoya reaktsiyasi. Organizmni "qoch yoki kurash" holatiga tayyorlaydi.',
  ),
  Emotion(
    id: 12,
    nameEn: 'Surprise',
    nameRu: 'Удивление',
    nameUz: 'Ajablanish',
    nameTr: 'Sürpriz',
    color: Colors.blue,
    icon: Icons.nature_people,
    description: 'Kutilmagan voqea-hodisalarga nisbatan paydo bo\'ladigan his. Qisqa muddatli va o\'tkinchi bo\'lishi mumkin.',
  ),
  Emotion(
    id: 13,
    nameEn: 'Sadness',
    nameRu: 'Грусть',
    nameUz: 'G\'amginlik',
    nameTr: 'Üzüntü',
    color: Colors.blueGrey,
    icon: Icons.sentiment_dissatisfied,
    description: 'Yo\'qotish yoki muvaffaqiyatsizlik natijasida paydo bo\'ladigan salbiy his-tuyg\'u.',
  ),
  Emotion(
    id: 14,
    nameEn: 'Disgust',
    nameRu: 'Отвращение',
    nameUz: 'Nafratlanish',
    nameTr: 'İğrenme',
    color: Colors.green[900]!,
    icon: Icons.sick,
    description: 'Jirkanish va yoqtirmaslik hissi. Noxush hodisalar yoki narsalarga nisbatan paydo bo\'ladi.',
  ),
  Emotion(
    id: 15,
    nameEn: 'Anger',
    nameRu: 'Злость',
    nameUz: 'G\'azab',
    nameTr: 'Öfke',
    color: Colors.red,
    icon: Icons.sentiment_very_dissatisfied,
    description: 'G\'azab va jahllanish hissi. Stress gormonlari darajasining oshishi bilan bog\'liq.',
  ),
  Emotion(
    id: 16,
    nameEn: 'Anticipation',
    nameRu: 'Ожидание',
    nameUz: 'Oldindan sezish',
    nameTr: 'Beklenti',
    color: Colors.teal,
    icon: Icons.update,
    description: 'Kutish va umid bilan bog\'liq his-tuyg\'u. Kelajakdagi voqealarga tayyorgarlik ko\'rish bilan bog\'liq.',
  ),
  Emotion(
    id: 17,
    nameEn: 'Serenity',
    nameRu: 'Безмятежность',
    nameUz: 'Hotirjamlik',
    nameTr: 'Sakinlik',
    color: Colors.lightBlue,
    icon: Icons.spa,
    description: 'Tinchlik va xotirjamlik hissi. Stress gormonlari past darajada bo\'lgan holatdir.',
  ),
  Emotion(
    id: 18,
    nameEn: 'Acceptance',
    nameRu: 'Признание',
    nameUz: 'Ma\'qullash',
    nameTr: 'Kabul',
    color: Colors.lightGreen,
    icon: Icons.check_circle,
    description: 'Vaziyatni qabul qilish va ko\'nikish hissi. Moslashish qobiliyati bilan bog\'liq.',
  ),
  Emotion(
    id: 19,
    nameEn: 'Apprehension',
    nameRu: 'Опасение',
    nameUz: 'Vahima',
    nameTr: 'Endişe',
    color: Colors.deepPurple,
    icon: Icons.help_outline,
    description: 'Xavotir va noaniqlik hissi. Kelajakdagi noma\'lum vaziyatlar oldidagi bezovtalik.',
  ),
  Emotion(
    id: 20,
    nameEn: 'Distraction',
    nameRu: 'Рассеянность',
    nameUz: 'Chalg\'ish',
    nameTr: 'Dalgınlık',
    color: Colors.grey,
    icon: Icons.blur_on,
    description: 'Diqqatning tarqoqligi va e\'tiborsizlik holati. Stress yoki charchoq natijasida paydo bo\'lishi mumkin.',
  ),
  Emotion(
    id: 21,
    nameEn: 'Pensiveness',
    nameRu: 'Задумчивость',
    nameUz: 'O\'ychanlik',
    nameTr: 'Düşüncelilik',
    color: Colors.indigo,
    icon: Icons.psychology,
    description: 'Chuqur o\'ylarga cho\'mish holati. Muhim qarorlar qabul qilish paytida paydo bo\'ladi.',
  ),
  Emotion(
    id: 22,
    nameEn: 'Boredom',
    nameRu: 'Скука',
    nameUz: 'Zerikish',
    nameTr: 'Can sıkıntısı',
    color: Colors.grey[500]!,
    icon: Icons.schedule,
    description: 'Qiziqishning yo\'qligi va motivatsiyaning pastligi. Bir xil yoki stimulsiz vaziyatlarda paydo bo\'ladi.',
  ),
  Emotion(
    id: 23,
    nameEn: 'Annoyance',
    nameRu: 'Досада',
    nameUz: 'Bezovtalik',
    nameTr: 'Rahatsızlık',
    color: Colors.deepOrange,
    icon: Icons.thumb_down,
    description: 'Yengil g\'azab va norozilik hissi. Kichik xalaqitlar yoki noqulayliklar tufayli paydo bo\'ladi.',
  ),
  Emotion(
    id: 24,
    nameEn: 'Interest',
    nameRu: 'Интерес',
    nameUz: 'Qiziqish',
    nameTr: 'İlgi',
    color: Colors.lime,
    icon: Icons.lightbulb,
    description: 'Biror narsa yoki hodisaga bo\'lgan qiziqish hissi. O\'rganish va rivojlanishga undaydi.',
  ),
  Emotion(
    id: 25,
    nameEn: 'Love',
    nameRu: 'Любовь',
    nameUz: 'Sevgi',
    nameTr: 'Aşk',
    color: Colors.pink[300]!,
    icon: Icons.favorite,
    description: 'Chuqur mehr va yaqinlik hissi. Oksitotsin va dopamin gormonlari bilan bog\'liq.',
  ),
  Emotion(
    id: 26,
    nameEn: 'Submission',
    nameRu: 'Покорность',
    nameUz: 'Kamtarlik',
    nameTr: 'Boyun eğme',
    color: Colors.brown[300]!,
    icon: Icons.person_outline,
    description: 'Bo\'ysunish va itoat qilish hissi. Ijtimoiy ierarxiya va munosabatlarda muhim rol o\'ynaydi.',
  ),
  Emotion(
    id: 27,
    nameEn: 'Awe',
    nameRu: 'Трепет',
    nameUz: 'Hayrat aralash xavotir',
    nameTr: 'Hayranlık',
    color: Colors.deepPurple[300]!,
    icon: Icons.auto_awesome,
    description: 'Hayrat va hurmat aralash qo\'rquv hissi. Ulug\'vor yoki qudratli narsalar oldida paydo bo\'ladi.',
  ),
  Emotion(
    id: 28,
    nameEn: 'Disapproval',
    nameRu: 'Неодобрение',
    nameUz: 'Norozilik',
    nameTr: 'Onaylamama',
    color: Colors.red[300]!,
    icon: Icons.thumb_down,
    description: 'Norozilik va ma\'qullamaslik hissi. Qabul qilib bo\'lmaydigan vaziyat yoki xatti-harakatlarga nisbatan paydo bo\'ladi.',
  ),
  Emotion(
    id: 29,
    nameEn: 'Remorse',
    nameRu: 'Раскаяние',
    nameUz: 'Afsus',
    nameTr: 'Pişmanlık',
    color: Colors.blueGrey[300]!,
    icon: Icons.mood_bad,
    description: 'Afsuslanish va pushaymonlik hissi. Noto\'g\'ri qaror yoki xatti-harakat natijasida paydo bo\'ladi.',
  ),];
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.indigo[400]!, Colors.purple[300]!],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.psychology,
                    size: 80,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'Emotsiyalar Lug\'ati',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 48),
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              prefixIcon: Icon(Icons.email),
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Emailni kiriting';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: 'Parol',
                              prefixIcon: Icon(Icons.lock),
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Parolni kiriting';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const EmotionsListPage(),
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Kirish',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextButton(
                            onPressed: () {
                              // Implement registration
                            },
                            child: const Text('Ro\'yxatdan o\'tish'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
