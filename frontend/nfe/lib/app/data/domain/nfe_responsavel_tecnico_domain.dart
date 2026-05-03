class NfeResponsavelTecnicoDomain {
	NfeResponsavelTecnicoDomain._();

	static getIdentificadorCsrt(String? identificadorCsrt) { 
		switch (identificadorCsrt) { 
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

	static setIdentificadorCsrt(String? identificadorCsrt) { 
		switch (identificadorCsrt) { 
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