create or replace package apl_bd2.pck_cadastro_exc is

  -- Author  : SVTR_
  -- Created : 20/06/2021 00:36:43
  -- Purpose : 
  
  procedure executa(p_numero in number,
                    p_erro out varchar2,
                    p_msg_erro out varchar2);
  
end;
/
create or replace package body apl_bd2.pck_cadastro_exc is

  procedure executa(p_numero in number,
                    p_erro out varchar2,
                    p_msg_erro out varchar2) is
                    
  begin
     delete from apl_bd2.pessoa p
     where p.idpessoa in (select cad.idcadastro from apl_bd2.cadastro cad where cad.numero = p_numero);
     
     delete from apl_bd2.imovel i
     where i.idimovel in (select cad.idcadastro from apl_bd2.cadastro cad where cad.numero = p_numero);
     
     /*delete from apl_bd2.cadastro cad
     where cad.numero = p_numero;*/ --o cadastro nao é removido, por conta do historico de imoveis
     
     p_erro := 'N';
     p_msg_erro := 'Cadastro removido';
     
  exception
    when others then
      p_erro := 'S';
      p_msg_erro := 'Ocorreu um erro durante a exclusao.';
      return;
  end;

end;
/
