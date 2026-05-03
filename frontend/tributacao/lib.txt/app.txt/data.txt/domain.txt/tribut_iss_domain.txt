class TributIssDomain {
	TributIssDomain._();

	static getModalidadeBaseCalculo(String? modalidadeBaseCalculo) { 
		switch (modalidadeBaseCalculo) { 
			case '': 
			case '0': 
				return '0-Valor Operação'; 
			case '9': 
				return '9-Outros'; 
			default: 
				return null; 
		} 
	} 

	static setModalidadeBaseCalculo(String? modalidadeBaseCalculo) { 
		switch (modalidadeBaseCalculo) { 
			case '0-Valor Operação': 
				return '0'; 
			case '9-Outros': 
				return '9'; 
			default: 
				return null; 
		} 
	}

	static getCodigoTributacao(String? codigoTributacao) { 
		switch (codigoTributacao) { 
			case '': 
			case 'N': 
				return 'Normal'; 
			case 'R': 
				return 'Retida'; 
			case 'S': 
				return 'Substituta'; 
			case 'I': 
				return 'Isenta'; 
			default: 
				return null; 
		} 
	} 

	static setCodigoTributacao(String? codigoTributacao) { 
		switch (codigoTributacao) { 
			case 'Normal': 
				return 'N'; 
			case 'Retida': 
				return 'R'; 
			case 'Substituta': 
				return 'S'; 
			case 'Isenta': 
				return 'I'; 
			default: 
				return null; 
		} 
	}

}