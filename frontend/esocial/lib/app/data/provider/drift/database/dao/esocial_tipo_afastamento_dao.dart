import 'package:drift/drift.dart';
import 'package:esocial/app/data/provider/drift/database/database.dart';
import 'package:esocial/app/data/provider/drift/database/database_imports.dart';

part 'esocial_tipo_afastamento_dao.g.dart';

@DriftAccessor(tables: [
	EsocialTipoAfastamentos,
])
class EsocialTipoAfastamentoDao extends DatabaseAccessor<AppDatabase> with _$EsocialTipoAfastamentoDaoMixin {
	final AppDatabase db;

	List<EsocialTipoAfastamento> esocialTipoAfastamentoList = []; 
	List<EsocialTipoAfastamentoGrouped> esocialTipoAfastamentoGroupedList = []; 

	EsocialTipoAfastamentoDao(this.db) : super(db);

	Future<List<EsocialTipoAfastamento>> getList() async {
		esocialTipoAfastamentoList = await select(esocialTipoAfastamentos).get();
		return esocialTipoAfastamentoList;
	}

	Future<List<EsocialTipoAfastamento>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		esocialTipoAfastamentoList = await (select(esocialTipoAfastamentos)..where((t) => expression)).get();
		return esocialTipoAfastamentoList;	 
	}

	Future<List<EsocialTipoAfastamentoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(esocialTipoAfastamentos)
			.join([]);

		if (field != null && field != '') { 
			final column = esocialTipoAfastamentos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		esocialTipoAfastamentoGroupedList = await query.map((row) {
			final esocialTipoAfastamento = row.readTableOrNull(esocialTipoAfastamentos); 

			return EsocialTipoAfastamentoGrouped(
				esocialTipoAfastamento: esocialTipoAfastamento, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var esocialTipoAfastamentoGrouped in esocialTipoAfastamentoGroupedList) {
		//}		

		return esocialTipoAfastamentoGroupedList;	
	}

	Future<EsocialTipoAfastamento?> getObject(dynamic pk) async {
		return await (select(esocialTipoAfastamentos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<EsocialTipoAfastamento?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM esocial_tipo_afastamento WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as EsocialTipoAfastamento;		 
	} 

	Future<EsocialTipoAfastamentoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(EsocialTipoAfastamentoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.esocialTipoAfastamento = object.esocialTipoAfastamento!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(esocialTipoAfastamentos).insert(object.esocialTipoAfastamento!);
			object.esocialTipoAfastamento = object.esocialTipoAfastamento!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(EsocialTipoAfastamentoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(esocialTipoAfastamentos).replace(object.esocialTipoAfastamento!);
		});	 
	} 

	Future<int> deleteObject(EsocialTipoAfastamentoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(esocialTipoAfastamentos).delete(object.esocialTipoAfastamento!);
		});		
	}

	Future<void> insertChildren(EsocialTipoAfastamentoGrouped object) async {
	}
	
	Future<void> deleteChildren(EsocialTipoAfastamentoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from esocial_tipo_afastamento").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}