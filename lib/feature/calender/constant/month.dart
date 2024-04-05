class Month {
  static const baishakh = 'वैशाख';
  static const jestha = 'ज्येष्ठ';
  static const ashad = 'अषाढ';
  static const shrawan = 'श्रावण';
  static const bhadra = 'भाद्र';
  static const ashwin = 'आश्विन	';
  static const kartik = 'कार्तिक';
  static const mansir = 'मार्गशीर्ष';
  static const push = 'पौष';
  static const magh = 'माघ';
  static const phagun = 'फाल्गुण';
  static const chaitra = 'चैत्र';

  static const baishakhEn = 'Baishakh';
  static const jesthaEn = 'Jestha';
  static const ashadEn = 'Ashad';
  static const shrawanEn = 'Shrawan';
  static const bhadraEn = 'Bhadra';
  static const ashwinEn = 'Ashwin';
  static const kartikEn = 'Kartik';
  static const mangsirEn = 'Mangsir';
  static const poushEn = 'Poush';
  static const maghEn = 'Magh';
  static const falgunEn = 'Falgun';
  static const chaitraEn = 'Chaitra';

  static const List<String> monthList = [
    baishakh,
    jestha,
    ashad,
    shrawan,
    bhadra,
    ashwin,
    kartik,
    mansir,
    push,
    magh,
    phagun,
    chaitra,
  ];

  static List<String> monthsListEn = [
    baishakhEn,
    jesthaEn,
    ashadEn,
    shrawanEn,
    bhadraEn,
    ashwinEn,
    kartikEn,
    mangsirEn,
    poushEn,
    maghEn,
    falgunEn,
    chaitraEn,
  ];

  static getMonthIndex(String month) {
    switch (month) {
      case baishakhEn:
        return 0;

      case jesthaEn:
        return 1;
      case ashadEn:
        return 2;

      case shrawanEn:
        return 3;
      case bhadraEn:
        return 4;
      case ashwinEn:
        return 5;
      case kartikEn:
        return 6;
      case mangsirEn:
        return 7;
      case poushEn:
        return 8;
      case maghEn:
        return 9;
      case falgunEn:
        return 10;
      case chaitraEn:
        return 11;
    }
  }
}
