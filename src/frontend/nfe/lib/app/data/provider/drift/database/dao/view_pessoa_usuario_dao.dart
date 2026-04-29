import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';
import 'package:nfe/app/data/provider/drift/database/database_imports.dart';

part 'view_pessoa_usuario_dao.g.dart';

@DriftAccessor(tables: [
	ViewPessoaUsuarios,
])
class ViewPessoaUsuarioDao extends DatabaseAccessor<AppDatabase> with _$ViewPessoaUsuarioDaoMixin {
	final AppDatabase db;

	List<ViewPessoaUsuario> viewPessoaUsuarioList = []; 
	List<ViewPessoaUsuarioGrouped> viewPessoaUsuarioGroupedList = []; 

	ViewPessoaUsuarioDao(this.db) : super(db);

	Future<List<ViewPessoaUsuario>> getList() async {
		viewPessoaUsuarioList = await select(viewPessoaUsuarios).get();
		return viewPessoaUsuarioList;
	}

	Future<List<ViewPessoaUsuario>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		viewPessoaUsuarioList = await (select(viewPessoaUsuarios)..where((t) => expression)).get();
		return viewPessoaUsuarioList;	 
	}

	Future<List<ViewPessoaUsuarioGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(viewPessoaUsuarios)
			.join([]);

		if (field != null && field != '') { 
			final column = viewPessoaUsuarios.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		viewPessoaUsuarioGroupedList = await query.map((row) {
			final viewPessoaUsuario = row.readTableOrNull(viewPessoaUsuarios); 

			return ViewPessoaUsuarioGrouped(
				viewPessoaUsuario: viewPessoaUsuario, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var viewPessoaUsuarioGrouped in viewPessoaUsuarioGroupedList) {
		//}		

		return viewPessoaUsuarioGroupedList;	
	}

	Future<ViewPessoaUsuario?> getObject(dynamic pk) async {
		return await (select(viewPessoaUsuarios)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<ViewPessoaUsuario?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM view_pessoa_usuario WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as ViewPessoaUsuario;		 
	} 

	Future<ViewPessoaUsuarioGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(ViewPessoaUsuarioGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.viewPessoaUsuario = object.viewPessoaUsuario!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(viewPessoaUsuarios).insert(object.viewPessoaUsuario!);
			object.viewPessoaUsuario = object.viewPessoaUsuario!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(ViewPessoaUsuarioGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(viewPessoaUsuarios).replace(object.viewPessoaUsuario!);
		});	 
	} 

	Future<int> deleteObject(ViewPessoaUsuarioGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(viewPessoaUsuarios).delete(object.viewPessoaUsuario!);
		});		
	}

	Future<void> insertChildren(ViewPessoaUsuarioGrouped object) async {
	}
	
	Future<void> deleteChildren(ViewPessoaUsuarioGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from view_pessoa_usuario").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}