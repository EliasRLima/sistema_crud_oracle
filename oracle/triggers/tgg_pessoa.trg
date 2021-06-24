create or replace trigger apl_bd2.tgg_pessoa
  before insert or update
  on APL_BD2.PESSOA 
  for each row
declare
  -- local variables here
  v_aux number;
begin
  
  if :NEW.EMAIL IS NULL and :NEW.TELEFONE IS NULL THEN
    RAISE_APPLICATION_ERROR( -20001, 
                             'As formas de contato nao podem ser vazias.' );
  elsif :NEW.EMAIL IS NULL and :NEW.Telefone IS NOT NULL then
    v_aux := apl_bd2.fnc_validatelefone(p_telefone => :NEW.TELEFONE);
    
    if v_aux = 0 then
      RAISE_APPLICATION_ERROR( -20001, 
                             'O telefone é invalido. Verifique ou adicione outra forma de contato.' );
    end if;
  elsif :NEW.EMAIL IS NOT NULL and :NEW.Telefone IS NULL then
    v_aux := apl_bd2.fnc_validaemail(p_email => :NEW.Email);
    
    if v_aux = 0 then
      RAISE_APPLICATION_ERROR( -20001, 
                             'O email é invalido. Verifique ou adicione outra forma de contato.' );
    end if;
  elsif :NEW.EMAIL IS NOT NULL and :NEW.Telefone IS NOT NULL then
     v_aux := apl_bd2.fnc_validatelefone(p_telefone => :NEW.TELEFONE);
    
    if v_aux = 0 then
      v_aux := apl_bd2.fnc_validaemail(p_email => :NEW.Email);
      
      RAISE_APPLICATION_ERROR( -20001, 
                             'As formas de contato estao invalidas.' );
    end if;
  else
    RAISE_APPLICATION_ERROR( -20001, 
                             'Erro inesperado.' );
  end if;
end;
/
