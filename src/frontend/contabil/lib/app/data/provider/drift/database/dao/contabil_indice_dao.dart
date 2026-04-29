import 'package:drift/drift.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';
import 'package:contabil/app/data/provider/drift/database/database_imports.dart';

part 'contabil_indice_dao.g.dart';

@DriftAccessor(tables: [
	ContabilIndices,
	ContabilIndiceValors,
])
class ContabilIndiceDao extends DatabaseAccessor<AppDatabase> with _$ContabilIndiceDaoMixin {
	final AppDatabase db;

	List<ContabilIndice> contabilIndiceList = []; 
	List<ContabilIndiceGrouped> contabilIndiceGroupedList = []; 

	ContabilIndiceDao(this.db) : super(db);

	Future<List<ContabilIndice>> getList() async {
		contabilIndiceList = await select(contabilIndices).get();
		return contabilIndiceList;
	}

	Future<List<ContabilIndice>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		contabilIndiceList = await (select(contabilIndices)..where((t) => expression)).get();
		return contabilIndiceList;	 
	}

	Future<List<ContabilIndiceGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(contabilIndices)
			.join([]);

		if (field != null && field != '') { 
			final column = contabilIndices.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		contabilIndiceGroupedList = await query.map((row) {
			final contabilIndice = row.readTableOrNull(contabilIndices); 

			return ContabilIndiceGrouped(
				contabilIndice: contabilIndice, 

			);
		}).get();

		// fill internal lists
		dynamic expression;
		for (var contabilIndiceGrouped in contabilIndiceGroupedList) {
			contabilIndiceGrouped.contabilIndiceValorGroupedList = [];
			final queryContabilIndiceValor = ' id_contabil_indice = ${contabilIndiceGrouped.contabilIndice!.id}';
			expression = CustomExpression<bool>(queryContabilIndiceValor);
			final contabilIndiceValorList = await (select(contabilIndiceValors)..where((t) => expression)).get();
			for (var contabilIndiceValor in contabilIndiceValorList) {
				ContabilIndiceValorGrouped contabilIndiceValorGrouped = ContabilIndiceValorGrouped(
					contabilIndiceValor: contabilIndiceValor,
				);
				contabilIndiceGrouped.contabilIndiceValorGroupedList!.add(contabilIndiceValorGrouped);
			}

		}		

		return contabilIndiceGroupedList;	
	}

	Future<ContabilIndice?> getObject(dynamic pk) async {
		return await (select(contabilIndices)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<ContabilIndice?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM contabil_indice WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as ContabilIndice;		 
	} 

	Future<ContabilIndiceGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(ContabilIndiceGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.contabilIndice = object.contabilIndice!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(contabilIndices).insert(object.contabilIndice!);
			object.contabilIndice = object.contabilIndice!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(ContabilIndiceGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(contabilIndices).replace(object.contabilIndice!);
		});	 
	} 

	Future<int> deleteObject(ContabilIndiceGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(contabilIndices).delete(object.contabilIndice!);
		});		
	}

	Future<void> insertChildren(ContabilIndiceGrouped object) async {
		for (var contabilIndiceValorGrouped in object.contabilIndiceValorGroupedList!) {
			contabilIndiceValorGrouped.contabilIndiceValor = contabilIndiceValorGrouped.contabilIndiceValor?.copyWith(
				id: const Value(null),
				idContabilIndice: Value(object.contabilIndice!.id),
			);
			await into(contabilIndiceValors).insert(contabilIndiceValorGrouped.contabilIndiceValor!);
		}
	}
	
	Future<void> deleteChildren(ContabilIndiceGrouped object) async {
		await (delete(contabilIndiceValors)..where((t) => t.idContabilIndice.equals(object.contabilIndice!.id!))).go();
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from contabil_indice").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}