class NfeDetalheImpostoIssqnDomain {
	NfeDetalheImpostoIssqnDomain._();

	static getIndicadorExigibilidadeIss(String? indicadorExigibilidadeIss) { 
		switch (indicadorExigibilidadeIss) { 
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

	static setIndicadorExigibilidadeIss(String? indicadorExigibilidadeIss) { 
		switch (indicadorExigibilidadeIss) { 
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

	static getIndicadorIncentivoFiscal(String? indicadorIncentivoFiscal) { 
		switch (indicadorIncentivoFiscal) { 
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

	static setIndicadorIncentivoFiscal(String? indicadorIncentivoFiscal) { 
		switch (indicadorIncentivoFiscal) { 
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