import 'package:drift/drift.dart';
import 'package:nfse/app/data/provider/drift/database/database.dart';
import 'package:nfse/app/data/provider/drift/database/database_imports.dart';

part 'os_status_dao.g.dart';

@DriftAccessor(tables: [
	OsStatuss,
	OsAberturas,
	ViewPessoaColaboradors,
	ViewPessoaClientes,
])
class OsStatusDao extends DatabaseAccessor<AppDatabase> with _$OsStatusDaoMixin {
	final AppDatabase db;

	List<OsStatus> osStatusList = []; 
	List<OsStatusGrouped> osStatusGroupedList = []; 

	OsStatusDao(this.db) : super(db);

	Future<List<OsStatus>> getList() async {
		osStatusList = await select(osStatuss).get();
		return osStatusList;
	}

	Future<List<OsStatus>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		osStatusList = await (select(osStatuss)..where((t) => expression)).get();
		return osStatusList;	 
	}

	Future<List<OsStatusGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(osStatuss)
			.join([]);

		if (field != null && field != '') { 
			final column = osStatuss.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		osStatusGroupedList = await query.map((row) {
			final osStatus = row.readTableOrNull(osStatuss); 

			return OsStatusGrouped(
				osStatus: osStatus, 

			);
		}).get();

		// fill internal lists
		dynamic expression;
		for (var osStatusGrouped in osStatusGroupedList) {
			osStatusGrouped.osAberturaGroupedList = [];
			final queryOsAbertura = ' id_os_status = ${osStatusGrouped.osStatus!.id}';
			expression = CustomExpression<bool>(queryOsAbertura);
			final osAberturaList = await (select(osAberturas)..where((t) => expression)).get();
			for (var osAbertura in osAberturaList) {
				OsAberturaGrouped osAberturaGrouped = OsAberturaGrouped(
					osAbertura: osAbertura,
					viewPessoaColaborador: await (select(viewPessoaColaboradors)..where((t) => t.id.equals(osAbertura.idColaborador!))).getSingleOrNull(),
					viewPessoaCliente: await (select(viewPessoaClientes)..where((t) => t.id.equals(osAbertura.idCliente!))).getSingleOrNull(),
				);
				osStatusGrouped.osAberturaGroupedList!.add(osAberturaGrouped);
			}

		}		

		return osStatusGroupedList;	
	}

	Future<OsStatus?> getObject(dynamic pk) async {
		return await (select(osStatuss)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<OsStatus?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM os_status WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as OsStatus;		 
	} 

	Future<OsStatusGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(OsStatusGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.osStatus = object.osStatus!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(osStatuss).insert(object.osStatus!);
			object.osStatus = object.osStatus!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(OsStatusGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(osStatuss).replace(object.osStatus!);
		});	 
	} 

	Future<int> deleteObject(OsStatusGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(osStatuss).delete(object.osStatus!);
		});		
	}

	Future<void> insertChildren(OsStatusGrouped object) async {
		for (var osAberturaGrouped in object.osAberturaGroupedList!) {
			osAberturaGrouped.osAbertura = osAberturaGrouped.osAbertura?.copyWith(
				id: const Value(null),
				idOsStatus: Value(object.osStatus!.id),
			);
			await into(osAberturas).insert(osAberturaGrouped.osAbertura!);
		}
	}
	
	Future<void> deleteChildren(OsStatusGrouped object) async {
		await (delete(osAberturas)..where((t) => t.idOsStatus.equals(object.osStatus!.id!))).go();
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from os_status").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}