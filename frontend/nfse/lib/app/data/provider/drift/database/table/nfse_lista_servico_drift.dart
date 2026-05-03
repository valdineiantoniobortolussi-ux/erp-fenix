import 'package:drift/drift.dart';
import 'package:nfse/app/data/provider/drift/database/database.dart';

@DataClassName("NfseListaServico")
class NfseListaServicos extends Table {
	@override
	String get tableName => 'nfse_lista_servico';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get codigo => text().named('codigo').withLength(min: 0, max: 5).nullable()();
	TextColumn get descricao => text().named('descricao').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class NfseListaServicoGrouped {
	NfseListaServico? nfseListaServico; 

  NfseListaServicoGrouped({
		this.nfseListaServico, 

  });
}
