-- criação do banco de dados para o cenário de Oficina Mecânica
-- drop database Oficina_Mecanica;
-- drop table OSCliente;

-- show databases;
create database Oficina_Mecanica;

use Oficina_Mecanica;

-- criar tabela cliente

create table cliente(
	idCliente int auto_increment primary key,
    Nome varchar(10),
    Sobrenome varchar(20),
    CPF char(11) not null,
    logradouro varchar(30),
    Número int not null,
    Bairro varchar(20),
    Cidade varchar(20),
    Estado Varchar(20),
    País Varchar(20),
    constraint unique_cpf_client unique (CPF)
    );

create table funcionarios(
	idFuncionario int auto_increment primary key,
    Nome varchar(10),
    Sobrenome varchar(20),
    CPF char(11) not null,
    dtAniversário date,
    Função varchar(45),
    dtAdmissao date,
    logradouro varchar(30),
    Número int not null,
    Bairro varchar(20),
    Cidade varchar(20),
    Estado Varchar(20),
    País Varchar(20),
    constraint unique_cpf_client unique (CPF)
    );
    
create table servicos(
	IdServico int auto_increment primary key,
    NomeServico varchar(45) not null,
    ValorServico float,
	Tiposervico enum('Manutenção', 'Revisão')
    );

create table fornecedor(
	idFornecedor int auto_increment primary key,
    Razão_Social varchar(45),
    Nome_Fantasia varchar(45),
    CNPJ char(15),
    CPF char(11),
    Contato char(11),
    logradouro varchar(30),
    Número int not null,
    Bairro varchar(20),
    Cidade varchar(20),
    Estado Varchar(20),
    País Varchar(20),
    constraint unique_CNPJ_fornecedor unique (CNPJ),
    constraint unique_CPF_fornecedor unique (CPF)
    );

create table estoque(
	idEProduto int auto_increment primary key, 
    idEFornecedor int,
	nomeProduto varchar(45) not null,
    valorProduto float not null,
    quantProduto int,
    constraint fk_estoque_Fornecedor foreign key (idEFornecedor) references Fornecedor(idFornecedor)
    );

create table ordemServico(
	idOServico int auto_increment primary key,
    statusServico enum('Em análise', 'Em execução', 'Concluído') default 'Em análise',
	dtOServico date,
    dtEntregaServico date,   
    idOSFuncionario int,
    idOSCliente int,
    constraint fk_ordemServico_Funcionario foreign key (idOSFuncionario) references funcionarios(idFuncionario),
    constraint fk_ordemServico_Cliente foreign key (idOSCliente) references cliente(idCliente)
);

create table OSfuncionarios(
	idOSFFuncionarios int,
	idOSfServicos int,
    primary key(idOSFFuncionarios,idOSfServicos),
    constraint fk_OSFFuncionarios_Funcionarios foreign key (idOSFFuncionarios) references funcionarios(idFuncionario),
    constraint fk_OSFFuncionarios_Servicos foreign key (idOSfServicos) references ordemServico(idOServico) 
); 

create table OSCliente(
	idOSCServico int,
	idOSCCliente int,
    primary key(idOSCServico,idOSCCliente),
    constraint fk_OSCCliente_OSCServico foreign key (idOSCServico) references ordemServico(idOServico),
    constraint fk_OSCCliente_OSCCliente foreign key (idOSCCliente ) references Cliente(idCliente)
   ); 

create table OSEstoque(
	idOSEProduto int,
    idOSServicos int,
    idOSEFornecedor int,
    primary key (idOSEProduto,idOSServicos),
    constraint fk_OSEstoque_Servicos foreign key (idOSServicos) references ordemServico(idOServico),
	constraint fk_OSEstoque_Produto foreign key (idOSEProduto) references estoque(idEProduto),
	constraint fk_OSEstoque_Fornecedor foreign key (idOSEFornecedor) references estoque(idEFornecedor)
);

create table OSServicos(
	idOSSServicos int,
    idSServicos int,
    primary key(idOSSServicos,idSServicos),
	constraint fk_OSServicos_Servicos foreign key (idOSSServicos) references ordemServico(idOServico),
	constraint fk_OSServicos_Produto foreign key (idSServicos) references servicos(IdServico)
);