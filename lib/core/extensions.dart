extension Tools on int {
  toMonthName() => [
        'Январь',
        'Февраль',
        'Март',
        'Апрель',
        'Май',
        'Июнь',
        'Июль',
        'Август',
        'Сентябрь',
        'Октябрь',
        'Ноябрь',
        'Декабрь'
      ][this - 1];
      
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