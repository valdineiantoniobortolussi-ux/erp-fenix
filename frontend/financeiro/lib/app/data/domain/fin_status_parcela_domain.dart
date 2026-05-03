class FinStatusParcelaDomain {
	FinStatusParcelaDomain._();

	static getSituacao(String? situacao) { 
		switch (situacao) { 
			case '': 
			case '0': 
				return '01 = Aberto'; 
			case '1': 
				return '02 = Quitado'; 
			case '2': 
				return '03 = Quitado Parcial'; 
			case '3': 
				return '04 = Vencido'; 
			case '4': 
				return '05 = Renegociado'; 
			default: 
				return null; 
		} 
	} 

	static setSituacao(String? situacao) { 
		switch (situacao) { 
			case '01 = Aberto': 
				return '0'; 
			case '02 = Quitado': 
				return '1'; 
			case '03 = Quitado Parcial': 
				return '2'; 
			case '04 = Vencido': 
				return '3'; 
			case '05 = Renegociado': 
				return '4'; 
			default: 
				return null; 
		} 
	}

}