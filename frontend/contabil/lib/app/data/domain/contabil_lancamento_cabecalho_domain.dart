class ContabilLancamentoCabecalhoDomain {
	ContabilLancamentoCabecalhoDomain._();

	static getTipo(String? tipo) { 
		switch (tipo) { 
			case '': 
			case '0': 
				return 'UDVC=Um Débito para Vários Créditos'; 
			case '1': 
				return 'UCVD=Um Crédito para Vários Débitos'; 
			case '2': 
				return 'UDUC=Um Débito para Um Crédito'; 
			case '3': 
				return 'VDVC = Vários Débitos para Vários Créditos'; 
			default: 
				return null; 
		} 
	} 

	static setTipo(String? tipo) { 
		switch (tipo) { 
			case 'UDVC=Um Débito para Vários Créditos': 
				return '0'; 
			case 'UCVD=Um Crédito para Vários Débitos': 
				return '1'; 
			case 'UDUC=Um Débito para Um Crédito': 
				return '2'; 
			case 'VDVC = Vários Débitos para Vários Créditos': 
				return '3'; 
			default: 
				return null; 
		} 
	}

	static getLiberado(String? liberado) { 
		switch (liberado) { 
			case '': 
			case 'S': 
				return 'Sim'; 
			case 'N': 
				return 'Não'; 
			default: 
				return null; 
		} 
	} 

	static setLiberado(String? liberado) { 
		switch (liberado) { 
			case 'Sim': 
				return 'S'; 
			case 'Não': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

}