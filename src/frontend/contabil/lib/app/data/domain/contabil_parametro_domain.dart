class ContabilParametroDomain {
	ContabilParametroDomain._();

	static getInformarContaPor(String? informarContaPor) { 
		switch (informarContaPor) { 
			case '': 
			case 'C': 
				return 'Código'; 
			case 'M': 
				return 'Máscara'; 
			default: 
				return null; 
		} 
	} 

	static setInformarContaPor(String? informarContaPor) { 
		switch (informarContaPor) { 
			case 'Código': 
				return 'C'; 
			case 'Máscara': 
				return 'M'; 
			default: 
				return null; 
		} 
	}

	static getCompartilhaPlanoConta(String? compartilhaPlanoConta) { 
		switch (compartilhaPlanoConta) { 
			case '': 
			case 'S': 
				return 'Sim'; 
			case 'N': 
				return 'Não'; 
			default: 
				return null; 
		} 
	} 

	static setCompartilhaPlanoConta(String? compartilhaPlanoConta) { 
		switch (compartilhaPlanoConta) { 
			case 'Sim': 
				return 'S'; 
			case 'Não': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

	static getCompartilhaHistoricos(String? compartilhaHistoricos) { 
		switch (compartilhaHistoricos) { 
			case '': 
			case 'S': 
				return 'Sim'; 
			case 'N': 
				return 'Não'; 
			default: 
				return null; 
		} 
	} 

	static setCompartilhaHistoricos(String? compartilhaHistoricos) { 
		switch (compartilhaHistoricos) { 
			case 'Sim': 
				return 'S'; 
			case 'Não': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

	static getAlteraLancamentoOutro(String? alteraLancamentoOutro) { 
		switch (alteraLancamentoOutro) { 
			case '': 
			case 'S': 
				return 'Sim'; 
			case 'N': 
				return 'Não'; 
			default: 
				return null; 
		} 
	} 

	static setAlteraLancamentoOutro(String? alteraLancamentoOutro) { 
		switch (alteraLancamentoOutro) { 
			case 'Sim': 
				return 'S'; 
			case 'Não': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

	static getHistoricoObrigatorio(String? historicoObrigatorio) { 
		switch (historicoObrigatorio) { 
			case '': 
			case 'S': 
				return 'Sim'; 
			case 'N': 
				return 'Não'; 
			default: 
				return null; 
		} 
	} 

	static setHistoricoObrigatorio(String? historicoObrigatorio) { 
		switch (historicoObrigatorio) { 
			case 'Sim': 
				return 'S'; 
			case 'Não': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

	static getPermiteLancamentoZerado(String? permiteLancamentoZerado) { 
		switch (permiteLancamentoZerado) { 
			case '': 
			case 'S': 
				return 'Sim'; 
			case 'N': 
				return 'Não'; 
			default: 
				return null; 
		} 
	} 

	static setPermiteLancamentoZerado(String? permiteLancamentoZerado) { 
		switch (permiteLancamentoZerado) { 
			case 'Sim': 
				return 'S'; 
			case 'Não': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

	static getGeraInformativoSped(String? geraInformativoSped) { 
		switch (geraInformativoSped) { 
			case '': 
			case 'S': 
				return 'Sim'; 
			case 'N': 
				return 'Não'; 
			default: 
				return null; 
		} 
	} 

	static setGeraInformativoSped(String? geraInformativoSped) { 
		switch (geraInformativoSped) { 
			case 'Sim': 
				return 'S'; 
			case 'Não': 
				return 'N'; 
			default: 
				return null; 
		} 
	}

	static getSpedFormaEscritDiario(String? spedFormaEscritDiario) { 
		switch (spedFormaEscritDiario) { 
			case '': 
			case '0': 
				return 'Livro Diário Completo'; 
			case '1': 
				return 'Livro Diário com Escrituração Resumida'; 
			case '2': 
				return 'Livro Balancete Diário e Balanços'; 
			default: 
				return null; 
		} 
	} 

	static setSpedFormaEscritDiario(String? spedFormaEscritDiario) { 
		switch (spedFormaEscritDiario) { 
			case 'Livro Diário Completo': 
				return '0'; 
			case 'Livro Diário com Escrituração Resumida': 
				return '1'; 
			case 'Livro Balancete Diário e Balanços': 
				return '2'; 
			default: 
				return null; 
		} 
	}

}