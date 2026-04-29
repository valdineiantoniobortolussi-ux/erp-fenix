class ContabilDreDetalheDomain {
	ContabilDreDetalheDomain._();

	static getFormaCalculo(String? formaCalculo) { 
		switch (formaCalculo) { 
			case '': 
			case 'S': 
				return 'Sintética'; 
			case 'V': 
				return 'Vinculada'; 
			case 'R': 
				return 'Resultado de Operações da DRE'; 
			default: 
				return null; 
		} 
	} 

	static setFormaCalculo(String? formaCalculo) { 
		switch (formaCalculo) { 
			case 'Sintética': 
				return 'S'; 
			case 'Vinculada': 
				return 'V'; 
			case 'Resultado de Operações da DRE': 
				return 'R'; 
			default: 
				return null; 
		} 
	}

	static getSinal(String? sinal) { 
		switch (sinal) { 
			case '': 
			case '+': 
				return '+'; 
			case '-': 
				return '-'; 
			case '=': 
				return '='; 
			default: 
				return null; 
		} 
	} 

	static setSinal(String? sinal) { 
		switch (sinal) { 
			case '+': 
				return '+'; 
			case '-': 
				return '-'; 
			case '=': 
				return '='; 
			default: 
				return null; 
		} 
	}

	static getNatureza(String? natureza) { 
		switch (natureza) { 
			case '': 
			case 'C': 
				return 'Credora'; 
			case 'D': 
				return 'Devedora'; 
			default: 
				return null; 
		} 
	} 

	static setNatureza(String? natureza) { 
		switch (natureza) { 
			case 'Credora': 
				return 'C'; 
			case 'Devedora': 
				return 'D'; 
			default: 
				return null; 
		} 
	}

}