create or replace package apl_bd2.pck_cadastro_con is

-- Author  : SVTR_
-- Created : 19/06/2021 13:56:49
-- Purpose : 
    
   procedure executa(p_tipo          in number,
                    p_numero        in varchar2 default 'N',
                    p_nome          in varchar2 default 'N',
                    p_valor_min     in number default 0,
                    p_valor_max     in number default 0,
                    p_lista_retorno out apl_bd2.pck_tipos.t_cursor,
                    p_erro          out varchar2,
                    p_msg_retorno   out varchar2);
end;
/
create or replace package body apl_bd2.pck_cadastro_con is


  procedure executa(p_tipo          in number,
                    p_numero        in varchar2 default 'N',
                    p_nome          in varchar2 default 'N',
                    p_valor_min     in number default 0,
                    p_valor_max     in number default 0,
                    p_lista_retorno out apl_bd2.pck_tipos.t_cursor,
                    p_erro          out varchar2,
                    p_msg_retorno   out varchar2) is
  
    v_sql varchar2(2000);
  
  begin
  
    if p_tipo in (1, 2) then
      v_sql := 'select
                 pes.idpessoa,
                 pes.nome,
                 pes.email,
                 pes.telefone,
                 cad.numero,
                 cad.tipo
                from apl_bd2.cadastro cad,
                 apl_bd2.pessoa pes
                where pes.idpessoa = cad.idcadastro';
       
      if p_nome not like 'N' then
        v_sql := ' and lower(pes.nome) like %' || lower(p_nome) || '%';
      end if;
      
      if p_numero not like 'N' then
        v_sql := ' and cad.numero like ' || p_nome;
      end if;
    
    elsif p_tipo = 3 then
      v_sql := ' select
                  imo.idimovel,
                  imo.endereco,
                  imo.padrao,
                  imo.valor,
                  cad.numero
                from apl_bd2.cadastro cad,
                     apl_bd2.imovel imo
                where imo.idimovel = cad.idcadastro';
                
      if p_numero not like 'N' then
        v_sql := ' and cad.numero like ' || p_nome;
      end if;
      
      if p_valor_max > 0 then
          v_sql := ' and imo.valor between ' || p_valor_min || ' and ' || p_valor_max;
      elsif p_valor_min > 0 then
          v_sql := ' and imo.valor >= ' || p_valor_min;
      end if;
    
    else
      p_erro := 'S';
      open p_lista_retorno for
        select 0 from dual;
      p_msg_retorno := 'É necessario o tipo do cadastro para buscar.';
      return;
    end if;
    
    open p_lista_retorno for v_sql;
    p_erro := 'N';
    p_msg_retorno := 'Consulta efetuada com sucesso.';
    return;
  exception
    when others then
      p_erro := 'S';
      open p_lista_retorno for
        select 0 from dual;
      p_msg_retorno := 'Aconteceu um erro durante a busca.';
      return;
  end;

end;
/
