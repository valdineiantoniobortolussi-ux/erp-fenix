import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';
import 'package:nfe/app/data/provider/drift/database/database_imports.dart';

part 'view_pessoa_fornecedor_dao.g.dart';

@DriftAccessor(tables: [
	ViewPessoaFornecedors,
])
class ViewPessoaFornecedorDao extends DatabaseAccessor<AppDatabase> with _$ViewPessoaFornecedorDaoMixin {
	final AppDatabase db;

	List<ViewPessoaFornecedor> viewPessoaFornecedorList = []; 
	List<ViewPessoaFornecedorGrouped> viewPessoaFornecedorGroupedList = []; 

	ViewPessoaFornecedorDao(this.db) : super(db);

	Future<List<ViewPessoaFornecedor>> getList() async {
		viewPessoaFornecedorList = await select(viewPessoaFornecedors).get();
		return viewPessoaFornecedorList;
	}

	Future<List<ViewPessoaFornecedor>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		viewPessoaFornecedorList = await (select(viewPessoaFornecedors)..where((t) => expression)).get();
		return viewPessoaFornecedorList;	 
	}

	Future<List<ViewPessoaFornecedorGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(viewPessoaFornecedors)
			.join([]);

		if (field != null && field != '') { 
			final column = viewPessoaFornecedors.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		viewPessoaFornecedorGroupedList = await query.map((row) {
			final viewPessoaFornecedor = row.readTableOrNull(viewPessoaFornecedors); 

			return ViewPessoaFornecedorGrouped(
				viewPessoaFornecedor: viewPessoaFornecedor, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var viewPessoaFornecedorGrouped in viewPessoaFornecedorGroupedList) {
		//}		

		return viewPessoaFornecedorGroupedList;	
	}

	Future<ViewPessoaFornecedor?> getObject(dynamic pk) async {
		return await (select(viewPessoaFornecedors)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<ViewPessoaFornecedor?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM view_pessoa_fornecedor WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as ViewPessoaFornecedor;		 
	} 

	Future<ViewPessoaFornecedorGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(ViewPessoaFornecedorGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.viewPessoaFornecedor = object.viewPessoaFornecedor!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(viewPessoaFornecedors).insert(object.viewPessoaFornecedor!);
			object.viewPessoaFornecedor = object.viewPessoaFornecedor!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(ViewPessoaFornecedorGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(viewPessoaFornecedors).replace(object.viewPessoaFornecedor!);
		});	 
	} 

	Future<int> deleteObject(ViewPessoaFornecedorGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(viewPessoaFornecedors).delete(object.viewPessoaFornecedor!);
		});		
	}

	Future<void> insertChildren(ViewPessoaFornecedorGrouped object) async {
	}
	
	Future<void> deleteChildren(ViewPessoaFornecedorGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from view_pessoa_fornecedor").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}