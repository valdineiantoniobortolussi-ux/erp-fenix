import 'package:drift/drift.dart';
import 'package:contratos/app/data/provider/drift/database/database.dart';
import 'package:contratos/app/data/provider/drift/database/database_imports.dart';

part 'tipo_contrato_dao.g.dart';

@DriftAccessor(tables: [
	TipoContratos,
])
class TipoContratoDao extends DatabaseAccessor<AppDatabase> with _$TipoContratoDaoMixin {
	final AppDatabase db;

	List<TipoContrato> tipoContratoList = []; 
	List<TipoContratoGrouped> tipoContratoGroupedList = []; 

	TipoContratoDao(this.db) : super(db);

	Future<List<TipoContrato>> getList() async {
		tipoContratoList = await select(tipoContratos).get();
		return tipoContratoList;
	}

	Future<List<TipoContrato>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		tipoContratoList = await (select(tipoContratos)..where((t) => expression)).get();
		return tipoContratoList;	 
	}

	Future<List<TipoContratoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(tipoContratos)
			.join([]);

		if (field != null && field != '') { 
			final column = tipoContratos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		tipoContratoGroupedList = await query.map((row) {
			final tipoContrato = row.readTableOrNull(tipoContratos); 

			return TipoContratoGrouped(
				tipoContrato: tipoContrato, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var tipoContratoGrouped in tipoContratoGroupedList) {
		//}		

		return tipoContratoGroupedList;	
	}

	Future<TipoContrato?> getObject(dynamic pk) async {
		return await (select(tipoContratos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<TipoContrato?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM tipo_contrato WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as TipoContrato;		 
	} 

	Future<TipoContratoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(TipoContratoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.tipoContrato = object.tipoContrato!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(tipoContratos).insert(object.tipoContrato!);
			object.tipoContrato = object.tipoContrato!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(TipoContratoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(tipoContratos).replace(object.tipoContrato!);
		});	 
	} 

	Future<int> deleteObject(TipoContratoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(tipoContratos).delete(object.tipoContrato!);
		});		
	}

	Future<void> insertChildren(TipoContratoGrouped object) async {
	}
	
	Future<void> deleteChildren(TipoContratoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from tipo_contrato").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}