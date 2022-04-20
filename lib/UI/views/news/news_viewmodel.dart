import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

class NewsViewModel extends BaseViewModel {
  NewsViewModel(BuildContext context);
  int selectedIndex = 0;

  void onTapBottomBar(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  Future onReady() async {}

  List<String> newsName = [
    '23 апреля в Кемеровском государственном университете состоится день открытых дверей',
    'Институт биологии, экологии и природных ресурсов – победитель фестиваля творчества студентов «Студвесна в КемГУ» 2022 года',
    'В КемГУ подвели итоги конкурса с международным участием «Космическая история России»',
    'В КемГУ стартовали курсы повышения квалификации для муниципальных служащих и работников предприятий Кузбасса по вопросам концессионных соглашений',
    'В 2022 году институт цифры Кемеровского госуниверситета будет осуществлять набор на обучение по IT-направлениям',
    '14 тысяч молодых ученых из России и зарубежных стран участвуют в работе XVIII Международного молодежного научного форума «Ломоносов – 2022»'
  ];
  List<String> newsPhoto = [
    'images/1.jpg',
    'images/2.jpg',
    'images/3.jpg',
    'images/4.jpg',
    'images/5.jpg',
    'images/6.jpg',
  ];
  List<String> newsDate = [
    '14.04.2022',
    '14.04.2022',
    '13.04.2022',
    '13.04.2022',
    '13.04.2022',
    '13.04.2022',
  ];
}
