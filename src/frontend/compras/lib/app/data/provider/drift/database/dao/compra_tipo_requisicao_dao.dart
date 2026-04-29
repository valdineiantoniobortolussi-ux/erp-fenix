import 'package:drift/drift.dart';
import 'package:compras/app/data/provider/drift/database/database.dart';
import 'package:compras/app/data/provider/drift/database/database_imports.dart';

part 'compra_tipo_requisicao_dao.g.dart';

@DriftAccessor(tables: [
	CompraTipoRequisicaos,
])
class CompraTipoRequisicaoDao extends DatabaseAccessor<AppDatabase> with _$CompraTipoRequisicaoDaoMixin {
	final AppDatabase db;

	List<CompraTipoRequisicao> compraTipoRequisicaoList = []; 
	List<CompraTipoRequisicaoGrouped> compraTipoRequisicaoGroupedList = []; 

	CompraTipoRequisicaoDao(this.db) : super(db);

	Future<List<CompraTipoRequisicao>> getList() async {
		compraTipoRequisicaoList = await select(compraTipoRequisicaos).get();
		return compraTipoRequisicaoList;
	}

	Future<List<CompraTipoRequisicao>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		compraTipoRequisicaoList = await (select(compraTipoRequisicaos)..where((t) => expression)).get();
		return compraTipoRequisicaoList;	 
	}

	Future<List<CompraTipoRequisicaoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(compraTipoRequisicaos)
			.join([]);

		if (field != null && field != '') { 
			final column = compraTipoRequisicaos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		compraTipoRequisicaoGroupedList = await query.map((row) {
			final compraTipoRequisicao = row.readTableOrNull(compraTipoRequisicaos); 

			return CompraTipoRequisicaoGrouped(
				compraTipoRequisicao: compraTipoRequisicao, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var compraTipoRequisicaoGrouped in compraTipoRequisicaoGroupedList) {
		//}		

		return compraTipoRequisicaoGroupedList;	
	}

	Future<CompraTipoRequisicao?> getObject(dynamic pk) async {
		return await (select(compraTipoRequisicaos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<CompraTipoRequisicao?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM compra_tipo_requisicao WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as CompraTipoRequisicao;		 
	} 

	Future<CompraTipoRequisicaoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(CompraTipoRequisicaoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.compraTipoRequisicao = object.compraTipoRequisicao!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(compraTipoRequisicaos).insert(object.compraTipoRequisicao!);
			object.compraTipoRequisicao = object.compraTipoRequisicao!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(CompraTipoRequisicaoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(compraTipoRequisicaos).replace(object.compraTipoRequisicao!);
		});	 
	} 

	Future<int> deleteObject(CompraTipoRequisicaoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(compraTipoRequisicaos).delete(object.compraTipoRequisicao!);
		});		
	}

	Future<void> insertChildren(CompraTipoRequisicaoGrouped object) async {
	}
	
	Future<void> deleteChildren(CompraTipoRequisicaoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from compra_tipo_requisicao").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}