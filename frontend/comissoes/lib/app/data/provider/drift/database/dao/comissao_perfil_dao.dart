import 'package:drift/drift.dart';
import 'package:comissoes/app/data/provider/drift/database/database.dart';
import 'package:comissoes/app/data/provider/drift/database/database_imports.dart';

part 'comissao_perfil_dao.g.dart';

@DriftAccessor(tables: [
	ComissaoPerfils,
])
class ComissaoPerfilDao extends DatabaseAccessor<AppDatabase> with _$ComissaoPerfilDaoMixin {
	final AppDatabase db;

	List<ComissaoPerfil> comissaoPerfilList = []; 
	List<ComissaoPerfilGrouped> comissaoPerfilGroupedList = []; 

	ComissaoPerfilDao(this.db) : super(db);

	Future<List<ComissaoPerfil>> getList() async {
		comissaoPerfilList = await select(comissaoPerfils).get();
		return comissaoPerfilList;
	}

	Future<List<ComissaoPerfil>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		comissaoPerfilList = await (select(comissaoPerfils)..where((t) => expression)).get();
		return comissaoPerfilList;	 
	}

	Future<List<ComissaoPerfilGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(comissaoPerfils)
			.join([]);

		if (field != null && field != '') { 
			final column = comissaoPerfils.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		comissaoPerfilGroupedList = await query.map((row) {
			final comissaoPerfil = row.readTableOrNull(comissaoPerfils); 

			return ComissaoPerfilGrouped(
				comissaoPerfil: comissaoPerfil, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var comissaoPerfilGrouped in comissaoPerfilGroupedList) {
		//}		

		return comissaoPerfilGroupedList;	
	}

	Future<ComissaoPerfil?> getObject(dynamic pk) async {
		return await (select(comissaoPerfils)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<ComissaoPerfil?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM comissao_perfil WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as ComissaoPerfil;		 
	} 

	Future<ComissaoPerfilGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(ComissaoPerfilGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.comissaoPerfil = object.comissaoPerfil!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(comissaoPerfils).insert(object.comissaoPerfil!);
			object.comissaoPerfil = object.comissaoPerfil!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(ComissaoPerfilGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(comissaoPerfils).replace(object.comissaoPerfil!);
		});	 
	} 

	Future<int> deleteObject(ComissaoPerfilGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(comissaoPerfils).delete(object.comissaoPerfil!);
		});		
	}

	Future<void> insertChildren(ComissaoPerfilGrouped object) async {
	}
	
	Future<void> deleteChildren(ComissaoPerfilGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from comissao_perfil").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}