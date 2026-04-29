import 'package:drift/drift.dart';
import 'package:administrativo/app/data/provider/drift/database/database.dart';
import 'package:administrativo/app/data/provider/drift/database/database_imports.dart';

part 'usuario_token_dao.g.dart';

@DriftAccessor(tables: [
	UsuarioTokens,
])
class UsuarioTokenDao extends DatabaseAccessor<AppDatabase> with _$UsuarioTokenDaoMixin {
	final AppDatabase db;

	List<UsuarioToken> usuarioTokenList = []; 
	List<UsuarioTokenGrouped> usuarioTokenGroupedList = []; 

	UsuarioTokenDao(this.db) : super(db);

	Future<List<UsuarioToken>> getList() async {
		usuarioTokenList = await select(usuarioTokens).get();
		return usuarioTokenList;
	}

	Future<List<UsuarioToken>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		usuarioTokenList = await (select(usuarioTokens)..where((t) => expression)).get();
		return usuarioTokenList;	 
	}

	Future<List<UsuarioTokenGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(usuarioTokens)
			.join([]);

		if (field != null && field != '') { 
			final column = usuarioTokens.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		usuarioTokenGroupedList = await query.map((row) {
			final usuarioToken = row.readTableOrNull(usuarioTokens); 

			return UsuarioTokenGrouped(
				usuarioToken: usuarioToken, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var usuarioTokenGrouped in usuarioTokenGroupedList) {
		//}		

		return usuarioTokenGroupedList;	
	}

	Future<UsuarioToken?> getObject(dynamic pk) async {
		return await (select(usuarioTokens)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<UsuarioToken?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM usuario_token WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as UsuarioToken;		 
	} 

	Future<UsuarioTokenGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(UsuarioTokenGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.usuarioToken = object.usuarioToken!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(usuarioTokens).insert(object.usuarioToken!);
			object.usuarioToken = object.usuarioToken!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(UsuarioTokenGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(usuarioTokens).replace(object.usuarioToken!);
		});	 
	} 

	Future<int> deleteObject(UsuarioTokenGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(usuarioTokens).delete(object.usuarioToken!);
		});		
	}

	Future<void> insertChildren(UsuarioTokenGrouped object) async {
	}
	
	Future<void> deleteChildren(UsuarioTokenGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from usuario_token").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}