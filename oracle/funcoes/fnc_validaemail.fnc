create or replace function apl_bd2.fnc_validaemail(p_email in varchar2) return number is
  FunctionResult number;
begin
  
  if p_email like '%@%' 
    and substr(p_email, instr(p_email,'@',1)+2, length(p_email)) like '%.%' 
    and substr(p_email, instr(p_email,'@',1)+2, length(p_email)) not like '%.' then
      return 1;
  end if;
  
  return 0;
end;

