import 'package:drift/drift.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';
import 'package:folha/app/data/provider/drift/database/database_imports.dart';

part 'empresa_transporte_dao.g.dart';

@DriftAccessor(tables: [
	EmpresaTransportes,
	EmpresaTransporteItinerarios,
])
class EmpresaTransporteDao extends DatabaseAccessor<AppDatabase> with _$EmpresaTransporteDaoMixin {
	final AppDatabase db;

	List<EmpresaTransporte> empresaTransporteList = []; 
	List<EmpresaTransporteGrouped> empresaTransporteGroupedList = []; 

	EmpresaTransporteDao(this.db) : super(db);

	Future<List<EmpresaTransporte>> getList() async {
		empresaTransporteList = await select(empresaTransportes).get();
		return empresaTransporteList;
	}

	Future<List<EmpresaTransporte>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		empresaTransporteList = await (select(empresaTransportes)..where((t) => expression)).get();
		return empresaTransporteList;	 
	}

	Future<List<EmpresaTransporteGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(empresaTransportes)
			.join([]);

		if (field != null && field != '') { 
			final column = empresaTransportes.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		empresaTransporteGroupedList = await query.map((row) {
			final empresaTransporte = row.readTableOrNull(empresaTransportes); 

			return EmpresaTransporteGrouped(
				empresaTransporte: empresaTransporte, 

			);
		}).get();

		// fill internal lists
		dynamic expression;
		for (var empresaTransporteGrouped in empresaTransporteGroupedList) {
			empresaTransporteGrouped.empresaTransporteItinerarioGroupedList = [];
			final queryEmpresaTransporteItinerario = ' id_empresa_transporte = ${empresaTransporteGrouped.empresaTransporte!.id}';
			expression = CustomExpression<bool>(queryEmpresaTransporteItinerario);
			final empresaTransporteItinerarioList = await (select(empresaTransporteItinerarios)..where((t) => expression)).get();
			for (var empresaTransporteItinerario in empresaTransporteItinerarioList) {
				EmpresaTransporteItinerarioGrouped empresaTransporteItinerarioGrouped = EmpresaTransporteItinerarioGrouped(
					empresaTransporteItinerario: empresaTransporteItinerario,
				);
				empresaTransporteGrouped.empresaTransporteItinerarioGroupedList!.add(empresaTransporteItinerarioGrouped);
			}

		}		

		return empresaTransporteGroupedList;	
	}

	Future<EmpresaTransporte?> getObject(dynamic pk) async {
		return await (select(empresaTransportes)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<EmpresaTransporte?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM empresa_transporte WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as EmpresaTransporte;		 
	} 

	Future<EmpresaTransporteGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(EmpresaTransporteGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.empresaTransporte = object.empresaTransporte!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(empresaTransportes).insert(object.empresaTransporte!);
			object.empresaTransporte = object.empresaTransporte!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(EmpresaTransporteGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(empresaTransportes).replace(object.empresaTransporte!);
		});	 
	} 

	Future<int> deleteObject(EmpresaTransporteGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(empresaTransportes).delete(object.empresaTransporte!);
		});		
	}

	Future<void> insertChildren(EmpresaTransporteGrouped object) async {
		for (var empresaTransporteItinerarioGrouped in object.empresaTransporteItinerarioGroupedList!) {
			empresaTransporteItinerarioGrouped.empresaTransporteItinerario = empresaTransporteItinerarioGrouped.empresaTransporteItinerario?.copyWith(
				id: const Value(null),
				idEmpresaTransporte: Value(object.empresaTransporte!.id),
			);
			await into(empresaTransporteItinerarios).insert(empresaTransporteItinerarioGrouped.empresaTransporteItinerario!);
		}
	}
	
	Future<void> deleteChildren(EmpresaTransporteGrouped object) async {
		await (delete(empresaTransporteItinerarios)..where((t) => t.idEmpresaTransporte.equals(object.empresaTransporte!.id!))).go();
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from empresa_transporte").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}