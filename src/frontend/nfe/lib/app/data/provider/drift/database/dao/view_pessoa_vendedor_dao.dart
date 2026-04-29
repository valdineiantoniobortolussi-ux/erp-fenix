import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';
import 'package:nfe/app/data/provider/drift/database/database_imports.dart';

part 'view_pessoa_vendedor_dao.g.dart';

@DriftAccessor(tables: [
	ViewPessoaVendedors,
])
class ViewPessoaVendedorDao extends DatabaseAccessor<AppDatabase> with _$ViewPessoaVendedorDaoMixin {
	final AppDatabase db;

	List<ViewPessoaVendedor> viewPessoaVendedorList = []; 
	List<ViewPessoaVendedorGrouped> viewPessoaVendedorGroupedList = []; 

	ViewPessoaVendedorDao(this.db) : super(db);

	Future<List<ViewPessoaVendedor>> getList() async {
		viewPessoaVendedorList = await select(viewPessoaVendedors).get();
		return viewPessoaVendedorList;
	}

	Future<List<ViewPessoaVendedor>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		viewPessoaVendedorList = await (select(viewPessoaVendedors)..where((t) => expression)).get();
		return viewPessoaVendedorList;	 
	}

	Future<List<ViewPessoaVendedorGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(viewPessoaVendedors)
			.join([]);

		if (field != null && field != '') { 
			final column = viewPessoaVendedors.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		viewPessoaVendedorGroupedList = await query.map((row) {
			final viewPessoaVendedor = row.readTableOrNull(viewPessoaVendedors); 

			return ViewPessoaVendedorGrouped(
				viewPessoaVendedor: viewPessoaVendedor, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var viewPessoaVendedorGrouped in viewPessoaVendedorGroupedList) {
		//}		

		return viewPessoaVendedorGroupedList;	
	}

	Future<ViewPessoaVendedor?> getObject(dynamic pk) async {
		return await (select(viewPessoaVendedors)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<ViewPessoaVendedor?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM view_pessoa_vendedor WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as ViewPessoaVendedor;		 
	} 

	Future<ViewPessoaVendedorGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(ViewPessoaVendedorGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.viewPessoaVendedor = object.viewPessoaVendedor!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(viewPessoaVendedors).insert(object.viewPessoaVendedor!);
			object.viewPessoaVendedor = object.viewPessoaVendedor!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(ViewPessoaVendedorGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(viewPessoaVendedors).replace(object.viewPessoaVendedor!);
		});	 
	} 

	Future<int> deleteObject(ViewPessoaVendedorGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(viewPessoaVendedors).delete(object.viewPessoaVendedor!);
		});		
	}

	Future<void> insertChildren(ViewPessoaVendedorGrouped object) async {
	}
	
	Future<void> deleteChildren(ViewPessoaVendedorGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from view_pessoa_vendedor").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}