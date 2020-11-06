/* Criação da base de dados */
create database wk_teste character set UTF8 collate utf8_bin;

/* Tabela Clientes */
create table clientes(
   codigo integer       not null auto_increment comment 'codigo unico para armazenar cliente' ,
   nome   varchar(255)  not null                                                              ,
   cidade varchar(255)                                                                        ,
   uf     char(2)                                                                             ,    
   primary key(codigo)
);
/* Constraint tabela clientes */
create index index_codigo_cliente on clientes(codigo);

/* Insert tabela Clientes */
/*1*/ insert into clientes(nome, cidade, uf)
              values('Hugo Pereira de Souza', 'Guzolândia', 'SP');
/*2*/insert into clientes(nome, cidade,  uf)
              values('Manoel Jose Ferreira', 'Araçatuba', 'SP');
/*3*/insert into clientes(nome, cidade,  uf)
              values('Miguel Augusto Donegar', 'Angra dos Reis', 'RJ');
/*4*/insert into clientes(nome, cidade,  uf)
              values('Jussara Nathalia', 'Balneário Camboriu', 'SC');
/*5*/insert into clientes(nome, cidade,  uf)
              values('Vitor Pereira de Miranda', 'Ribas do Rio Pardo', 'MS');
/*6*/insert into clientes(nome, cidade,  uf)
              values('Débora Eloisa', 'Guzolândia', 'SP');
/*7*/insert into clientes(nome, cidade,  uf)
              values('Matheus Nathalino Jose', 'Londrina', 'PR');
/*8*/insert into clientes(nome, cidade,  uf)
              values('Vitor José dos Campos', 'Auriflama', 'SP');
/*9*/insert into clientes(nome, cidade,  uf)
              values('Janete da Silva', 'Auriflama', 'SP');
/*10*/insert into clientes(nome, cidade, uf)
              values('Edson de Souza', 'São José do Rio Preto', 'SP');
/*11*/insert into clientes(nome, cidade, uf)
              values('Cido Pereira', 'Blumenau', 'SC');
/*12*/insert into clientes(nome, cidade, uf)
              values('Telma Farias', 'Florianópolis', 'SC');
/*13*/insert into clientes(nome, cidade,  uf)
              values('Alan Alberto', 'Itajai', 'SC');
/*14*/insert into clientes(nome, cidade,  uf)
              values('Lucky Militante', 'Santos', 'SP');
/*15*/insert into clientes(nome, cidade,  uf)
              values('Cristopher Jose', 'Ubatuba', 'SP');                                                                                                  
/*16*/insert into clientes(nome, cidade,  uf)
              values('Marcia Cida', 'Balneário Camboriu', 'SC');
/*17*/insert into clientes(nome, cidade,  uf)
              values('Vitoria Andrade', 'Amazonia Sul', 'AM');
/*18*/insert into clientes(nome, cidade,  uf)
              values('Gabriel Victor', 'Jales', 'SP');
/*19*/insert into clientes(nome, cidade,  uf)
              values('Vilmo Severino', 'Rio das Ostras', 'RJ');
/*20*/insert into clientes(nome, cidade,  uf)
              values('Jose Pereira', 'Guzolândia', 'SP');                                                                      

/* FIM Clientes */

/* Tabela Produtos */
create table produtos(
   codigo      integer      not null auto_increment comment 'codigo unico para armazenar produto' ,
   descricao   varchar(255) not null                                                              ,
   preco_venda real         not null                                                              ,
   primary key(codigo)
);

/* Constraint tabela clientes */
create index index_codigo_produto on produtos(codigo);

/* Insert tabela produtos */
/*1*/ insert into produtos(descricao, preco_venda)
              values('Coca-Cola 2 Litros', 7.50);
/*2*/insert into produtos(descricao, preco_venda)
              values('Pão Integral', 2.00);
/*3*/insert into produtos(descricao, preco_venda)
              values('Manteiga', 20.00);
/*4*/insert into produtos(descricao, preco_venda)
              values('SKOL Litrão', 6.00);
/*5*/insert into produtos(descricao, preco_venda)
              values('Budwaiser', 10.00);
/*6*/insert into produtos(descricao, preco_venda)
              values('Café Rosseiro', 6.60);
/*7*/insert into produtos(descricao, preco_venda)
              values('Mussarela Fatiada', 8.50);
/*8*/insert into produtos(descricao, preco_venda)
              values('Maça', 4.00);
/*9*/insert into produtos(descricao, preco_venda)
              values('Tomate', 3.00);
/*10*/insert into produtos(descricao, preco_venda)
              values('Vinho', 20.00);
/*11*/insert into produtos(descricao, preco_venda)
              values('Panetone Trufado', 15.00);
/*12*/insert into produtos(descricao, preco_venda)
              values('Whisk Blue Label', 80.00);
/*13*/insert into produtos(descricao, preco_venda)
              values('Beringela', 4.00);
/*14*/insert into produtos(descricao, preco_venda)
              values('Sprite 2 Litros', 7.50);
/*15*/insert into produtos(descricao, preco_venda)
              values('Uva', 5.00);                                                                                                  
/*16*/insert into produtos(descricao, preco_venda)
              values('Presunto Perdigão', 7.50);
/*17*/insert into produtos(descricao, preco_venda)
              values('Salame', 9.00);
/*18*/insert into produtos(descricao, preco_venda)
              values('Televisao 50 Smart', 2000.00);
/*19*/insert into produtos(descricao, preco_venda)
              values('MACBOOK PRO', 10000.00);
/*20*/insert into produtos(descricao, preco_venda)
              values('Tenis NIKE', 250.00);  

/* FIM Produtos */

/* Tabela Pedido */
create table dados_gerais_pedido(
   numero_pedido  integer not null comment 'codigo unico e gerado sequencialmente' ,
   data_emissao   timestamp default current_timestamp()                            ,
   codigo_cliente integer not null                                                 ,
   valor_total    real                                                             ,
   primary key(numero_pedido)
);

/* Constraint tabela clientes */
create index index_numero_pedido on dados_gerais_pedido(numero_pedido);
create unique index index_unq_numero_pedido on dados_gerais_pedido(numero_pedido);
alter  table dados_gerais_pedido add foreign key(codigo_cliente) references clientes(codigo);


/* FIM Pedido */


/* Tabela Pedido Produto */
create table pedidos_produtos(
   codigo         integer not null auto_increment comment 'codigo unico' ,
   numero_pedido  integer not null                                       ,
   codigo_produto integer not null                                       ,
   quantidade     integer not null                                       ,
   valor_unitario real    not null                                       ,
   valor_total    real    not null                                       ,
   primary key(codigo)
);

/* Constraint tabela clientes */
create index index_codigo_pedidos_produto on pedidos_produtos(codigo);
alter  table pedidos_produtos add foreign key(numero_pedido)  references dados_gerais_pedido(numero_pedido);
alter  table pedidos_produtos add foreign key(codigo_produto) references produtos(codigo);
/* FIM Pedido Produto */
