drop type if exists color_enum cascade;
drop type if exists privacy_enum cascade;
drop type if exists theme_enum cascade;
drop type if exists priority_enum cascade;
create type color_enum as enum
  ('red', 'orange', 'yellow', 'green', 'blue', 'indigo', 'violet');
create type privacy_enum as enum ('private', 'public');
create type theme_enum as enum ('dark', 'light');
create type priority_enum as enum ('low', 'medium', 'high');



drop table if exists Accounts cascade;
create table Accounts (
    AccountId int         not null,
    UserName  varchar(30) not null,
    Mail      varchar(100)    null,
    primary key (AccountId)
);

drop table if exists Address cascade;
create table Address (
    AddressId int         not null,
    Counrty  varchar(100) not null,
    City     varchar(100) not null,
    Street   varchar(100) not null,
    Building varchar(100) not null,

    primary key (AddressId)
);

drop table if exists Calendars cascade;
create table Calendars (
    CalendarId     int          not null,
    AccountId      int          not null,
    CalendarName   varchar(60)  not null,
    PrivacySetting privacy_enum not null,
    Theme          theme_enum   not null,
    lastModified   timestamp    default current_timestamp not null,

    primary key (CalendarId),
    foreign key (AccountId) references Accounts(AccountId)
);

drop table if exists SubCalendars cascade;
create table SubCalendars (
    SubCalendarId   int         not null,
    CalendarId      int         not null,
    Color           color_enum  not null,
    SubCalendarName varchar(60) not null,

    primary key (SubCalendarId),
    foreign key (CalendarId) references Calendars(CalendarId)
);

drop table if exists Projects cascade;
create table Projects (
    ProjectId     int         not null,
    SubCalendarId int         not null,
    ProjectName   varchar(60) not null,
    Deadline      timestamp   not null,
    lastModified  timestamp   default current_timestamp not null,

    primary key (ProjectId),
    foreign key (SubCalendarId)
      references SubCalendars(SubCalendarId)
);

drop table if exists Tasks cascade;
create table Tasks (
    TaskId      int         not null,
    ProjectId   int         not null,
    TaskName    varchar(60) not null,
    Description text            null,
    Orders      int         not null,

    primary key (TaskId),
    unique (ProjectId, Orders),
    foreign key (ProjectId) references Projects(ProjectId)
);

drop table if exists Events cascade;
create table Events (
    EventId       int           not null,
    SubCalendarId int           not null,
    EventName     varchar(60)   not null,
    StartTime     timestamp     not null,
    Duration      int           not null,
    Priority      priority_enum     null,

    primary key (EventId),
    check (Duration > 0),
    foreign key (SubCalendarId)
      references SubCalendars(SubCalendarId)
);

drop table if exists Notes cascade;
create table Notes (
    NoteId  int  not null,
    EventId int  not null,
    Content text not null,
    Orders  int  not null,

    primary key (NoteId),
    unique (EventId, Orders),
    foreign key (EventId) references Events(EventId)
);

drop table if exists EventAddress cascade;
create table EventAddress (
    EventId   int  not null,
    AddressId int  not null,

    primary key (EventId),
    foreign key (EventId) references Events(EventId),
    foreign key (AddressId) references Address(AddressId)
);

-- нам часто нужны соединения для поискак ивентов по пользователю или проектов
-- по пользователю, поэтому разумно завести hash индекс для ускорение ествественного соединения
create index on Accounts using hash (AccountId);
create index on Calendars using hash (CalendarId);
create index on SubCalendars using hash (SubCalendarId);
-- индексы ниже кроме соединией упомянтых выше, часто встречаются
-- с Tasks или с Notes
create index on Projects using hash (ProjectId);
create index on Events using hash (EventId);
