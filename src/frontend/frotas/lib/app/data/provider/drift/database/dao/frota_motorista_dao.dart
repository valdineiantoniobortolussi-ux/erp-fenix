import 'package:drift/drift.dart';
import 'package:frotas/app/data/provider/drift/database/database.dart';
import 'package:frotas/app/data/provider/drift/database/database_imports.dart';

part 'frota_motorista_dao.g.dart';

@DriftAccessor(tables: [
	FrotaMotoristas,
	ViewPessoaColaboradors,
])
class FrotaMotoristaDao extends DatabaseAccessor<AppDatabase> with _$FrotaMotoristaDaoMixin {
	final AppDatabase db;

	List<FrotaMotorista> frotaMotoristaList = []; 
	List<FrotaMotoristaGrouped> frotaMotoristaGroupedList = []; 

	FrotaMotoristaDao(this.db) : super(db);

	Future<List<FrotaMotorista>> getList() async {
		frotaMotoristaList = await select(frotaMotoristas).get();
		return frotaMotoristaList;
	}

	Future<List<FrotaMotorista>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		frotaMotoristaList = await (select(frotaMotoristas)..where((t) => expression)).get();
		return frotaMotoristaList;	 
	}

	Future<List<FrotaMotoristaGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(frotaMotoristas)
			.join([ 
				leftOuterJoin(viewPessoaColaboradors, viewPessoaColaboradors.id.equalsExp(frotaMotoristas.idColaborador)), 
			]);

		if (field != null && field != '') { 
			final column = frotaMotoristas.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		frotaMotoristaGroupedList = await query.map((row) {
			final frotaMotorista = row.readTableOrNull(frotaMotoristas); 
			final viewPessoaColaborador = row.readTableOrNull(viewPessoaColaboradors); 

			return FrotaMotoristaGrouped(
				frotaMotorista: frotaMotorista, 
				viewPessoaColaborador: viewPessoaColaborador, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var frotaMotoristaGrouped in frotaMotoristaGroupedList) {
		//}		

		return frotaMotoristaGroupedList;	
	}

	Future<FrotaMotorista?> getObject(dynamic pk) async {
		return await (select(frotaMotoristas)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<FrotaMotorista?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM frota_motorista WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as FrotaMotorista;		 
	} 

	Future<FrotaMotoristaGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(FrotaMotoristaGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.frotaMotorista = object.frotaMotorista!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(frotaMotoristas).insert(object.frotaMotorista!);
			object.frotaMotorista = object.frotaMotorista!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(FrotaMotoristaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(frotaMotoristas).replace(object.frotaMotorista!);
		});	 
	} 

	Future<int> deleteObject(FrotaMotoristaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(frotaMotoristas).delete(object.frotaMotorista!);
		});		
	}

	Future<void> insertChildren(FrotaMotoristaGrouped object) async {
	}
	
	Future<void> deleteChildren(FrotaMotoristaGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from frota_motorista").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}