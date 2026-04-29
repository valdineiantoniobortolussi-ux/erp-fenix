import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';
import 'package:nfe/app/data/provider/drift/database/database_imports.dart';

part 'view_pessoa_transportadora_dao.g.dart';

@DriftAccessor(tables: [
	ViewPessoaTransportadoras,
])
class ViewPessoaTransportadoraDao extends DatabaseAccessor<AppDatabase> with _$ViewPessoaTransportadoraDaoMixin {
	final AppDatabase db;

	List<ViewPessoaTransportadora> viewPessoaTransportadoraList = []; 
	List<ViewPessoaTransportadoraGrouped> viewPessoaTransportadoraGroupedList = []; 

	ViewPessoaTransportadoraDao(this.db) : super(db);

	Future<List<ViewPessoaTransportadora>> getList() async {
		viewPessoaTransportadoraList = await select(viewPessoaTransportadoras).get();
		return viewPessoaTransportadoraList;
	}

	Future<List<ViewPessoaTransportadora>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		viewPessoaTransportadoraList = await (select(viewPessoaTransportadoras)..where((t) => expression)).get();
		return viewPessoaTransportadoraList;	 
	}

	Future<List<ViewPessoaTransportadoraGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(viewPessoaTransportadoras)
			.join([]);

		if (field != null && field != '') { 
			final column = viewPessoaTransportadoras.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		viewPessoaTransportadoraGroupedList = await query.map((row) {
			final viewPessoaTransportadora = row.readTableOrNull(viewPessoaTransportadoras); 

			return ViewPessoaTransportadoraGrouped(
				viewPessoaTransportadora: viewPessoaTransportadora, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var viewPessoaTransportadoraGrouped in viewPessoaTransportadoraGroupedList) {
		//}		

		return viewPessoaTransportadoraGroupedList;	
	}

	Future<ViewPessoaTransportadora?> getObject(dynamic pk) async {
		return await (select(viewPessoaTransportadoras)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<ViewPessoaTransportadora?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM view_pessoa_transportadora WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as ViewPessoaTransportadora;		 
	} 

	Future<ViewPessoaTransportadoraGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(ViewPessoaTransportadoraGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.viewPessoaTransportadora = object.viewPessoaTransportadora!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(viewPessoaTransportadoras).insert(object.viewPessoaTransportadora!);
			object.viewPessoaTransportadora = object.viewPessoaTransportadora!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(ViewPessoaTransportadoraGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(viewPessoaTransportadoras).replace(object.viewPessoaTransportadora!);
		});	 
	} 

	Future<int> deleteObject(ViewPessoaTransportadoraGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(viewPessoaTransportadoras).delete(object.viewPessoaTransportadora!);
		});		
	}

	Future<void> insertChildren(ViewPessoaTransportadoraGrouped object) async {
	}
	
	Future<void> deleteChildren(ViewPessoaTransportadoraGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from view_pessoa_transportadora").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}