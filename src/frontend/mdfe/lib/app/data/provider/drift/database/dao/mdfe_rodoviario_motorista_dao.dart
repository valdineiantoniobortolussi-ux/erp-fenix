import 'package:drift/drift.dart';
import 'package:mdfe/app/data/provider/drift/database/database.dart';
import 'package:mdfe/app/data/provider/drift/database/database_imports.dart';

part 'mdfe_rodoviario_motorista_dao.g.dart';

@DriftAccessor(tables: [
	MdfeRodoviarioMotoristas,
	MdfeRodoviarios,
])
class MdfeRodoviarioMotoristaDao extends DatabaseAccessor<AppDatabase> with _$MdfeRodoviarioMotoristaDaoMixin {
	final AppDatabase db;

	List<MdfeRodoviarioMotorista> mdfeRodoviarioMotoristaList = []; 
	List<MdfeRodoviarioMotoristaGrouped> mdfeRodoviarioMotoristaGroupedList = []; 

	MdfeRodoviarioMotoristaDao(this.db) : super(db);

	Future<List<MdfeRodoviarioMotorista>> getList() async {
		mdfeRodoviarioMotoristaList = await select(mdfeRodoviarioMotoristas).get();
		return mdfeRodoviarioMotoristaList;
	}

	Future<List<MdfeRodoviarioMotorista>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		mdfeRodoviarioMotoristaList = await (select(mdfeRodoviarioMotoristas)..where((t) => expression)).get();
		return mdfeRodoviarioMotoristaList;	 
	}

	Future<List<MdfeRodoviarioMotoristaGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(mdfeRodoviarioMotoristas)
			.join([ 
				leftOuterJoin(mdfeRodoviarios, mdfeRodoviarios.id.equalsExp(mdfeRodoviarioMotoristas.idMdfeRodoviario)), 
			]);

		if (field != null && field != '') { 
			final column = mdfeRodoviarioMotoristas.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		mdfeRodoviarioMotoristaGroupedList = await query.map((row) {
			final mdfeRodoviarioMotorista = row.readTableOrNull(mdfeRodoviarioMotoristas); 
			final mdfeRodoviario = row.readTableOrNull(mdfeRodoviarios); 

			return MdfeRodoviarioMotoristaGrouped(
				mdfeRodoviarioMotorista: mdfeRodoviarioMotorista, 
				mdfeRodoviario: mdfeRodoviario, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var mdfeRodoviarioMotoristaGrouped in mdfeRodoviarioMotoristaGroupedList) {
		//}		

		return mdfeRodoviarioMotoristaGroupedList;	
	}

	Future<MdfeRodoviarioMotorista?> getObject(dynamic pk) async {
		return await (select(mdfeRodoviarioMotoristas)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<MdfeRodoviarioMotorista?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM mdfe_rodoviario_motorista WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as MdfeRodoviarioMotorista;		 
	} 

	Future<MdfeRodoviarioMotoristaGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(MdfeRodoviarioMotoristaGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.mdfeRodoviarioMotorista = object.mdfeRodoviarioMotorista!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(mdfeRodoviarioMotoristas).insert(object.mdfeRodoviarioMotorista!);
			object.mdfeRodoviarioMotorista = object.mdfeRodoviarioMotorista!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(MdfeRodoviarioMotoristaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(mdfeRodoviarioMotoristas).replace(object.mdfeRodoviarioMotorista!);
		});	 
	} 

	Future<int> deleteObject(MdfeRodoviarioMotoristaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(mdfeRodoviarioMotoristas).delete(object.mdfeRodoviarioMotorista!);
		});		
	}

	Future<void> insertChildren(MdfeRodoviarioMotoristaGrouped object) async {
	}
	
	Future<void> deleteChildren(MdfeRodoviarioMotoristaGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from mdfe_rodoviario_motorista").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}