class CteRodoviarioDomain {
	CteRodoviarioDomain._();

	static getIndicadorLotacao(String? indicadorLotacao) { 
		switch (indicadorLotacao) { 
			case '': 
			case '0': 
				return 'AAA'; 
			case '1': 
				return 'BBB'; 
			case '2': 
				return 'CCC'; 
			default: 
				return null; 
		} 
	} 

	static setIndicadorLotacao(String? indicadorLotacao) { 
		switch (indicadorLotacao) { 
			case 'AAA': 
				return '0'; 
			case 'BBB': 
				return '1'; 
			case 'CCC': 
				return '2'; 
			default: 
				return null; 
		} 
	}

}