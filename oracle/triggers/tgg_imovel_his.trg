create or replace trigger apl_bd2.tgg_imovel_his
  after insert or update or delete
  on APL_BD2.IMOVEL 
  for each row
declare
  -- local variables here
begin
  
 insert into apl_bd2.imovelhis
 select
    nvl(:NEW.IDIMOVEL, :OLD.IDIMOVEL) idimovel, 
    :NEW.ENDERECO endereco, 
    :NEW.PADRAO padrao, 
    :NEW.VALOR valor, 
    sysdate datalt, 
    USER usuario 
 from dual;
end;
/
