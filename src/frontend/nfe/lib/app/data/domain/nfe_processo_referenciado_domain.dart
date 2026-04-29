class NfeProcessoReferenciadoDomain {
	NfeProcessoReferenciadoDomain._();

	static getOrigem(String? origem) { 
		switch (origem) { 
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

	static setOrigem(String? origem) { 
		switch (origem) { 
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