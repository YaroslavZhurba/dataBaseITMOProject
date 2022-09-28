-- информация о пользователях
select * from Accounts;

-- база данных адресов
select * from Address;

-- Accounts
-- Address
-- Calendars
-- SubCalendars
-- Projects
-- Tasks
-- Events
-- Notes
-- EventAddress

create view
  AccountsEvents(AccountId, UserName, EventId, EventName, StartTime, Duration, Priority)
as select AccountId, UserName, EventId, EventName, StartTime, Duration, Priority
   from Accounts natural join
        Calendars natural join
        SubCalendars natural join
        Events;

create view
  AccountsProjects(AccountId, UserName, ProjectId, ProjectName, Deadline)
as select AccountId, UserName, ProjectId, ProjectName, Deadline
   from Accounts natural join
        Calendars natural join
        SubCalendars natural join
        Projects;

create view
  EventsNotes(EventId, EventName, NoteId, Content, Orders)
as select EventId, EventName, NoteId, Content, Orders
   from Events natural join
        Notes;

create view
  ProjectsTasks(ProjectId, ProjectName, Deadline, TaskId, TaskName, Description, Orders)
as select ProjectId, ProjectName, Deadline, TaskId, TaskName, Description, Orders
   from Projects natural join
        Tasks;

create view
  EventsAddress(EventId, EventName, AddressId, Counrty, City, Street, Building)
as select EventId, EventName, AddressId, Counrty, City, Street, Building
   from Events natural join
        EventAddress natural join
        Address;


-- EventsByAccount
select EventName, StartTime
  from AccountsEvents
  where UserName = 'yaroslav';

-- ProjectsByAccount
select ProjectName, Deadline
  from AccountsProjects
  where UserName = 'yaroslav';

-- NotesByEvent
select EventName, NoteId, Content, Orders
  from EventsNotes
  where EventId = 2
  order by Orders;

-- TasksByProject
select ProjectName, Deadline, TaskId, TaskName, Description, Orders
  from ProjectsTasks
  where ProjectId = 1
  order by Orders;

-- AdressByEvent
select EventName, AddressId, Counrty, City, Street, Building
  from EventsAddress
  where EventId = 2;
