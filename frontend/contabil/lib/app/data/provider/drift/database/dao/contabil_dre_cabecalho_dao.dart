import 'package:drift/drift.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';
import 'package:contabil/app/data/provider/drift/database/database_imports.dart';

part 'contabil_dre_cabecalho_dao.g.dart';

@DriftAccessor(tables: [
	ContabilDreCabecalhos,
	ContabilDreDetalhes,
])
class ContabilDreCabecalhoDao extends DatabaseAccessor<AppDatabase> with _$ContabilDreCabecalhoDaoMixin {
	final AppDatabase db;

	List<ContabilDreCabecalho> contabilDreCabecalhoList = []; 
	List<ContabilDreCabecalhoGrouped> contabilDreCabecalhoGroupedList = []; 

	ContabilDreCabecalhoDao(this.db) : super(db);

	Future<List<ContabilDreCabecalho>> getList() async {
		contabilDreCabecalhoList = await select(contabilDreCabecalhos).get();
		return contabilDreCabecalhoList;
	}

	Future<List<ContabilDreCabecalho>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		contabilDreCabecalhoList = await (select(contabilDreCabecalhos)..where((t) => expression)).get();
		return contabilDreCabecalhoList;	 
	}

	Future<List<ContabilDreCabecalhoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(contabilDreCabecalhos)
			.join([]);

		if (field != null && field != '') { 
			final column = contabilDreCabecalhos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		contabilDreCabecalhoGroupedList = await query.map((row) {
			final contabilDreCabecalho = row.readTableOrNull(contabilDreCabecalhos); 

			return ContabilDreCabecalhoGrouped(
				contabilDreCabecalho: contabilDreCabecalho, 

			);
		}).get();

		// fill internal lists
		dynamic expression;
		for (var contabilDreCabecalhoGrouped in contabilDreCabecalhoGroupedList) {
			contabilDreCabecalhoGrouped.contabilDreDetalheGroupedList = [];
			final queryContabilDreDetalhe = ' id_contabil_dre_cabecalho = ${contabilDreCabecalhoGrouped.contabilDreCabecalho!.id}';
			expression = CustomExpression<bool>(queryContabilDreDetalhe);
			final contabilDreDetalheList = await (select(contabilDreDetalhes)..where((t) => expression)).get();
			for (var contabilDreDetalhe in contabilDreDetalheList) {
				ContabilDreDetalheGrouped contabilDreDetalheGrouped = ContabilDreDetalheGrouped(
					contabilDreDetalhe: contabilDreDetalhe,
				);
				contabilDreCabecalhoGrouped.contabilDreDetalheGroupedList!.add(contabilDreDetalheGrouped);
			}

		}		

		return contabilDreCabecalhoGroupedList;	
	}

	Future<ContabilDreCabecalho?> getObject(dynamic pk) async {
		return await (select(contabilDreCabecalhos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<ContabilDreCabecalho?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM contabil_dre_cabecalho WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as ContabilDreCabecalho;		 
	} 

	Future<ContabilDreCabecalhoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(ContabilDreCabecalhoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.contabilDreCabecalho = object.contabilDreCabecalho!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(contabilDreCabecalhos).insert(object.contabilDreCabecalho!);
			object.contabilDreCabecalho = object.contabilDreCabecalho!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(ContabilDreCabecalhoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(contabilDreCabecalhos).replace(object.contabilDreCabecalho!);
		});	 
	} 

	Future<int> deleteObject(ContabilDreCabecalhoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(contabilDreCabecalhos).delete(object.contabilDreCabecalho!);
		});		
	}

	Future<void> insertChildren(ContabilDreCabecalhoGrouped object) async {
		for (var contabilDreDetalheGrouped in object.contabilDreDetalheGroupedList!) {
			contabilDreDetalheGrouped.contabilDreDetalhe = contabilDreDetalheGrouped.contabilDreDetalhe?.copyWith(
				id: const Value(null),
				idContabilDreCabecalho: Value(object.contabilDreCabecalho!.id),
			);
			await into(contabilDreDetalhes).insert(contabilDreDetalheGrouped.contabilDreDetalhe!);
		}
	}
	
	Future<void> deleteChildren(ContabilDreCabecalhoGrouped object) async {
		await (delete(contabilDreDetalhes)..where((t) => t.idContabilDreCabecalho.equals(object.contabilDreCabecalho!.id!))).go();
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from contabil_dre_cabecalho").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}