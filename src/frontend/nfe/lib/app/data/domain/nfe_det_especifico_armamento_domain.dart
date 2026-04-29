class NfeDetEspecificoArmamentoDomain {
	NfeDetEspecificoArmamentoDomain._();

	static getTipoArma(String? tipoArma) { 
		switch (tipoArma) { 
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

	static setTipoArma(String? tipoArma) { 
		switch (tipoArma) { 
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