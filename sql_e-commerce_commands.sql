use ecommerce;

show tables;

show databases;

show tables;

desc referential_constraints;

use information_schema;

select * from referential_constraints where constraint_schema = 'ecommerce';

select * from productSelle;

select count(*) from clients;

select * from clients c, orders o where c.idClient = idOrderClient;

select concat(Fname,' ', Lname) as Complete_Name, idOrder as Request, orderStatus as Order_Status from clients c, orders o where c.idClient = idOrderClient;

select * from clients c, orders o
			where c.idClient = idOrderClient
            group by idOrder;

select count(*) from clients c, orders o
			where c.idClient = idOrderClient
            group by idOrder;

select * from Clients
	left outer join orders ON idClient = idOrderClient;

select * from productOrder;

-- recuperação de pedido com produto associado
select * from clients c 
			inner join orders o on c.idClient = o.idOrderClient
			inner join productOrder p on p.idPOrder = o.idOrder
            group by idClient;

-- Recuperar quantos pedidos foram realizados pelos clientes?
select c.idClient, Fname, count(*) as Number_of_orders from clients c 
			inner join orders o on c.idClient = o.idOrderClient
			inner join productOrder p on p.idPOrder = o.idOrder
            group by idClient;



