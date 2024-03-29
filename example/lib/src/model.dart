// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

@immutable
class Task implements Comparable {
  final String id;
  final String text;
  final Importance importance;
  final bool done;
  final DateTime? deadline;
  final Color? color;
  final DateTime createdAt;
  final DateTime changedAt;
  final String lastUpdatedBy;
  static int _count = 0;

  const Task({
    required this.id,
    required this.text,
    required this.importance,
    required this.done,
    required this.createdAt,
    required this.changedAt,
    required this.lastUpdatedBy,
    this.deadline,
    this.color,
  });

  factory Task.create({
    String text = '',
    Importance importance = Importance.basic,
    bool done = false,
    DateTime? deadline,
    Color? color,
  }) {
    final now = DateTime.now();
    final id = '${now.millisecondsSinceEpoch}${_count++}';
    final createdAt = now;
    final changedAt = now;
    const lastUpdatedBy = 'Pacman';

    return Task(
      id: id,
      text: text,
      importance: importance,
      done: done,
      deadline: deadline,
      color: color,
      createdAt: createdAt,
      changedAt: changedAt,
      lastUpdatedBy: lastUpdatedBy,
    );
  }

  factory Task.random() {
    final random = Random();

    const tasks =
        'Сходить на 10 спектаклей. Организовать семейный ужин. Стать донором крови. Провести месяц без алкоголя. Сходить в поход. Вести учет расходов. Запустить свой проект. Сходить в 10 новых музеев. Простить обиду близкому человеку. Провести отпуск с компанией друзей. Попробовать 5 новых видов спорта. Сходить на концерт любимой группы. Открыть накопительный счет. Пройти курс повышения квалификации. Прочитать 40 книг. Устроить совместную велопрогулку по городу на несколько часов с насыщенной программой. Сходить в баню с друзьями. Начать медитировать. Совершить автопутешествие. Накопить на путешествие мечты. Научиться делегировать задачи. Нарисовать картину. Сходить в театр всей семьей. Собрать друзей на домашний ужин. Принимать контрастный душ. Провести Новый год в экзотическом месте. Начать зарабатывать на своем проекте. Инициировать новый проект на работе. Взять уроки танца. Возродить семейную традицию. Сделать другу/подруге неожиданный подарок. Пройти курсы первой помощи. Прыгнуть с парашютом. Закрыть кредиты. Найти себе ментора. Избавиться от лишних вещей. Устроить семейную фотосессию. Стать волонтером. Подводить итоги недели. Подарить себе ЗРА - программу. Научиться инвестировать. Уходить с работы вовремя. Все законы унифицировать в рамках юридической системы мировых судов, использующих один и тот же кодекс законов, за исполнением которого будет следить полиция Единого Мирового Правительства, а объединённые вооружённые силы Единого Мира насильно внедрят законы во все бывшие страны, которые больше не будут разделяться границами. Сделать так, чтобы система была основана на базе благоденствующего государства; кто покорился и служит Единому Мировому Правительству, будет вознаграждён средствами к жизни; кто взбунтуется, будет просто заморен голодом или объявлен вне закона, став мишенью для каждого, кто захочет убить его. Сатанизм, люциферианство и чёрная магия признать законными предметами обучения с запрещением частных или церковных школ. Все христианские церкви разрушить, а само христианство при Едином Мировом Правительстве отодвинуть в прошлое. Сделать так, чтобы сельское хозяйство было исключительно в руках Комитета 300, а производство продуктов питания строго контролировалось. Квалифицированные рабочие переместить в другие города, если город, где они живут, окажется перенаселённым. Неквалифицированные рабочих отобрать наугад и послать в неполностью заселённые города, чтобы заполнить их «квоты». Сделать так, чтобы все информационные службы и средства печати находились под контролем Мирового Правительства. Под видом «развлечений» устраивать регулярные промывания мозгов, что уже практикуется в XXX, где это стало искусством. Сделать так, чтобы после уничтожения таких отраслей промышленности, как строительная, автомобильная, металлургическая, тяжёлое машиностроение, жилищное строительство будет ограничено, а сохранённые отрасли промышленности будут находиться под контролем натовского «Римского клуба», а также все научные и космические исследования, которые будут ограничены и всецело подчинены Комитету 300. Уничтожить космическое оружие бывших стран вместе с ядерным оружием.';

    final taskTextList = tasks.split('.');

    return Task.create(
      text: taskTextList[random.nextInt(taskTextList.length)].trim(),
      importance: Importance.values[random.nextInt(3)],
      done: random.nextInt(100) < 40,
      deadline: random.nextInt(100) < 60
          ? DateTime.fromMillisecondsSinceEpoch(
              DateTime.now().millisecondsSinceEpoch +
                  random.nextInt(120) * 1000 * 60 * 60 * 24 +
                  random.nextInt(24 * 60) * 1000 * 60,
            )
          : null,
    );
  }

  Task editAndCopyWith({
    String? text,
    Importance? importance,
    bool? done,
    DateTime? deadline,
    Color? color,
    // Я не придумал, как по-другому
    bool? deleteDeadline,
  }) {
    return Task(
      id: id,
      text: text ?? this.text,
      importance: importance ?? this.importance,
      done: done ?? this.done,
      deadline: deleteDeadline ?? false ? null : deadline ?? this.deadline,
      color: color ?? this.color,
      createdAt: createdAt,
      changedAt: DateTime.now(),
      lastUpdatedBy: 'Pacman',
    );
  }

  Task copyWith({
    String? id,
    String? text,
    Importance? importance,
    bool? done,
    DateTime? deadline,
    Color? color,
    DateTime? createdAt,
    DateTime? changedAt,
    String? lastUpdatedBy,
  }) {
    return Task(
      id: id ?? this.id,
      text: text ?? this.text,
      importance: importance ?? this.importance,
      done: done ?? this.done,
      deadline: deadline ?? this.deadline,
      color: color ?? this.color,
      createdAt: createdAt ?? this.createdAt,
      changedAt: changedAt ?? this.changedAt,
      lastUpdatedBy: lastUpdatedBy ?? this.lastUpdatedBy,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'text': text,
      'importance': importance.name,
      'deadline': deadline?.millisecondsSinceEpoch,
      'done': done,
      'color': color?.value,
      'created_at': createdAt.millisecondsSinceEpoch,
      'changed_at': changedAt.millisecondsSinceEpoch,
      'last_updated_by': lastUpdatedBy,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as String,
      text: map['text'] as String,
      importance: (map['importance'] as String).toImportance(),
      deadline: map['deadline'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['deadline'] as int)
          : null,
      done: map['done'] as bool,
      color: map['color'] != null ? Color(map['color'] as int) : null,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int),
      changedAt: DateTime.fromMillisecondsSinceEpoch(map['changed_at'] as int),
      lastUpdatedBy: map['last_updated_by'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) =>
      Task.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Task(id: $id, text: $text, importance: $importance, deadline: $deadline, done: $done, color: $color, created_at: $createdAt, changed_at: $changedAt, last_updated_by: $lastUpdatedBy)';
  }

  @override
  bool operator ==(covariant Task other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.text == text &&
        other.importance == importance &&
        other.done == done &&
        other.deadline == deadline &&
        other.color == color &&
        other.createdAt.millisecondsSinceEpoch ~/ 1000 ==
            createdAt.millisecondsSinceEpoch ~/ 1000 &&
        other.changedAt.millisecondsSinceEpoch ~/ 1000 ==
            changedAt.millisecondsSinceEpoch ~/ 1000 &&
        other.lastUpdatedBy == lastUpdatedBy;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        text.hashCode ^
        importance.hashCode ^
        done.hashCode ^
        deadline.hashCode ^
        color.hashCode ^
        createdAt.hashCode ^
        changedAt.hashCode ^
        lastUpdatedBy.hashCode;
  }

  @override
  int compareTo(covariant Task other) {
    return text.compareTo(other.text);
  }
}

enum Importance {
  low,
  basic,
  important,
}

extension StringToEnum on String {
  Importance toImportance() {
    return Importance.values.firstWhere(
      (element) => element.name == this,
      orElse: () => throw Exception('Unknown importance $this'),
    );
  }
}
