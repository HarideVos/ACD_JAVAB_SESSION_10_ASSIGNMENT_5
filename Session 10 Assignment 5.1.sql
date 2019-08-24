create schema employeeleaverecord1051;
use employeeleaverecord1051;


create table employeetype(
emptype enum ('perm', 'temp'),
paid int,
earned int,
sick int,
vacations int,
primary key (emptype)
);

create table salary(
base int,
total double generated always as ((1+pf+da+allowance)* base) stored unique,
pf decimal,
da decimal,
allowance decimal, 
primary key (base, total)
);

create table employee (
id int auto_increment,
ename varchar(45),
emptype enum ('perm', 'temp'),
phoneno int,
email varchar(45),
basepay int,
totalpay double,
foreign key fk_emptype(emptype) references employeetype(emptype),
primary key (id)
);

insert into employeetype values
('perm', 40, 5, 10, 15),('temp', 40, null, null, 15)
;

INSERT INTO salary (`base`, `pf`, `da`, `allowance`) VALUES ('300', '.12', '.60', '.50');
INSERT INTO salary (`base`, `pf`, `da`, `allowance`) VALUES ('150', '.12', '.60', '.50');
INSERT INTO salary (`base`, `pf`, `da`, `allowance`) VALUES ('250', '.12', '.60', '.50');
INSERT INTO salary (`base`, `pf`, `da`, `allowance`) VALUES ('200', '.12', '.60', '.50');
INSERT INTO salary (`base`, `pf`, `da`, `allowance`) VALUES ('600', '.12', '.60', '.50');

INSERT INTO employee (`id`, `ename`, `emptype`, `phoneno`, `email`) VALUES ('1234', 'Darren', 'perm', '000000', 'd@d.com');
INSERT INTO employee (`id`, `ename`, `emptype`, `phoneno`, `email`) VALUES ('2345', 'Ove', 'temp', '111111', 'o@o.com');
INSERT INTO employee (`id`, `ename`, `emptype`, `phoneno`, `email`) VALUES ('3456', 'Niels', 'perm', '222222', 'n@n.com');
INSERT INTO employee (`id`, `ename`, `emptype`, `phoneno`, `email`) VALUES ('4567', 'Jozef', 'temp', '333333', 'j@j.com');
INSERT INTO employee (`id`, `ename`, `emptype`, `phoneno`, `email`) VALUES ('5678', 'Ulrich', 'perm', '444444', 'u@u.com');




