import 'package:drift/drift.dart';
import 'package:wms/app/data/provider/drift/database/database.dart';

@DataClassName("WmsRecebimentoDetalhe")
class WmsRecebimentoDetalhes extends Table {
	@override
	String get tableName => 'wms_recebimento_detalhe';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idWmsRecebimentoCabecalho => integer().named('id_wms_recebimento_cabecalho').nullable()();
	IntColumn get idProduto => integer().named('id_produto').nullable()();
	IntColumn get quantidadeVolume => integer().named('quantidade_volume').nullable()();
	IntColumn get quantidadeItemPorVolume => integer().named('quantidade_item_por_volume').nullable()();
	IntColumn get quantidadeRecebida => integer().named('quantidade_recebida').nullable()();
	TextColumn get destino => text().named('destino').withLength(min: 0, max: 1).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class WmsRecebimentoDetalheGrouped {
	WmsRecebimentoDetalhe? wmsRecebimentoDetalhe; 
	Produto? produto; 

  WmsRecebimentoDetalheGrouped({
		this.wmsRecebimentoDetalhe, 
		this.produto, 

  });
}
