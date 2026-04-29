import 'package:drift/drift.dart';
import 'package:mdfe/app/data/provider/drift/database/database.dart';

@DataClassName("MdfeMunicipioDescarrega")
class MdfeMunicipioDescarregas extends Table {
	@override
	String get tableName => 'mdfe_municipio_descarrega';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idMdfeCabecalho => integer().named('id_mdfe_cabecalho').nullable()();
	TextColumn get codigoMunicipio => text().named('codigo_municipio').withLength(min: 0, max: 7).nullable()();
	TextColumn get nomeMunicipio => text().named('nome_municipio').withLength(min: 0, max: 60).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class MdfeMunicipioDescarregaGrouped {
	MdfeMunicipioDescarrega? mdfeMunicipioDescarrega; 

  MdfeMunicipioDescarregaGrouped({
		this.mdfeMunicipioDescarrega, 

  });
}
