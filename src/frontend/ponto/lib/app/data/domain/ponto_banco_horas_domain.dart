class PontoBancoHorasDomain {
	PontoBancoHorasDomain._();

	static getSituacao(String? situacao) { 
		switch (situacao) { 
			case '': 
			case '0': 
				return 'Não Utilizado'; 
			case '1': 
				return 'Utilizado'; 
			case '2': 
				return 'Utilizado Parcialmente'; 
			default: 
				return null; 
		} 
	} 

	static setSituacao(String? situacao) { 
		switch (situacao) { 
			case 'Não Utilizado': 
				return '0'; 
			case 'Utilizado': 
				return '1'; 
			case 'Utilizado Parcialmente': 
				return '2'; 
			default: 
				return null; 
		} 
	}

}