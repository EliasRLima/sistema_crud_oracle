create or replace package apl_bd2.pck_cadastro_alt is

-- Author  : SVTR_
-- Created : 20/06/2021 00:59:58
-- Purpose : 

end;
/
create or replace package body apl_bd2.pck_cadastro_alt is

  procedure executa(p_idcadastro in number, --pessoa
                    p_numero     in varchar2,
                    p_tipo       in number,
                    p_nome       in varchar2,
                    p_email      in varchar2,
                    p_telefone   in varchar2,
                    p_erro       out varchar2,
                    p_msg_erro   out varchar2) is
  
    v_sql varchar2(2000);
  begin
  
    if p_idcadastro is not null then
      if p_numero is not null or p_tipo is not null then
        v_sql := 'update apl_bd2.cadastro c 
                   set';
        if p_tipo is not null then
          v_sql := v_sql || ' c.tipo = ' || p_tipo;
        end if;
      
        if p_numero is not null then
          v_sql := v_sql || ' c.numero = ''' || p_numero || '''';
        end if;
      
        v_sql := v_sql || ' where c.idcadastro = ' || p_idcadastro;
      
        execute immediate v_sql;
      end if;
      if p_nome is not null or p_email is not null or
         p_telefone is not null then
        v_sql := 'update apl_bd2.pessoa p
                   set ';
      
        if p_nome is not null then
          v_sql := v_sql || ' p.nome = ''' || p_nome || '''';
        end if;
      
        if p_email is not null then
          v_sql := v_sql || ' p.email = ''' || p_email || '''';
        end if;
      
        if p_telefone is not null then
          v_sql := v_sql || ' p.telefone = ''' || p_telefone || '''';
        end if;
      
        v_sql := v_sql || ' where p.idpessoa = ' || p_idcadastro;
      
        execute immediate v_sql;
      end if;
      p_erro := 'N';
      p_msg_erro := 'Valor atualizado com sucesso.';
      return;
    else
      p_erro := 'S';
      p_msg_erro := 'É necessario passar o id do cadastro.';
      return;
    end if;
  exception
    when others then
      p_erro := 'S';
      p_msg_erro := 'Ocorreu um erro inesperado.';
  end;

  procedure executa(p_idcadastro in number, --imovel
                    p_numero   in varchar2, 
                    p_endereco in varchar2,
                    p_padrao   in varchar2,
                    p_valor    in number,
                    p_erro     out varchar2,
                    p_msg_erro out varchar2) is
     v_sql varchar2(2000);
   begin
     
     if p_idcadastro is not null then
      if p_numero is not null then
        v_sql := 'update apl_bd2.cadastro c 
                   set c.numero = ''' || p_numero || '''
                   where c.idcadastro = ' || p_idcadastro;
      
        execute immediate v_sql;
      end if;
      
      
      if p_endereco is not null 
         or p_padrao is not null 
         or p_valor is not null 
       then
        v_sql := 'update apl_bd2.imovel p
                   set ';
      
        if p_endereco is not null then
          v_sql := v_sql || ' p.endereco = ''' || p_endereco || '''';
        end if;
      
        if p_padrao is not null then
          v_sql := v_sql || ' p.padrao = ''' || p_padrao || '''';
        end if;
      
        if p_valor is not null then
          v_sql := v_sql || ' p.valor = ' || p_valor;
        end if;
      
        v_sql := v_sql || ' where p.idimovel = ' || p_idcadastro;
      
        execute immediate v_sql;
      end if;
      p_erro := 'N';
      p_msg_erro := 'Valor atualizado com sucesso.';
      return;
    else
      p_erro := 'S';
      p_msg_erro := 'É necessario passar o id do cadastro.';
      return;
    end if;
  exception
    when others then
      p_erro := 'S';
      p_msg_erro := 'Ocorreu um erro inesperado.';
   end;
end;
/
