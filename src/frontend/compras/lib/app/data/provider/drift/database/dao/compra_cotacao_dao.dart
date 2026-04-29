import 'package:drift/drift.dart';
import 'package:compras/app/data/provider/drift/database/database.dart';
import 'package:compras/app/data/provider/drift/database/database_imports.dart';

part 'compra_cotacao_dao.g.dart';

@DriftAccessor(tables: [
	CompraCotacaos,
	CompraFornecedorCotacaos,
	ViewPessoaFornecedors,
	CompraRequisicaos,
	CompraCotacaoDetalhes,
	Produtos,
])
class CompraCotacaoDao extends DatabaseAccessor<AppDatabase> with _$CompraCotacaoDaoMixin {
	final AppDatabase db;

	List<CompraCotacao> compraCotacaoList = []; 
	List<CompraCotacaoGrouped> compraCotacaoGroupedList = []; 

	CompraCotacaoDao(this.db) : super(db);

	Future<List<CompraCotacao>> getList() async {
		compraCotacaoList = await select(compraCotacaos).get();
		return compraCotacaoList;
	}

	Future<List<CompraCotacao>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		compraCotacaoList = await (select(compraCotacaos)..where((t) => expression)).get();
		return compraCotacaoList;	 
	}

	Future<List<CompraCotacaoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(compraCotacaos)
			.join([ 
				leftOuterJoin(compraRequisicaos, compraRequisicaos.id.equalsExp(compraCotacaos.idCompraRequisicao)), 
			]);

		if (field != null && field != '') { 
			final column = compraCotacaos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		compraCotacaoGroupedList = await query.map((row) {
			final compraCotacao = row.readTableOrNull(compraCotacaos); 
			final compraRequisicao = row.readTableOrNull(compraRequisicaos); 

			return CompraCotacaoGrouped(
				compraCotacao: compraCotacao, 
				compraRequisicao: compraRequisicao, 

			);
		}).get();

		// fill internal lists
		dynamic expression;
		for (var compraCotacaoGrouped in compraCotacaoGroupedList) {
			compraCotacaoGrouped.compraFornecedorCotacaoGroupedList = [];
			final queryCompraFornecedorCotacao = ' id_compra_cotacao = ${compraCotacaoGrouped.compraCotacao!.id}';
			expression = CustomExpression<bool>(queryCompraFornecedorCotacao);
			final compraFornecedorCotacaoList = await (select(compraFornecedorCotacaos)..where((t) => expression)).get();
			for (var compraFornecedorCotacao in compraFornecedorCotacaoList) {
				CompraFornecedorCotacaoGrouped compraFornecedorCotacaoGrouped = CompraFornecedorCotacaoGrouped(
					compraFornecedorCotacao: compraFornecedorCotacao,
					viewPessoaFornecedor: await (select(viewPessoaFornecedors)..where((t) => t.id.equals(compraFornecedorCotacao.idFornecedor!))).getSingleOrNull(),
				);
				compraCotacaoGrouped.compraFornecedorCotacaoGroupedList!.add(compraFornecedorCotacaoGrouped);
			}

			compraCotacaoGrouped.compraCotacaoDetalheGroupedList = [];
			final queryCompraCotacaoDetalhe = ' id_compra_cotacao = ${compraCotacaoGrouped.compraCotacao!.id}';
			expression = CustomExpression<bool>(queryCompraCotacaoDetalhe);
			final compraCotacaoDetalheList = await (select(compraCotacaoDetalhes)..where((t) => expression)).get();
			for (var compraCotacaoDetalhe in compraCotacaoDetalheList) {
				CompraCotacaoDetalheGrouped compraCotacaoDetalheGrouped = CompraCotacaoDetalheGrouped(
					compraCotacaoDetalhe: compraCotacaoDetalhe,
					produto: await (select(produtos)..where((t) => t.id.equals(compraCotacaoDetalhe.idProduto!))).getSingleOrNull(),
				);
				compraCotacaoGrouped.compraCotacaoDetalheGroupedList!.add(compraCotacaoDetalheGrouped);
			}

		}		

		return compraCotacaoGroupedList;	
	}

	Future<CompraCotacao?> getObject(dynamic pk) async {
		return await (select(compraCotacaos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<CompraCotacao?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM compra_cotacao WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as CompraCotacao;		 
	} 

	Future<CompraCotacaoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(CompraCotacaoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.compraCotacao = object.compraCotacao!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(compraCotacaos).insert(object.compraCotacao!);
			object.compraCotacao = object.compraCotacao!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(CompraCotacaoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(compraCotacaos).replace(object.compraCotacao!);
		});	 
	} 

	Future<int> deleteObject(CompraCotacaoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(compraCotacaos).delete(object.compraCotacao!);
		});		
	}

	Future<void> insertChildren(CompraCotacaoGrouped object) async {
		for (var compraFornecedorCotacaoGrouped in object.compraFornecedorCotacaoGroupedList!) {
			compraFornecedorCotacaoGrouped.compraFornecedorCotacao = compraFornecedorCotacaoGrouped.compraFornecedorCotacao?.copyWith(
				id: const Value(null),
				idCompraCotacao: Value(object.compraCotacao!.id),
			);
			await into(compraFornecedorCotacaos).insert(compraFornecedorCotacaoGrouped.compraFornecedorCotacao!);
		}
		for (var compraCotacaoDetalheGrouped in object.compraCotacaoDetalheGroupedList!) {
			compraCotacaoDetalheGrouped.compraCotacaoDetalhe = compraCotacaoDetalheGrouped.compraCotacaoDetalhe?.copyWith(
				id: const Value(null),
				idCompraCotacao: Value(object.compraCotacao!.id),
			);
			await into(compraCotacaoDetalhes).insert(compraCotacaoDetalheGrouped.compraCotacaoDetalhe!);
		}
	}
	
	Future<void> deleteChildren(CompraCotacaoGrouped object) async {
		await (delete(compraFornecedorCotacaos)..where((t) => t.idCompraCotacao.equals(object.compraCotacao!.id!))).go();
		await (delete(compraCotacaoDetalhes)..where((t) => t.idCompraCotacao.equals(object.compraCotacao!.id!))).go();
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from compra_cotacao").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}