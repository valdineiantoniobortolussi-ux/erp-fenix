import 'package:drift/drift.dart';
import 'package:compras/app/data/provider/drift/database/database.dart';
import 'package:compras/app/data/provider/drift/database/database_imports.dart';

part 'compra_tipo_pedido_dao.g.dart';

@DriftAccessor(tables: [
	CompraTipoPedidos,
])
class CompraTipoPedidoDao extends DatabaseAccessor<AppDatabase> with _$CompraTipoPedidoDaoMixin {
	final AppDatabase db;

	List<CompraTipoPedido> compraTipoPedidoList = []; 
	List<CompraTipoPedidoGrouped> compraTipoPedidoGroupedList = []; 

	CompraTipoPedidoDao(this.db) : super(db);

	Future<List<CompraTipoPedido>> getList() async {
		compraTipoPedidoList = await select(compraTipoPedidos).get();
		return compraTipoPedidoList;
	}

	Future<List<CompraTipoPedido>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		compraTipoPedidoList = await (select(compraTipoPedidos)..where((t) => expression)).get();
		return compraTipoPedidoList;	 
	}

	Future<List<CompraTipoPedidoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(compraTipoPedidos)
			.join([]);

		if (field != null && field != '') { 
			final column = compraTipoPedidos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		compraTipoPedidoGroupedList = await query.map((row) {
			final compraTipoPedido = row.readTableOrNull(compraTipoPedidos); 

			return CompraTipoPedidoGrouped(
				compraTipoPedido: compraTipoPedido, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var compraTipoPedidoGrouped in compraTipoPedidoGroupedList) {
		//}		

		return compraTipoPedidoGroupedList;	
	}

	Future<CompraTipoPedido?> getObject(dynamic pk) async {
		return await (select(compraTipoPedidos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<CompraTipoPedido?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM compra_tipo_pedido WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as CompraTipoPedido;		 
	} 

	Future<CompraTipoPedidoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(CompraTipoPedidoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.compraTipoPedido = object.compraTipoPedido!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(compraTipoPedidos).insert(object.compraTipoPedido!);
			object.compraTipoPedido = object.compraTipoPedido!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(CompraTipoPedidoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(compraTipoPedidos).replace(object.compraTipoPedido!);
		});	 
	} 

	Future<int> deleteObject(CompraTipoPedidoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(compraTipoPedidos).delete(object.compraTipoPedido!);
		});		
	}

	Future<void> insertChildren(CompraTipoPedidoGrouped object) async {
	}
	
	Future<void> deleteChildren(CompraTipoPedidoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from compra_tipo_pedido").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}