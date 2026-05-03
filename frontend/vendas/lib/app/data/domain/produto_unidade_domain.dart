class ProdutoUnidadeDomain {
	ProdutoUnidadeDomain._();

	static getPodeFracionar(String? podeFracionar) { 
		switch (podeFracionar) { 
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

	static setPodeFracionar(String? podeFracionar) { 
		switch (podeFracionar) { 
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