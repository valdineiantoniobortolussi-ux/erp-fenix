import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';
import 'package:nfe/app/data/provider/drift/database/database_imports.dart';

part 'view_controle_acesso_dao.g.dart';

@DriftAccessor(tables: [
	ViewControleAcessos,
])
class ViewControleAcessoDao extends DatabaseAccessor<AppDatabase> with _$ViewControleAcessoDaoMixin {
	final AppDatabase db;

	List<ViewControleAcesso> viewControleAcessoList = []; 
	List<ViewControleAcessoGrouped> viewControleAcessoGroupedList = []; 

	ViewControleAcessoDao(this.db) : super(db);

	Future<List<ViewControleAcesso>> getList() async {
		viewControleAcessoList = await select(viewControleAcessos).get();
		return viewControleAcessoList;
	}

	Future<List<ViewControleAcesso>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		viewControleAcessoList = await (select(viewControleAcessos)..where((t) => expression)).get();
		return viewControleAcessoList;	 
	}

	Future<List<ViewControleAcessoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(viewControleAcessos)
			.join([]);

		if (field != null && field != '') { 
			final column = viewControleAcessos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		viewControleAcessoGroupedList = await query.map((row) {
			final viewControleAcesso = row.readTableOrNull(viewControleAcessos); 

			return ViewControleAcessoGrouped(
				viewControleAcesso: viewControleAcesso, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var viewControleAcessoGrouped in viewControleAcessoGroupedList) {
		//}		

		return viewControleAcessoGroupedList;	
	}

	Future<ViewControleAcesso?> getObject(dynamic pk) async {
		return await (select(viewControleAcessos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<ViewControleAcesso?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM view_controle_acesso WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as ViewControleAcesso;		 
	} 

	Future<ViewControleAcessoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(ViewControleAcessoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.viewControleAcesso = object.viewControleAcesso!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(viewControleAcessos).insert(object.viewControleAcesso!);
			object.viewControleAcesso = object.viewControleAcesso!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(ViewControleAcessoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(viewControleAcessos).replace(object.viewControleAcesso!);
		});	 
	} 

	Future<int> deleteObject(ViewControleAcessoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(viewControleAcessos).delete(object.viewControleAcesso!);
		});		
	}

	Future<void> insertChildren(ViewControleAcessoGrouped object) async {
	}
	
	Future<void> deleteChildren(ViewControleAcessoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from view_controle_acesso").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}