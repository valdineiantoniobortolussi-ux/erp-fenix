class NfeInformacaoPagamentoDomain {
	NfeInformacaoPagamentoDomain._();

	static getIndicadorPagamento(String? indicadorPagamento) { 
		switch (indicadorPagamento) { 
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

	static setIndicadorPagamento(String? indicadorPagamento) { 
		switch (indicadorPagamento) { 
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

	static getMeioPagamento(String? meioPagamento) { 
		switch (meioPagamento) { 
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

	static setMeioPagamento(String? meioPagamento) { 
		switch (meioPagamento) { 
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

	static getTipoIntegracao(String? tipoIntegracao) { 
		switch (tipoIntegracao) { 
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

	static setTipoIntegracao(String? tipoIntegracao) { 
		switch (tipoIntegracao) { 
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

	static getBandeira(String? bandeira) { 
		switch (bandeira) { 
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

	static setBandeira(String? bandeira) { 
		switch (bandeira) { 
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