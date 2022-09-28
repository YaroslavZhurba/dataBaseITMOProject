create or replace function foo (in value int) returns bool
    language plpgsql
    security definer
as
$$
declare
    tmp int := 0;
begin

    raise notice 'Value: %', value;

    return true;
end
$$;
