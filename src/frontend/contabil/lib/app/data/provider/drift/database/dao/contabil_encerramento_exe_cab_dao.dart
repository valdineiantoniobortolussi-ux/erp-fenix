import 'package:drift/drift.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';
import 'package:contabil/app/data/provider/drift/database/database_imports.dart';

part 'contabil_encerramento_exe_cab_dao.g.dart';

@DriftAccessor(tables: [
	ContabilEncerramentoExeCabs,
	ContabilEncerramentoExeDets,
	ContabilContas,
])
class ContabilEncerramentoExeCabDao extends DatabaseAccessor<AppDatabase> with _$ContabilEncerramentoExeCabDaoMixin {
	final AppDatabase db;

	List<ContabilEncerramentoExeCab> contabilEncerramentoExeCabList = []; 
	List<ContabilEncerramentoExeCabGrouped> contabilEncerramentoExeCabGroupedList = []; 

	ContabilEncerramentoExeCabDao(this.db) : super(db);

	Future<List<ContabilEncerramentoExeCab>> getList() async {
		contabilEncerramentoExeCabList = await select(contabilEncerramentoExeCabs).get();
		return contabilEncerramentoExeCabList;
	}

	Future<List<ContabilEncerramentoExeCab>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		contabilEncerramentoExeCabList = await (select(contabilEncerramentoExeCabs)..where((t) => expression)).get();
		return contabilEncerramentoExeCabList;	 
	}

	Future<List<ContabilEncerramentoExeCabGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(contabilEncerramentoExeCabs)
			.join([]);

		if (field != null && field != '') { 
			final column = contabilEncerramentoExeCabs.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		contabilEncerramentoExeCabGroupedList = await query.map((row) {
			final contabilEncerramentoExeCab = row.readTableOrNull(contabilEncerramentoExeCabs); 

			return ContabilEncerramentoExeCabGrouped(
				contabilEncerramentoExeCab: contabilEncerramentoExeCab, 

			);
		}).get();

		// fill internal lists
		dynamic expression;
		for (var contabilEncerramentoExeCabGrouped in contabilEncerramentoExeCabGroupedList) {
			contabilEncerramentoExeCabGrouped.contabilEncerramentoExeDetGroupedList = [];
			final queryContabilEncerramentoExeDet = ' id_contabil_encerramento_exe = ${contabilEncerramentoExeCabGrouped.contabilEncerramentoExeCab!.id}';
			expression = CustomExpression<bool>(queryContabilEncerramentoExeDet);
			final contabilEncerramentoExeDetList = await (select(contabilEncerramentoExeDets)..where((t) => expression)).get();
			for (var contabilEncerramentoExeDet in contabilEncerramentoExeDetList) {
				ContabilEncerramentoExeDetGrouped contabilEncerramentoExeDetGrouped = ContabilEncerramentoExeDetGrouped(
					contabilEncerramentoExeDet: contabilEncerramentoExeDet,
					contabilConta: await (select(contabilContas)..where((t) => t.id.equals(contabilEncerramentoExeDet.idContabilConta!))).getSingleOrNull(),
				);
				contabilEncerramentoExeCabGrouped.contabilEncerramentoExeDetGroupedList!.add(contabilEncerramentoExeDetGrouped);
			}

		}		

		return contabilEncerramentoExeCabGroupedList;	
	}

	Future<ContabilEncerramentoExeCab?> getObject(dynamic pk) async {
		return await (select(contabilEncerramentoExeCabs)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<ContabilEncerramentoExeCab?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM contabil_encerramento_exe_cab WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as ContabilEncerramentoExeCab;		 
	} 

	Future<ContabilEncerramentoExeCabGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(ContabilEncerramentoExeCabGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.contabilEncerramentoExeCab = object.contabilEncerramentoExeCab!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(contabilEncerramentoExeCabs).insert(object.contabilEncerramentoExeCab!);
			object.contabilEncerramentoExeCab = object.contabilEncerramentoExeCab!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(ContabilEncerramentoExeCabGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(contabilEncerramentoExeCabs).replace(object.contabilEncerramentoExeCab!);
		});	 
	} 

	Future<int> deleteObject(ContabilEncerramentoExeCabGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(contabilEncerramentoExeCabs).delete(object.contabilEncerramentoExeCab!);
		});		
	}

	Future<void> insertChildren(ContabilEncerramentoExeCabGrouped object) async {
		for (var contabilEncerramentoExeDetGrouped in object.contabilEncerramentoExeDetGroupedList!) {
			contabilEncerramentoExeDetGrouped.contabilEncerramentoExeDet = contabilEncerramentoExeDetGrouped.contabilEncerramentoExeDet?.copyWith(
				id: const Value(null),
				idContabilEncerramentoExe: Value(object.contabilEncerramentoExeCab!.id),
			);
			await into(contabilEncerramentoExeDets).insert(contabilEncerramentoExeDetGrouped.contabilEncerramentoExeDet!);
		}
	}
	
	Future<void> deleteChildren(ContabilEncerramentoExeCabGrouped object) async {
		await (delete(contabilEncerramentoExeDets)..where((t) => t.idContabilEncerramentoExe.equals(object.contabilEncerramentoExeCab!.id!))).go();
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from contabil_encerramento_exe_cab").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}