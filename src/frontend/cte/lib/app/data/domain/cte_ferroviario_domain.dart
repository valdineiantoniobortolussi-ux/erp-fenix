class CteFerroviarioDomain {
	CteFerroviarioDomain._();

	static getTipoTrafego(String? tipoTrafego) { 
		switch (tipoTrafego) { 
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

	static setTipoTrafego(String? tipoTrafego) { 
		switch (tipoTrafego) { 
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

	static getResponsavelFaturamento(String? responsavelFaturamento) { 
		switch (responsavelFaturamento) { 
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

	static setResponsavelFaturamento(String? responsavelFaturamento) { 
		switch (responsavelFaturamento) { 
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

	static getFerroviaEmitenteCte(String? ferroviaEmitenteCte) { 
		switch (ferroviaEmitenteCte) { 
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

	static setFerroviaEmitenteCte(String? ferroviaEmitenteCte) { 
		switch (ferroviaEmitenteCte) { 
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