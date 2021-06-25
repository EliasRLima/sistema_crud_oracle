create or replace package apl_bd2.pck_cadastro_inc is

  -- Author  : SVTR_
  -- Created : 18/06/2021 19:21:54
  -- Purpose : 

   procedure executa(p_numero   in varchar2, --pessoa
                    p_tipo     in number,
                    p_nome     in varchar2,
                    p_email    in varchar2,
                    p_telefone in varchar2,
                    p_erro out varchar2,
                    p_msg_erro out varchar2);

  procedure executa(p_numero   in varchar2, --imovel
                    p_endereco in varchar2,
                    p_padrao   in varchar2,
                    p_valor    in number,
                    p_erro out varchar2,
                    p_msg_erro out varchar2);

end;
/
create or replace noneditionable package body apl_bd2.pck_cadastro_inc is

  procedure executa(p_numero   in varchar2, --pessoa
                    p_tipo     in number,
                    p_nome     in varchar2,
                    p_email    in varchar2,
                    p_telefone in varchar2,
                    p_erro out varchar2,
                    p_msg_erro out varchar2) is
                    
    begin
      
    for aux in (
         select 0
         from apl_bd2.cadastro cad
         where cad.numero = p_numero
    ) loop
       p_erro := 'S';
       p_msg_erro := 'Esse CPF/CNPJ ja foi cadastrado!';
       return;
    end loop;
    
    insert into apl_bd2.cadastro
    (idcadastro, 
     tipo, 
     numero )
    values
    (APL_BD2.seq_cadastro.NEXTVAL,
     p_tipo,
     p_numero);
     
     insert into apl_bd2.pessoa
     (idpessoa, 
      nome, 
      email, 
      telefone)
     values
     (APL_BD2.seq_cadastro.CURRVAL,
      p_nome,
      p_email,
      p_telefone);
      
      p_erro := 'N';
      p_msg_erro := 'Cadastro inserido com sucesso.';
    
    exception
      when others then 
        p_erro := 'S';
        p_msg_erro := 'Nao foi possivel inserir esse cadastro.';
        return;
    end;

  procedure executa(p_numero   in varchar2, --imovel
                    p_endereco in varchar2,
                    p_padrao   in varchar2,
                    p_valor    in number,
                    p_erro out varchar2,
                    p_msg_erro out varchar2) is
                    
    begin
     for aux in (
         select 0
         from apl_bd2.cadastro cad
         where cad.numero = p_numero
    ) loop
       p_erro := 'S';
       p_msg_erro := 'Esse imovel ja foi cadastrado!';
       return;
    end loop;
    
    insert into apl_bd2.cadastro
    (idcadastro, 
     tipo, 
     numero )
    values
    (APL_BD2.seq_cadastro.NEXTVAL,
     3,
     p_numero);
     
     insert into apl_bd2.imovel
     (idimovel, 
      endereco, 
      padrao, 
      valor )
     values
     (APL_BD2.seq_cadastro.CURRVAL,
      p_endereco,
      p_padrao,
      p_valor);
      
      p_erro := 'N';
      p_msg_erro := 'Cadastro inserido com sucesso.';

    exception
      when others then 
        p_erro := 'S';
        p_msg_erro := 'Nao foi possivel inserir esse cadastro.'; 
    end;
end;
/
