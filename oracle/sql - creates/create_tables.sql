alter session set "_ORACLE_SCRIPT"=true;

create user apl_bd2
  identified by erl
  default tablespace SYSTEM
  temporary tablespace TEMP
  profile DEFAULT;
  
create table apl_bd2.cadastro
(
    idcadastro number primary key,
    tipo number, -- 1 = pessoa fisica, 2 = pessoa juridica, 3 = imovel
    numero varchar2(14) --cpf / cnpj / insmob   
);

create table apl_bd2.pessoa
(
   idpessoa number primary key, --refere a idcadastro
   nome varchar2(100) not null,
   email varchar2(100),
   telefone varchar2(30)
);
alter table APL_BD2.PESSOA
  add constraint FK_PESSOA foreign key (IDPESSOA)
  references APL_BD2.CADASTRO (IDCADASTRO) on delete cascade;

create table apl_bd2.imovel
(
   idimovel number primary key, --refere a idcadastro
   endereco varchar2(200),
   padrao varchar2(10),
   valor number
);
alter table APL_BD2.IMOVEL
  add constraint FK_IMOVEL foreign key (IDIMOVEL)
  references APL_BD2.CADASTRO (IDCADASTRO) on delete cascade;
  
create table apl_bd2.imovelhis as
 select i.*,
        sysdate datalt,
        user usuario
 from apl_bd2.imovel i;
 
alter table APL_BD2.IMOVELHIS
  add constraint FK_IMOV_HIS foreign key (IDIMOVEL)
  references APL_BD2.IMOVEL (IDIMOVEL);
  
create sequence APL_BD2.seq_cadastro
minvalue 1
maxvalue 99999999999999
start with 1
increment by 1;
  




