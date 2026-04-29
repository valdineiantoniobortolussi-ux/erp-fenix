import 'package:drift/drift.dart';
import 'package:mdfe/app/data/provider/drift/database/database.dart';
import 'package:mdfe/app/data/provider/drift/database/database_imports.dart';

part 'mdfe_rodoviario_veiculo_dao.g.dart';

@DriftAccessor(tables: [
	MdfeRodoviarioVeiculos,
	MdfeRodoviarios,
])
class MdfeRodoviarioVeiculoDao extends DatabaseAccessor<AppDatabase> with _$MdfeRodoviarioVeiculoDaoMixin {
	final AppDatabase db;

	List<MdfeRodoviarioVeiculo> mdfeRodoviarioVeiculoList = []; 
	List<MdfeRodoviarioVeiculoGrouped> mdfeRodoviarioVeiculoGroupedList = []; 

	MdfeRodoviarioVeiculoDao(this.db) : super(db);

	Future<List<MdfeRodoviarioVeiculo>> getList() async {
		mdfeRodoviarioVeiculoList = await select(mdfeRodoviarioVeiculos).get();
		return mdfeRodoviarioVeiculoList;
	}

	Future<List<MdfeRodoviarioVeiculo>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		mdfeRodoviarioVeiculoList = await (select(mdfeRodoviarioVeiculos)..where((t) => expression)).get();
		return mdfeRodoviarioVeiculoList;	 
	}

	Future<List<MdfeRodoviarioVeiculoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(mdfeRodoviarioVeiculos)
			.join([ 
				leftOuterJoin(mdfeRodoviarios, mdfeRodoviarios.id.equalsExp(mdfeRodoviarioVeiculos.idMdfeRodoviario)), 
			]);

		if (field != null && field != '') { 
			final column = mdfeRodoviarioVeiculos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		mdfeRodoviarioVeiculoGroupedList = await query.map((row) {
			final mdfeRodoviarioVeiculo = row.readTableOrNull(mdfeRodoviarioVeiculos); 
			final mdfeRodoviario = row.readTableOrNull(mdfeRodoviarios); 

			return MdfeRodoviarioVeiculoGrouped(
				mdfeRodoviarioVeiculo: mdfeRodoviarioVeiculo, 
				mdfeRodoviario: mdfeRodoviario, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var mdfeRodoviarioVeiculoGrouped in mdfeRodoviarioVeiculoGroupedList) {
		//}		

		return mdfeRodoviarioVeiculoGroupedList;	
	}

	Future<MdfeRodoviarioVeiculo?> getObject(dynamic pk) async {
		return await (select(mdfeRodoviarioVeiculos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<MdfeRodoviarioVeiculo?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM mdfe_rodoviario_veiculo WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as MdfeRodoviarioVeiculo;		 
	} 

	Future<MdfeRodoviarioVeiculoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(MdfeRodoviarioVeiculoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.mdfeRodoviarioVeiculo = object.mdfeRodoviarioVeiculo!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(mdfeRodoviarioVeiculos).insert(object.mdfeRodoviarioVeiculo!);
			object.mdfeRodoviarioVeiculo = object.mdfeRodoviarioVeiculo!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(MdfeRodoviarioVeiculoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(mdfeRodoviarioVeiculos).replace(object.mdfeRodoviarioVeiculo!);
		});	 
	} 

	Future<int> deleteObject(MdfeRodoviarioVeiculoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(mdfeRodoviarioVeiculos).delete(object.mdfeRodoviarioVeiculo!);
		});		
	}

	Future<void> insertChildren(MdfeRodoviarioVeiculoGrouped object) async {
	}
	
	Future<void> deleteChildren(MdfeRodoviarioVeiculoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from mdfe_rodoviario_veiculo").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}