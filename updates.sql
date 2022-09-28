-- changeColorBySubCalendarId
update SubCalendars
  set color = 'orange'
  where SubCalendarId = 1;

-- changeAllCalenderThemeByUser
update Calendars
  set theme = 'dark'
  where AccountId = 1;

-- transaction serializable
-- чтобы избежать косой записи
create or replace function swapTasksByProjectId (in ord_a int,
                                                 in ord_b int,
                                                 in project_id int) returns bool
    language plpgsql
    security definer
as
$$
declare
    tmp int := 0;
begin
    if (ord_a < 1) or (ord_b < 1) then
        return false;
    end if;

    if not exists
      (select *
         from Tasks
         where ProjectId = project_id and
               Orders = ord_a) then
      return false;
    end if;
    if not exists
      (select *
         from Tasks
         where ProjectId = project_id and
               Orders = ord_b) then
      return false;
    end if;
    tmp := (select max(Orders)
             from Tasks
             where ProjectId = project_id);
    tmp = tmp + 1;
    update Tasks
      set Orders = tmp
      where ProjectId = project_id and
            Orders = ord_a;

    update Tasks
      set Orders = ord_a
      where ProjectId = project_id and
            Orders = ord_b;

    update Tasks
      set Orders = ord_b
      where ProjectId = project_id and
            Orders = tmp;
    return true;
end
$$;

-- transaction serializable
-- чтобы избежать косой записи
create or replace function swawNotesByProjectId (in ord_a int,
                                                 in ord_b int,
                                                 in event_id int) returns bool
    language plpgsql
    security definer
as
$$
declare
    tmp int := 0;
begin
    if (ord_a < 1) or (ord_b < 1) then
        return false;
    end if;

    if not exists
      (select *
         from Notes
         where EventId = event_id and
               Orders = ord_a) then
      return false;
    end if;
    if not exists
      (select *
         from Notes
         where EventId = event_id and
               Orders = ord_b) then
      return false;
    end if;
    tmp := (select max(Orders)
             from Notes
             where EventId = event_id);
    tmp = tmp + 1;
    update Notes
      set Orders = tmp
      where EventId = event_id and
            Orders = ord_a;

    update Notes
      set Orders = ord_a
      where EventId = event_id and
            Orders = ord_b;

    update Notes
      set Orders = ord_b
      where EventId = event_id and
            Orders = tmp;
    return true;
end
$$;

-- deleteNoteByEventAndOrd
delete from Notes
  where EventId = 2 and
        Orders = 1;

-- deleteAddressByEvent
delete from EventAddress
  where EventId = 8;


create trigger last_mod_task_trig after insert or update or delete on Tasks
  referencing new row task
  for each row execute procedure
  update_last_modified_project(task.ProjectId);


create trigger last_mod_event_trig after insert or update or delete on Tasks
  referencing new row event
  for each row execute procedure
  update_last_modified_project(get_calendar_id_by_event(eventId.ProjectId));


create or replace function get_calendar_id_by_event(in event_id int) return int
    language plpgsql
    security definer
as
$$
begin
    return (select CalendarId
      from Events natural join SubCalendars natural join Calendars
      where Events.EventId = event_id;)
end
$$;

create or replace procedure update_last_modified_project(in project_id int)
    language plpgsql
    security definer
as
$$
begin
    update Projects
      set lastModified = now()
      where ProjectId = project_id;
end
$$;


create or replace procedure update_last_modified_calendar(in calendar_id int)
    language plpgsql
    security definer
as
$$
begin
    update Calendars
      set lastModified = now()
      where CalendarId = calendar_id;
end
$$;
