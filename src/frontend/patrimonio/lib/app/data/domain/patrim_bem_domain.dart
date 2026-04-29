class PatrimBemDomain {
	PatrimBemDomain._();

	static getDeprecia(String? deprecia) { 
		switch (deprecia) { 
			case '': 
			case 'S': 
				return 'Sim'; 
			case 'N': 
				return 'Não'; 
			default: 
				return null; 
		} 
	} 

	static setDeprecia(String? deprecia) { 
		switch (deprecia) { 
			case 'Sim': 
				return 'S'; 
			case 'Não': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

	static getMetodoDepreciacao(String? metodoDepreciacao) { 
		switch (metodoDepreciacao) { 
			case '': 
			case '1': 
				return '1=Linear'; 
			case '2': 
				return '2=Soma dos Algarismos dos Anos'; 
			case '3': 
				return '3=Horas de Trabalho'; 
			case '4': 
				return '4=Unidades Produzidas'; 
			default: 
				return null; 
		} 
	} 

	static setMetodoDepreciacao(String? metodoDepreciacao) { 
		switch (metodoDepreciacao) { 
			case '1=Linear': 
				return '1'; 
			case '2=Soma dos Algarismos dos Anos': 
				return '2'; 
			case '3=Horas de Trabalho': 
				return '3'; 
			case '4=Unidades Produzidas': 
				return '4'; 
			default: 
				return null; 
		} 
	}

	static getTipoDepreciacao(String? tipoDepreciacao) { 
		switch (tipoDepreciacao) { 
			case '': 
			case 'N': 
				return 'Normal'; 
			case 'A': 
				return 'Acelerada'; 
			case 'I': 
				return 'Incentivada'; 
			default: 
				return null; 
		} 
	} 

	static setTipoDepreciacao(String? tipoDepreciacao) { 
		switch (tipoDepreciacao) { 
			case 'Normal': 
				return 'N'; 
			case 'Acelerada': 
				return 'A'; 
			case 'Incentivada': 
				return 'I'; 
			default: 
				return null; 
		} 
	}

}