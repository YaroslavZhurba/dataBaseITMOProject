delete from EventAddress where true;
delete from Notes where true;
delete from Events where true;
delete from Tasks where true;
delete from Projects where true;
delete from SubCalendars where true;
delete from Calendars where true;
delete from Address where true;
delete from Accounts where true;

insert into Accounts
  (AccountId, UserName, Mail)
values
  (1,'yaroslav', null),
  (2,'turing228', 'top1337ru@gmail.com'),
  (3,'петя', null);

insert into Address
  (AddressId, Counrty, City, Street, Building)
values
  (1, 'Россия', 'Санкт-Петербург', 'Кронверкский проспект', 'дом 49'),
  (2, 'Россия', 'Санкт-Петербург', 'улица Ломоносова', 'дом 9'),
  (3, 'Россия', 'Санкт-Петербург', 'улица Малая Морская', 'дом 15/7');


insert into Calendars
  (CalendarId, AccountId, CalendarName, PrivacySetting, Theme)
values
  (1, 1, 'itmo' , 'private', 'dark' ),
  (2, 1, 'chill', 'public' , 'light'),
  (3, 2, 'itmo' , 'private', 'dark' ),
  (4, 3, 'itmo' , 'private', 'dark' );

insert into SubCalendars
  (SubCalendarId, CalendarId, Color, SubCalendarName)
values
  (1, 1, 'blue', 'теоркод'),
  (2, 1, 'red', 'бд'),
  (3, 2, 'red' , 'настолки'),
  (4, 2, 'indigo', 'игры с друзьями'),
  (5, 3, 'blue', 'пары'),
  (6, 4, 'blue', 'пары');


insert into Projects
  (ProjectId, SubCalendarId, ProjectName, Deadline)
values
  (1, 1, 'Алгоритм Витерби', timestamp '2022-02-11 09:50:00 AM'),
  (2, 2, 'Проект по бд', timestamp '2022-01-14 9:59:59 AM');


insert into Tasks
  (TaskId, ProjectId, TaskName, Description, Orders)
values
  (1, 1, 'Узнать формулу шума', null, 1),
  (2, 1, 'Реализовать кодер', 'Полезна будет, вторая глаба из Кудряшова', 2),
  (3, 1, 'Реализовать решетку', 'Полезна будет, третья глава Кудршева, также..', 3),
  (4, 1, 'Реализовать докер и симуляцию', null, 4),
  (5, 2, 'Нарисовать erm и pdm', 'Для рисования лучше использовать онлайн редактор по ссылке..', 1),
  (6, 2, 'Реализовать sql', null, 2);

insert into Events
  (EventId, SubCalendarId, EventName, StartTime, Duration, Priority)
values
  (1, 2, 'консультация по бд', timestamp '2022-01-16 10:00:00 AM', 3600, 'high'),
  (2, 1, 'практика теоркод', timestamp '2022-02-16 10:00:00 AM', 3600, null),
  (3, 3, 'вечер настолок в гаге', timestamp '2022-02-01 06:00:00 PM', 7200, 'medium'),
  (4, 3, 'вечер настолок в гаге', timestamp '2022-02-02 06:00:00 PM', 7200, 'medium'),
  (5, 4, 'дота онлайн', timestamp '2022-03-02 06:00:00 PM', 9000, 'low'),
  (6, 6, 'консультация по бд', timestamp '2022-01-16 10:00:00 AM', 3600, 'high'),
  (7, 5, 'практика теоркод', timestamp '2022-01-16 10:00:00 AM', 3600, null),
  (8, 6, 'английский ', timestamp '2022-01-18 10:00:00 AM', 1800, null);


insert into Notes
  (NoteId, EventId, Content, Orders)
values
  (1, 2, 'Взять ручку', 1),
  (2, 2, 'Взять тетрадку', 2),
  (3, 4, 'Взять деньги', 1);

insert into EventAddress
  (EventId, AddressId)
values
  (2, 1),
  (7, 1),
  (8, 2),
  (3, 3),
  (4, 3);
