import 'package:drift/drift.dart';
import 'package:estoque/app/data/provider/drift/database/database.dart';
import 'package:estoque/app/data/provider/drift/database/database_imports.dart';

part 'estoque_reajuste_cabecalho_dao.g.dart';

@DriftAccessor(tables: [
	EstoqueReajusteCabecalhos,
	EstoqueReajusteDetalhes,
	Produtos,
	ViewPessoaColaboradors,
])
class EstoqueReajusteCabecalhoDao extends DatabaseAccessor<AppDatabase> with _$EstoqueReajusteCabecalhoDaoMixin {
	final AppDatabase db;

	List<EstoqueReajusteCabecalho> estoqueReajusteCabecalhoList = []; 
	List<EstoqueReajusteCabecalhoGrouped> estoqueReajusteCabecalhoGroupedList = []; 

	EstoqueReajusteCabecalhoDao(this.db) : super(db);

	Future<List<EstoqueReajusteCabecalho>> getList() async {
		estoqueReajusteCabecalhoList = await select(estoqueReajusteCabecalhos).get();
		return estoqueReajusteCabecalhoList;
	}

	Future<List<EstoqueReajusteCabecalho>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		estoqueReajusteCabecalhoList = await (select(estoqueReajusteCabecalhos)..where((t) => expression)).get();
		return estoqueReajusteCabecalhoList;	 
	}

	Future<List<EstoqueReajusteCabecalhoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(estoqueReajusteCabecalhos)
			.join([ 
				leftOuterJoin(viewPessoaColaboradors, viewPessoaColaboradors.id.equalsExp(estoqueReajusteCabecalhos.idColaborador)), 
			]);

		if (field != null && field != '') { 
			final column = estoqueReajusteCabecalhos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		estoqueReajusteCabecalhoGroupedList = await query.map((row) {
			final estoqueReajusteCabecalho = row.readTableOrNull(estoqueReajusteCabecalhos); 
			final viewPessoaColaborador = row.readTableOrNull(viewPessoaColaboradors); 

			return EstoqueReajusteCabecalhoGrouped(
				estoqueReajusteCabecalho: estoqueReajusteCabecalho, 
				viewPessoaColaborador: viewPessoaColaborador, 

			);
		}).get();

		// fill internal lists
		dynamic expression;
		for (var estoqueReajusteCabecalhoGrouped in estoqueReajusteCabecalhoGroupedList) {
			estoqueReajusteCabecalhoGrouped.estoqueReajusteDetalheGroupedList = [];
			final queryEstoqueReajusteDetalhe = ' id_estoque_reajuste_cabecalho = ${estoqueReajusteCabecalhoGrouped.estoqueReajusteCabecalho!.id}';
			expression = CustomExpression<bool>(queryEstoqueReajusteDetalhe);
			final estoqueReajusteDetalheList = await (select(estoqueReajusteDetalhes)..where((t) => expression)).get();
			for (var estoqueReajusteDetalhe in estoqueReajusteDetalheList) {
				EstoqueReajusteDetalheGrouped estoqueReajusteDetalheGrouped = EstoqueReajusteDetalheGrouped(
					estoqueReajusteDetalhe: estoqueReajusteDetalhe,
					produto: await (select(produtos)..where((t) => t.id.equals(estoqueReajusteDetalhe.idProduto!))).getSingleOrNull(),
				);
				estoqueReajusteCabecalhoGrouped.estoqueReajusteDetalheGroupedList!.add(estoqueReajusteDetalheGrouped);
			}

		}		

		return estoqueReajusteCabecalhoGroupedList;	
	}

	Future<EstoqueReajusteCabecalho?> getObject(dynamic pk) async {
		return await (select(estoqueReajusteCabecalhos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<EstoqueReajusteCabecalho?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM estoque_reajuste_cabecalho WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as EstoqueReajusteCabecalho;		 
	} 

	Future<EstoqueReajusteCabecalhoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(EstoqueReajusteCabecalhoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.estoqueReajusteCabecalho = object.estoqueReajusteCabecalho!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(estoqueReajusteCabecalhos).insert(object.estoqueReajusteCabecalho!);
			object.estoqueReajusteCabecalho = object.estoqueReajusteCabecalho!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(EstoqueReajusteCabecalhoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(estoqueReajusteCabecalhos).replace(object.estoqueReajusteCabecalho!);
		});	 
	} 

	Future<int> deleteObject(EstoqueReajusteCabecalhoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(estoqueReajusteCabecalhos).delete(object.estoqueReajusteCabecalho!);
		});		
	}

	Future<void> insertChildren(EstoqueReajusteCabecalhoGrouped object) async {
		for (var estoqueReajusteDetalheGrouped in object.estoqueReajusteDetalheGroupedList!) {
			estoqueReajusteDetalheGrouped.estoqueReajusteDetalhe = estoqueReajusteDetalheGrouped.estoqueReajusteDetalhe?.copyWith(
				id: const Value(null),
				idEstoqueReajusteCabecalho: Value(object.estoqueReajusteCabecalho!.id),
			);
			await into(estoqueReajusteDetalhes).insert(estoqueReajusteDetalheGrouped.estoqueReajusteDetalhe!);
		}
	}
	
	Future<void> deleteChildren(EstoqueReajusteCabecalhoGrouped object) async {
		await (delete(estoqueReajusteDetalhes)..where((t) => t.idEstoqueReajusteCabecalho.equals(object.estoqueReajusteCabecalho!.id!))).go();
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from estoque_reajuste_cabecalho").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}