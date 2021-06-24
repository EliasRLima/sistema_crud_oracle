create or replace function apl_bd2.fnc_validatelefone(p_telefone in varchar2) return number is
  FunctionResult number;
  v_telefone varchar2(50);
  v_telefone_numero number;
begin
  
  v_telefone := replace(p_telefone,'/','');
  v_telefone := replace(v_telefone,'.','');
  v_telefone := replace(v_telefone,'-','');
  v_telefone := replace(v_telefone,')','');
  v_telefone := replace(v_telefone,'(','');
  v_telefone := replace(v_telefone,' ','');
  v_telefone_numero := to_number(v_telefone);
  
  --55 99 9 9999 9999
  --13, 11, 10, 9
  
  if length(v_telefone_numero) in (13, 11, 10, 9, 8) then
    return 1;
  end if;
  
  return 0;
exception
  when others then
    return 0;
end;
/
