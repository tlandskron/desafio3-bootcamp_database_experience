-- criação do banco de dados para o cenário de e-commerce

create database ecommerce;
use ecommerce;


-- criar tabela cliente

create table clients(
		idClient int auto_increment primary key,
        Fname varchar(10), 
        Minit char(3),
        Lname varchar(20),
        CPF char(11) not null,
        Address varchar(30),
        constraint unique_cpf_client unique (CPF)
);

alter table clients auto_increment=1;

-- desc client;

-- cirar tabela produto

create table product(
		idProduct int auto_increment primary key,
        Pname varchar(10) not null, 
        classification_kids bool default false,
        category enum('Eletrônico','Vestuário','Brinquedos','Alimentos','Móveis') not null,
        Address varchar(30),
        -- avaliação
        assessment float default 0,
        -- size = dimensão do produto
        size varchar(10)
);

alter table product auto_increment=1;

-- desc product;

-- criar tabbela pagamentos

create table payments(
		idPayClient int,
		idPayment int,
		typePayment enum ('Boleto','Cartão de Crédito','Dois Cartões de Crédito','PIX'),
		limitAvailable float,
		dateValidate char(5),
		numberCard char(15),
		nameCard varchar (15),
		primary key (idPayClient, idPayment),
        constraint fk_payments_client foreign key (idPayClient) references clients (idClient),
		constraint fk_payments_order foreign key (idPayment) references orders (idOrder)
);


-- criar tabela pedido

create table orders(
		idOrder int auto_increment primary key,
   		idOrderClient int,
		orderStatus enum('Cancelado','Confirmado','Em processamento') default 'Em processamento',
        orderDescription varchar(255),
        senValue float default 10,
        paymentCash bool default false,
        constraint fk_orders_client foreign key (idOrderClient) references clients (idClient)
				on update cascade
                -- caso necessite excluir definitivamente o registro do cliente utilizar parâmetro abaixo
                -- on delete set null
);

alter table orders auto_increment=1;

-- criar tabela estoque

create table productStorage(
		idproductStorage int auto_increment primary key,
   		category enum('Eletrônico','Vestuário','Brinquedos','Alimentos','Móveis') not null,
        storageLocation varchar(255),
        quantity int default 1
);

alter table productStorage auto_increment=1;

-- criar tabela fornecedor

create table supplier(
		idSupplier int auto_increment primary key,
        SocialName varchar(255) not null,
        CNPJ char(15) not null,
   		contact char(11) not null,
        constraint unique_supplier unique (CNPJ)
);

alter table supplier auto_increment=1;

-- criar tabela vendedor

create table seller(
		idSeller int auto_increment primary key,
        SocialName varchar(255) not null,
        AbstName varchar(255),
        location varchar(255),
        CNPJ char(15),
        CPF char(9), 
   		contact char(11) not null,
        constraint unique_cnpj_seller unique (CNPJ),
        constraint unique_cpf_seller unique (CPF)
);

alter table seller auto_increment=1;

-- criar tabela relacional Produto Vendedor

create table productSeller(
		idPseller int,
        idProduct int,
        Quantity int default 1,
        primary key (idPseller, idProduct),
        constraint fk_product_seller foreign key (idPseller) references seller (idSeller),
        constraint fk_product_product foreign key (idProduct) references product (idProduct)
);


-- criar tabela relaciona Produto Pedido

create table productOrder(
		idPOproduct int,
        idPOorder int,
        poQuantity int default 1,
        poStatus enum('Disponível','Sem estoque') default 'Disponível',
        primary key (idPOproduct, idPOorder),
        constraint fk_product_idPOproduct foreign key (idPOproduct) references product (idProduct),
        constraint fk_product_idPOorder foreign key (idPOorder) references orders (idOrder)
);

-- criar tabela localização estoque

create table storageLocation(
		idLproduct int,
        idLstorage int,
        location varchar(255),
        primary key (idLproduct, idLstorage),
        constraint fk_product_idPOproduct foreign key (idLproduct) references product (idProduct),
        constraint fk_product_idLstorage foreign key (idLstorage) references productStorage (idProductStorage)
);


-- criar tabela relacional Produto e Fornecedor

create table productSupplier(
		idPsSupplier int,
        idPsProduct int,
        PsQuantity int not null,
        primary key (idPsSupplier, idPsProduct),
        constraint fk_product_idPsSupplier foreign key (idPsSupplier) references supllier (idSupplier),
        constraint fk_product_idPsProduct foreign key (idPsProduct) references product (idProduct)
);

