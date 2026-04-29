import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';
import 'package:nfe/app/data/provider/drift/database/database_imports.dart';

part 'view_pessoa_cliente_dao.g.dart';

@DriftAccessor(tables: [
	ViewPessoaClientes,
])
class ViewPessoaClienteDao extends DatabaseAccessor<AppDatabase> with _$ViewPessoaClienteDaoMixin {
	final AppDatabase db;

	List<ViewPessoaCliente> viewPessoaClienteList = []; 
	List<ViewPessoaClienteGrouped> viewPessoaClienteGroupedList = []; 

	ViewPessoaClienteDao(this.db) : super(db);

	Future<List<ViewPessoaCliente>> getList() async {
		viewPessoaClienteList = await select(viewPessoaClientes).get();
		return viewPessoaClienteList;
	}

	Future<List<ViewPessoaCliente>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		viewPessoaClienteList = await (select(viewPessoaClientes)..where((t) => expression)).get();
		return viewPessoaClienteList;	 
	}

	Future<List<ViewPessoaClienteGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(viewPessoaClientes)
			.join([]);

		if (field != null && field != '') { 
			final column = viewPessoaClientes.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		viewPessoaClienteGroupedList = await query.map((row) {
			final viewPessoaCliente = row.readTableOrNull(viewPessoaClientes); 

			return ViewPessoaClienteGrouped(
				viewPessoaCliente: viewPessoaCliente, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var viewPessoaClienteGrouped in viewPessoaClienteGroupedList) {
		//}		

		return viewPessoaClienteGroupedList;	
	}

	Future<ViewPessoaCliente?> getObject(dynamic pk) async {
		return await (select(viewPessoaClientes)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<ViewPessoaCliente?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM view_pessoa_cliente WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as ViewPessoaCliente;		 
	} 

	Future<ViewPessoaClienteGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(ViewPessoaClienteGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.viewPessoaCliente = object.viewPessoaCliente!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(viewPessoaClientes).insert(object.viewPessoaCliente!);
			object.viewPessoaCliente = object.viewPessoaCliente!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(ViewPessoaClienteGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(viewPessoaClientes).replace(object.viewPessoaCliente!);
		});	 
	} 

	Future<int> deleteObject(ViewPessoaClienteGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(viewPessoaClientes).delete(object.viewPessoaCliente!);
		});		
	}

	Future<void> insertChildren(ViewPessoaClienteGrouped object) async {
	}
	
	Future<void> deleteChildren(ViewPessoaClienteGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from view_pessoa_cliente").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}