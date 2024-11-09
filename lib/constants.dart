enum MovieGenres {
  Action(28),
  Adventure(12),
  Animation(16),
  Comedy(35),
  Crime(80),
  Documentary(99),
  Drama(18),
  Family(10751),
  Fantasy(14),
  History(36),
  Horror(27),
  Music(10402),
  Mystery(9648),
  Romance(10749),
  ScienceFiction(878),
  TVMovie(10770),
  Thriller(53),
  War(10752),
  Western(37),
  None(0);

  final int id;

  const MovieGenres(this.id);
}

enum SerieGenres {
  ActionAdventure(10759),
  Animation(16),
  Comedy(35),
  Crime(80),
  Documentary(99),
  Drama(18),
  Family(10751),
  Kids(10762),
  Mystery(9648),
  News(10763),
  Reality(10764),
  SciFiFantasy(10765),
  Soap(10766),
  Talk(10767),
  WarPolitics(10768),
  Western(37),
  None(0);

  final int id;

  const SerieGenres(this.id);
}

List<String> months = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December'
];