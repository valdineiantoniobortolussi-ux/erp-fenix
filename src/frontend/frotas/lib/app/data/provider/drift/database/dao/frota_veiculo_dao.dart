import 'package:drift/drift.dart';
import 'package:frotas/app/data/provider/drift/database/database.dart';
import 'package:frotas/app/data/provider/drift/database/database_imports.dart';

part 'frota_veiculo_dao.g.dart';

@DriftAccessor(tables: [
	FrotaVeiculos,
	FrotaIpvaControles,
	FrotaDpvatControles,
	FrotaVeiculoSinistros,
	FrotaVeiculoMovimentacaos,
	FrotaMotoristas,
	FrotaVeiculoPneus,
	FrotaVeiculoManutencaos,
	FrotaMultaControles,
	FrotaCombustivelControles,
	FrotaVeiculoTipos,
	FrotaCombustivelTipos,
])
class FrotaVeiculoDao extends DatabaseAccessor<AppDatabase> with _$FrotaVeiculoDaoMixin {
	final AppDatabase db;

	List<FrotaVeiculo> frotaVeiculoList = []; 
	List<FrotaVeiculoGrouped> frotaVeiculoGroupedList = []; 

	FrotaVeiculoDao(this.db) : super(db);

	Future<List<FrotaVeiculo>> getList() async {
		frotaVeiculoList = await select(frotaVeiculos).get();
		return frotaVeiculoList;
	}

	Future<List<FrotaVeiculo>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		frotaVeiculoList = await (select(frotaVeiculos)..where((t) => expression)).get();
		return frotaVeiculoList;	 
	}

	Future<List<FrotaVeiculoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(frotaVeiculos)
			.join([ 
				leftOuterJoin(frotaVeiculoTipos, frotaVeiculoTipos.id.equalsExp(frotaVeiculos.idFrotaVeiculoTipo)), 
			]).join([ 
				leftOuterJoin(frotaCombustivelTipos, frotaCombustivelTipos.id.equalsExp(frotaVeiculos.idFrotaCombustivelTipo)), 
			]);

		if (field != null && field != '') { 
			final column = frotaVeiculos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		frotaVeiculoGroupedList = await query.map((row) {
			final frotaVeiculo = row.readTableOrNull(frotaVeiculos); 
			final frotaVeiculoTipo = row.readTableOrNull(frotaVeiculoTipos); 
			final frotaCombustivelTipo = row.readTableOrNull(frotaCombustivelTipos); 

			return FrotaVeiculoGrouped(
				frotaVeiculo: frotaVeiculo, 
				frotaVeiculoTipo: frotaVeiculoTipo, 
				frotaCombustivelTipo: frotaCombustivelTipo, 

			);
		}).get();

		// fill internal lists
		dynamic expression;
		for (var frotaVeiculoGrouped in frotaVeiculoGroupedList) {
			frotaVeiculoGrouped.frotaIpvaControleGroupedList = [];
			final queryFrotaIpvaControle = ' id_frota_veiculo = ${frotaVeiculoGrouped.frotaVeiculo!.id}';
			expression = CustomExpression<bool>(queryFrotaIpvaControle);
			final frotaIpvaControleList = await (select(frotaIpvaControles)..where((t) => expression)).get();
			for (var frotaIpvaControle in frotaIpvaControleList) {
				FrotaIpvaControleGrouped frotaIpvaControleGrouped = FrotaIpvaControleGrouped(
					frotaIpvaControle: frotaIpvaControle,
				);
				frotaVeiculoGrouped.frotaIpvaControleGroupedList!.add(frotaIpvaControleGrouped);
			}

			frotaVeiculoGrouped.frotaDpvatControleGroupedList = [];
			final queryFrotaDpvatControle = ' id_frota_veiculo = ${frotaVeiculoGrouped.frotaVeiculo!.id}';
			expression = CustomExpression<bool>(queryFrotaDpvatControle);
			final frotaDpvatControleList = await (select(frotaDpvatControles)..where((t) => expression)).get();
			for (var frotaDpvatControle in frotaDpvatControleList) {
				FrotaDpvatControleGrouped frotaDpvatControleGrouped = FrotaDpvatControleGrouped(
					frotaDpvatControle: frotaDpvatControle,
				);
				frotaVeiculoGrouped.frotaDpvatControleGroupedList!.add(frotaDpvatControleGrouped);
			}

			frotaVeiculoGrouped.frotaVeiculoSinistroGroupedList = [];
			final queryFrotaVeiculoSinistro = ' id_frota_veiculo = ${frotaVeiculoGrouped.frotaVeiculo!.id}';
			expression = CustomExpression<bool>(queryFrotaVeiculoSinistro);
			final frotaVeiculoSinistroList = await (select(frotaVeiculoSinistros)..where((t) => expression)).get();
			for (var frotaVeiculoSinistro in frotaVeiculoSinistroList) {
				FrotaVeiculoSinistroGrouped frotaVeiculoSinistroGrouped = FrotaVeiculoSinistroGrouped(
					frotaVeiculoSinistro: frotaVeiculoSinistro,
				);
				frotaVeiculoGrouped.frotaVeiculoSinistroGroupedList!.add(frotaVeiculoSinistroGrouped);
			}

			frotaVeiculoGrouped.frotaVeiculoMovimentacaoGroupedList = [];
			final queryFrotaVeiculoMovimentacao = ' id_frota_veiculo = ${frotaVeiculoGrouped.frotaVeiculo!.id}';
			expression = CustomExpression<bool>(queryFrotaVeiculoMovimentacao);
			final frotaVeiculoMovimentacaoList = await (select(frotaVeiculoMovimentacaos)..where((t) => expression)).get();
			for (var frotaVeiculoMovimentacao in frotaVeiculoMovimentacaoList) {
				FrotaVeiculoMovimentacaoGrouped frotaVeiculoMovimentacaoGrouped = FrotaVeiculoMovimentacaoGrouped(
					frotaVeiculoMovimentacao: frotaVeiculoMovimentacao,
					frotaMotorista: await (select(frotaMotoristas)..where((t) => t.id.equals(frotaVeiculoMovimentacao.idFrotaMotorista!))).getSingleOrNull(),
				);
				frotaVeiculoGrouped.frotaVeiculoMovimentacaoGroupedList!.add(frotaVeiculoMovimentacaoGrouped);
			}

			frotaVeiculoGrouped.frotaVeiculoPneuGroupedList = [];
			final queryFrotaVeiculoPneu = ' id_frota_veiculo = ${frotaVeiculoGrouped.frotaVeiculo!.id}';
			expression = CustomExpression<bool>(queryFrotaVeiculoPneu);
			final frotaVeiculoPneuList = await (select(frotaVeiculoPneus)..where((t) => expression)).get();
			for (var frotaVeiculoPneu in frotaVeiculoPneuList) {
				FrotaVeiculoPneuGrouped frotaVeiculoPneuGrouped = FrotaVeiculoPneuGrouped(
					frotaVeiculoPneu: frotaVeiculoPneu,
				);
				frotaVeiculoGrouped.frotaVeiculoPneuGroupedList!.add(frotaVeiculoPneuGrouped);
			}

			frotaVeiculoGrouped.frotaVeiculoManutencaoGroupedList = [];
			final queryFrotaVeiculoManutencao = ' id_frota_veiculo = ${frotaVeiculoGrouped.frotaVeiculo!.id}';
			expression = CustomExpression<bool>(queryFrotaVeiculoManutencao);
			final frotaVeiculoManutencaoList = await (select(frotaVeiculoManutencaos)..where((t) => expression)).get();
			for (var frotaVeiculoManutencao in frotaVeiculoManutencaoList) {
				FrotaVeiculoManutencaoGrouped frotaVeiculoManutencaoGrouped = FrotaVeiculoManutencaoGrouped(
					frotaVeiculoManutencao: frotaVeiculoManutencao,
				);
				frotaVeiculoGrouped.frotaVeiculoManutencaoGroupedList!.add(frotaVeiculoManutencaoGrouped);
			}

			frotaVeiculoGrouped.frotaMultaControleGroupedList = [];
			final queryFrotaMultaControle = ' id_frota_veiculo = ${frotaVeiculoGrouped.frotaVeiculo!.id}';
			expression = CustomExpression<bool>(queryFrotaMultaControle);
			final frotaMultaControleList = await (select(frotaMultaControles)..where((t) => expression)).get();
			for (var frotaMultaControle in frotaMultaControleList) {
				FrotaMultaControleGrouped frotaMultaControleGrouped = FrotaMultaControleGrouped(
					frotaMultaControle: frotaMultaControle,
				);
				frotaVeiculoGrouped.frotaMultaControleGroupedList!.add(frotaMultaControleGrouped);
			}

			frotaVeiculoGrouped.frotaCombustivelControleGroupedList = [];
			final queryFrotaCombustivelControle = ' id_frota_veiculo = ${frotaVeiculoGrouped.frotaVeiculo!.id}';
			expression = CustomExpression<bool>(queryFrotaCombustivelControle);
			final frotaCombustivelControleList = await (select(frotaCombustivelControles)..where((t) => expression)).get();
			for (var frotaCombustivelControle in frotaCombustivelControleList) {
				FrotaCombustivelControleGrouped frotaCombustivelControleGrouped = FrotaCombustivelControleGrouped(
					frotaCombustivelControle: frotaCombustivelControle,
				);
				frotaVeiculoGrouped.frotaCombustivelControleGroupedList!.add(frotaCombustivelControleGrouped);
			}

		}		

		return frotaVeiculoGroupedList;	
	}

	Future<FrotaVeiculo?> getObject(dynamic pk) async {
		return await (select(frotaVeiculos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<FrotaVeiculo?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM frota_veiculo WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as FrotaVeiculo;		 
	} 

	Future<FrotaVeiculoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(FrotaVeiculoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.frotaVeiculo = object.frotaVeiculo!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(frotaVeiculos).insert(object.frotaVeiculo!);
			object.frotaVeiculo = object.frotaVeiculo!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(FrotaVeiculoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(frotaVeiculos).replace(object.frotaVeiculo!);
		});	 
	} 

	Future<int> deleteObject(FrotaVeiculoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(frotaVeiculos).delete(object.frotaVeiculo!);
		});		
	}

	Future<void> insertChildren(FrotaVeiculoGrouped object) async {
		for (var frotaIpvaControleGrouped in object.frotaIpvaControleGroupedList!) {
			frotaIpvaControleGrouped.frotaIpvaControle = frotaIpvaControleGrouped.frotaIpvaControle?.copyWith(
				id: const Value(null),
				idFrotaVeiculo: Value(object.frotaVeiculo!.id),
			);
			await into(frotaIpvaControles).insert(frotaIpvaControleGrouped.frotaIpvaControle!);
		}
		for (var frotaDpvatControleGrouped in object.frotaDpvatControleGroupedList!) {
			frotaDpvatControleGrouped.frotaDpvatControle = frotaDpvatControleGrouped.frotaDpvatControle?.copyWith(
				id: const Value(null),
				idFrotaVeiculo: Value(object.frotaVeiculo!.id),
			);
			await into(frotaDpvatControles).insert(frotaDpvatControleGrouped.frotaDpvatControle!);
		}
		for (var frotaVeiculoSinistroGrouped in object.frotaVeiculoSinistroGroupedList!) {
			frotaVeiculoSinistroGrouped.frotaVeiculoSinistro = frotaVeiculoSinistroGrouped.frotaVeiculoSinistro?.copyWith(
				id: const Value(null),
				idFrotaVeiculo: Value(object.frotaVeiculo!.id),
			);
			await into(frotaVeiculoSinistros).insert(frotaVeiculoSinistroGrouped.frotaVeiculoSinistro!);
		}
		for (var frotaVeiculoMovimentacaoGrouped in object.frotaVeiculoMovimentacaoGroupedList!) {
			frotaVeiculoMovimentacaoGrouped.frotaVeiculoMovimentacao = frotaVeiculoMovimentacaoGrouped.frotaVeiculoMovimentacao?.copyWith(
				id: const Value(null),
				idFrotaVeiculo: Value(object.frotaVeiculo!.id),
			);
			await into(frotaVeiculoMovimentacaos).insert(frotaVeiculoMovimentacaoGrouped.frotaVeiculoMovimentacao!);
		}
		for (var frotaVeiculoPneuGrouped in object.frotaVeiculoPneuGroupedList!) {
			frotaVeiculoPneuGrouped.frotaVeiculoPneu = frotaVeiculoPneuGrouped.frotaVeiculoPneu?.copyWith(
				id: const Value(null),
				idFrotaVeiculo: Value(object.frotaVeiculo!.id),
			);
			await into(frotaVeiculoPneus).insert(frotaVeiculoPneuGrouped.frotaVeiculoPneu!);
		}
		for (var frotaVeiculoManutencaoGrouped in object.frotaVeiculoManutencaoGroupedList!) {
			frotaVeiculoManutencaoGrouped.frotaVeiculoManutencao = frotaVeiculoManutencaoGrouped.frotaVeiculoManutencao?.copyWith(
				id: const Value(null),
				idFrotaVeiculo: Value(object.frotaVeiculo!.id),
			);
			await into(frotaVeiculoManutencaos).insert(frotaVeiculoManutencaoGrouped.frotaVeiculoManutencao!);
		}
		for (var frotaMultaControleGrouped in object.frotaMultaControleGroupedList!) {
			frotaMultaControleGrouped.frotaMultaControle = frotaMultaControleGrouped.frotaMultaControle?.copyWith(
				id: const Value(null),
				idFrotaVeiculo: Value(object.frotaVeiculo!.id),
			);
			await into(frotaMultaControles).insert(frotaMultaControleGrouped.frotaMultaControle!);
		}
		for (var frotaCombustivelControleGrouped in object.frotaCombustivelControleGroupedList!) {
			frotaCombustivelControleGrouped.frotaCombustivelControle = frotaCombustivelControleGrouped.frotaCombustivelControle?.copyWith(
				id: const Value(null),
				idFrotaVeiculo: Value(object.frotaVeiculo!.id),
			);
			await into(frotaCombustivelControles).insert(frotaCombustivelControleGrouped.frotaCombustivelControle!);
		}
	}
	
	Future<void> deleteChildren(FrotaVeiculoGrouped object) async {
		await (delete(frotaIpvaControles)..where((t) => t.idFrotaVeiculo.equals(object.frotaVeiculo!.id!))).go();
		await (delete(frotaDpvatControles)..where((t) => t.idFrotaVeiculo.equals(object.frotaVeiculo!.id!))).go();
		await (delete(frotaVeiculoSinistros)..where((t) => t.idFrotaVeiculo.equals(object.frotaVeiculo!.id!))).go();
		await (delete(frotaVeiculoMovimentacaos)..where((t) => t.idFrotaVeiculo.equals(object.frotaVeiculo!.id!))).go();
		await (delete(frotaVeiculoPneus)..where((t) => t.idFrotaVeiculo.equals(object.frotaVeiculo!.id!))).go();
		await (delete(frotaVeiculoManutencaos)..where((t) => t.idFrotaVeiculo.equals(object.frotaVeiculo!.id!))).go();
		await (delete(frotaMultaControles)..where((t) => t.idFrotaVeiculo.equals(object.frotaVeiculo!.id!))).go();
		await (delete(frotaCombustivelControles)..where((t) => t.idFrotaVeiculo.equals(object.frotaVeiculo!.id!))).go();
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from frota_veiculo").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}