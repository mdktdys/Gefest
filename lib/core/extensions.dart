extension Tools on int {
  toWeekName() => [
        'Понедельник',
        'Вторник',
        'Среда',
        'Четверг',
        'Пятница',
        'Суббота',
        'Воскресенье'
      ][this-1];
}

extension Toolss on DateTime{
  formatDDMMYY() => "$day.$month.${  year.toString().substring(2,4) }";
}