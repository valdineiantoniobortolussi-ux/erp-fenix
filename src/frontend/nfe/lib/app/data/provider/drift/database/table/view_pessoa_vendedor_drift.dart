import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';

@DataClassName("ViewPessoaVendedor")
class ViewPessoaVendedors extends Table {
	@override
	String get tableName => 'view_pessoa_vendedor';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 450).nullable()();
	TextColumn get tipo => text().named('tipo').withLength(min: 0, max: 3).nullable()();
	TextColumn get email => text().named('email').withLength(min: 0, max: 750).nullable()();
	TextColumn get site => text().named('site').withLength(min: 0, max: 450).nullable()();
	TextColumn get cpfCnpj => text().named('cpf_cnpj').withLength(min: 0, max: 20).nullable()();
	TextColumn get rgIe => text().named('rg_ie').withLength(min: 0, max: 20).nullable()();
	TextColumn get matricula => text().named('matricula').withLength(min: 0, max: 50).nullable()();
	DateTimeColumn get dataCadastro => dateTime().named('data_cadastro').nullable()();
	DateTimeColumn get dataAdmissao => dateTime().named('data_admissao').nullable()();
	DateTimeColumn get dataDemissao => dateTime().named('data_demissao').nullable()();
	TextColumn get ctpsNumero => text().named('ctps_numero').withLength(min: 0, max: 20).nullable()();
	TextColumn get ctpsSerie => text().named('ctps_serie').withLength(min: 0, max: 10).nullable()();
	DateTimeColumn get ctpsDataExpedicao => dateTime().named('ctps_data_expedicao').nullable()();
	TextColumn get ctpsUf => text().named('ctps_uf').withLength(min: 0, max: 2).nullable()();
	TextColumn get observacao => text().named('observacao').nullable()();
	TextColumn get logradouro => text().named('logradouro').withLength(min: 0, max: 450).nullable()();
	TextColumn get numero => text().named('numero').withLength(min: 0, max: 20).nullable()();
	TextColumn get complemento => text().named('complemento').withLength(min: 0, max: 450).nullable()();
	TextColumn get bairro => text().named('bairro').withLength(min: 0, max: 150).nullable()();
	TextColumn get cidade => text().named('cidade').withLength(min: 0, max: 150).nullable()();
	TextColumn get cep => text().named('cep').withLength(min: 0, max: 10).nullable()();
	TextColumn get municipioIbge => text().named('municipio_ibge').withLength(min: 0, max: 10).nullable()();
	TextColumn get uf => text().named('uf').withLength(min: 0, max: 2).nullable()();
	IntColumn get idPessoa => integer().named('id_pessoa').nullable()();
	IntColumn get idCargo => integer().named('id_cargo').nullable()();
	IntColumn get idSetor => integer().named('id_setor').nullable()();
	RealColumn get comissao => real().named('comissao').nullable()();
	RealColumn get metaVenda => real().named('meta_venda').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class ViewPessoaVendedorGrouped {
	ViewPessoaVendedor? viewPessoaVendedor; 

  ViewPessoaVendedorGrouped({
		this.viewPessoaVendedor, 

  });
}
