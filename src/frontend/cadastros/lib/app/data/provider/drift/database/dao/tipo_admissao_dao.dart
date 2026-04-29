import 'package:drift/drift.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';
import 'package:cadastros/app/data/provider/drift/database/database_imports.dart';

part 'tipo_admissao_dao.g.dart';

@DriftAccessor(tables: [
	TipoAdmissaos,
])
class TipoAdmissaoDao extends DatabaseAccessor<AppDatabase> with _$TipoAdmissaoDaoMixin {
	final AppDatabase db;

	List<TipoAdmissao> tipoAdmissaoList = []; 
	List<TipoAdmissaoGrouped> tipoAdmissaoGroupedList = []; 

	TipoAdmissaoDao(this.db) : super(db);

	Future<List<TipoAdmissao>> getList() async {
		tipoAdmissaoList = await select(tipoAdmissaos).get();
		return tipoAdmissaoList;
	}

	Future<List<TipoAdmissao>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		tipoAdmissaoList = await (select(tipoAdmissaos)..where((t) => expression)).get();
		return tipoAdmissaoList;	 
	}

	Future<List<TipoAdmissaoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(tipoAdmissaos)
			.join([]);

		if (field != null && field != '') { 
			final column = tipoAdmissaos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		tipoAdmissaoGroupedList = await query.map((row) {
			final tipoAdmissao = row.readTableOrNull(tipoAdmissaos); 

			return TipoAdmissaoGrouped(
				tipoAdmissao: tipoAdmissao, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var tipoAdmissaoGrouped in tipoAdmissaoGroupedList) {
		//}		

		return tipoAdmissaoGroupedList;	
	}

	Future<TipoAdmissao?> getObject(dynamic pk) async {
		return await (select(tipoAdmissaos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<TipoAdmissao?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM tipo_admissao WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as TipoAdmissao;		 
	} 

	Future<TipoAdmissaoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(TipoAdmissaoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.tipoAdmissao = object.tipoAdmissao!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(tipoAdmissaos).insert(object.tipoAdmissao!);
			object.tipoAdmissao = object.tipoAdmissao!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(TipoAdmissaoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(tipoAdmissaos).replace(object.tipoAdmissao!);
		});	 
	} 

	Future<int> deleteObject(TipoAdmissaoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(tipoAdmissaos).delete(object.tipoAdmissao!);
		});		
	}

	Future<void> insertChildren(TipoAdmissaoGrouped object) async {
	}
	
	Future<void> deleteChildren(TipoAdmissaoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from tipo_admissao").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}