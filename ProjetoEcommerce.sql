-- criando a base de dados
create database ecommerce;

--criando as tabelas
create table categoria(
	cat_cd_id serial,
	cat_tx_nome varchar(50),
	cat_tx_descrição varchar(50),
	primary key (cat_cd_id)
);

create table produto(
	pro_cd_id serial,
	pro_tx_nomepro varchar(20),
	pro_tx_descricao varchar(256),
	pro_int_estoque integer,
	pro_dt_datafab date,
	pro_int_valor integer,
	fk_fun_cd_id integer,
	fk_cat_cd_id integer,
	primary key (pro_cd_id),
	foreign key (fk_fun_cd_id) references funcionario,
	foreign key (fk_cat_cd_id) references categoria
);

create table pedido_produto(
	pedpro_cd_id serial,
	fk_pro_cd_id integer,
	fk_ped_cd_id integer,
	primary key (pedpro_cd_id),
	foreign key (fk_pro_cd_id) references produto,
	foreign key (fk_ped_cd_id) references pedido
);

create table pedido(
	ped_cd_id serial,
	ped_tx_forma_pg varchar(50),
	ped_int_num_cartao varchar(16),
	ped_int_quantidade integer,
	fk_cli_cd_id integer,
	primary key (ped_cd_id),
	foreign key (fk_cli_cd_id) references cliente
);
alter table pedido add column ped_dt_data_venda date;
alter table pedido rename column ped_int_num_cartao to ped_tx_num_cartao;



create table cliente(
	cli_cd_id serial,
	cli_tx_nomeusu varchar(20),
	cli_tx_email varchar(50),
	cli_dt_datanasc date,
	cli_tx_endereco varchar(200),
	fk_user_cd_id integer,
	fk_end_cd_id integer,
	primary key (cli_cd_id),
	foreign key (fk_user_cd_id) references usuario,
	foreign key (fk_end_cd_id) references endereco
);

create table funcionario(
	fun_cd_id serial,
	fk_user_cd_id integer unique,
	primary key (fun_cd_id),
	foreign key (fk_user_cd_id) references usuario
);

create table usuario(
	user_cd_id serial,
	user_tx_nome varchar(50),
	user_tx_cpf varchar(11) unique,
	primary key (user_cd_id)
);
alter table usuario add column user_tx_senha varchar(20);

create table endereco(
	end_cd_id serial,
	end_tx_rua varchar(50),
	end_tx_bairro varchar(50),
	end_char_cep varchar(8),
	end_int_numero integer,
	fk_cid_cd_id integer,
	primary key (end_cd_id),
	foreign key (fk_cid_cd_id) references cidade
);

create table cidade(
	cid_cd_id serial,
	cid_tx_nome varchar(50),
	fk_est_cd_id integer,
	primary key (cid_cd_id),
	foreign key (fk_est_cd_id) references estado
);

create table estado(
	est_cd_id serial,
	est_tx_estado varchar(50),
	est_tx_sigla varchar(50),
	est_char_pais varchar(8),
	primary key (est_cd_id)
);

--criar view nota fiscal
create view nota_fiscal as
select pedido.ped_tx_forma_pg , pedido.ped_dt_data_venda,
pedido.ped_int_quantidade, produto.pro_int_valor, produto.pro_tx_nomepro, usuario.user_tx_nome,
usuario.user_tx_cpf, cliente.fk_end_cd_id
from pedido, produto, cliente, usuario;




--inserindo dados nas tabelas


--criar drops caso precise de alteração

