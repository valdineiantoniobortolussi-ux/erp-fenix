import 'package:drift/drift.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';
import 'package:contabil/app/data/provider/drift/database/database_imports.dart';

part 'contabil_lancamento_cabecalho_dao.g.dart';

@DriftAccessor(tables: [
	ContabilLancamentoCabecalhos,
	ContabilLancamentoDetalhes,
	ContabilContas,
	ContabilHistoricos,
	ContabilLotes,
])
class ContabilLancamentoCabecalhoDao extends DatabaseAccessor<AppDatabase> with _$ContabilLancamentoCabecalhoDaoMixin {
	final AppDatabase db;

	List<ContabilLancamentoCabecalho> contabilLancamentoCabecalhoList = []; 
	List<ContabilLancamentoCabecalhoGrouped> contabilLancamentoCabecalhoGroupedList = []; 

	ContabilLancamentoCabecalhoDao(this.db) : super(db);

	Future<List<ContabilLancamentoCabecalho>> getList() async {
		contabilLancamentoCabecalhoList = await select(contabilLancamentoCabecalhos).get();
		return contabilLancamentoCabecalhoList;
	}

	Future<List<ContabilLancamentoCabecalho>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		contabilLancamentoCabecalhoList = await (select(contabilLancamentoCabecalhos)..where((t) => expression)).get();
		return contabilLancamentoCabecalhoList;	 
	}

	Future<List<ContabilLancamentoCabecalhoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(contabilLancamentoCabecalhos)
			.join([ 
				leftOuterJoin(contabilLotes, contabilLotes.id.equalsExp(contabilLancamentoCabecalhos.idContabilLote)), 
			]);

		if (field != null && field != '') { 
			final column = contabilLancamentoCabecalhos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		contabilLancamentoCabecalhoGroupedList = await query.map((row) {
			final contabilLancamentoCabecalho = row.readTableOrNull(contabilLancamentoCabecalhos); 
			final contabilLote = row.readTableOrNull(contabilLotes); 

			return ContabilLancamentoCabecalhoGrouped(
				contabilLancamentoCabecalho: contabilLancamentoCabecalho, 
				contabilLote: contabilLote, 

			);
		}).get();

		// fill internal lists
		dynamic expression;
		for (var contabilLancamentoCabecalhoGrouped in contabilLancamentoCabecalhoGroupedList) {
			contabilLancamentoCabecalhoGrouped.contabilLancamentoDetalheGroupedList = [];
			final queryContabilLancamentoDetalhe = ' id_contabil_lancamento_cab = ${contabilLancamentoCabecalhoGrouped.contabilLancamentoCabecalho!.id}';
			expression = CustomExpression<bool>(queryContabilLancamentoDetalhe);
			final contabilLancamentoDetalheList = await (select(contabilLancamentoDetalhes)..where((t) => expression)).get();
			for (var contabilLancamentoDetalhe in contabilLancamentoDetalheList) {
				ContabilLancamentoDetalheGrouped contabilLancamentoDetalheGrouped = ContabilLancamentoDetalheGrouped(
					contabilLancamentoDetalhe: contabilLancamentoDetalhe,
					contabilConta: await (select(contabilContas)..where((t) => t.id.equals(contabilLancamentoDetalhe.idContabilConta!))).getSingleOrNull(),
					contabilHistorico: await (select(contabilHistoricos)..where((t) => t.id.equals(contabilLancamentoDetalhe.idContabilHistorico!))).getSingleOrNull(),
				);
				contabilLancamentoCabecalhoGrouped.contabilLancamentoDetalheGroupedList!.add(contabilLancamentoDetalheGrouped);
			}

		}		

		return contabilLancamentoCabecalhoGroupedList;	
	}

	Future<ContabilLancamentoCabecalho?> getObject(dynamic pk) async {
		return await (select(contabilLancamentoCabecalhos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<ContabilLancamentoCabecalho?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM contabil_lancamento_cabecalho WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as ContabilLancamentoCabecalho;		 
	} 

	Future<ContabilLancamentoCabecalhoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(ContabilLancamentoCabecalhoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.contabilLancamentoCabecalho = object.contabilLancamentoCabecalho!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(contabilLancamentoCabecalhos).insert(object.contabilLancamentoCabecalho!);
			object.contabilLancamentoCabecalho = object.contabilLancamentoCabecalho!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(ContabilLancamentoCabecalhoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(contabilLancamentoCabecalhos).replace(object.contabilLancamentoCabecalho!);
		});	 
	} 

	Future<int> deleteObject(ContabilLancamentoCabecalhoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(contabilLancamentoCabecalhos).delete(object.contabilLancamentoCabecalho!);
		});		
	}

	Future<void> insertChildren(ContabilLancamentoCabecalhoGrouped object) async {
		for (var contabilLancamentoDetalheGrouped in object.contabilLancamentoDetalheGroupedList!) {
			contabilLancamentoDetalheGrouped.contabilLancamentoDetalhe = contabilLancamentoDetalheGrouped.contabilLancamentoDetalhe?.copyWith(
				id: const Value(null),
				idContabilLancamentoCab: Value(object.contabilLancamentoCabecalho!.id),
			);
			await into(contabilLancamentoDetalhes).insert(contabilLancamentoDetalheGrouped.contabilLancamentoDetalhe!);
		}
	}
	
	Future<void> deleteChildren(ContabilLancamentoCabecalhoGrouped object) async {
		await (delete(contabilLancamentoDetalhes)..where((t) => t.idContabilLancamentoCab.equals(object.contabilLancamentoCabecalho!.id!))).go();
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from contabil_lancamento_cabecalho").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}