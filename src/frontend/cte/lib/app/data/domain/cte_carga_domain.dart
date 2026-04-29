class CteCargaDomain {
	CteCargaDomain._();

	static getCodigoUnidadeMedida(String? codigoUnidadeMedida) { 
		switch (codigoUnidadeMedida) { 
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

	static setCodigoUnidadeMedida(String? codigoUnidadeMedida) { 
		switch (codigoUnidadeMedida) { 
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