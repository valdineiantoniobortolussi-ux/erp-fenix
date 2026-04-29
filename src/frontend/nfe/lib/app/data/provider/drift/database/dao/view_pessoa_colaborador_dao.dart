import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';
import 'package:nfe/app/data/provider/drift/database/database_imports.dart';

part 'view_pessoa_colaborador_dao.g.dart';

@DriftAccessor(tables: [
	ViewPessoaColaboradors,
])
class ViewPessoaColaboradorDao extends DatabaseAccessor<AppDatabase> with _$ViewPessoaColaboradorDaoMixin {
	final AppDatabase db;

	List<ViewPessoaColaborador> viewPessoaColaboradorList = []; 
	List<ViewPessoaColaboradorGrouped> viewPessoaColaboradorGroupedList = []; 

	ViewPessoaColaboradorDao(this.db) : super(db);

	Future<List<ViewPessoaColaborador>> getList() async {
		viewPessoaColaboradorList = await select(viewPessoaColaboradors).get();
		return viewPessoaColaboradorList;
	}

	Future<List<ViewPessoaColaborador>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		viewPessoaColaboradorList = await (select(viewPessoaColaboradors)..where((t) => expression)).get();
		return viewPessoaColaboradorList;	 
	}

	Future<List<ViewPessoaColaboradorGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(viewPessoaColaboradors)
			.join([]);

		if (field != null && field != '') { 
			final column = viewPessoaColaboradors.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		viewPessoaColaboradorGroupedList = await query.map((row) {
			final viewPessoaColaborador = row.readTableOrNull(viewPessoaColaboradors); 

			return ViewPessoaColaboradorGrouped(
				viewPessoaColaborador: viewPessoaColaborador, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var viewPessoaColaboradorGrouped in viewPessoaColaboradorGroupedList) {
		//}		

		return viewPessoaColaboradorGroupedList;	
	}

	Future<ViewPessoaColaborador?> getObject(dynamic pk) async {
		return await (select(viewPessoaColaboradors)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<ViewPessoaColaborador?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM view_pessoa_colaborador WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as ViewPessoaColaborador;		 
	} 

	Future<ViewPessoaColaboradorGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(ViewPessoaColaboradorGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.viewPessoaColaborador = object.viewPessoaColaborador!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(viewPessoaColaboradors).insert(object.viewPessoaColaborador!);
			object.viewPessoaColaborador = object.viewPessoaColaborador!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(ViewPessoaColaboradorGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(viewPessoaColaboradors).replace(object.viewPessoaColaborador!);
		});	 
	} 

	Future<int> deleteObject(ViewPessoaColaboradorGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(viewPessoaColaboradors).delete(object.viewPessoaColaborador!);
		});		
	}

	Future<void> insertChildren(ViewPessoaColaboradorGrouped object) async {
	}
	
	Future<void> deleteChildren(ViewPessoaColaboradorGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from view_pessoa_colaborador").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}