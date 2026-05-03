-- ================================================================
-- NexCRM / Fênix ERP — Script DDL PostgreSQL 13+
-- Gerado a partir do modelo MySQL Workbench (fenix.mwb)
-- Tabelas: 478  |  Colunas: 4118  |  FKs: 432
-- ================================================================

-- Criar schema e definir search_path
CREATE SCHEMA IF NOT EXISTS fenix;
SET search_path TO fenix, public;

-- Extensões recomendadas
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pg_trgm";
CREATE EXTENSION IF NOT EXISTS "unaccent";

-- ----------------------------------------------------------------
-- PESSOA
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PESSOA (
  ID SERIAL NOT NULL,
  NOME VARCHAR(150),
  TIPO CHAR(1),
  SITE VARCHAR(250),
  EMAIL VARCHAR(250),
  EH_CLIENTE CHAR(1),
  EH_FORNECEDOR CHAR(1),
  EH_TRANSPORTADORA CHAR(1),
  EH_COLABORADOR CHAR(1),
  EH_CONTADOR CHAR(1),
  CONSTRAINT pk_pessoa PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PESSOA_FISICA
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PESSOA_FISICA (
  ID SERIAL NOT NULL,
  ID_PESSOA INTEGER NOT NULL,
  ID_NIVEL_FORMACAO INTEGER NOT NULL,
  ID_ESTADO_CIVIL INTEGER NOT NULL,
  CPF VARCHAR(11),
  RG VARCHAR(20),
  ORGAO_RG VARCHAR(20),
  DATA_EMISSAO_RG DATE,
  DATA_NASCIMENTO DATE,
  SEXO CHAR(1),
  RACA CHAR(1),
  NACIONALIDADE VARCHAR(100),
  NATURALIDADE VARCHAR(100),
  NOME_PAI VARCHAR(200),
  NOME_MAE VARCHAR(200),
  CONSTRAINT pk_pessoa_fisica PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PESSOA_JURIDICA
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PESSOA_JURIDICA (
  ID SERIAL NOT NULL,
  ID_PESSOA INTEGER NOT NULL,
  CNPJ VARCHAR(14),
  NOME_FANTASIA VARCHAR(100),
  INSCRICAO_ESTADUAL VARCHAR(45),
  INSCRICAO_MUNICIPAL VARCHAR(45),
  DATA_CONSTITUICAO DATE,
  TIPO_REGIME CHAR(1),
  CRT CHAR(1),
  CONSTRAINT pk_pessoa_juridica PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CLIENTE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CLIENTE (
  ID SERIAL NOT NULL,
  ID_PESSOA INTEGER NOT NULL,
  ID_TABELA_PRECO INTEGER,
  DESDE DATE,
  DATA_CADASTRO DATE,
  TAXA_DESCONTO NUMERIC(18,6),
  LIMITE_CREDITO NUMERIC(18,6),
  OBSERVACAO VARCHAR(250),
  CONSTRAINT pk_cliente PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- FORNECEDOR
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FORNECEDOR (
  ID SERIAL NOT NULL,
  ID_PESSOA INTEGER NOT NULL,
  DESDE DATE,
  DATA_CADASTRO DATE,
  OBSERVACAO VARCHAR(250),
  CONSTRAINT pk_fornecedor PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- TRANSPORTADORA
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS TRANSPORTADORA (
  ID SERIAL NOT NULL,
  ID_PESSOA INTEGER NOT NULL,
  DATA_CADASTRO DATE,
  OBSERVACAO VARCHAR(250),
  CONSTRAINT pk_transportadora PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CONTADOR
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CONTADOR (
  ID SERIAL NOT NULL,
  ID_PESSOA INTEGER NOT NULL,
  CRC_INSCRICAO VARCHAR(15),
  CRC_UF CHAR(2),
  CONSTRAINT pk_contador PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- COLABORADOR
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS COLABORADOR (
  ID SERIAL NOT NULL,
  ID_PESSOA INTEGER NOT NULL,
  ID_CARGO INTEGER,
  ID_SETOR INTEGER,
  ID_COLABORADOR_SITUACAO INTEGER,
  ID_TIPO_ADMISSAO INTEGER,
  ID_COLABORADOR_TIPO INTEGER,
  ID_SINDICATO INTEGER,
  MATRICULA VARCHAR(10),
  DATA_CADASTRO DATE,
  DATA_ADMISSAO DATE,
  DATA_DEMISSAO DATE,
  CTPS_NUMERO VARCHAR(10),
  CTPS_SERIE VARCHAR(10),
  CTPS_DATA_EXPEDICAO DATE,
  CTPS_UF CHAR(2),
  OBSERVACAO VARCHAR(250),
  CONSTRAINT pk_colaborador PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- VENDEDOR
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS VENDEDOR (
  ID SERIAL NOT NULL,
  ID_COLABORADOR INTEGER NOT NULL,
  ID_COMISSAO_PERFIL INTEGER,
  COMISSAO NUMERIC(18,6),
  META_VENDA NUMERIC(18,6),
  CONSTRAINT pk_vendedor PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PESSOA_ENDERECO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PESSOA_ENDERECO (
  ID SERIAL NOT NULL,
  ID_PESSOA INTEGER NOT NULL,
  LOGRADOURO VARCHAR(100),
  NUMERO VARCHAR(10),
  BAIRRO VARCHAR(100),
  MUNICIPIO_IBGE INTEGER,
  UF CHAR(2),
  CEP VARCHAR(8),
  CIDADE VARCHAR(100),
  COMPLEMENTO VARCHAR(100),
  PRINCIPAL CHAR(1),
  ENTREGA CHAR(1),
  COBRANCA CHAR(1),
  CORRESPONDENCIA CHAR(1),
  CONSTRAINT pk_pessoa_endereco PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PESSOA_CONTATO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PESSOA_CONTATO (
  ID SERIAL NOT NULL,
  ID_PESSOA INTEGER NOT NULL,
  NOME VARCHAR(150),
  EMAIL VARCHAR(250),
  OBSERVACAO VARCHAR(250),
  CONSTRAINT pk_pessoa_contato PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PESSOA_TELEFONE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PESSOA_TELEFONE (
  ID SERIAL NOT NULL,
  ID_PESSOA INTEGER NOT NULL,
  TIPO CHAR(1),
  NUMERO VARCHAR(15),
  CONSTRAINT pk_pessoa_telefone PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- NIVEL_FORMACAO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS NIVEL_FORMACAO (
  ID SERIAL NOT NULL,
  NOME VARCHAR(100),
  DESCRICAO VARCHAR(250),
  CONSTRAINT pk_nivel_formacao PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- ESTADO_CIVIL
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ESTADO_CIVIL (
  ID SERIAL NOT NULL,
  NOME VARCHAR(50),
  DESCRICAO VARCHAR(250),
  CONSTRAINT pk_estado_civil PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CARGO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CARGO (
  ID SERIAL NOT NULL,
  NOME VARCHAR(100),
  DESCRICAO VARCHAR(250),
  SALARIO NUMERIC(18,6),
  CBO_1994 VARCHAR(10),
  CBO_2002 VARCHAR(10),
  CONSTRAINT pk_cargo PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- USUARIO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS USUARIO (
  ID SERIAL NOT NULL,
  ID_COLABORADOR INTEGER NOT NULL,
  ID_PAPEL INTEGER NOT NULL,
  LOGIN VARCHAR(50),
  SENHA VARCHAR(50),
  ADMINISTRADOR CHAR(1),
  DATA_CADASTRO DATE,
  CONSTRAINT pk_usuario PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- FUNCAO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FUNCAO (
  ID SERIAL NOT NULL,
  NOME VARCHAR(100),
  DESCRICAO VARCHAR(250),
  CONSTRAINT pk_funcao PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PAPEL
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PAPEL (
  ID SERIAL NOT NULL,
  NOME VARCHAR(100),
  DESCRICAO VARCHAR(250),
  CONSTRAINT pk_papel PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PAPEL_FUNCAO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PAPEL_FUNCAO (
  ID SERIAL NOT NULL,
  ID_PAPEL INTEGER NOT NULL,
  ID_FUNCAO INTEGER NOT NULL,
  HABILITADO CHAR(1),
  PODE_INSERIR CHAR(1),
  PODE_ALTERAR CHAR(1),
  PODE_EXCLUIR CHAR(1),
  CONSTRAINT pk_papel_funcao PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- EMPRESA
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS EMPRESA (
  ID SERIAL NOT NULL,
  RAZAO_SOCIAL VARCHAR(150),
  NOME_FANTASIA VARCHAR(150),
  CNPJ VARCHAR(14),
  INSCRICAO_ESTADUAL VARCHAR(45),
  INSCRICAO_MUNICIPAL VARCHAR(45),
  TIPO_REGIME CHAR(1),
  CRT CHAR(1),
  EMAIL VARCHAR(250),
  SITE VARCHAR(250),
  CONTATO VARCHAR(100),
  DATA_CONSTITUICAO DATE,
  TIPO CHAR(1),
  INSCRICAO_JUNTA_COMERCIAL VARCHAR(30),
  DATA_INSC_JUNTA_COMERCIAL DATE,
  CODIGO_IBGE_CIDADE INTEGER DEFAULT NULL,
  CODIGO_IBGE_UF INTEGER DEFAULT NULL,
  CEI VARCHAR(12) DEFAULT NULL,
  CODIGO_CNAE_PRINCIPAL VARCHAR(7) DEFAULT NULL,
  IMAGEM_LOGOTIPO TEXT,
  CONSTRAINT pk_empresa PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- SETOR
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS SETOR (
  ID SERIAL NOT NULL,
  NOME VARCHAR(100),
  DESCRICAO VARCHAR(250),
  CONSTRAINT pk_setor PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PRODUTO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PRODUTO (
  ID SERIAL NOT NULL,
  ID_PRODUTO_SUBGRUPO INTEGER NOT NULL,
  ID_PRODUTO_MARCA INTEGER NOT NULL,
  ID_PRODUTO_UNIDADE INTEGER NOT NULL,
  ID_TRIBUT_ICMS_CUSTOM_CAB INTEGER,
  ID_TRIBUT_GRUPO_TRIBUTARIO INTEGER,
  NOME VARCHAR(100),
  DESCRICAO VARCHAR(250),
  GTIN VARCHAR(14),
  CODIGO_INTERNO VARCHAR(50),
  VALOR_COMPRA NUMERIC(18,6),
  VALOR_VENDA NUMERIC(18,6),
  CODIGO_NCM VARCHAR(8),
  ESTOQUE_MINIMO NUMERIC(18,6),
  ESTOQUE_MAXIMO NUMERIC(18,6),
  QUANTIDADE_ESTOQUE NUMERIC(18,6),
  DATA_CADASTRO DATE,
  CONSTRAINT pk_produto PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PRODUTO_GRUPO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PRODUTO_GRUPO (
  ID SERIAL NOT NULL,
  NOME VARCHAR(100),
  DESCRICAO VARCHAR(250),
  CONSTRAINT pk_produto_grupo PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PRODUTO_SUBGRUPO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PRODUTO_SUBGRUPO (
  ID SERIAL NOT NULL,
  ID_PRODUTO_GRUPO INTEGER NOT NULL,
  NOME VARCHAR(100),
  DESCRICAO VARCHAR(250),
  CONSTRAINT pk_produto_subgrupo PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PRODUTO_MARCA
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PRODUTO_MARCA (
  ID SERIAL NOT NULL,
  NOME VARCHAR(100),
  DESCRICAO VARCHAR(250),
  CONSTRAINT pk_produto_marca PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PRODUTO_UNIDADE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PRODUTO_UNIDADE (
  ID SERIAL NOT NULL,
  SIGLA VARCHAR(10),
  DESCRICAO VARCHAR(250),
  PODE_FRACIONAR CHAR(1),
  CONSTRAINT pk_produto_unidade PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- BANCO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS BANCO (
  ID SERIAL NOT NULL,
  CODIGO VARCHAR(10),
  NOME VARCHAR(100),
  URL VARCHAR(250),
  CONSTRAINT pk_banco PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- BANCO_AGENCIA
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS BANCO_AGENCIA (
  ID SERIAL NOT NULL,
  ID_BANCO INTEGER NOT NULL,
  NUMERO VARCHAR(20),
  DIGITO CHAR(1),
  NOME VARCHAR(100),
  TELEFONE VARCHAR(15),
  CONTATO VARCHAR(100),
  OBSERVACAO VARCHAR(250),
  GERENTE VARCHAR(100),
  CONSTRAINT pk_banco_agencia PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- BANCO_CONTA_CAIXA
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS BANCO_CONTA_CAIXA (
  ID SERIAL NOT NULL,
  ID_BANCO_AGENCIA INTEGER,
  NUMERO VARCHAR(20),
  DIGITO CHAR(1),
  NOME VARCHAR(100),
  TIPO CHAR(1),
  DESCRICAO VARCHAR(250),
  CONSTRAINT pk_banco_conta_caixa PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CEP
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CEP (
  ID SERIAL NOT NULL,
  NUMERO VARCHAR(8),
  LOGRADOURO VARCHAR(100),
  COMPLEMENTO VARCHAR(100),
  BAIRRO VARCHAR(100),
  MUNICIPIO VARCHAR(100),
  UF CHAR(2),
  CODIGO_IBGE_MUNICIPIO INTEGER,
  CONSTRAINT pk_cep PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- MUNICIPIO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS MUNICIPIO (
  ID SERIAL NOT NULL,
  ID_UF INTEGER NOT NULL,
  NOME VARCHAR(100),
  CODIGO_IBGE INTEGER,
  CODIGO_RECEITA_FEDERAL INTEGER,
  CODIGO_ESTADUAL INTEGER,
  CONSTRAINT pk_municipio PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- UF
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS UF (
  ID SERIAL NOT NULL,
  SIGLA CHAR(2),
  NOME VARCHAR(100),
  CODIGO_IBGE INTEGER,
  CONSTRAINT pk_uf PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- NCM
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS NCM (
  ID SERIAL NOT NULL,
  CODIGO VARCHAR(8),
  DESCRICAO VARCHAR(1000),
  OBSERVACAO VARCHAR(1000),
  CONSTRAINT pk_ncm PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CFOP
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CFOP (
  ID SERIAL NOT NULL,
  CODIGO INTEGER,
  DESCRICAO VARCHAR(1000),
  APLICACAO VARCHAR(1000),
  CONSTRAINT pk_cfop PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CST_ICMS
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CST_ICMS (
  ID SERIAL NOT NULL,
  CODIGO CHAR(2),
  DESCRICAO VARCHAR(250),
  OBSERVACAO VARCHAR(250),
  CONSTRAINT pk_cst_icms PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CST_IPI
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CST_IPI (
  ID SERIAL NOT NULL,
  CODIGO CHAR(2),
  DESCRICAO VARCHAR(250),
  OBSERVACAO VARCHAR(250),
  CONSTRAINT pk_cst_ipi PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CST_COFINS
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CST_COFINS (
  ID SERIAL NOT NULL,
  CODIGO CHAR(2),
  DESCRICAO VARCHAR(250),
  OBSERVACAO VARCHAR(250),
  CONSTRAINT pk_cst_cofins PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CST_PIS
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CST_PIS (
  ID SERIAL NOT NULL,
  CODIGO CHAR(2),
  DESCRICAO VARCHAR(250),
  OBSERVACAO VARCHAR(250),
  CONSTRAINT pk_cst_pis PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CSOSN
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CSOSN (
  ID SERIAL NOT NULL,
  CODIGO CHAR(3),
  DESCRICAO VARCHAR(250),
  OBSERVACAO VARCHAR(1000),
  CONSTRAINT pk_csosn PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- EMPRESA_ENDERECO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS EMPRESA_ENDERECO (
  ID SERIAL NOT NULL,
  ID_EMPRESA INTEGER NOT NULL,
  LOGRADOURO VARCHAR(100),
  NUMERO VARCHAR(10),
  BAIRRO VARCHAR(100),
  CIDADE VARCHAR(100),
  UF CHAR(2),
  CEP VARCHAR(8),
  MUNICIPIO_IBGE INTEGER,
  COMPLEMENTO VARCHAR(100),
  PRINCIPAL CHAR(1),
  ENTREGA CHAR(1),
  COBRANCA CHAR(1),
  CORRESPONDENCIA CHAR(1),
  CONSTRAINT pk_empresa_endereco PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- EMPRESA_CONTATO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS EMPRESA_CONTATO (
  ID SERIAL NOT NULL,
  ID_EMPRESA INTEGER NOT NULL,
  NOME VARCHAR(150),
  EMAIL VARCHAR(250),
  OBSERVACAO VARCHAR(250),
  CONSTRAINT pk_empresa_contato PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- EMPRESA_TELEFONE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS EMPRESA_TELEFONE (
  ID SERIAL NOT NULL,
  ID_EMPRESA INTEGER NOT NULL,
  TIPO CHAR(1),
  NUMERO VARCHAR(15),
  CONSTRAINT pk_empresa_telefone PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CNAE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CNAE (
  ID SERIAL NOT NULL,
  CODIGO VARCHAR(7),
  DENOMINACAO VARCHAR(1000),
  CONSTRAINT pk_cnae PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- TALONARIO_CHEQUE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS TALONARIO_CHEQUE (
  ID SERIAL NOT NULL,
  ID_BANCO_CONTA_CAIXA INTEGER NOT NULL,
  TALAO VARCHAR(10),
  NUMERO INTEGER,
  STATUS_TALAO CHAR(1),
  CONSTRAINT pk_talonario_cheque PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CHEQUE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CHEQUE (
  ID SERIAL NOT NULL,
  ID_TALONARIO_CHEQUE INTEGER NOT NULL,
  NUMERO INTEGER,
  STATUS_CHEQUE CHAR(1),
  DATA_STATUS DATE,
  CONSTRAINT pk_cheque PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- FIN_FECHAMENTO_CAIXA_BANCO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FIN_FECHAMENTO_CAIXA_BANCO (
  ID SERIAL NOT NULL,
  ID_BANCO_CONTA_CAIXA INTEGER NOT NULL,
  DATA_FECHAMENTO DATE,
  MES_ANO VARCHAR(7),
  MES CHAR(2),
  ANO CHAR(4),
  SALDO_ANTERIOR NUMERIC(18,6),
  RECEBIMENTOS NUMERIC(18,6),
  PAGAMENTOS NUMERIC(18,6),
  SALDO_CONTA NUMERIC(18,6),
  CHEQUE_NAO_COMPENSADO NUMERIC(18,6),
  SALDO_DISPONIVEL NUMERIC(18,6),
  CONSTRAINT pk_fin_fechamento_caixa_banco PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- FIN_EXTRATO_CONTA_BANCO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FIN_EXTRATO_CONTA_BANCO (
  ID SERIAL NOT NULL,
  ID_BANCO_CONTA_CAIXA INTEGER NOT NULL,
  MES_ANO VARCHAR(7),
  MES CHAR(2),
  ANO CHAR(4),
  DATA_MOVIMENTO DATE,
  DATA_BALANCETE DATE,
  HISTORICO VARCHAR(250),
  DOCUMENTO VARCHAR(50),
  VALOR NUMERIC(18,6),
  CONCILIADO CHAR(1),
  OBSERVACAO TEXT,
  CONSTRAINT pk_fin_extrato_conta_banco PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- FIN_LANCAMENTO_PAGAR
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FIN_LANCAMENTO_PAGAR (
  ID SERIAL NOT NULL,
  ID_FIN_DOCUMENTO_ORIGEM INTEGER NOT NULL,
  ID_FIN_NATUREZA_FINANCEIRA INTEGER NOT NULL,
  ID_FORNECEDOR INTEGER NOT NULL,
  ID_BANCO_CONTA_CAIXA INTEGER NOT NULL,
  QUANTIDADE_PARCELA INTEGER,
  VALOR_A_PAGAR NUMERIC(18,6),
  DATA_LANCAMENTO DATE,
  NUMERO_DOCUMENTO VARCHAR(50),
  IMAGEM_DOCUMENTO TEXT,
  PRIMEIRO_VENCIMENTO DATE,
  INTERVALO_ENTRE_PARCELAS INTEGER,
  DIA_FIXO CHAR(2),
  CONSTRAINT pk_fin_lancamento_pagar PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- FIN_PARCELA_PAGAR
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FIN_PARCELA_PAGAR (
  ID SERIAL NOT NULL,
  ID_FIN_LANCAMENTO_PAGAR INTEGER NOT NULL,
  ID_FIN_STATUS_PARCELA INTEGER NOT NULL,
  ID_FIN_TIPO_PAGAMENTO INTEGER,
  ID_FIN_CHEQUE_EMITIDO INTEGER,
  NUMERO_PARCELA INTEGER,
  DATA_EMISSAO DATE,
  DATA_VENCIMENTO DATE,
  DATA_PAGAMENTO DATE,
  DESCONTO_ATE DATE,
  VALOR NUMERIC(18,6),
  TAXA_JURO NUMERIC(18,6),
  TAXA_MULTA NUMERIC(18,6),
  TAXA_DESCONTO NUMERIC(18,6),
  VALOR_JURO NUMERIC(18,6),
  VALOR_MULTA NUMERIC(18,6),
  VALOR_DESCONTO NUMERIC(18,6),
  VALOR_PAGO NUMERIC(18,6),
  HISTORICO TEXT,
  CONSTRAINT pk_fin_parcela_pagar PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- FIN_DOCUMENTO_ORIGEM
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FIN_DOCUMENTO_ORIGEM (
  ID SERIAL NOT NULL,
  CODIGO CHAR(3),
  SIGLA CHAR(10),
  DESCRICAO TEXT,
  CONSTRAINT pk_fin_documento_origem PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- FIN_STATUS_PARCELA
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FIN_STATUS_PARCELA (
  ID SERIAL NOT NULL,
  SITUACAO CHAR(2) NOT NULL,
  DESCRICAO VARCHAR(30),
  PROCEDIMENTO TEXT,
  CONSTRAINT pk_fin_status_parcela PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- FIN_TIPO_PAGAMENTO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FIN_TIPO_PAGAMENTO (
  ID SERIAL NOT NULL,
  CODIGO CHAR(2),
  DESCRICAO VARCHAR(30),
  CONSTRAINT pk_fin_tipo_pagamento PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- FIN_CHEQUE_EMITIDO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FIN_CHEQUE_EMITIDO (
  ID SERIAL NOT NULL,
  ID_CHEQUE INTEGER NOT NULL,
  DATA_EMISSAO DATE,
  BOM_PARA DATE,
  DATA_COMPENSACAO DATE,
  VALOR NUMERIC(18,6),
  NOMINAL_A VARCHAR(100),
  CONSTRAINT pk_fin_cheque_emitido PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- FIN_NATUREZA_FINANCEIRA
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FIN_NATUREZA_FINANCEIRA (
  ID SERIAL NOT NULL,
  CODIGO CHAR(4),
  DESCRICAO VARCHAR(100),
  TIPO CHAR(1),
  APLICACAO VARCHAR(250),
  CONSTRAINT pk_fin_natureza_financeira PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- FIN_TIPO_RECEBIMENTO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FIN_TIPO_RECEBIMENTO (
  ID SERIAL NOT NULL,
  CODIGO CHAR(2),
  DESCRICAO VARCHAR(100),
  CONSTRAINT pk_fin_tipo_recebimento PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- FIN_LANCAMENTO_RECEBER
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FIN_LANCAMENTO_RECEBER (
  ID SERIAL NOT NULL,
  ID_FIN_DOCUMENTO_ORIGEM INTEGER NOT NULL,
  ID_FIN_NATUREZA_FINANCEIRA INTEGER NOT NULL,
  ID_CLIENTE INTEGER NOT NULL,
  ID_BANCO_CONTA_CAIXA INTEGER NOT NULL,
  QUANTIDADE_PARCELA INTEGER,
  VALOR_A_RECEBER NUMERIC(18,6),
  DATA_LANCAMENTO DATE,
  NUMERO_DOCUMENTO VARCHAR(50),
  PRIMEIRO_VENCIMENTO DATE,
  TAXA_COMISSAO NUMERIC(18,6),
  VALOR_COMISSAO NUMERIC(18,6),
  INTERVALO_ENTRE_PARCELAS INTEGER,
  DIA_FIXO CHAR(2),
  CONSTRAINT pk_fin_lancamento_receber PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- FIN_PARCELA_RECEBER
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FIN_PARCELA_RECEBER (
  ID SERIAL NOT NULL,
  ID_FIN_LANCAMENTO_RECEBER INTEGER NOT NULL,
  ID_FIN_STATUS_PARCELA INTEGER NOT NULL,
  ID_FIN_TIPO_RECEBIMENTO INTEGER,
  ID_FIN_CHEQUE_RECEBIDO INTEGER,
  NUMERO_PARCELA INTEGER,
  DATA_EMISSAO DATE,
  DATA_VENCIMENTO DATE,
  DATA_RECEBIMENTO DATE,
  DESCONTO_ATE DATE,
  VALOR NUMERIC(18,6),
  TAXA_JURO NUMERIC(18,6),
  TAXA_MULTA NUMERIC(18,6),
  TAXA_DESCONTO NUMERIC(18,6),
  VALOR_JURO NUMERIC(18,6),
  VALOR_MULTA NUMERIC(18,6),
  VALOR_DESCONTO NUMERIC(18,6),
  EMITIU_BOLETO CHAR(1),
  BOLETO_NOSSO_NUMERO VARCHAR(50),
  VALOR_RECEBIDO NUMERIC(18,6),
  HISTORICO TEXT,
  CONSTRAINT pk_fin_parcela_receber PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- FIN_CHEQUE_RECEBIDO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FIN_CHEQUE_RECEBIDO (
  ID SERIAL NOT NULL,
  ID_PESSOA INTEGER,
  CPF VARCHAR(11),
  CNPJ VARCHAR(14),
  NOME VARCHAR(100),
  CODIGO_BANCO VARCHAR(10),
  CODIGO_AGENCIA VARCHAR(10),
  CONTA VARCHAR(20),
  NUMERO INTEGER,
  DATA_EMISSAO DATE,
  BOM_PARA DATE,
  DATA_COMPENSACAO DATE,
  VALOR NUMERIC(18,6),
  CUSTODIA_DATA DATE,
  CUSTODIA_TARIFA NUMERIC(18,6),
  CUSTODIA_COMISSAO NUMERIC(18,6),
  DESCONTO_DATA DATE,
  DESCONTO_TARIFA NUMERIC(18,6),
  DESCONTO_COMISSAO NUMERIC(18,6),
  VALOR_RECEBIDO NUMERIC(18,6),
  CONSTRAINT pk_fin_cheque_recebido PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- FIN_CONFIGURACAO_BOLETO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FIN_CONFIGURACAO_BOLETO (
  ID SERIAL NOT NULL,
  ID_BANCO_CONTA_CAIXA INTEGER NOT NULL,
  INSTRUCAO01 VARCHAR(100),
  INSTRUCAO02 VARCHAR(100),
  CAMINHO_ARQUIVO_REMESSA VARCHAR(250),
  CAMINHO_ARQUIVO_RETORNO VARCHAR(250),
  CAMINHO_ARQUIVO_LOGOTIPO VARCHAR(250),
  CAMINHO_ARQUIVO_PDF VARCHAR(250),
  MENSAGEM VARCHAR(250),
  LOCAL_PAGAMENTO VARCHAR(100),
  LAYOUT_REMESSA CHAR(3),
  ACEITE CHAR(1),
  ESPECIE CHAR(1),
  CARTEIRA CHAR(3),
  CODIGO_CONVENIO VARCHAR(20),
  CODIGO_CEDENTE VARCHAR(20),
  TAXA_MULTA NUMERIC(18,6),
  TAXA_JURO NUMERIC(18,6),
  DIAS_PROTESTO INTEGER,
  NOSSO_NUMERO_ANTERIOR VARCHAR(50),
  CONSTRAINT pk_fin_configuracao_boleto PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- TRIBUT_OPERACAO_FISCAL
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS TRIBUT_OPERACAO_FISCAL (
  ID SERIAL NOT NULL,
  DESCRICAO VARCHAR(100),
  DESCRICAO_NA_NF VARCHAR(100),
  CFOP INTEGER,
  OBSERVACAO TEXT,
  CONSTRAINT pk_tribut_operacao_fiscal PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- TRIBUT_ICMS_UF
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS TRIBUT_ICMS_UF (
  ID SERIAL NOT NULL,
  ID_TRIBUT_CONFIGURA_OF_GT INTEGER NOT NULL,
  UF_DESTINO CHAR(2),
  CFOP INTEGER,
  CSOSN CHAR(3),
  CST CHAR(2),
  MODALIDADE_BC CHAR(1),
  ALIQUOTA NUMERIC(18,6),
  VALOR_PAUTA NUMERIC(18,6),
  VALOR_PRECO_MAXIMO NUMERIC(18,6),
  MVA NUMERIC(18,6),
  PORCENTO_BC NUMERIC(18,6),
  MODALIDADE_BC_ST CHAR(1),
  ALIQUOTA_INTERNA_ST NUMERIC(18,6),
  ALIQUOTA_INTERESTADUAL_ST NUMERIC(18,6),
  PORCENTO_BC_ST NUMERIC(18,6),
  ALIQUOTA_ICMS_ST NUMERIC(18,6),
  VALOR_PAUTA_ST NUMERIC(18,6),
  VALOR_PRECO_MAXIMO_ST NUMERIC(18,6),
  CONSTRAINT pk_tribut_icms_uf PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- TRIBUT_PIS
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS TRIBUT_PIS (
  ID SERIAL NOT NULL,
  ID_TRIBUT_CONFIGURA_OF_GT INTEGER NOT NULL,
  CST_PIS CHAR(2),
  EFD_TABELA_435 CHAR(2),
  MODALIDADE_BASE_CALCULO CHAR(1),
  PORCENTO_BASE_CALCULO NUMERIC(18,6),
  ALIQUOTA_PORCENTO NUMERIC(18,6),
  ALIQUOTA_UNIDADE NUMERIC(18,6),
  VALOR_PRECO_MAXIMO NUMERIC(18,6),
  VALOR_PAUTA_FISCAL NUMERIC(18,6),
  CONSTRAINT pk_tribut_pis PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- TRIBUT_COFINS
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS TRIBUT_COFINS (
  ID SERIAL NOT NULL,
  ID_TRIBUT_CONFIGURA_OF_GT INTEGER NOT NULL,
  CST_COFINS CHAR(2),
  EFD_TABELA_435 CHAR(2),
  MODALIDADE_BASE_CALCULO CHAR(1),
  PORCENTO_BASE_CALCULO NUMERIC(18,6),
  ALIQUOTA_PORCENTO NUMERIC(18,6),
  ALIQUOTA_UNIDADE NUMERIC(18,6),
  VALOR_PRECO_MAXIMO NUMERIC(18,6),
  VALOR_PAUTA_FISCAL NUMERIC(18,6),
  CONSTRAINT pk_tribut_cofins PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- TRIBUT_IPI
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS TRIBUT_IPI (
  ID SERIAL NOT NULL,
  ID_TRIBUT_CONFIGURA_OF_GT INTEGER NOT NULL,
  CST_IPI CHAR(2),
  MODALIDADE_BASE_CALCULO CHAR(1),
  PORCENTO_BASE_CALCULO NUMERIC(18,6),
  ALIQUOTA_PORCENTO NUMERIC(18,6),
  ALIQUOTA_UNIDADE NUMERIC(18,6),
  VALOR_PRECO_MAXIMO NUMERIC(18,6),
  VALOR_PAUTA_FISCAL NUMERIC(18,6),
  CONSTRAINT pk_tribut_ipi PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- TRIBUT_GRUPO_TRIBUTARIO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS TRIBUT_GRUPO_TRIBUTARIO (
  ID SERIAL NOT NULL,
  DESCRICAO VARCHAR(100),
  ORIGEM_MERCADORIA CHAR(1),
  OBSERVACAO TEXT,
  CONSTRAINT pk_tribut_grupo_tributario PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- TRIBUT_ISS
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS TRIBUT_ISS (
  ID SERIAL NOT NULL,
  ID_TRIBUT_OPERACAO_FISCAL INTEGER NOT NULL,
  MODALIDADE_BASE_CALCULO CHAR(1),
  PORCENTO_BASE_CALCULO NUMERIC(18,6),
  ALIQUOTA_PORCENTO NUMERIC(18,6),
  ALIQUOTA_UNIDADE NUMERIC(18,6),
  VALOR_PRECO_MAXIMO NUMERIC(18,6),
  VALOR_PAUTA_FISCAL NUMERIC(18,6),
  ITEM_LISTA_SERVICO INTEGER,
  CODIGO_TRIBUTACAO CHAR(1),
  CONSTRAINT pk_tribut_iss PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- COMPRA_TIPO_REQUISICAO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS COMPRA_TIPO_REQUISICAO (
  ID SERIAL NOT NULL,
  CODIGO CHAR(2),
  NOME VARCHAR(30),
  DESCRICAO TEXT,
  CONSTRAINT pk_compra_tipo_requisicao PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- COMPRA_REQUISICAO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS COMPRA_REQUISICAO (
  ID SERIAL NOT NULL,
  ID_COMPRA_TIPO_REQUISICAO INTEGER NOT NULL,
  ID_COLABORADOR INTEGER NOT NULL,
  DESCRICAO VARCHAR(100),
  DATA_REQUISICAO DATE,
  OBSERVACAO TEXT,
  CONSTRAINT pk_compra_requisicao PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- COMPRA_REQUISICAO_DETALHE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS COMPRA_REQUISICAO_DETALHE (
  ID SERIAL NOT NULL,
  ID_COMPRA_REQUISICAO INTEGER NOT NULL,
  ID_PRODUTO INTEGER NOT NULL,
  QUANTIDADE NUMERIC(18,6),
  CONSTRAINT pk_compra_requisicao_detalhe PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- COMPRA_COTACAO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS COMPRA_COTACAO (
  ID SERIAL NOT NULL,
  ID_COMPRA_REQUISICAO INTEGER NOT NULL,
  DATA_COTACAO DATE,
  DESCRICAO VARCHAR(100),
  CONSTRAINT pk_compra_cotacao PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- COMPRA_FORNECEDOR_COTACAO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS COMPRA_FORNECEDOR_COTACAO (
  ID SERIAL NOT NULL,
  ID_COMPRA_COTACAO INTEGER NOT NULL,
  ID_FORNECEDOR INTEGER NOT NULL,
  CODIGO VARCHAR(32),
  PRAZO_ENTREGA VARCHAR(50),
  VENDA_CONDICOES_PAGAMENTO VARCHAR(50),
  VALOR_SUBTOTAL NUMERIC(18,6),
  TAXA_DESCONTO NUMERIC(18,6),
  VALOR_DESCONTO NUMERIC(18,6),
  VALOR_TOTAL NUMERIC(18,6),
  CONSTRAINT pk_compra_fornecedor_cotacao PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- COMPRA_COTACAO_DETALHE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS COMPRA_COTACAO_DETALHE (
  ID SERIAL NOT NULL,
  ID_COMPRA_FORNECEDOR_COTACAO INTEGER NOT NULL,
  ID_PRODUTO INTEGER NOT NULL,
  QUANTIDADE NUMERIC(18,6),
  VALOR_UNITARIO NUMERIC(18,6),
  VALOR_SUBTOTAL NUMERIC(18,6),
  TAXA_DESCONTO NUMERIC(18,6),
  VALOR_DESCONTO NUMERIC(18,6),
  VALOR_TOTAL NUMERIC(18,6),
  CONSTRAINT pk_compra_cotacao_detalhe PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- COMPRA_PEDIDO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS COMPRA_PEDIDO (
  ID SERIAL NOT NULL,
  ID_COMPRA_TIPO_PEDIDO INTEGER NOT NULL,
  ID_FORNECEDOR INTEGER NOT NULL,
  ID_COLABORADOR INTEGER NOT NULL,
  DATA_PEDIDO DATE,
  DATA_PREVISTA_ENTREGA DATE,
  DATA_PREVISAO_PAGAMENTO DATE,
  LOCAL_ENTREGA VARCHAR(100),
  LOCAL_COBRANCA VARCHAR(100),
  CONTATO VARCHAR(50),
  VALOR_SUBTOTAL NUMERIC(18,6),
  TAXA_DESCONTO NUMERIC(18,6),
  VALOR_DESCONTO NUMERIC(18,6),
  VALOR_TOTAL NUMERIC(18,6),
  TIPO_FRETE CHAR(1),
  FORMA_PAGAMENTO CHAR(1),
  BASE_CALCULO_ICMS NUMERIC(18,6),
  VALOR_ICMS NUMERIC(18,6),
  BASE_CALCULO_ICMS_ST NUMERIC(18,6),
  VALOR_ICMS_ST NUMERIC(18,6),
  VALOR_TOTAL_PRODUTOS NUMERIC(18,6),
  VALOR_FRETE NUMERIC(18,6),
  VALOR_SEGURO NUMERIC(18,6),
  VALOR_OUTRAS_DESPESAS NUMERIC(18,6),
  VALOR_IPI NUMERIC(18,6),
  VALOR_TOTAL_NF NUMERIC(18,6),
  QUANTIDADE_PARCELAS INTEGER,
  DIA_PRIMEIRO_VENCIMENTO CHAR(2),
  INTERVALO_ENTRE_PARCELAS INTEGER,
  DIA_FIXO_PARCELA CHAR(2),
  CODIGO_COTACAO VARCHAR(32),
  CONSTRAINT pk_compra_pedido PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- COMPRA_PEDIDO_DETALHE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS COMPRA_PEDIDO_DETALHE (
  ID SERIAL NOT NULL,
  ID_COMPRA_PEDIDO INTEGER NOT NULL,
  ID_PRODUTO INTEGER NOT NULL,
  QUANTIDADE NUMERIC(18,6),
  VALOR_UNITARIO NUMERIC(18,6),
  VALOR_SUBTOTAL NUMERIC(18,6),
  TAXA_DESCONTO NUMERIC(18,6),
  VALOR_DESCONTO NUMERIC(18,6),
  VALOR_TOTAL NUMERIC(18,6),
  CST CHAR(2),
  CSOSN CHAR(3),
  CFOP INTEGER,
  BASE_CALCULO_ICMS NUMERIC(18,6),
  VALOR_ICMS NUMERIC(18,6),
  VALOR_IPI NUMERIC(18,6),
  ALIQUOTA_ICMS NUMERIC(18,6),
  ALIQUOTA_IPI NUMERIC(18,6),
  CONSTRAINT pk_compra_pedido_detalhe PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- COMPRA_TIPO_PEDIDO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS COMPRA_TIPO_PEDIDO (
  ID SERIAL NOT NULL,
  CODIGO CHAR(2),
  NOME VARCHAR(30),
  DESCRICAO TEXT,
  CONSTRAINT pk_compra_tipo_pedido PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- VENDA_ORCAMENTO_CABECALHO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS VENDA_ORCAMENTO_CABECALHO (
  ID SERIAL NOT NULL,
  ID_VENDA_CONDICOES_PAGAMENTO INTEGER NOT NULL,
  ID_VENDEDOR INTEGER NOT NULL,
  ID_CLIENTE INTEGER NOT NULL,
  ID_TRANSPORTADORA INTEGER,
  CODIGO VARCHAR(20),
  DATA_CADASTRO DATE,
  DATA_ENTREGA DATE,
  VALIDADE DATE,
  TIPO_FRETE CHAR(1),
  VALOR_SUBTOTAL NUMERIC(18,6),
  VALOR_FRETE NUMERIC(18,6),
  TAXA_COMISSAO NUMERIC(18,6),
  VALOR_COMISSAO NUMERIC(18,6),
  TAXA_DESCONTO NUMERIC(18,6),
  VALOR_DESCONTO NUMERIC(18,6),
  VALOR_TOTAL NUMERIC(18,6),
  OBSERVACAO TEXT,
  CONSTRAINT pk_venda_orcamento_cabecalho PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- NOTA_FISCAL_TIPO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS NOTA_FISCAL_TIPO (
  ID SERIAL NOT NULL,
  ID_NOTA_FISCAL_MODELO INTEGER NOT NULL,
  NOME VARCHAR(50),
  DESCRICAO TEXT,
  SERIE CHAR(3),
  SERIE_SCAN CHAR(3),
  ULTIMO_NUMERO INTEGER,
  CONSTRAINT pk_nota_fiscal_tipo PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- VENDA_ORCAMENTO_DETALHE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS VENDA_ORCAMENTO_DETALHE (
  ID SERIAL NOT NULL,
  ID_VENDA_ORCAMENTO_CABECALHO INTEGER NOT NULL,
  ID_PRODUTO INTEGER NOT NULL,
  QUANTIDADE NUMERIC(18,6),
  VALOR_UNITARIO NUMERIC(18,6),
  VALOR_SUBTOTAL NUMERIC(18,6),
  TAXA_DESCONTO NUMERIC(18,6),
  VALOR_DESCONTO NUMERIC(18,6),
  VALOR_TOTAL NUMERIC(18,6),
  CONSTRAINT pk_venda_orcamento_detalhe PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- VENDA_CABECALHO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS VENDA_CABECALHO (
  ID SERIAL NOT NULL,
  ID_VENDA_ORCAMENTO_CABECALHO INTEGER,
  ID_VENDA_CONDICOES_PAGAMENTO INTEGER NOT NULL,
  ID_NOTA_FISCAL_TIPO INTEGER NOT NULL,
  ID_CLIENTE INTEGER NOT NULL,
  ID_TRANSPORTADORA INTEGER,
  ID_VENDEDOR INTEGER NOT NULL,
  DATA_VENDA DATE,
  DATA_SAIDA DATE,
  HORA_SAIDA VARCHAR(8),
  NUMERO_FATURA INTEGER,
  LOCAL_ENTREGA VARCHAR(100),
  LOCAL_COBRANCA VARCHAR(100),
  VALOR_SUBTOTAL NUMERIC(18,6),
  TAXA_COMISSAO NUMERIC(18,6),
  VALOR_COMISSAO NUMERIC(18,6),
  TAXA_DESCONTO NUMERIC(18,6),
  VALOR_DESCONTO NUMERIC(18,6),
  VALOR_TOTAL NUMERIC(18,6),
  TIPO_FRETE CHAR(1),
  FORMA_PAGAMENTO CHAR(1),
  VALOR_FRETE NUMERIC(18,6),
  VALOR_SEGURO NUMERIC(18,6),
  OBSERVACAO TEXT,
  SITUACAO CHAR(1),
  DIA_FIXO_PARCELA CHAR(2),
  CONSTRAINT pk_venda_cabecalho PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- VENDA_DETALHE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS VENDA_DETALHE (
  ID SERIAL NOT NULL,
  ID_VENDA_CABECALHO INTEGER NOT NULL,
  ID_PRODUTO INTEGER NOT NULL,
  QUANTIDADE NUMERIC(18,6),
  VALOR_UNITARIO NUMERIC(18,6),
  VALOR_SUBTOTAL NUMERIC(18,6),
  TAXA_DESCONTO NUMERIC(18,6),
  VALOR_DESCONTO NUMERIC(18,6),
  VALOR_TOTAL NUMERIC(18,6),
  CONSTRAINT pk_venda_detalhe PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- VENDA_CONDICOES_PAGAMENTO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS VENDA_CONDICOES_PAGAMENTO (
  ID SERIAL NOT NULL,
  NOME VARCHAR(50),
  DESCRICAO TEXT,
  FATURAMENTO_MINIMO NUMERIC(18,6),
  FATURAMENTO_MAXIMO NUMERIC(18,6),
  INDICE_CORRECAO NUMERIC(18,6),
  DIAS_TOLERANCIA INTEGER,
  VALOR_TOLERANCIA NUMERIC(18,6),
  PRAZO_MEDIO INTEGER,
  VISTA_PRAZO CHAR(1),
  CONSTRAINT pk_venda_condicoes_pagamento PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- VENDA_CONDICOES_PARCELAS
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS VENDA_CONDICOES_PARCELAS (
  ID SERIAL NOT NULL,
  ID_VENDA_CONDICOES_PAGAMENTO INTEGER NOT NULL,
  PARCELA INTEGER,
  DIAS INTEGER,
  TAXA NUMERIC(18,6),
  CONSTRAINT pk_venda_condicoes_parcelas PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- VENDA_FRETE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS VENDA_FRETE (
  ID SERIAL NOT NULL,
  ID_VENDA_CABECALHO INTEGER NOT NULL,
  ID_TRANSPORTADORA INTEGER NOT NULL,
  CONHECIMENTO INTEGER,
  RESPONSAVEL CHAR(1),
  PLACA VARCHAR(7),
  UF_PLACA CHAR(2),
  SELO_FISCAL INTEGER,
  QUANTIDADE_VOLUME NUMERIC(18,6),
  MARCA_VOLUME VARCHAR(50),
  ESPECIE_VOLUME VARCHAR(20),
  PESO_BRUTO NUMERIC(18,6),
  PESO_LIQUIDO NUMERIC(18,6),
  CONSTRAINT pk_venda_frete PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- VENDA_COMISSAO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS VENDA_COMISSAO (
  ID SERIAL NOT NULL,
  ID_VENDA_CABECALHO INTEGER NOT NULL,
  ID_VENDEDOR INTEGER NOT NULL,
  VALOR_VENDA NUMERIC(18,6),
  TIPO_CONTABIL CHAR(1),
  VALOR_COMISSAO NUMERIC(18,6),
  SITUACAO CHAR(1),
  DATA_LANCAMENTO DATE,
  CONSTRAINT pk_venda_comissao PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- REQUISICAO_INTERNA_CABECALHO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS REQUISICAO_INTERNA_CABECALHO (
  ID SERIAL NOT NULL,
  ID_COLABORADOR INTEGER NOT NULL,
  DATA_REQUISICAO DATE,
  SITUACAO CHAR(1),
  CONSTRAINT pk_requisicao_interna_cabecalho PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- REQUISICAO_INTERNA_DETALHE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS REQUISICAO_INTERNA_DETALHE (
  ID SERIAL NOT NULL,
  ID_REQUISICAO_INTERNA_CABECALHO INTEGER NOT NULL,
  ID_PRODUTO INTEGER NOT NULL,
  QUANTIDADE NUMERIC(18,6) NOT NULL,
  CONSTRAINT pk_requisicao_interna_detalhe PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- ESTOQUE_REAJUSTE_CABECALHO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ESTOQUE_REAJUSTE_CABECALHO (
  ID SERIAL NOT NULL,
  ID_COLABORADOR INTEGER NOT NULL,
  DATA_REAJUSTE DATE,
  TAXA NUMERIC(18,6),
  TIPO_REAJUSTE CHAR(1),
  JUSTIFICATIVA VARCHAR(100),
  CONSTRAINT pk_estoque_reajuste_cabecalho PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- ESTOQUE_REAJUSTE_DETALHE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ESTOQUE_REAJUSTE_DETALHE (
  ID SERIAL NOT NULL,
  ID_ESTOQUE_REAJUSTE_CABECALHO INTEGER NOT NULL,
  ID_PRODUTO INTEGER NOT NULL,
  VALOR_ORIGINAL NUMERIC(18,6),
  VALOR_REAJUSTE NUMERIC(18,6),
  CONSTRAINT pk_estoque_reajuste_detalhe PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- ESTOQUE_GRADE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ESTOQUE_GRADE (
  ID SERIAL NOT NULL,
  ID_ESTOQUE_MARCA INTEGER,
  ID_ESTOQUE_SABOR INTEGER,
  ID_ESTOQUE_TAMANHO INTEGER,
  ID_ESTOQUE_COR INTEGER,
  ID_PRODUTO INTEGER NOT NULL,
  CODIGO VARCHAR(50),
  QUANTIDADE NUMERIC(18,6),
  CONSTRAINT pk_estoque_grade PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- ESTOQUE_COR
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ESTOQUE_COR (
  ID SERIAL NOT NULL,
  CODIGO CHAR(4),
  NOME VARCHAR(50),
  CONSTRAINT pk_estoque_cor PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- ESTOQUE_TAMANHO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ESTOQUE_TAMANHO (
  ID SERIAL NOT NULL,
  CODIGO CHAR(4),
  NOME VARCHAR(50),
  ALTURA NUMERIC(18,6),
  COMPRIMENTO NUMERIC(18,6),
  LARGURA NUMERIC(18,6),
  CONSTRAINT pk_estoque_tamanho PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- NOTA_FISCAL_MODELO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS NOTA_FISCAL_MODELO (
  ID SERIAL NOT NULL,
  CODIGO CHAR(2),
  DESCRICAO VARCHAR(100),
  MODELO VARCHAR(10),
  CONSTRAINT pk_nota_fiscal_modelo PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- TRIBUT_CONFIGURA_OF_GT
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS TRIBUT_CONFIGURA_OF_GT (
  ID SERIAL NOT NULL,
  ID_TRIBUT_GRUPO_TRIBUTARIO INTEGER NOT NULL,
  ID_TRIBUT_OPERACAO_FISCAL INTEGER NOT NULL,
  CONSTRAINT pk_tribut_configura_of_gt PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- TRIBUT_ICMS_CUSTOM_DET
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS TRIBUT_ICMS_CUSTOM_DET (
  ID SERIAL NOT NULL,
  ID_TRIBUT_ICMS_CUSTOM_CAB INTEGER NOT NULL,
  UF_DESTINO CHAR(2),
  CFOP INTEGER,
  CSOSN CHAR(3),
  CST CHAR(2),
  MODALIDADE_BC CHAR(1),
  ALIQUOTA NUMERIC(18,6),
  VALOR_PAUTA NUMERIC(18,6),
  VALOR_PRECO_MAXIMO NUMERIC(18,6),
  MVA NUMERIC(18,6),
  PORCENTO_BC NUMERIC(18,6),
  MODALIDADE_BC_ST CHAR(1),
  ALIQUOTA_INTERNA_ST NUMERIC(18,6),
  ALIQUOTA_INTERESTADUAL_ST NUMERIC(18,6),
  PORCENTO_BC_ST NUMERIC(18,6),
  ALIQUOTA_ICMS_ST NUMERIC(18,6),
  VALOR_PAUTA_ST NUMERIC(18,6),
  VALOR_PRECO_MAXIMO_ST NUMERIC(18,6),
  CONSTRAINT pk_tribut_icms_custom_det PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- TRIBUT_ICMS_CUSTOM_CAB
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS TRIBUT_ICMS_CUSTOM_CAB (
  ID SERIAL NOT NULL,
  DESCRICAO VARCHAR(100),
  ORIGEM_MERCADORIA CHAR(1),
  CONSTRAINT pk_tribut_icms_custom_cab PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- ESTOQUE_SABOR
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ESTOQUE_SABOR (
  ID SERIAL NOT NULL,
  CODIGO CHAR(4),
  NOME VARCHAR(50),
  CONSTRAINT pk_estoque_sabor PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- ESTOQUE_MARCA
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ESTOQUE_MARCA (
  ID SERIAL NOT NULL,
  CODIGO CHAR(4),
  NOME VARCHAR(50),
  CONSTRAINT pk_estoque_marca PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- DIA_PARCELA
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS DIA_PARCELA (
  ID SERIAL NOT NULL,
  DIA CHAR(2),
  CONSTRAINT pk_dia_parcela PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- NFE_CABECALHO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS NFE_CABECALHO (
  ID SERIAL NOT NULL,
  ID_VENDEDOR INTEGER,
  UF_EMITENTE INTEGER,
  CODIGO_NUMERICO VARCHAR(8),
  NATUREZA_OPERACAO VARCHAR(60),
  CODIGO_MODELO CHAR(2),
  SERIE CHAR(3),
  NUMERO VARCHAR(9),
  DATA_HORA_EMISSAO TEXT,
  DATA_HORA_ENTRADA_SAIDA TEXT,
  TIPO_OPERACAO CHAR(1),
  LOCAL_DESTINO CHAR(1),
  CODIGO_MUNICIPIO INTEGER,
  FORMATO_IMPRESSAO_DANFE CHAR(1),
  TIPO_EMISSAO CHAR(1),
  CHAVE_ACESSO VARCHAR(44),
  DIGITO_CHAVE_ACESSO CHAR(1),
  AMBIENTE CHAR(1),
  FINALIDADE_EMISSAO CHAR(1),
  CONSUMIDOR_OPERACAO CHAR(1),
  CONSUMIDOR_PRESENCA CHAR(1),
  PROCESSO_EMISSAO CHAR(1),
  VERSAO_PROCESSO_EMISSAO VARCHAR(20),
  DATA_ENTRADA_CONTINGENCIA TEXT,
  JUSTIFICATIVA_CONTINGENCIA VARCHAR(255),
  BASE_CALCULO_ICMS NUMERIC(18,6),
  VALOR_ICMS NUMERIC(18,6),
  VALOR_ICMS_DESONERADO NUMERIC(18,6),
  TOTAL_ICMS_FCP_UF_DESTINO NUMERIC(18,6),
  TOTAL_ICMS_INTERESTADUAL_UF_DESTINO NUMERIC(18,6),
  TOTAL_ICMS_INTERESTADUAL_UF_REMETENTE NUMERIC(18,6),
  VALOR_TOTAL_FCP NUMERIC(18,6),
  BASE_CALCULO_ICMS_ST NUMERIC(18,6),
  VALOR_ICMS_ST NUMERIC(18,6),
  VALOR_TOTAL_FCP_ST NUMERIC(18,6),
  VALOR_TOTAL_FCP_ST_RETIDO NUMERIC(18,6),
  VALOR_TOTAL_PRODUTOS NUMERIC(18,6),
  VALOR_FRETE NUMERIC(18,6),
  VALOR_SEGURO NUMERIC(18,6),
  VALOR_DESCONTO NUMERIC(18,6),
  VALOR_IMPOSTO_IMPORTACAO NUMERIC(18,6),
  VALOR_IPI NUMERIC(18,6),
  VALOR_IPI_DEVOLVIDO NUMERIC(18,6),
  VALOR_PIS NUMERIC(18,6),
  VALOR_COFINS NUMERIC(18,6),
  VALOR_DESPESAS_ACESSORIAS NUMERIC(18,6),
  VALOR_TOTAL NUMERIC(18,6),
  VALOR_TOTAL_TRIBUTOS NUMERIC(18,6),
  VALOR_SERVICOS NUMERIC(18,6),
  BASE_CALCULO_ISSQN NUMERIC(18,6),
  VALOR_ISSQN NUMERIC(18,6),
  VALOR_PIS_ISSQN NUMERIC(18,6),
  VALOR_COFINS_ISSQN NUMERIC(18,6),
  DATA_PRESTACAO_SERVICO DATE,
  VALOR_DEDUCAO_ISSQN NUMERIC(18,6),
  OUTRAS_RETENCOES_ISSQN NUMERIC(18,6),
  DESCONTO_INCONDICIONADO_ISSQN NUMERIC(18,6),
  DESCONTO_CONDICIONADO_ISSQN NUMERIC(18,6),
  TOTAL_RETENCAO_ISSQN NUMERIC(18,6),
  REGIME_ESPECIAL_TRIBUTACAO CHAR(1),
  VALOR_RETIDO_PIS NUMERIC(18,6),
  VALOR_RETIDO_COFINS NUMERIC(18,6),
  VALOR_RETIDO_CSLL NUMERIC(18,6),
  BASE_CALCULO_IRRF NUMERIC(18,6),
  VALOR_RETIDO_IRRF NUMERIC(18,6),
  BASE_CALCULO_PREVIDENCIA NUMERIC(18,6),
  VALOR_RETIDO_PREVIDENCIA NUMERIC(18,6),
  INFORMACOES_ADD_FISCO TEXT,
  INFORMACOES_ADD_CONTRIBUINTE TEXT,
  COMEX_UF_EMBARQUE CHAR(2),
  COMEX_LOCAL_EMBARQUE VARCHAR(60),
  COMEX_LOCAL_DESPACHO VARCHAR(60),
  COMPRA_NOTA_EMPENHO VARCHAR(22),
  COMPRA_PEDIDO VARCHAR(60),
  COMPRA_CONTRATO VARCHAR(60),
  QRCODE TEXT,
  URL_CHAVE VARCHAR(85),
  STATUS_NOTA CHAR(1),
  ID_FORNECEDOR INTEGER,
  ID_NFCE_MOVIMENTO INTEGER,
  ID_VENDA_CABECALHO INTEGER,
  ID_TRIBUT_OPERACAO_FISCAL INTEGER,
  ID_CLIENTE INTEGER,
  CONSTRAINT pk_nfe_cabecalho PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- NFE_DETALHE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS NFE_DETALHE (
  ID SERIAL NOT NULL,
  ID_NFE_CABECALHO INTEGER NOT NULL,
  ID_PRODUTO INTEGER,
  NUMERO_ITEM INTEGER,
  CODIGO_PRODUTO VARCHAR(60),
  GTIN VARCHAR(14),
  NOME_PRODUTO VARCHAR(120),
  NCM VARCHAR(8),
  NVE VARCHAR(6),
  CEST VARCHAR(7),
  INDICADOR_ESCALA_RELEVANTE CHAR(1),
  CNPJ_FABRICANTE VARCHAR(14),
  CODIGO_BENEFICIO_FISCAL VARCHAR(10),
  EX_TIPI INTEGER,
  CFOP INTEGER,
  UNIDADE_COMERCIAL VARCHAR(6),
  QUANTIDADE_COMERCIAL NUMERIC(18,6),
  NUMERO_PEDIDO_COMPRA VARCHAR(15),
  ITEM_PEDIDO_COMPRA INTEGER,
  NUMERO_FCI VARCHAR(36),
  NUMERO_RECOPI VARCHAR(20),
  VALOR_UNITARIO_COMERCIAL NUMERIC(18,6),
  VALOR_BRUTO_PRODUTO NUMERIC(18,6),
  GTIN_UNIDADE_TRIBUTAVEL VARCHAR(14),
  UNIDADE_TRIBUTAVEL VARCHAR(6),
  QUANTIDADE_TRIBUTAVEL NUMERIC(18,6),
  VALOR_UNITARIO_TRIBUTAVEL NUMERIC(18,6),
  VALOR_FRETE NUMERIC(18,6),
  VALOR_SEGURO NUMERIC(18,6),
  VALOR_DESCONTO NUMERIC(18,6),
  VALOR_OUTRAS_DESPESAS NUMERIC(18,6),
  ENTRA_TOTAL CHAR(1),
  VALOR_TOTAL_TRIBUTOS NUMERIC(18,6),
  PERCENTUAL_DEVOLVIDO NUMERIC(18,6),
  VALOR_IPI_DEVOLVIDO NUMERIC(18,6),
  INFORMACOES_ADICIONAIS TEXT,
  VALOR_SUBTOTAL NUMERIC(18,6),
  VALOR_TOTAL NUMERIC(18,6),
  CONSTRAINT pk_nfe_detalhe PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- NFE_REFERENCIADA
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS NFE_REFERENCIADA (
  ID SERIAL NOT NULL,
  ID_NFE_CABECALHO INTEGER NOT NULL,
  CHAVE_ACESSO VARCHAR(44),
  CONSTRAINT pk_nfe_referenciada PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- NFE_EMITENTE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS NFE_EMITENTE (
  ID SERIAL NOT NULL,
  ID_NFE_CABECALHO INTEGER NOT NULL,
  CNPJ VARCHAR(14),
  CPF VARCHAR(11),
  NOME VARCHAR(60),
  FANTASIA VARCHAR(60),
  LOGRADOURO VARCHAR(60),
  NUMERO VARCHAR(60),
  COMPLEMENTO VARCHAR(60),
  BAIRRO VARCHAR(60),
  CODIGO_MUNICIPIO INTEGER,
  NOME_MUNICIPIO VARCHAR(60),
  UF CHAR(2),
  CEP VARCHAR(8),
  CODIGO_PAIS INTEGER DEFAULT '1058',
  NOME_PAIS VARCHAR(60) DEFAULT '''BRASIL''',
  TELEFONE VARCHAR(14),
  INSCRICAO_ESTADUAL VARCHAR(14),
  INSCRICAO_ESTADUAL_ST VARCHAR(14),
  INSCRICAO_MUNICIPAL VARCHAR(15),
  CNAE VARCHAR(7),
  CRT CHAR(1),
  CONSTRAINT pk_nfe_emitente PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- NFE_DESTINATARIO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS NFE_DESTINATARIO (
  ID SERIAL NOT NULL,
  ID_NFE_CABECALHO INTEGER NOT NULL,
  CNPJ VARCHAR(14),
  CPF VARCHAR(11),
  ESTRANGEIRO_IDENTIFICACAO VARCHAR(20),
  NOME VARCHAR(60),
  LOGRADOURO VARCHAR(60),
  NUMERO VARCHAR(60),
  COMPLEMENTO VARCHAR(60),
  BAIRRO VARCHAR(60),
  CODIGO_MUNICIPIO INTEGER,
  NOME_MUNICIPIO VARCHAR(60),
  UF CHAR(2),
  CEP VARCHAR(8),
  CODIGO_PAIS INTEGER,
  NOME_PAIS VARCHAR(60),
  TELEFONE VARCHAR(14),
  INDICADOR_IE CHAR(1),
  INSCRICAO_ESTADUAL VARCHAR(14),
  SUFRAMA INTEGER,
  INSCRICAO_MUNICIPAL VARCHAR(15),
  EMAIL VARCHAR(60),
  CONSTRAINT pk_nfe_destinatario PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- NFE_LOCAL_RETIRADA
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS NFE_LOCAL_RETIRADA (
  ID SERIAL NOT NULL,
  ID_NFE_CABECALHO INTEGER NOT NULL,
  CNPJ VARCHAR(14),
  CPF VARCHAR(11),
  NOME_EXPEDIDOR VARCHAR(60),
  LOGRADOURO VARCHAR(60),
  NUMERO VARCHAR(60),
  COMPLEMENTO VARCHAR(60),
  BAIRRO VARCHAR(60),
  CODIGO_MUNICIPIO INTEGER,
  NOME_MUNICIPIO VARCHAR(60),
  UF CHAR(2),
  CEP VARCHAR(8),
  CODIGO_PAIS INTEGER,
  NOME_PAIS VARCHAR(60),
  TELEFONE VARCHAR(14),
  EMAIL VARCHAR(60),
  INSCRICAO_ESTADUAL VARCHAR(14),
  CONSTRAINT pk_nfe_local_retirada PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- NFE_LOCAL_ENTREGA
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS NFE_LOCAL_ENTREGA (
  ID SERIAL NOT NULL,
  ID_NFE_CABECALHO INTEGER NOT NULL,
  CNPJ VARCHAR(14),
  CPF VARCHAR(11),
  NOME_RECEBEDOR VARCHAR(60),
  LOGRADOURO VARCHAR(60),
  NUMERO VARCHAR(60),
  COMPLEMENTO VARCHAR(60),
  BAIRRO VARCHAR(60),
  CODIGO_MUNICIPIO INTEGER,
  NOME_MUNICIPIO VARCHAR(60),
  UF CHAR(2),
  CEP VARCHAR(8),
  CODIGO_PAIS INTEGER,
  NOME_PAIS VARCHAR(60),
  TELEFONE VARCHAR(14),
  EMAIL VARCHAR(60),
  INSCRICAO_ESTADUAL VARCHAR(14),
  CONSTRAINT pk_nfe_local_entrega PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- NFE_DET_ESPECIFICO_VEICULO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS NFE_DET_ESPECIFICO_VEICULO (
  ID SERIAL NOT NULL,
  ID_NFE_DETALHE INTEGER NOT NULL,
  TIPO_OPERACAO CHAR(1),
  CHASSI VARCHAR(17),
  COR VARCHAR(4),
  DESCRICAO_COR VARCHAR(40),
  POTENCIA_MOTOR VARCHAR(4),
  CILINDRADAS VARCHAR(4),
  PESO_LIQUIDO VARCHAR(9),
  PESO_BRUTO VARCHAR(9),
  NUMERO_SERIE VARCHAR(9),
  TIPO_COMBUSTIVEL CHAR(2),
  NUMERO_MOTOR VARCHAR(21),
  CAPACIDADE_MAXIMA_TRACAO VARCHAR(9),
  DISTANCIA_EIXOS VARCHAR(4),
  ANO_MODELO CHAR(4),
  ANO_FABRICACAO CHAR(4),
  TIPO_PINTURA CHAR(1),
  TIPO_VEICULO CHAR(2),
  ESPECIE_VEICULO CHAR(1),
  CONDICAO_VIN CHAR(1),
  CONDICAO_VEICULO CHAR(1),
  CODIGO_MARCA_MODELO VARCHAR(6),
  CODIGO_COR_DENATRAN CHAR(2),
  LOTACAO_MAXIMA INTEGER,
  RESTRICAO CHAR(1),
  CONSTRAINT pk_nfe_det_especifico_veiculo PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- NFE_DET_ESPECIFICO_MEDICAMENTO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS NFE_DET_ESPECIFICO_MEDICAMENTO (
  ID SERIAL NOT NULL,
  ID_NFE_DETALHE INTEGER NOT NULL,
  CODIGO_ANVISA VARCHAR(13),
  MOTIVO_ISENCAO VARCHAR(250),
  PRECO_MAXIMO_CONSUMIDOR NUMERIC(18,6),
  CONSTRAINT pk_nfe_det_especifico_medicamento PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- NFE_DET_ESPECIFICO_ARMAMENTO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS NFE_DET_ESPECIFICO_ARMAMENTO (
  ID SERIAL NOT NULL,
  ID_NFE_DETALHE INTEGER NOT NULL,
  TIPO_ARMA CHAR(1),
  NUMERO_SERIE_ARMA VARCHAR(15),
  NUMERO_SERIE_CANO VARCHAR(15),
  DESCRICAO VARCHAR(250),
  CONSTRAINT pk_nfe_det_especifico_armamento PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- NFE_DET_ESPECIFICO_COMBUSTIVEL
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS NFE_DET_ESPECIFICO_COMBUSTIVEL (
  ID SERIAL NOT NULL,
  ID_NFE_DETALHE INTEGER NOT NULL,
  CODIGO_ANP INTEGER,
  DESCRICAO_ANP VARCHAR(95),
  PERCENTUAL_GLP NUMERIC(18,6),
  PERCENTUAL_GAS_NACIONAL NUMERIC(18,6),
  PERCENTUAL_GAS_IMPORTADO NUMERIC(18,6),
  VALOR_PARTIDA NUMERIC(18,6),
  CODIF VARCHAR(21),
  QUANTIDADE_TEMP_AMBIENTE NUMERIC(18,6),
  UF_CONSUMO CHAR(2),
  CIDE_BASE_CALCULO NUMERIC(18,6),
  CIDE_ALIQUOTA NUMERIC(18,6),
  CIDE_VALOR NUMERIC(18,6),
  ENCERRANTE_BICO INTEGER,
  ENCERRANTE_BOMBA INTEGER,
  ENCERRANTE_TANQUE INTEGER,
  ENCERRANTE_VALOR_INICIO NUMERIC(18,6),
  ENCERRANTE_VALOR_FIM NUMERIC(18,6),
  CONSTRAINT pk_nfe_det_especifico_combustivel PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- NFE_TRANSPORTE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS NFE_TRANSPORTE (
  ID SERIAL NOT NULL,
  ID_NFE_CABECALHO INTEGER NOT NULL,
  ID_TRANSPORTADORA INTEGER,
  MODALIDADE_FRETE CHAR(1),
  CNPJ VARCHAR(14),
  CPF VARCHAR(11),
  NOME VARCHAR(60),
  INSCRICAO_ESTADUAL VARCHAR(14),
  ENDERECO VARCHAR(60),
  NOME_MUNICIPIO VARCHAR(60),
  UF CHAR(2),
  VALOR_SERVICO NUMERIC(18,6),
  VALOR_BC_RETENCAO_ICMS NUMERIC(18,6),
  ALIQUOTA_RETENCAO_ICMS NUMERIC(18,6),
  VALOR_ICMS_RETIDO NUMERIC(18,6),
  CFOP INTEGER,
  MUNICIPIO INTEGER,
  PLACA_VEICULO VARCHAR(7),
  UF_VEICULO CHAR(2),
  RNTC_VEICULO VARCHAR(20),
  CONSTRAINT pk_nfe_transporte PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- NFE_FATURA
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS NFE_FATURA (
  ID SERIAL NOT NULL,
  ID_NFE_CABECALHO INTEGER NOT NULL,
  NUMERO VARCHAR(60),
  VALOR_ORIGINAL NUMERIC(18,6),
  VALOR_DESCONTO NUMERIC(18,6),
  VALOR_LIQUIDO NUMERIC(18,6),
  CONSTRAINT pk_nfe_fatura PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- NFE_DUPLICATA
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS NFE_DUPLICATA (
  ID SERIAL NOT NULL,
  ID_NFE_FATURA INTEGER NOT NULL,
  NUMERO VARCHAR(60),
  DATA_VENCIMENTO DATE,
  VALOR NUMERIC(18,6),
  CONSTRAINT pk_nfe_duplicata PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- NFE_DECLARACAO_IMPORTACAO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS NFE_DECLARACAO_IMPORTACAO (
  ID SERIAL NOT NULL,
  ID_NFE_DETALHE INTEGER NOT NULL,
  NUMERO_DOCUMENTO VARCHAR(12),
  DATA_REGISTRO DATE,
  LOCAL_DESEMBARACO VARCHAR(60),
  UF_DESEMBARACO CHAR(2),
  DATA_DESEMBARACO DATE,
  VIA_TRANSPORTE CHAR(1),
  VALOR_AFRMM NUMERIC(18,6),
  FORMA_INTERMEDIACAO CHAR(1),
  CNPJ VARCHAR(14),
  UF_TERCEIRO CHAR(2),
  CODIGO_EXPORTADOR VARCHAR(60),
  CONSTRAINT pk_nfe_declaracao_importacao PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- NFE_IMPORTACAO_DETALHE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS NFE_IMPORTACAO_DETALHE (
  ID SERIAL NOT NULL,
  ID_NFE_DECLARACAO_IMPORTACAO INTEGER NOT NULL,
  NUMERO_ADICAO INTEGER,
  NUMERO_SEQUENCIAL INTEGER,
  CODIGO_FABRICANTE_ESTRANGEIRO VARCHAR(60),
  VALOR_DESCONTO NUMERIC(18,6),
  DRAWBACK INTEGER,
  CONSTRAINT pk_nfe_importacao_detalhe PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- NFE_CANA
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS NFE_CANA (
  ID SERIAL NOT NULL,
  ID_NFE_CABECALHO INTEGER NOT NULL,
  SAFRA VARCHAR(9),
  MES_ANO_REFERENCIA VARCHAR(7),
  CONSTRAINT pk_nfe_cana PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- NFE_CANA_FORNECIMENTO_DIARIO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS NFE_CANA_FORNECIMENTO_DIARIO (
  ID SERIAL NOT NULL,
  ID_NFE_CANA INTEGER NOT NULL,
  DIA CHAR(2),
  QUANTIDADE NUMERIC(18,6),
  QUANTIDADE_TOTAL_MES NUMERIC(18,6),
  QUANTIDADE_TOTAL_ANTERIOR NUMERIC(18,6),
  QUANTIDADE_TOTAL_GERAL NUMERIC(18,6),
  CONSTRAINT pk_nfe_cana_fornecimento_diario PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- NFE_CANA_DEDUCOES_SAFRA
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS NFE_CANA_DEDUCOES_SAFRA (
  ID SERIAL NOT NULL,
  ID_NFE_CANA INTEGER NOT NULL,
  DECRICAO VARCHAR(60),
  VALOR_DEDUCAO NUMERIC(18,6),
  VALOR_FORNECIMENTO NUMERIC(18,6),
  VALOR_TOTAL_DEDUCAO NUMERIC(18,6),
  VALOR_LIQUIDO_FORNECIMENTO NUMERIC(18,6),
  CONSTRAINT pk_nfe_cana_deducoes_safra PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- NFE_CUPOM_FISCAL_REFERENCIADO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS NFE_CUPOM_FISCAL_REFERENCIADO (
  ID SERIAL NOT NULL,
  ID_NFE_CABECALHO INTEGER NOT NULL,
  MODELO_DOCUMENTO_FISCAL CHAR(2),
  NUMERO_ORDEM_ECF INTEGER,
  COO INTEGER,
  DATA_EMISSAO_CUPOM DATE,
  NUMERO_CAIXA INTEGER,
  NUMERO_SERIE_ECF VARCHAR(21),
  CONSTRAINT pk_nfe_cupom_fiscal_referenciado PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- NFE_NUMERO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS NFE_NUMERO (
  ID SERIAL NOT NULL,
  SERIE CHAR(3),
  NUMERO INTEGER,
  CONSTRAINT pk_nfe_numero PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- NFE_PROD_RURAL_REFERENCIADA
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS NFE_PROD_RURAL_REFERENCIADA (
  ID SERIAL NOT NULL,
  ID_NFE_CABECALHO INTEGER NOT NULL,
  CODIGO_UF INTEGER,
  ANO_MES VARCHAR(4),
  CNPJ VARCHAR(14),
  CPF VARCHAR(11),
  INSCRICAO_ESTADUAL VARCHAR(14),
  MODELO CHAR(2),
  SERIE CHAR(3),
  NUMERO_NF INTEGER,
  CONSTRAINT pk_nfe_prod_rural_referenciada PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- NFE_NF_REFERENCIADA
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS NFE_NF_REFERENCIADA (
  ID SERIAL NOT NULL,
  ID_NFE_CABECALHO INTEGER NOT NULL,
  CODIGO_UF INTEGER,
  ANO_MES VARCHAR(4),
  CNPJ VARCHAR(14),
  MODELO CHAR(2) DEFAULT '''01''',
  SERIE CHAR(3),
  NUMERO_NF INTEGER,
  CONSTRAINT pk_nfe_nf_referenciada PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- NFE_DETALHE_IMPOSTO_ICMS
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS NFE_DETALHE_IMPOSTO_ICMS (
  ID SERIAL NOT NULL,
  ID_NFE_DETALHE INTEGER NOT NULL,
  ORIGEM_MERCADORIA CHAR(1),
  CST_ICMS CHAR(2),
  CSOSN CHAR(3),
  MODALIDADE_BC_ICMS CHAR(1),
  PERCENTUAL_REDUCAO_BC_ICMS NUMERIC(18,6),
  VALOR_BC_ICMS NUMERIC(18,6),
  ALIQUOTA_ICMS NUMERIC(18,6),
  VALOR_ICMS_OPERACAO NUMERIC(18,6),
  PERCENTUAL_DIFERIMENTO NUMERIC(18,6),
  VALOR_ICMS_DIFERIDO NUMERIC(18,6),
  VALOR_ICMS NUMERIC(18,6),
  BASE_CALCULO_FCP NUMERIC(18,6),
  PERCENTUAL_FCP NUMERIC(18,6),
  VALOR_FCP NUMERIC(18,6),
  MODALIDADE_BC_ICMS_ST CHAR(1),
  PERCENTUAL_MVA_ICMS_ST NUMERIC(18,6),
  PERCENTUAL_REDUCAO_BC_ICMS_ST NUMERIC(18,6),
  VALOR_BASE_CALCULO_ICMS_ST NUMERIC(18,6),
  ALIQUOTA_ICMS_ST NUMERIC(18,6),
  VALOR_ICMS_ST NUMERIC(18,6),
  BASE_CALCULO_FCP_ST NUMERIC(18,6),
  PERCENTUAL_FCP_ST NUMERIC(18,6),
  VALOR_FCP_ST NUMERIC(18,6),
  UF_ST CHAR(2),
  PERCENTUAL_BC_OPERACAO_PROPRIA NUMERIC(18,6),
  VALOR_BC_ICMS_ST_RETIDO NUMERIC(18,6),
  ALIQUOTA_SUPORTADA_CONSUMIDOR NUMERIC(18,6),
  VALOR_ICMS_SUBSTITUTO NUMERIC(18,6),
  VALOR_ICMS_ST_RETIDO NUMERIC(18,6),
  BASE_CALCULO_FCP_ST_RETIDO NUMERIC(18,6),
  PERCENTUAL_FCP_ST_RETIDO NUMERIC(18,6),
  VALOR_FCP_ST_RETIDO NUMERIC(18,6),
  MOTIVO_DESONERACAO_ICMS CHAR(2),
  VALOR_ICMS_DESONERADO NUMERIC(18,6),
  ALIQUOTA_CREDITO_ICMS_SN NUMERIC(18,6),
  VALOR_CREDITO_ICMS_SN NUMERIC(18,6),
  VALOR_BC_ICMS_ST_DESTINO NUMERIC(18,6),
  VALOR_ICMS_ST_DESTINO NUMERIC(18,6),
  PERCENTUAL_REDUCAO_BC_EFETIVO NUMERIC(18,6),
  VALOR_BC_EFETIVO NUMERIC(18,6),
  ALIQUOTA_ICMS_EFETIVO NUMERIC(18,6),
  VALOR_ICMS_EFETIVO NUMERIC(18,6),
  CONSTRAINT pk_nfe_detalhe_imposto_icms PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- NFE_DETALHE_IMPOSTO_IPI
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS NFE_DETALHE_IMPOSTO_IPI (
  ID SERIAL NOT NULL,
  ID_NFE_DETALHE INTEGER NOT NULL,
  CNPJ_PRODUTOR VARCHAR(14),
  CODIGO_SELO_IPI VARCHAR(60),
  QUANTIDADE_SELO_IPI INTEGER,
  ENQUADRAMENTO_LEGAL_IPI CHAR(3),
  CST_IPI CHAR(2),
  VALOR_BASE_CALCULO_IPI NUMERIC(18,6),
  QUANTIDADE_UNIDADE_TRIBUTAVEL NUMERIC(18,6),
  VALOR_UNIDADE_TRIBUTAVEL NUMERIC(18,6),
  ALIQUOTA_IPI NUMERIC(18,6),
  VALOR_IPI NUMERIC(18,6),
  CONSTRAINT pk_nfe_detalhe_imposto_ipi PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- NFE_DETALHE_IMPOSTO_II
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS NFE_DETALHE_IMPOSTO_II (
  ID SERIAL NOT NULL,
  ID_NFE_DETALHE INTEGER NOT NULL,
  VALOR_BC_II NUMERIC(18,6),
  VALOR_DESPESAS_ADUANEIRAS NUMERIC(18,6),
  VALOR_IMPOSTO_IMPORTACAO NUMERIC(18,6),
  VALOR_IOF NUMERIC(18,6),
  CONSTRAINT pk_nfe_detalhe_imposto_ii PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- NFE_DETALHE_IMPOSTO_PIS
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS NFE_DETALHE_IMPOSTO_PIS (
  ID SERIAL NOT NULL,
  ID_NFE_DETALHE INTEGER NOT NULL,
  CST_PIS CHAR(2),
  VALOR_BASE_CALCULO_PIS NUMERIC(18,6),
  ALIQUOTA_PIS_PERCENTUAL NUMERIC(18,6),
  VALOR_PIS NUMERIC(18,6),
  QUANTIDADE_VENDIDA NUMERIC(18,6),
  ALIQUOTA_PIS_REAIS NUMERIC(18,6),
  CONSTRAINT pk_nfe_detalhe_imposto_pis PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- NFE_DETALHE_IMPOSTO_COFINS
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS NFE_DETALHE_IMPOSTO_COFINS (
  ID SERIAL NOT NULL,
  ID_NFE_DETALHE INTEGER NOT NULL,
  CST_COFINS CHAR(2),
  BASE_CALCULO_COFINS NUMERIC(18,6),
  ALIQUOTA_COFINS_PERCENTUAL NUMERIC(18,6),
  QUANTIDADE_VENDIDA NUMERIC(18,6),
  ALIQUOTA_COFINS_REAIS NUMERIC(18,6),
  VALOR_COFINS NUMERIC(18,6),
  CONSTRAINT pk_nfe_detalhe_imposto_cofins PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- NFE_DETALHE_IMPOSTO_ISSQN
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS NFE_DETALHE_IMPOSTO_ISSQN (
  ID SERIAL NOT NULL,
  ID_NFE_DETALHE INTEGER NOT NULL,
  BASE_CALCULO_ISSQN NUMERIC(18,6),
  ALIQUOTA_ISSQN NUMERIC(18,6),
  VALOR_ISSQN NUMERIC(18,6),
  MUNICIPIO_ISSQN INTEGER,
  ITEM_LISTA_SERVICOS INTEGER,
  VALOR_DEDUCAO NUMERIC(18,6),
  VALOR_OUTRAS_RETENCOES NUMERIC(18,6),
  VALOR_DESCONTO_INCONDICIONADO NUMERIC(18,6),
  VALOR_DESCONTO_CONDICIONADO NUMERIC(18,6),
  VALOR_RETENCAO_ISS NUMERIC(18,6),
  INDICADOR_EXIGIBILIDADE_ISS CHAR(1),
  CODIGO_SERVICO VARCHAR(20),
  MUNICIPIO_INCIDENCIA INTEGER,
  PAIS_SEVICO_PRESTADO INTEGER,
  NUMERO_PROCESSO VARCHAR(30),
  INDICADOR_INCENTIVO_FISCAL CHAR(1),
  CONSTRAINT pk_nfe_detalhe_imposto_issqn PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- NFE_TRANSPORTE_REBOQUE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS NFE_TRANSPORTE_REBOQUE (
  ID SERIAL NOT NULL,
  ID_NFE_TRANSPORTE INTEGER NOT NULL,
  PLACA VARCHAR(8),
  UF CHAR(2),
  RNTC VARCHAR(20),
  VAGAO VARCHAR(20),
  BALSA VARCHAR(20),
  CONSTRAINT pk_nfe_transporte_reboque PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- NFE_TRANSPORTE_VOLUME
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS NFE_TRANSPORTE_VOLUME (
  ID INTEGER NOT NULL,
  ID_NFE_TRANSPORTE INTEGER NOT NULL,
  QUANTIDADE INTEGER,
  ESPECIE VARCHAR(60),
  MARCA VARCHAR(60),
  NUMERACAO VARCHAR(60),
  PESO_LIQUIDO NUMERIC(18,6),
  PESO_BRUTO NUMERIC(18,6),
  CONSTRAINT pk_nfe_transporte_volume PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- NFE_TRANSPORTE_VOLUME_LACRE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS NFE_TRANSPORTE_VOLUME_LACRE (
  ID SERIAL NOT NULL,
  ID_NFE_TRANSPORTE_VOLUME INTEGER NOT NULL,
  NUMERO VARCHAR(60),
  CONSTRAINT pk_nfe_transporte_volume_lacre PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- NFE_PROCESSO_REFERENCIADO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS NFE_PROCESSO_REFERENCIADO (
  ID SERIAL NOT NULL,
  ID_NFE_CABECALHO INTEGER NOT NULL,
  IDENTIFICADOR VARCHAR(60),
  ORIGEM CHAR(1),
  CONSTRAINT pk_nfe_processo_referenciado PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- NFE_CTE_REFERENCIADO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS NFE_CTE_REFERENCIADO (
  ID SERIAL NOT NULL,
  ID_NFE_CABECALHO INTEGER NOT NULL,
  CHAVE_ACESSO VARCHAR(44),
  CONSTRAINT pk_nfe_cte_referenciado PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- NFE_CONFIGURACAO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS NFE_CONFIGURACAO (
  ID SERIAL NOT NULL,
  CERTIFICADO_DIGITAL_SERIE VARCHAR(100),
  CERTIFICADO_DIGITAL_CAMINHO TEXT,
  CERTIFICADO_DIGITAL_SENHA VARCHAR(100),
  TIPO_EMISSAO INTEGER,
  FORMATO_IMPRESSAO_DANFE INTEGER,
  PROCESSO_EMISSAO INTEGER,
  VERSAO_PROCESSO_EMISSAO VARCHAR(20),
  CAMINHO_LOGOMARCA TEXT,
  SALVAR_XML CHAR(1),
  CAMINHO_SALVAR_XML TEXT,
  CAMINHO_SCHEMAS TEXT,
  CAMINHO_ARQUIVO_DANFE TEXT,
  CAMINHO_SALVAR_PDF TEXT,
  WEBSERVICE_UF CHAR(2),
  WEBSERVICE_AMBIENTE INTEGER,
  WEBSERVICE_PROXY_HOST VARCHAR(100),
  WEBSERVICE_PROXY_PORTA INTEGER,
  WEBSERVICE_PROXY_USUARIO VARCHAR(100),
  WEBSERVICE_PROXY_SENHA VARCHAR(100),
  WEBSERVICE_VISUALIZAR CHAR(1),
  EMAIL_SERVIDOR_SMTP VARCHAR(100),
  EMAIL_PORTA INTEGER,
  EMAIL_USUARIO VARCHAR(100),
  EMAIL_SENHA VARCHAR(100),
  EMAIL_ASSUNTO VARCHAR(100),
  EMAIL_AUTENTICA_SSL CHAR(1),
  EMAIL_TEXTO TEXT,
  CONSTRAINT pk_nfe_configuracao PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- NFE_ACESSO_XML
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS NFE_ACESSO_XML (
  ID SERIAL NOT NULL,
  ID_NFE_CABECALHO INTEGER NOT NULL,
  CNPJ VARCHAR(14),
  CPF VARCHAR(11),
  CONSTRAINT pk_nfe_acesso_xml PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- NFE_EXPORTACAO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS NFE_EXPORTACAO (
  ID SERIAL NOT NULL,
  ID_NFE_DETALHE INTEGER NOT NULL,
  DRAWBACK INTEGER,
  NUMERO_REGISTRO INTEGER,
  CHAVE_ACESSO VARCHAR(44),
  QUANTIDADE NUMERIC(18,6),
  CONSTRAINT pk_nfe_exportacao PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- NFE_INFORMACAO_PAGAMENTO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS NFE_INFORMACAO_PAGAMENTO (
  ID SERIAL NOT NULL,
  ID_NFE_CABECALHO INTEGER NOT NULL,
  INDICADOR_PAGAMENTO CHAR(1),
  MEIO_PAGAMENTO CHAR(2),
  VALOR NUMERIC(18,6),
  TIPO_INTEGRACAO CHAR(1),
  CNPJ_OPERADORA_CARTAO VARCHAR(14),
  BANDEIRA CHAR(2),
  NUMERO_AUTORIZACAO VARCHAR(20),
  TROCO NUMERIC(18,6),
  CONSTRAINT pk_nfe_informacao_pagamento PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- NFE_NUMERO_INUTILIZADO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS NFE_NUMERO_INUTILIZADO (
  ID SERIAL NOT NULL,
  SERIE CHAR(3),
  NUMERO INTEGER,
  DATA_INUTILIZACAO DATE,
  OBSERVACAO TEXT,
  CONSTRAINT pk_nfe_numero_inutilizado PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- NFE_ITEM_RASTREADO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS NFE_ITEM_RASTREADO (
  ID SERIAL NOT NULL,
  ID_NFE_DETALHE INTEGER NOT NULL,
  NUMERO_LOTE VARCHAR(20),
  QUANTIDADE_ITENS NUMERIC(18,6),
  DATA_FABRICACAO DATE,
  DATA_VALIDADE DATE,
  CODIGO_AGREGACAO VARCHAR(20),
  CONSTRAINT pk_nfe_item_rastreado PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- NFE_DETALHE_IMPOSTO_PIS_ST
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS NFE_DETALHE_IMPOSTO_PIS_ST (
  ID SERIAL NOT NULL,
  ID_NFE_DETALHE INTEGER NOT NULL,
  VALOR_BASE_CALCULO_PIS_ST NUMERIC(18,6),
  ALIQUOTA_PIS_ST_PERCENTUAL NUMERIC(18,6),
  QUANTIDADE_VENDIDA_PIS_ST NUMERIC(18,6),
  ALIQUOTA_PIS_ST_REAIS NUMERIC(18,6),
  VALOR_PIS_ST NUMERIC(18,6),
  CONSTRAINT pk_nfe_detalhe_imposto_pis_st PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- NFE_DETALHE_IMPOSTO_ICMS_UFDEST
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS NFE_DETALHE_IMPOSTO_ICMS_UFDEST (
  ID SERIAL NOT NULL,
  ID_NFE_DETALHE INTEGER NOT NULL,
  VALOR_BC_ICMS_UF_DESTINO NUMERIC(18,6),
  VALOR_BC_FCP_UF_DESTINO NUMERIC(18,6),
  PERCENTUAL_FCP_UF_DESTINO NUMERIC(18,6),
  ALIQUOTA_INTERNA_UF_DESTINO NUMERIC(18,6),
  ALIQUOTA_INTERESDATUAL_UF_ENVOLVIDAS NUMERIC(18,6),
  PERCENTUAL_PROVISORIO_PARTILHA_ICMS NUMERIC(18,6),
  VALOR_ICMS_FCP_UF_DESTINO NUMERIC(18,6),
  VALOR_INTERESTADUAL_UF_DESTINO NUMERIC(18,6),
  VALOR_INTERESTADUAL_UF_REMETENTE NUMERIC(18,6),
  CONSTRAINT pk_nfe_detalhe_imposto_icms_ufdest PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- NFE_DETALHE_IMPOSTO_COFINS_ST
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS NFE_DETALHE_IMPOSTO_COFINS_ST (
  ID SERIAL NOT NULL,
  ID_NFE_DETALHE INTEGER NOT NULL,
  BASE_CALCULO_COFINS_ST NUMERIC(18,6),
  ALIQUOTA_COFINS_ST_PERCENTUAL NUMERIC(18,6),
  QUANTIDADE_VENDIDA_COFINS_ST NUMERIC(18,6),
  ALIQUOTA_COFINS_ST_REAIS NUMERIC(18,6),
  VALOR_COFINS_ST NUMERIC(18,6),
  CONSTRAINT pk_nfe_detalhe_imposto_cofins_st PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- NFE_RESPONSAVEL_TECNICO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS NFE_RESPONSAVEL_TECNICO (
  ID SERIAL NOT NULL,
  ID_NFE_CABECALHO INTEGER NOT NULL,
  CNPJ VARCHAR(14),
  CONTATO VARCHAR(60),
  EMAIL VARCHAR(60),
  TELEFONE VARCHAR(14),
  IDENTIFICADOR_CSRT CHAR(2),
  HASH_CSRT VARCHAR(28),
  CONSTRAINT pk_nfe_responsavel_tecnico PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CBO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CBO (
  ID SERIAL NOT NULL,
  CODIGO VARCHAR(10),
  CODIGO_1994 VARCHAR(10),
  NOME VARCHAR(250),
  OBSERVACAO TEXT,
  CONSTRAINT pk_cbo PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PAIS
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PAIS (
  ID SERIAL NOT NULL,
  CODIGO INTEGER,
  NOME_EN VARCHAR(100),
  NOME_PTBR VARCHAR(100),
  SIGLA2 CHAR(2),
  SIGLA3 CHAR(3),
  CODIGO_BACEN INTEGER,
  CONSTRAINT pk_pais PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- TABELA_PRECO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS TABELA_PRECO (
  ID SERIAL NOT NULL,
  NOME VARCHAR(100),
  PRINCIPAL CHAR(1),
  COEFICIENTE NUMERIC(18,6),
  CONSTRAINT pk_tabela_preco PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- TABELA_PRECO_PRODUTO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS TABELA_PRECO_PRODUTO (
  ID SERIAL NOT NULL,
  ID_TABELA_PRECO INTEGER NOT NULL,
  ID_PRODUTO INTEGER NOT NULL,
  PRECO NUMERIC(18,6),
  CONSTRAINT pk_tabela_preco_produto PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- GED_DOCUMENTO_DETALHE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS GED_DOCUMENTO_DETALHE (
  ID SERIAL NOT NULL,
  ID_GED_DOCUMENTO_CABECALHO INTEGER NOT NULL,
  ID_GED_TIPO_DOCUMENTO INTEGER NOT NULL,
  NOME VARCHAR(100),
  DESCRICAO TEXT,
  PALAVRAS_CHAVE VARCHAR(250),
  PODE_EXCLUIR CHAR(1),
  PODE_ALTERAR CHAR(1),
  ASSINADO CHAR(1),
  DATA_FIM_VIGENCIA DATE,
  DATA_EXCLUSAO DATE,
  CONSTRAINT pk_ged_documento_detalhe PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- GED_TIPO_DOCUMENTO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS GED_TIPO_DOCUMENTO (
  ID SERIAL NOT NULL,
  NOME VARCHAR(100),
  TAMANHO_MAXIMO NUMERIC(18,6),
  CONSTRAINT pk_ged_tipo_documento PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- GED_VERSAO_DOCUMENTO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS GED_VERSAO_DOCUMENTO (
  ID SERIAL NOT NULL,
  ID_GED_DOCUMENTO_DETALHE INTEGER NOT NULL,
  ID_COLABORADOR INTEGER NOT NULL,
  VERSAO INTEGER,
  DATA_VERSAO DATE,
  HORA_VERSAO VARCHAR(8),
  HASH_ARQUIVO VARCHAR(250),
  CAMINHO VARCHAR(250),
  ACAO CHAR(1),
  CONSTRAINT pk_ged_versao_documento PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- GED_DOCUMENTO_CABECALHO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS GED_DOCUMENTO_CABECALHO (
  ID SERIAL NOT NULL,
  NOME VARCHAR(100),
  DESCRICAO TEXT,
  DATA_INCLUSAO DATE,
  CONSTRAINT pk_ged_documento_cabecalho PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- OS_ABERTURA
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS OS_ABERTURA (
  ID SERIAL NOT NULL,
  ID_OS_STATUS INTEGER NOT NULL,
  ID_CLIENTE INTEGER NOT NULL,
  ID_COLABORADOR INTEGER NOT NULL,
  NUMERO VARCHAR(20),
  DATA_INICIO DATE,
  HORA_INICIO VARCHAR(8),
  DATA_PREVISAO DATE,
  HORA_PREVISAO VARCHAR(8),
  DATA_FIM DATE,
  HORA_FIM VARCHAR(8),
  NOME_CONTATO VARCHAR(50),
  FONE_CONTATO VARCHAR(15),
  OBSERVACAO_CLIENTE TEXT,
  OBSERVACAO_ABERTURA TEXT,
  CONSTRAINT pk_os_abertura PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- OS_STATUS
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS OS_STATUS (
  ID SERIAL NOT NULL,
  CODIGO CHAR(2),
  NOME VARCHAR(100),
  CONSTRAINT pk_os_status PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- OS_EQUIPAMENTO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS OS_EQUIPAMENTO (
  ID SERIAL NOT NULL,
  NOME VARCHAR(100),
  DESCRICAO TEXT,
  CONSTRAINT pk_os_equipamento PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- OS_ABERTURA_EQUIPAMENTO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS OS_ABERTURA_EQUIPAMENTO (
  ID INTEGER NOT NULL,
  ID_OS_EQUIPAMENTO INTEGER NOT NULL,
  ID_OS_ABERTURA INTEGER NOT NULL,
  NUMERO_SERIE VARCHAR(50),
  TIPO_COBERTURA CHAR(1),
  CONSTRAINT pk_os_abertura_equipamento PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- OS_PRODUTO_SERVICO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS OS_PRODUTO_SERVICO (
  ID SERIAL NOT NULL,
  ID_OS_ABERTURA INTEGER NOT NULL,
  ID_PRODUTO INTEGER,
  TIPO CHAR(1),
  COMPLEMENTO TEXT,
  QUANTIDADE NUMERIC(18,6),
  VALOR_UNITARIO NUMERIC(18,6),
  VALOR_SUBTOTAL NUMERIC(18,6),
  TAXA_DESCONTO NUMERIC(18,6),
  VALOR_DESCONTO NUMERIC(18,6),
  VALOR_TOTAL NUMERIC(18,6),
  CONSTRAINT pk_os_produto_servico PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- OS_EVOLUCAO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS OS_EVOLUCAO (
  ID SERIAL NOT NULL,
  ID_OS_ABERTURA INTEGER NOT NULL,
  DATA_REGISTRO DATE,
  HORA_REGISTRO VARCHAR(8),
  OBSERVACAO TEXT,
  ENVIAR_EMAIL CHAR(1),
  CONSTRAINT pk_os_evolucao PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- COMISSAO_PERFIL
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS COMISSAO_PERFIL (
  ID SERIAL NOT NULL,
  CODIGO CHAR(3),
  NOME VARCHAR(100),
  CONSTRAINT pk_comissao_perfil PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- COMISSAO_OBJETIVO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS COMISSAO_OBJETIVO (
  ID SERIAL NOT NULL,
  ID_COMISSAO_PERFIL INTEGER NOT NULL,
  ID_PRODUTO INTEGER NOT NULL,
  CODIGO CHAR(3),
  NOME VARCHAR(100),
  DESCRICAO TEXT,
  FORMA_PAGAMENTO CHAR(1),
  TAXA_PAGAMENTO NUMERIC(18,6),
  VALOR_PAGAMENTO NUMERIC(18,6),
  VALOR_META NUMERIC(18,6),
  QUANTIDADE NUMERIC(18,6),
  CONSTRAINT pk_comissao_objetivo PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- VENDEDOR_ROTA
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS VENDEDOR_ROTA (
  ID SERIAL NOT NULL,
  ID_VENDEDOR INTEGER NOT NULL,
  ID_CLIENTE INTEGER NOT NULL,
  POSICAO INTEGER,
  CONSTRAINT pk_vendedor_rota PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- VENDEDOR_META
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS VENDEDOR_META (
  ID SERIAL NOT NULL,
  ID_VENDEDOR INTEGER NOT NULL,
  ID_CLIENTE INTEGER NOT NULL,
  PERIODO_META CHAR(1),
  META_ORCADA NUMERIC(18,6),
  META_REALIZADA NUMERIC(18,6),
  DATA_INICIO DATE,
  DATA_FIM DATE,
  CONSTRAINT pk_vendedor_meta PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- NFCE_SANGRIA
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS NFCE_SANGRIA (
  ID SERIAL NOT NULL,
  ID_NFCE_MOVIMENTO INTEGER NOT NULL,
  DATA_SANGRIA DATE,
  VALOR NUMERIC(18,6),
  OBSERVACAO TEXT,
  CONSTRAINT pk_nfce_sangria PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- NFCE_MOVIMENTO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS NFCE_MOVIMENTO (
  ID SERIAL NOT NULL,
  ID_NFCE_CAIXA INTEGER NOT NULL,
  ID_NFCE_OPERADOR INTEGER,
  ID_GERENTE_SUPERVISOR INTEGER,
  DATA_ABERTURA DATE,
  HORA_ABERTURA VARCHAR(8),
  DATA_FECHAMENTO DATE,
  HORA_FECHAMENTO VARCHAR(8),
  TOTAL_SUPRIMENTO NUMERIC(18,6),
  TOTAL_SANGRIA NUMERIC(18,6),
  TOTAL_NAO_FISCAL NUMERIC(18,6),
  TOTAL_VENDA NUMERIC(18,6),
  TOTAL_DESCONTO NUMERIC(18,6),
  TOTAL_ACRESCIMO NUMERIC(18,6),
  TOTAL_FINAL NUMERIC(18,6),
  TOTAL_RECEBIDO NUMERIC(18,6),
  TOTAL_TROCO NUMERIC(18,6),
  TOTAL_CANCELADO NUMERIC(18,6),
  STATUS_MOVIMENTO CHAR(1),
  CONSTRAINT pk_nfce_movimento PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- NFCE_OPERADOR
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS NFCE_OPERADOR (
  ID SERIAL NOT NULL,
  ID_COLABORADOR INTEGER NOT NULL,
  LOGIN VARCHAR(20),
  SENHA VARCHAR(20),
  NIVEL_AUTORIZACAO CHAR(1),
  CONSTRAINT pk_nfce_operador PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- NFCE_CAIXA
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS NFCE_CAIXA (
  ID SERIAL NOT NULL,
  NOME VARCHAR(50),
  DATA_CADASTRO DATE,
  CONSTRAINT pk_nfce_caixa PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- NFCE_FECHAMENTO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS NFCE_FECHAMENTO (
  ID SERIAL NOT NULL,
  ID_NFCE_MOVIMENTO INTEGER NOT NULL,
  ID_NFCE_TIPO_PAGAMENTO INTEGER NOT NULL,
  VALOR NUMERIC(18,6),
  CONSTRAINT pk_nfce_fechamento PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- NFCE_SUPRIMENTO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS NFCE_SUPRIMENTO (
  ID SERIAL NOT NULL,
  ID_NFCE_MOVIMENTO INTEGER NOT NULL,
  DATA_SUPRIMENTO DATE,
  VALOR NUMERIC(18,6),
  OBSERVACAO TEXT,
  CONSTRAINT pk_nfce_suprimento PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- NFCE_TIPO_PAGAMENTO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS NFCE_TIPO_PAGAMENTO (
  ID SERIAL NOT NULL,
  CODIGO CHAR(2),
  DESCRICAO VARCHAR(20),
  PERMITE_TROCO CHAR(1),
  GERA_PARCELAS CHAR(1),
  CONSTRAINT pk_nfce_tipo_pagamento PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- NFSE_LISTA_SERVICO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS NFSE_LISTA_SERVICO (
  ID SERIAL NOT NULL,
  CODIGO CHAR(5),
  DESCRICAO TEXT,
  CONSTRAINT pk_nfse_lista_servico PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- NFSE_CABECALHO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS NFSE_CABECALHO (
  ID SERIAL NOT NULL,
  ID_CLIENTE INTEGER NOT NULL,
  ID_OS_ABERTURA INTEGER,
  NUMERO VARCHAR(15),
  CODIGO_VERIFICACAO VARCHAR(9),
  DATA_HORA_EMISSAO TEXT,
  COMPETENCIA VARCHAR(6),
  NUMERO_SUBSTITUIDA VARCHAR(15),
  NATUREZA_OPERACAO CHAR(1),
  REGIME_ESPECIAL_TRIBUTACAO CHAR(1),
  OPTANTE_SIMPLES_NACIONAL CHAR(1),
  INCENTIVADOR_CULTURAL CHAR(1),
  NUMERO_RPS VARCHAR(15),
  SERIE_RPS VARCHAR(5),
  TIPO_RPS CHAR(1),
  DATA_EMISSAO_RPS DATE,
  OUTRAS_INFORMACOES TEXT,
  CONSTRAINT pk_nfse_cabecalho PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- NFSE_DETALHE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS NFSE_DETALHE (
  ID SERIAL NOT NULL,
  ID_NFSE_LISTA_SERVICO INTEGER NOT NULL,
  ID_NFSE_CABECALHO INTEGER NOT NULL,
  VALOR_SERVICOS NUMERIC(18,6),
  VALOR_DEDUCOES NUMERIC(18,6),
  VALOR_PIS NUMERIC(18,6),
  VALOR_COFINS NUMERIC(18,6),
  VALOR_INSS NUMERIC(18,6),
  VALOR_IR NUMERIC(18,6),
  VALOR_CSLL NUMERIC(18,6),
  CODIGO_CNAE VARCHAR(7),
  CODIGO_TRIBUTACAO_MUNICIPIO VARCHAR(20),
  VALOR_BASE_CALCULO NUMERIC(18,6),
  ALIQUOTA NUMERIC(18,6),
  VALOR_ISS NUMERIC(18,6),
  VALOR_LIQUIDO NUMERIC(18,6),
  OUTRAS_RETENCOES NUMERIC(18,6),
  VALOR_CREDITO NUMERIC(18,6),
  ISS_RETIDO CHAR(1),
  VALOR_ISS_RETIDO NUMERIC(18,6),
  VALOR_DESCONTO_CONDICIONADO NUMERIC(18,6),
  VALOR_DESCONTO_INCONDICIONADO NUMERIC(18,6),
  DISCRIMINACAO TEXT,
  MUNICIPIO_PRESTACAO INTEGER,
  CONSTRAINT pk_nfse_detalhe PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- NFSE_INTERMEDIARIO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS NFSE_INTERMEDIARIO (
  ID SERIAL NOT NULL,
  ID_NFSE_CABECALHO INTEGER NOT NULL,
  CNPJ VARCHAR(14),
  RAZAO VARCHAR(150),
  INSCRICAO_MUNICIPAL VARCHAR(15),
  CONSTRAINT pk_nfse_intermediario PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CTE_CABECALHO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CTE_CABECALHO (
  ID SERIAL NOT NULL,
  UF_EMITENTE INTEGER,
  CODIGO_NUMERICO VARCHAR(8),
  CFOP INTEGER,
  NATUREZA_OPERACAO VARCHAR(60),
  FORMA_PAGAMENTO CHAR(1),
  MODELO CHAR(2),
  SERIE CHAR(3),
  NUMERO VARCHAR(9),
  DATA_HORA_EMISSAO TEXT,
  FORMATO_IMPRESSAO_DACTE CHAR(1),
  TIPO_EMISSAO CHAR(1),
  CHAVE_ACESSO VARCHAR(44),
  DIGITO_CHAVE_ACESSO CHAR(1),
  AMBIENTE CHAR(1),
  TIPO_CTE CHAR(1),
  PROCESSO_EMISSAO CHAR(1),
  VERSAO_PROCESSO_EMISSAO VARCHAR(20),
  CHAVE_REFERENCIADO VARCHAR(44),
  CODIGO_MUNICIPIO_ENVIO INTEGER,
  NOME_MUNICIPIO_ENVIO VARCHAR(60),
  UF_ENVIO CHAR(2),
  MODAL CHAR(2),
  TIPO_SERVICO CHAR(1),
  CODIGO_MUNICIPIO_INI_PRESTACAO INTEGER,
  NOME_MUNICIPIO_INI_PRESTACAO VARCHAR(60),
  UF_INI_PRESTACAO CHAR(2),
  CODIGO_MUNICIPIO_FIM_PRESTACAO INTEGER,
  NOME_MUNICIPIO_FIM_PRESTACAO VARCHAR(60),
  UF_FIM_PRESTACAO CHAR(2),
  RETIRA CHAR(1),
  RETIRA_DETALHE VARCHAR(160),
  TOMADOR CHAR(1),
  DATA_ENTRADA_CONTINGENCIA TEXT,
  JUSTIFICATIVA_CONTINGENCIA VARCHAR(255),
  CARAC_ADICIONAL_TRANSPORTE VARCHAR(15),
  CARAC_ADICIONAL_SERVICO VARCHAR(30),
  FUNCIONARIO_EMISSOR VARCHAR(20),
  FLUXO_ORIGEM VARCHAR(15),
  ENTREGA_TIPO_PERIODO CHAR(1),
  ENTREGA_DATA_PROGRAMADA DATE,
  ENTREGA_DATA_INICIAL DATE,
  ENTREGA_DATA_FINAL DATE,
  ENTREGA_TIPO_HORA CHAR(1),
  ENTREGA_HORA_PROGRAMADA VARCHAR(8),
  ENTREGA_HORA_INICIAL VARCHAR(8),
  ENTREGA_HORA_FINAL VARCHAR(8),
  MUNICIPIO_ORIGEM_CALCULO VARCHAR(40),
  MUNICIPIO_DESTINO_CALCULO VARCHAR(40),
  OBSERVACOES_GERAIS TEXT,
  VALOR_TOTAL_SERVICO NUMERIC(18,6),
  VALOR_RECEBER NUMERIC(18,6),
  CST CHAR(2),
  BASE_CALCULO_ICMS NUMERIC(18,6),
  ALIQUOTA_ICMS NUMERIC(18,6),
  VALOR_ICMS NUMERIC(18,6),
  PERCENTUAL_REDUCAO_BC_ICMS NUMERIC(18,6),
  VALOR_BC_ICMS_ST_RETIDO NUMERIC(18,6),
  VALOR_ICMS_ST_RETIDO NUMERIC(18,6),
  ALIQUOTA_ICMS_ST_RETIDO NUMERIC(18,6),
  VALOR_CREDITO_PRESUMIDO_ICMS NUMERIC(18,6),
  PERCENTUAL_BC_ICMS_OUTRA_UF NUMERIC(18,6),
  VALOR_BC_ICMS_OUTRA_UF NUMERIC(18,6),
  ALIQUOTA_ICMS_OUTRA_UF NUMERIC(18,6),
  VALOR_ICMS_OUTRA_UF NUMERIC(18,6),
  SIMPLES_NACIONAL_INDICADOR CHAR(1),
  SIMPLES_NACIONAL_TOTAL NUMERIC(18,6),
  INFORMACOES_ADD_FISCO TEXT,
  VALOR_TOTAL_CARGA NUMERIC(18,6),
  PRODUTO_PREDOMINANTE VARCHAR(60),
  CARGA_OUTRAS_CARACTERISTICAS VARCHAR(30),
  MODAL_VERSAO_LAYOUT INTEGER,
  CHAVE_CTE_SUBSTITUIDO VARCHAR(44),
  CONSTRAINT pk_cte_cabecalho PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CTE_EMITENTE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CTE_EMITENTE (
  ID SERIAL NOT NULL,
  ID_CTE_CABECALHO INTEGER NOT NULL,
  CNPJ VARCHAR(14),
  IE VARCHAR(14),
  NOME VARCHAR(60),
  FANTASIA VARCHAR(60),
  LOGRADOURO VARCHAR(60),
  NUMERO VARCHAR(60),
  COMPLEMENTO VARCHAR(60),
  BAIRRO VARCHAR(60),
  CODIGO_MUNICIPIO INTEGER,
  NOME_MUNICIPIO VARCHAR(60),
  UF CHAR(2),
  CEP VARCHAR(8),
  TELEFONE VARCHAR(14),
  CONSTRAINT pk_cte_emitente PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CTE_LOCAL_COLETA
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CTE_LOCAL_COLETA (
  ID SERIAL NOT NULL,
  ID_CTE_CABECALHO INTEGER NOT NULL,
  CNPJ VARCHAR(14),
  CPF VARCHAR(11),
  NOME VARCHAR(60),
  LOGRADOURO VARCHAR(250),
  NUMERO VARCHAR(60),
  COMPLEMENTO VARCHAR(60),
  BAIRRO VARCHAR(60),
  CODIGO_MUNICIPIO INTEGER,
  NOME_MUNICIPIO VARCHAR(60),
  UF CHAR(2),
  CONSTRAINT pk_cte_local_coleta PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CTE_TOMADOR
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CTE_TOMADOR (
  ID SERIAL NOT NULL,
  ID_CTE_CABECALHO INTEGER NOT NULL,
  CNPJ VARCHAR(14),
  CPF VARCHAR(11),
  IE VARCHAR(14),
  NOME VARCHAR(60),
  FANTASIA VARCHAR(60),
  TELEFONE VARCHAR(14),
  LOGRADOURO VARCHAR(255),
  NUMERO VARCHAR(60),
  COMPLEMENTO VARCHAR(60),
  BAIRRO VARCHAR(60),
  CODIGO_MUNICIPIO INTEGER,
  NOME_MUNICIPIO VARCHAR(60),
  UF CHAR(2),
  CEP VARCHAR(8),
  CODIGO_PAIS INTEGER,
  NOME_PAIS VARCHAR(60),
  EMAIL VARCHAR(60),
  CONSTRAINT pk_cte_tomador PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CTE_PASSAGEM
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CTE_PASSAGEM (
  ID SERIAL NOT NULL,
  ID_CTE_CABECALHO INTEGER NOT NULL,
  SIGLA_PASSAGEM VARCHAR(15),
  SIGLA_DESTINO VARCHAR(15),
  ROTA VARCHAR(10),
  CONSTRAINT pk_cte_passagem PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CTE_REMETENTE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CTE_REMETENTE (
  ID SERIAL NOT NULL,
  ID_CTE_CABECALHO INTEGER NOT NULL,
  CNPJ VARCHAR(14),
  CPF VARCHAR(11),
  IE VARCHAR(20),
  NOME VARCHAR(60),
  FANTASIA VARCHAR(60),
  TELEFONE VARCHAR(14),
  LOGRADOURO VARCHAR(250),
  NUMERO VARCHAR(60),
  COMPLEMENTO VARCHAR(60),
  BAIRRO VARCHAR(60),
  CODIGO_MUNICIPIO INTEGER,
  NOME_MUNICIPIO VARCHAR(60),
  UF CHAR(2),
  CEP VARCHAR(8),
  CODIGO_PAIS INTEGER,
  NOME_PAIS VARCHAR(60),
  EMAIL VARCHAR(60),
  CONSTRAINT pk_cte_remetente PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CTE_EXPEDIDOR
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CTE_EXPEDIDOR (
  ID SERIAL NOT NULL,
  ID_CTE_CABECALHO INTEGER NOT NULL,
  CNPJ VARCHAR(14),
  CPF VARCHAR(11),
  IE VARCHAR(20),
  NOME VARCHAR(60),
  FANTASIA VARCHAR(60),
  TELEFONE VARCHAR(14),
  LOGRADOURO VARCHAR(250),
  NUMERO VARCHAR(60),
  COMPLEMENTO VARCHAR(60),
  BAIRRO VARCHAR(60),
  CODIGO_MUNICIPIO INTEGER,
  NOME_MUNICIPIO VARCHAR(60),
  UF CHAR(2),
  CEP VARCHAR(8),
  CODIGO_PAIS INTEGER,
  NOME_PAIS VARCHAR(60),
  EMAIL VARCHAR(60),
  CONSTRAINT pk_cte_expedidor PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CTE_RECEBEDOR
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CTE_RECEBEDOR (
  ID SERIAL NOT NULL,
  ID_CTE_CABECALHO INTEGER NOT NULL,
  CNPJ VARCHAR(14),
  CPF VARCHAR(11),
  IE VARCHAR(20),
  NOME VARCHAR(60),
  FANTASIA VARCHAR(60),
  TELEFONE VARCHAR(14),
  LOGRADOURO VARCHAR(250),
  NUMERO VARCHAR(60),
  COMPLEMENTO VARCHAR(60),
  BAIRRO VARCHAR(60),
  CODIGO_MUNICIPIO INTEGER,
  NOME_MUNICIPIO VARCHAR(60),
  UF CHAR(2),
  CEP VARCHAR(8),
  CODIGO_PAIS INTEGER,
  NOME_PAIS VARCHAR(60),
  EMAIL VARCHAR(60),
  CONSTRAINT pk_cte_recebedor PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CTE_DESTINATARIO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CTE_DESTINATARIO (
  ID SERIAL NOT NULL,
  ID_CTE_CABECALHO INTEGER NOT NULL,
  CNPJ VARCHAR(14),
  CPF VARCHAR(11),
  IE VARCHAR(20),
  NOME VARCHAR(60),
  FANTASIA VARCHAR(60),
  TELEFONE VARCHAR(14),
  LOGRADOURO VARCHAR(250),
  NUMERO VARCHAR(60),
  COMPLEMENTO VARCHAR(60),
  BAIRRO VARCHAR(60),
  CODIGO_MUNICIPIO INTEGER,
  NOME_MUNICIPIO VARCHAR(60),
  UF CHAR(2),
  CEP VARCHAR(8),
  CODIGO_PAIS INTEGER,
  NOME_PAIS VARCHAR(60),
  EMAIL VARCHAR(60),
  CONSTRAINT pk_cte_destinatario PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CTE_LOCAL_ENTREGA
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CTE_LOCAL_ENTREGA (
  ID SERIAL NOT NULL,
  ID_CTE_CABECALHO INTEGER NOT NULL,
  CNPJ VARCHAR(14),
  CPF VARCHAR(11),
  NOME VARCHAR(60),
  LOGRADOURO VARCHAR(250),
  NUMERO VARCHAR(60),
  COMPLEMENTO VARCHAR(60),
  BAIRRO VARCHAR(60),
  CODIGO_MUNICIPIO INTEGER,
  NOME_MUNICIPIO VARCHAR(60),
  UF CHAR(2),
  CONSTRAINT pk_cte_local_entrega PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CTE_COMPONENTE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CTE_COMPONENTE (
  ID SERIAL NOT NULL,
  ID_CTE_CABECALHO INTEGER NOT NULL,
  NOME VARCHAR(15),
  VALOR NUMERIC(18,6),
  CONSTRAINT pk_cte_componente PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CTE_CARGA
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CTE_CARGA (
  ID SERIAL NOT NULL,
  ID_CTE_CABECALHO INTEGER NOT NULL,
  CODIGO_UNIDADE_MEDIDA CHAR(2),
  TIPO_MEDIDA VARCHAR(20),
  QUANTIDADE NUMERIC(18,6),
  CONSTRAINT pk_cte_carga PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CTE_INFORMACAO_NF_OUTROS
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CTE_INFORMACAO_NF_OUTROS (
  ID SERIAL NOT NULL,
  ID_CTE_CABECALHO INTEGER NOT NULL,
  NUMERO_ROMANEIO VARCHAR(20),
  NUMERO_PEDIDO VARCHAR(20),
  CHAVE_ACESSO_NFE VARCHAR(44),
  CODIGO_MODELO CHAR(2),
  SERIE CHAR(3),
  NUMERO VARCHAR(20),
  DATA_EMISSAO DATE,
  UF_EMITENTE INTEGER,
  BASE_CALCULO_ICMS NUMERIC(18,6),
  VALOR_ICMS NUMERIC(18,6),
  BASE_CALCULO_ICMS_ST NUMERIC(18,6),
  VALOR_ICMS_ST NUMERIC(18,6),
  VALOR_TOTAL_PRODUTOS NUMERIC(18,6),
  VALOR_TOTAL NUMERIC(18,6),
  CFOP_PREDOMINANTE INTEGER,
  PESO_TOTAL_KG NUMERIC(18,6),
  PIN_SUFRAMA INTEGER,
  DATA_PREVISTA_ENTREGA DATE,
  OUTRO_TIPO_DOC_ORIG CHAR(2),
  OUTRO_DESCRICAO VARCHAR(100),
  OUTRO_VALOR_DOCUMENTO NUMERIC(18,6),
  CONSTRAINT pk_cte_informacao_nf_outros PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CTE_INFORMACAO_NF_TRANSPORTE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CTE_INFORMACAO_NF_TRANSPORTE (
  ID SERIAL NOT NULL,
  ID_CTE_INFORMACAO_NF INTEGER NOT NULL,
  TIPO_UNIDADE_TRANSPORTE CHAR(1),
  ID_UNIDADE_TRANSPORTE VARCHAR(20),
  CONSTRAINT pk_cte_informacao_nf_transporte PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CTE_INF_NF_TRANSPORTE_LACRE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CTE_INF_NF_TRANSPORTE_LACRE (
  ID INTEGER NOT NULL,
  ID_CTE_INFORMACAO_NF_TRANSPORTE INTEGER NOT NULL,
  NUMERO VARCHAR(20),
  CONSTRAINT pk_cte_inf_nf_transporte_lacre PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CTE_INFORMACAO_NF_CARGA
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CTE_INFORMACAO_NF_CARGA (
  ID SERIAL NOT NULL,
  ID_CTE_INFORMACAO_NF INTEGER NOT NULL,
  TIPO_UNIDADE_CARGA CHAR(1),
  ID_UNIDADE_CARGA VARCHAR(20),
  CONSTRAINT pk_cte_informacao_nf_carga PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CTE_INF_NF_CARGA_LACRE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CTE_INF_NF_CARGA_LACRE (
  ID SERIAL NOT NULL,
  ID_CTE_INFORMACAO_NF_CARGA INTEGER NOT NULL,
  NUMERO VARCHAR(20),
  QUANTIDADE_RATEADA NUMERIC(18,6),
  CONSTRAINT pk_cte_inf_nf_carga_lacre PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CTE_DOCUMENTO_ANTERIOR
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CTE_DOCUMENTO_ANTERIOR (
  ID SERIAL NOT NULL,
  ID_CTE_CABECALHO INTEGER NOT NULL,
  CNPJ VARCHAR(14),
  CPF VARCHAR(11),
  IE VARCHAR(20),
  UF CHAR(2),
  NOME VARCHAR(60),
  CONSTRAINT pk_cte_documento_anterior PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CTE_DOCUMENTO_ANTERIOR_ID
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CTE_DOCUMENTO_ANTERIOR_ID (
  ID SERIAL NOT NULL,
  ID_CTE_DOCUMENTO_ANTERIOR INTEGER NOT NULL,
  TIPO CHAR(2),
  SERIE CHAR(3),
  SUBSERIE CHAR(2),
  NUMERO VARCHAR(20),
  DATA_EMISSAO DATE,
  CHAVE_CTE VARCHAR(44),
  CONSTRAINT pk_cte_documento_anterior_id PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CTE_SEGURO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CTE_SEGURO (
  ID SERIAL NOT NULL,
  ID_CTE_CABECALHO INTEGER NOT NULL,
  RESPONSAVEL CHAR(1),
  SEGURADORA VARCHAR(30),
  APOLICE VARCHAR(20),
  AVERBACAO VARCHAR(20),
  VALOR_CARGA NUMERIC(18,6),
  CONSTRAINT pk_cte_seguro PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CTE_PERIGOSO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CTE_PERIGOSO (
  ID SERIAL NOT NULL,
  ID_CTE_CABECALHO INTEGER NOT NULL,
  NUMERO_ONU VARCHAR(4),
  NOME_APROPRIADO VARCHAR(150),
  CLASSE_RISCO VARCHAR(40),
  GRUPO_EMBALAGEM VARCHAR(6),
  QUANTIDADE_TOTAL_PRODUTO VARCHAR(20),
  QUANTIDADE_TIPO_VOLUME VARCHAR(60),
  PONTO_FULGOR VARCHAR(6),
  CONSTRAINT pk_cte_perigoso PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CTE_VEICULO_NOVO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CTE_VEICULO_NOVO (
  ID SERIAL NOT NULL,
  ID_CTE_CABECALHO INTEGER NOT NULL,
  CHASSI VARCHAR(17),
  COR VARCHAR(4),
  DESCRICAO_COR VARCHAR(40),
  CODIGO_MARCA_MODELO VARCHAR(6),
  VALOR_UNITARIO NUMERIC(18,6),
  VALOR_FRETE NUMERIC(18,6),
  CONSTRAINT pk_cte_veiculo_novo PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CTE_FATURA
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CTE_FATURA (
  ID SERIAL NOT NULL,
  ID_CTE_CABECALHO INTEGER NOT NULL,
  NUMERO VARCHAR(60),
  VALOR_ORIGINAL NUMERIC(18,6),
  VALOR_DESCONTO NUMERIC(18,6),
  VALOR_LIQUIDO NUMERIC(18,6),
  CONSTRAINT pk_cte_fatura PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CTE_DUPLICATA
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CTE_DUPLICATA (
  ID SERIAL NOT NULL,
  ID_CTE_CABECALHO INTEGER NOT NULL,
  NUMERO VARCHAR(60),
  DATA_VENCIMENTO DATE,
  VALOR NUMERIC(18,6),
  CONSTRAINT pk_cte_duplicata PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CTE_RODOVIARIO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CTE_RODOVIARIO (
  ID SERIAL NOT NULL,
  ID_CTE_CABECALHO INTEGER NOT NULL,
  RNTRC VARCHAR(8),
  DATA_PREVISTA_ENTREGA DATE,
  INDICADOR_LOTACAO CHAR(1),
  CIOT INTEGER,
  CONSTRAINT pk_cte_rodoviario PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CTE_RODOVIARIO_OCC
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CTE_RODOVIARIO_OCC (
  ID SERIAL NOT NULL,
  ID_CTE_RODOVIARIO INTEGER NOT NULL,
  SERIE CHAR(3),
  NUMERO INTEGER,
  DATA_EMISSAO DATE,
  CNPJ VARCHAR(14),
  CODIGO_INTERNO VARCHAR(10),
  IE VARCHAR(14),
  UF CHAR(2),
  TELEFONE VARCHAR(14),
  CONSTRAINT pk_cte_rodoviario_occ PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CTE_RODOVIARIO_PEDAGIO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CTE_RODOVIARIO_PEDAGIO (
  ID SERIAL NOT NULL,
  ID_CTE_RODOVIARIO INTEGER NOT NULL,
  CNPJ_FORNECEDOR VARCHAR(14),
  COMPROVANTE_COMPRA VARCHAR(20),
  CNPJ_RESPONSAVEL VARCHAR(14),
  VALOR NUMERIC(18,6),
  CONSTRAINT pk_cte_rodoviario_pedagio PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CTE_RODOVIARIO_VEICULO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CTE_RODOVIARIO_VEICULO (
  ID SERIAL NOT NULL,
  ID_CTE_RODOVIARIO INTEGER NOT NULL,
  CODIGO_INTERNO VARCHAR(10),
  RENAVAM VARCHAR(11),
  PLACA VARCHAR(7),
  TARA INTEGER,
  CAPACIDADE_KG INTEGER,
  CAPACIDADE_M3 INTEGER,
  TIPO_PROPRIEDADE CHAR(1),
  TIPO_VEICULO CHAR(1),
  TIPO_RODADO CHAR(2),
  TIPO_CARROCERIA CHAR(2),
  UF CHAR(2),
  PROPRIETARIO_CPF VARCHAR(11),
  PROPRIETARIO_CNPJ VARCHAR(14),
  PROPRIETARIO_RNTRC VARCHAR(8),
  PROPRIETARIO_NOME VARCHAR(60),
  PROPRIETARIO_IE VARCHAR(14),
  PROPRIETARIO_UF CHAR(2),
  PROPRIETARIO_TIPO CHAR(1),
  CONSTRAINT pk_cte_rodoviario_veiculo PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CTE_RODOVIARIO_LACRE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CTE_RODOVIARIO_LACRE (
  ID SERIAL NOT NULL,
  ID_CTE_RODOVIARIO INTEGER NOT NULL,
  NUMERO VARCHAR(20),
  CONSTRAINT pk_cte_rodoviario_lacre PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CTE_RODOVIARIO_MOTORISTA
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CTE_RODOVIARIO_MOTORISTA (
  ID SERIAL NOT NULL,
  ID_CTE_RODOVIARIO INTEGER NOT NULL,
  NOME VARCHAR(60),
  CPF VARCHAR(11),
  CONSTRAINT pk_cte_rodoviario_motorista PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CTE_AEREO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CTE_AEREO (
  ID SERIAL NOT NULL,
  ID_CTE_CABECALHO INTEGER NOT NULL,
  NUMERO_MINUTA INTEGER,
  NUMERO_CONHECIMENTO INTEGER,
  DATA_PREVISTA_ENTREGA DATE,
  ID_EMISSOR VARCHAR(20),
  ID_INTERNA_TOMADOR VARCHAR(14),
  TARIFA_CLASSE CHAR(1),
  TARIFA_CODIGO VARCHAR(4),
  TARIFA_VALOR NUMERIC(18,6),
  CARGA_DIMENSAO VARCHAR(14),
  CARGA_INFORMACAO_MANUSEIO CHAR(1),
  CARGA_ESPECIAL CHAR(3),
  CONSTRAINT pk_cte_aereo PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CTE_AQUAVIARIO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CTE_AQUAVIARIO (
  ID SERIAL NOT NULL,
  ID_CTE_CABECALHO INTEGER NOT NULL,
  VALOR_PRESTACAO NUMERIC(18,6),
  AFRMM NUMERIC(18,6),
  NUMERO_BOOKING VARCHAR(10),
  NUMERO_CONTROLE VARCHAR(10),
  ID_NAVIO VARCHAR(60),
  CONSTRAINT pk_cte_aquaviario PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CTE_AQUAVIARIO_BALSA
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CTE_AQUAVIARIO_BALSA (
  ID SERIAL NOT NULL,
  ID_CTE_AQUAVIARIO INTEGER NOT NULL,
  ID_BALSA VARCHAR(60),
  NUMERO_VIAGEM INTEGER,
  DIRECAO CHAR(1),
  PORTO_EMBARQUE VARCHAR(60),
  PORTO_TRANSBORDO VARCHAR(60),
  PORTO_DESTINO VARCHAR(60),
  TIPO_NAVEGACAO CHAR(1),
  IRIN VARCHAR(10),
  CONSTRAINT pk_cte_aquaviario_balsa PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CTE_FERROVIARIO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CTE_FERROVIARIO (
  ID SERIAL NOT NULL,
  ID_CTE_CABECALHO INTEGER NOT NULL,
  TIPO_TRAFEGO CHAR(1),
  RESPONSAVEL_FATURAMENTO CHAR(1),
  FERROVIA_EMITENTE_CTE CHAR(1),
  FLUXO VARCHAR(10),
  ID_TREM VARCHAR(7),
  VALOR_FRETE NUMERIC(18,6),
  CONSTRAINT pk_cte_ferroviario PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CTE_FERROVIARIO_FERROVIA
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CTE_FERROVIARIO_FERROVIA (
  ID SERIAL NOT NULL,
  ID_CTE_FERROVIARIO INTEGER NOT NULL,
  CNPJ VARCHAR(14),
  CODIGO_INTERNO VARCHAR(10),
  IE VARCHAR(20),
  NOME VARCHAR(60),
  LOGRADOURO VARCHAR(250),
  NUMERO VARCHAR(60),
  COMPLEMENTO VARCHAR(60),
  BAIRRO VARCHAR(60),
  CODIGO_MUNICIPIO INTEGER,
  NOME_MUNICIPIO VARCHAR(60),
  UF CHAR(2),
  CEP VARCHAR(8),
  CONSTRAINT pk_cte_ferroviario_ferrovia PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CTE_FERROVIARIO_VAGAO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CTE_FERROVIARIO_VAGAO (
  ID INTEGER NOT NULL,
  ID_CTE_FERROVIARIO INTEGER NOT NULL,
  NUMERO_VAGAO INTEGER,
  CAPACIDADE NUMERIC(18,6),
  TIPO_VAGAO CHAR(3),
  PESO_REAL NUMERIC(18,6),
  PESO_BC NUMERIC(18,6),
  CONSTRAINT pk_cte_ferroviario_vagao PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CTE_DUTOVIARIO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CTE_DUTOVIARIO (
  ID SERIAL NOT NULL,
  ID_CTE_CABECALHO INTEGER NOT NULL,
  VALOR_TARIFA NUMERIC(18,6),
  DATA_INICIO DATE,
  DATA_FIM DATE,
  CONSTRAINT pk_cte_dutoviario PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CTE_MULTIMODAL
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CTE_MULTIMODAL (
  ID SERIAL NOT NULL,
  ID_CTE_CABECALHO INTEGER NOT NULL,
  COTM VARCHAR(20),
  INDICADOR_NEGOCIAVEL CHAR(1),
  CONSTRAINT pk_cte_multimodal PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- OPERADORA_CARTAO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS OPERADORA_CARTAO (
  ID SERIAL NOT NULL,
  ID_BANCO_CONTA_CAIXA INTEGER NOT NULL,
  BANDEIRA VARCHAR(30),
  NOME VARCHAR(50),
  TAXA_ADM NUMERIC(18,6),
  TAXA_ADM_DEBITO NUMERIC(18,6),
  VALOR_ALUGUEL_POS_PIN NUMERIC(18,6),
  VENCIMENTO_ALUGUEL INTEGER,
  FONE1 VARCHAR(14),
  FONE2 VARCHAR(14),
  CLASSIFICACAO_CONTABIL_CONTA VARCHAR(30),
  CONSTRAINT pk_operadora_cartao PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- COLABORADOR_RELACIONAMENTO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS COLABORADOR_RELACIONAMENTO (
  ID SERIAL NOT NULL,
  ID_TIPO_RELACIONAMENTO INTEGER NOT NULL,
  ID_COLABORADOR INTEGER NOT NULL,
  NOME VARCHAR(100),
  DATA_NASCIMENTO DATE,
  CPF VARCHAR(11),
  REGISTRO_MATRICULA VARCHAR(50),
  REGISTRO_CARTORIO VARCHAR(50),
  REGISTRO_CARTORIO_NUMERO VARCHAR(50),
  REGISTRO_NUMERO_LIVRO VARCHAR(10),
  REGISTRO_NUMERO_FOLHA VARCHAR(10),
  DATA_ENTREGA_DOCUMENTO DATE,
  SALARIO_FAMILIA CHAR(1),
  SALARIO_FAMILIA_IDADE_LIMITE INTEGER,
  SALARIO_FAMILIA_DATA_FIM DATE,
  IMPOSTO_RENDA_IDADE_LIMITE INTEGER,
  IMPOSTO_RENDA_DATA_FIM INTEGER,
  CONSTRAINT pk_colaborador_relacionamento PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- TIPO_RELACIONAMENTO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS TIPO_RELACIONAMENTO (
  ID SERIAL NOT NULL,
  CODIGO CHAR(3),
  NOME VARCHAR(100),
  DESCRICAO TEXT,
  CONSTRAINT pk_tipo_relacionamento PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- COLABORADOR_TIPO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS COLABORADOR_TIPO (
  ID SERIAL NOT NULL,
  NOME VARCHAR(20),
  DESCRICAO TEXT,
  CONSTRAINT pk_colaborador_tipo PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- FORNECEDOR_PRODUTO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FORNECEDOR_PRODUTO (
  ID SERIAL NOT NULL,
  ID_PRODUTO INTEGER NOT NULL,
  ID_FORNECEDOR INTEGER NOT NULL,
  CODIGO_FORNECEDOR_PRODUTO VARCHAR(20),
  DATA_ULTIMA_COMPRA DATE,
  PRECO_ULTIMA_COMPRA NUMERIC(18,6),
  LOTE_MINIMO_COMPRA NUMERIC(18,6),
  MENOR_EMBALAGEM_COMPRA NUMERIC(18,6),
  CUSTO_ULTIMA_COMPRA NUMERIC(18,6),
  CONSTRAINT pk_fornecedor_produto PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- AIDF_AIMDF
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS AIDF_AIMDF (
  ID SERIAL NOT NULL,
  NUMERO INTEGER,
  DATA_VALIDADE DATE,
  DATA_AUTORIZACAO DATE,
  NUMERO_AUTORIZACAO VARCHAR(20),
  FORMULARIO_DISPONIVEL CHAR(1),
  CONSTRAINT pk_aidf_aimdf PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PRODUTO_PROMOCAO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PRODUTO_PROMOCAO (
  ID SERIAL NOT NULL,
  ID_PRODUTO INTEGER NOT NULL,
  DATA_INICIO DATE,
  DATA_FIM DATE,
  QUANTIDADE_EM_PROMOCAO NUMERIC(18,6),
  QUANTIDADE_MAXIMA_CLIENTE NUMERIC(18,6),
  VALOR NUMERIC(18,6),
  CONSTRAINT pk_produto_promocao PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PRODUTO_FICHA_TECNICA
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PRODUTO_FICHA_TECNICA (
  ID SERIAL NOT NULL,
  ID_PRODUTO INTEGER NOT NULL,
  DESCRICAO VARCHAR(100),
  ID_PRODUTO_FILHO INTEGER,
  QUANTIDADE NUMERIC(18,6),
  SEQUENCIA_PRODUCAO INTEGER,
  CONSTRAINT pk_produto_ficha_tecnica PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- TIPO_ITEM_SPED
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS TIPO_ITEM_SPED (
  ID SERIAL NOT NULL,
  CODIGO CHAR(2),
  DESCRICAO VARCHAR(50),
  CONSTRAINT pk_tipo_item_sped PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PRODUTO_CODIGO_ADICIONAL
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PRODUTO_CODIGO_ADICIONAL (
  ID SERIAL NOT NULL,
  ID_PRODUTO INTEGER NOT NULL,
  CODIGO VARCHAR(14),
  CONSTRAINT pk_produto_codigo_adicional PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- ALMOXARIFADO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ALMOXARIFADO (
  ID SERIAL NOT NULL,
  NOME VARCHAR(50),
  CONSTRAINT pk_almoxarifado PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- COLABORADOR_SITUACAO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS COLABORADOR_SITUACAO (
  ID SERIAL NOT NULL,
  CODIGO CHAR(3),
  NOME VARCHAR(100),
  DESCRICAO TEXT,
  CONSTRAINT pk_colaborador_situacao PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- TIPO_ADMISSAO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS TIPO_ADMISSAO (
  ID SERIAL NOT NULL,
  CODIGO CHAR(3),
  NOME VARCHAR(100),
  DESCRICAO TEXT,
  CONSTRAINT pk_tipo_admissao PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- OPERADORA_PLANO_SAUDE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS OPERADORA_PLANO_SAUDE (
  ID SERIAL NOT NULL,
  REGISTRO_ANS VARCHAR(20),
  NOME VARCHAR(100),
  CLASSIFICACAO_CONTABIL_CONTA VARCHAR(30),
  CONSTRAINT pk_operadora_plano_saude PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- IRRF
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS IRRF (
  ID SERIAL NOT NULL,
  COMPETENCIA VARCHAR(7),
  DESCONTO_POR_DEPENDENTE NUMERIC(18,6),
  MINIMO_PARA_RETENCAO NUMERIC(18,6),
  CONSTRAINT pk_irrf PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- IRRF_DETALHE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS IRRF_DETALHE (
  ID SERIAL NOT NULL,
  ID_IRRF INTEGER NOT NULL,
  FAIXA INTEGER,
  DE NUMERIC(18,6),
  ATE NUMERIC(18,6),
  TAXA NUMERIC(18,6),
  DESCONTO NUMERIC(18,6),
  CONSTRAINT pk_irrf_detalhe PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- INSS
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS INSS (
  ID SERIAL NOT NULL,
  COMPETENCIA VARCHAR(7),
  CONSTRAINT pk_inss PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- INSS_DETALHE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS INSS_DETALHE (
  ID SERIAL NOT NULL,
  ID_INSS INTEGER NOT NULL,
  FAIXA INTEGER,
  DE NUMERIC(18,6),
  ATE NUMERIC(18,6),
  TAXA NUMERIC(18,6),
  CONSTRAINT pk_inss_detalhe PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- SALARIO_FAMILIA
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS SALARIO_FAMILIA (
  ID SERIAL NOT NULL,
  ID_INSS INTEGER NOT NULL,
  FAIXA INTEGER,
  DE NUMERIC(18,6),
  ATE NUMERIC(18,6),
  VALOR NUMERIC(18,6),
  CONSTRAINT pk_salario_familia PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- SALARIO_MINIMO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS SALARIO_MINIMO (
  ID SERIAL NOT NULL,
  VIGENCIA DATE,
  VALOR_MENSAL NUMERIC(18,6),
  VALOR_DIARIO NUMERIC(18,6),
  VALOR_HORA NUMERIC(18,6),
  NORMA_LEGAL VARCHAR(100),
  DOU DATE,
  CONSTRAINT pk_salario_minimo PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- SINDICATO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS SINDICATO (
  ID SERIAL NOT NULL,
  NOME VARCHAR(100),
  CODIGO_BANCO INTEGER,
  CODIGO_AGENCIA INTEGER,
  CONTA_BANCO VARCHAR(20),
  CODIGO_CEDENTE VARCHAR(30),
  LOGRADOURO VARCHAR(100),
  NUMERO VARCHAR(10),
  BAIRRO VARCHAR(100),
  MUNICIPIO_IBGE INTEGER,
  UF CHAR(2),
  FONE1 VARCHAR(14),
  FONE2 VARCHAR(14),
  EMAIL VARCHAR(100),
  TIPO_SINDICATO CHAR(1),
  DATA_BASE DATE,
  PISO_SALARIAL NUMERIC(18,6),
  CNPJ VARCHAR(14),
  CLASSIFICACAO_CONTABIL_CONTA VARCHAR(30),
  CONSTRAINT pk_sindicato PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CONTRIB_SIND_PATRONAL_CAB
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CONTRIB_SIND_PATRONAL_CAB (
  ID SERIAL NOT NULL,
  ID_SINDICATO INTEGER NOT NULL,
  VIGENCIA_ANO CHAR(4),
  CONSTRAINT pk_contrib_sind_patronal_cab PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CONTRIB_SIND_PATRONAL_DET
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CONTRIB_SIND_PATRONAL_DET (
  ID SERIAL NOT NULL,
  ID_CONTRIB_SIND_PATRONAL_CAB INTEGER NOT NULL,
  DE NUMERIC(18,6),
  ATE NUMERIC(18,6),
  PERCENTUAL NUMERIC(18,6),
  VALOR_ADICIONAR NUMERIC(18,6),
  CONSTRAINT pk_contrib_sind_patronal_det PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- EMPRESA_TRANSPORTE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS EMPRESA_TRANSPORTE (
  ID SERIAL NOT NULL,
  UF CHAR(2),
  NOME VARCHAR(100),
  CLASSIFICACAO_CONTABIL_CONTA VARCHAR(30),
  CONSTRAINT pk_empresa_transporte PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- EMPRESA_TRANSPORTE_ITINERARIO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS EMPRESA_TRANSPORTE_ITINERARIO (
  ID SERIAL NOT NULL,
  ID_EMPRESA_TRANSPORTE INTEGER NOT NULL,
  NOME VARCHAR(100),
  TARIFA NUMERIC(18,6),
  TRAJETO TEXT,
  CONSTRAINT pk_empresa_transporte_itinerario PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PDV_CAIXA
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PDV_CAIXA (
  ID SERIAL NOT NULL,
  NOME VARCHAR(30),
  DATA_CADASTRO DATE,
  CONSTRAINT pk_pdv_caixa PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- ECF_IMPRESSORA
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ECF_IMPRESSORA (
  ID SERIAL NOT NULL,
  NUMERO INTEGER,
  CODIGO VARCHAR(10),
  SERIE VARCHAR(25),
  IDENTIFICACAO VARCHAR(250),
  MC CHAR(2),
  MD CHAR(2),
  VR CHAR(2),
  TIPO VARCHAR(7),
  MARCA VARCHAR(30),
  MODELO VARCHAR(30),
  MODELO_ACBR VARCHAR(30),
  MODELO_DOCUMENTO_FISCAL CHAR(2),
  VERSAO VARCHAR(30),
  LE CHAR(1),
  LEF CHAR(1),
  MFD CHAR(1),
  LACRE_NA_MFD CHAR(1),
  DATA_INSTALACAO_SB DATE,
  HORA_INSTALACAO_SB VARCHAR(8),
  DOCTO VARCHAR(60),
  ECF_IMPRESSORA VARCHAR(3),
  CONSTRAINT pk_ecf_impressora PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PDV_TIPO_PAGAMENTO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PDV_TIPO_PAGAMENTO (
  ID SERIAL NOT NULL,
  CODIGO CHAR(3),
  DESCRICAO VARCHAR(20),
  TEF CHAR(1),
  IMPRIME_VINCULADO CHAR(1),
  PERMITE_TROCO CHAR(1),
  TEF_TIPO_GP CHAR(1),
  GERA_PARCELAS CHAR(1),
  CONSTRAINT pk_pdv_tipo_pagamento PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PDV_MOVIMENTO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PDV_MOVIMENTO (
  ID SERIAL NOT NULL,
  NOME_CAIXA VARCHAR(30),
  ID_GERADO_CAIXA INTEGER,
  ID_EMPRESA INTEGER,
  ID_ECF_IMPRESSORA INTEGER,
  ID_PDV_OPERADOR INTEGER,
  ID_PDV_CAIXA INTEGER,
  ID_GERENTE_SUPERVISOR INTEGER NOT NULL,
  DATA_ABERTURA DATE,
  HORA_ABERTURA VARCHAR(8),
  DATA_FECHAMENTO DATE,
  HORA_FECHAMENTO VARCHAR(8),
  TOTAL_SUPRIMENTO NUMERIC(18,6),
  TOTAL_SANGRIA NUMERIC(18,6),
  TOTAL_NAO_FISCAL NUMERIC(18,6),
  TOTAL_VENDA NUMERIC(18,6),
  TOTAL_DESCONTO NUMERIC(18,6),
  TOTAL_ACRESCIMO NUMERIC(18,6),
  TOTAL_FINAL NUMERIC(18,6),
  TOTAL_RECEBIDO NUMERIC(18,6),
  TOTAL_TROCO NUMERIC(18,6),
  TOTAL_CANCELADO NUMERIC(18,6),
  STATUS_MOVIMENTO CHAR(1) NOT NULL,
  DATA_SINCRONIZACAO DATE,
  HORA_SINCRONIZACAO VARCHAR(8),
  CONSTRAINT pk_pdv_movimento PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PDV_VENDA_CABECALHO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PDV_VENDA_CABECALHO (
  ID SERIAL NOT NULL,
  NOME_CAIXA VARCHAR(30),
  ID_GERADO_CAIXA INTEGER,
  ID_EMPRESA INTEGER,
  ID_CLIENTE INTEGER,
  ID_PDV_FUNCIONARIO INTEGER,
  ID_PDV_MOVIMENTO INTEGER,
  ID_ECF_DAV INTEGER,
  ID_ECF_PRE_VENDA_CABECALHO INTEGER,
  SERIE_ECF VARCHAR(20),
  CFOP INTEGER,
  COO INTEGER,
  CCF INTEGER,
  DATA_VENDA DATE,
  HORA_VENDA VARCHAR(8),
  VALOR_VENDA NUMERIC(18,6),
  TAXA_DESCONTO NUMERIC(18,6),
  DESCONTO NUMERIC(18,6),
  TAXA_ACRESCIMO NUMERIC(18,6),
  ACRESCIMO NUMERIC(18,6),
  VALOR_FINAL NUMERIC(18,6),
  VALOR_RECEBIDO NUMERIC(18,6),
  TROCO NUMERIC(18,6),
  VALOR_CANCELADO NUMERIC(18,6),
  TOTAL_PRODUTOS NUMERIC(18,6),
  TOTAL_DOCUMENTO NUMERIC(18,6),
  BASE_ICMS NUMERIC(18,6),
  ICMS NUMERIC(18,6),
  ICMS_OUTRAS NUMERIC(18,6),
  ISSQN NUMERIC(18,6),
  PIS NUMERIC(18,6),
  COFINS NUMERIC(18,6),
  ACRESCIMO_ITENS NUMERIC(18,6),
  DESCONTO_ITENS NUMERIC(18,6),
  STATUS_VENDA CHAR(1),
  NOME_CLIENTE VARCHAR(100),
  CPF_CNPJ_CLIENTE VARCHAR(14),
  CUPOM_CANCELADO CHAR(1),
  HASH_REGISTRO VARCHAR(32),
  DATA_SINCRONIZACAO DATE,
  HORA_SINCRONIZACAO VARCHAR(8),
  CONSTRAINT pk_pdv_venda_cabecalho PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PDV_VENDA_DETALHE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PDV_VENDA_DETALHE (
  ID SERIAL NOT NULL,
  NOME_CAIXA VARCHAR(30),
  ID_GERADO_CAIXA INTEGER,
  ID_EMPRESA INTEGER,
  ID_PRODUTO INTEGER,
  ID_PDV_VENDA_CABECALHO INTEGER,
  CFOP INTEGER,
  GTIN VARCHAR(14),
  CCF INTEGER,
  COO INTEGER,
  SERIE_ECF VARCHAR(20),
  ITEM INTEGER,
  QUANTIDADE NUMERIC(18,6),
  VALOR_UNITARIO NUMERIC(18,6),
  VALOR_TOTAL NUMERIC(18,6),
  TOTAL_ITEM NUMERIC(18,6),
  BASE_ICMS NUMERIC(18,6),
  TAXA_ICMS NUMERIC(18,6),
  ICMS NUMERIC(18,6),
  TAXA_DESCONTO NUMERIC(18,6),
  DESCONTO NUMERIC(18,6),
  TAXA_ISSQN NUMERIC(18,6),
  ISSQN NUMERIC(18,6),
  TAXA_PIS NUMERIC(18,6),
  PIS NUMERIC(18,6),
  TAXA_COFINS NUMERIC(18,6),
  COFINS NUMERIC(18,6),
  TAXA_ACRESCIMO NUMERIC(18,6),
  ACRESCIMO NUMERIC(18,6),
  ACRESCIMO_RATEIO NUMERIC(18,6),
  DESCONTO_RATEIO NUMERIC(18,6),
  TOTALIZADOR_PARCIAL VARCHAR(10),
  CST CHAR(3),
  CANCELADO CHAR(1),
  MOVIMENTA_ESTOQUE CHAR(1),
  ECF_ICMS_ST VARCHAR(4),
  HASH_REGISTRO VARCHAR(32),
  DATA_SINCRONIZACAO DATE,
  HORA_SINCRONIZACAO VARCHAR(8),
  CONSTRAINT pk_pdv_venda_detalhe PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PDV_TOTAL_TIPO_PAGAMENTO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PDV_TOTAL_TIPO_PAGAMENTO (
  ID SERIAL NOT NULL,
  NOME_CAIXA VARCHAR(30),
  ID_GERADO_CAIXA INTEGER,
  ID_EMPRESA INTEGER,
  ID_PDV_VENDA_CABECALHO INTEGER,
  ID_PDV_TIPO_PAGAMENTO INTEGER,
  SERIE_ECF VARCHAR(20),
  COO INTEGER,
  CCF INTEGER,
  GNF INTEGER,
  VALOR NUMERIC(18,6),
  NSU VARCHAR(30),
  ESTORNO CHAR(1),
  REDE VARCHAR(10),
  CARTAO_DC CHAR(1),
  DATA_VENDA DATE,
  HASH_REGISTRO VARCHAR(32),
  DATA_SINCRONIZACAO DATE,
  HORA_SINCRONIZACAO VARCHAR(8),
  CONSTRAINT pk_pdv_total_tipo_pagamento PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PDV_CONFIGURACAO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PDV_CONFIGURACAO (
  ID SERIAL NOT NULL,
  NOME_CAIXA VARCHAR(30),
  ID_GERADO_CAIXA INTEGER,
  ID_EMPRESA INTEGER,
  ID_ECF_IMPRESSORA INTEGER,
  ID_PDV_CAIXA INTEGER,
  MENSAGEM_CUPOM VARCHAR(250),
  PORTA_ECF CHAR(10),
  IP_SERVIDOR VARCHAR(15),
  IP_SITEF VARCHAR(15),
  TIPO_TEF CHAR(2),
  TITULO_TELA_CAIXA VARCHAR(100),
  CAMINHO_IMAGENS_PRODUTOS VARCHAR(250),
  CAMINHO_IMAGENS_MARKETING VARCHAR(250),
  COR_JANELAS_INTERNAS VARCHAR(20),
  MARKETING_ATIVO CHAR(1),
  CFOP_ECF INTEGER,
  TIMEOUT_ECF INTEGER,
  INTERVALO_ECF INTEGER,
  DESCRICAO_SUPRIMENTO VARCHAR(20),
  DESCRICAO_SANGRIA VARCHAR(20),
  TEF_TIPO_GP INTEGER,
  TEF_TEMPO_ESPERA INTEGER,
  TEF_ESPERA_STS INTEGER,
  TEF_NUMERO_VIAS INTEGER,
  DECIMAIS_QUANTIDADE INTEGER,
  DECIMAIS_VALOR INTEGER,
  BITS_POR_SEGUNDO INTEGER,
  QTDE_MAXIMA_CARTOES INTEGER,
  PESQUISA_PARTE CHAR(1),
  CONFIGURACAO_BALANCA VARCHAR(100),
  PARAMETROS_DIVERSOS VARCHAR(250),
  ULTIMA_EXCLUSAO INTEGER,
  LAUDO VARCHAR(10),
  INDICE_GERENCIAL VARCHAR(100),
  DATA_ATUALIZACAO_ESTOQUE DATE,
  DATA_SINCRONIZACAO DATE,
  HORA_SINCRONIZACAO VARCHAR(8),
  CONSTRAINT pk_pdv_configuracao PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- ECF_DOCUMENTOS_EMITIDOS
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ECF_DOCUMENTOS_EMITIDOS (
  ID SERIAL NOT NULL,
  NOME_CAIXA VARCHAR(30),
  ID_GERADO_CAIXA INTEGER,
  ID_EMPRESA INTEGER,
  ID_PDV_MOVIMENTO INTEGER,
  DATA_EMISSAO DATE,
  HORA_EMISSAO VARCHAR(8),
  TIPO CHAR(2),
  COO INTEGER,
  DATA_SINCRONIZACAO DATE,
  HORA_SINCRONIZACAO VARCHAR(8),
  CONSTRAINT pk_ecf_documentos_emitidos PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PDV_FECHAMENTO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PDV_FECHAMENTO (
  ID SERIAL NOT NULL,
  NOME_CAIXA VARCHAR(30),
  ID_GERADO_CAIXA INTEGER,
  ID_EMPRESA INTEGER,
  ID_PDV_MOVIMENTO INTEGER,
  TIPO_PAGAMENTO VARCHAR(20),
  VALOR NUMERIC(18,6),
  DATA_SINCRONIZACAO DATE,
  HORA_SINCRONIZACAO VARCHAR(8),
  CONSTRAINT pk_pdv_fechamento PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- ECF_RECEBIMENTO_NAO_FISCAL
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ECF_RECEBIMENTO_NAO_FISCAL (
  ID SERIAL NOT NULL,
  NOME_CAIXA VARCHAR(30),
  ID_GERADO_CAIXA INTEGER,
  ID_EMPRESA INTEGER,
  ID_PDV_MOVIMENTO INTEGER,
  DATA_RECEBIMENTO DATE,
  DESCRICAO VARCHAR(50),
  VALOR NUMERIC(18,6),
  DATA_SINCRONIZACAO DATE,
  HORA_SINCRONIZACAO VARCHAR(8),
  CONSTRAINT pk_ecf_recebimento_nao_fiscal PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PDV_SUPRIMENTO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PDV_SUPRIMENTO (
  ID SERIAL NOT NULL,
  NOME_CAIXA VARCHAR(30),
  ID_GERADO_CAIXA INTEGER,
  ID_EMPRESA INTEGER,
  ID_PDV_MOVIMENTO INTEGER,
  DATA_SUPRIMENTO DATE,
  VALOR NUMERIC(18,6),
  DATA_SINCRONIZACAO DATE,
  HORA_SINCRONIZACAO VARCHAR(8),
  CONSTRAINT pk_pdv_suprimento PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- ECF_R02
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ECF_R02 (
  ID SERIAL NOT NULL,
  NOME_CAIXA VARCHAR(30),
  ID_GERADO_CAIXA INTEGER,
  ID_EMPRESA INTEGER,
  ID_PDV_OPERADOR INTEGER NOT NULL,
  ID_ECF_IMPRESSORA INTEGER NOT NULL,
  ID_PDV_CAIXA INTEGER,
  SERIE_ECF VARCHAR(20),
  CRZ INTEGER,
  COO INTEGER,
  CRO INTEGER,
  DATA_MOVIMENTO DATE,
  DATA_EMISSAO DATE,
  HORA_EMISSAO VARCHAR(8),
  VENDA_BRUTA NUMERIC(18,6),
  GRANDE_TOTAL NUMERIC(18,6),
  HASH_REGISTRO VARCHAR(32),
  DATA_SINCRONIZACAO DATE,
  HORA_SINCRONIZACAO VARCHAR(8),
  CONSTRAINT pk_ecf_r02 PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- ECF_R03
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ECF_R03 (
  ID SERIAL NOT NULL,
  NOME_CAIXA VARCHAR(30),
  ID_GERADO_CAIXA INTEGER,
  ID_EMPRESA INTEGER,
  ID_ECF_R02 INTEGER,
  SERIE_ECF VARCHAR(20),
  TOTALIZADOR_PARCIAL VARCHAR(10),
  VALOR_ACUMULADO NUMERIC(18,6),
  CRZ INTEGER,
  HASH_REGISTRO VARCHAR(32),
  DATA_SINCRONIZACAO DATE,
  HORA_SINCRONIZACAO VARCHAR(8),
  CONSTRAINT pk_ecf_r03 PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- ECF_R06
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ECF_R06 (
  ID SERIAL NOT NULL,
  NOME_CAIXA VARCHAR(30),
  ID_GERADO_CAIXA INTEGER,
  ID_EMPRESA INTEGER,
  ID_PDV_OPERADOR INTEGER NOT NULL,
  ID_ECF_IMPRESSORA INTEGER NOT NULL,
  ID_PDV_CAIXA INTEGER,
  SERIE_ECF VARCHAR(20),
  COO INTEGER,
  GNF INTEGER,
  GRG INTEGER,
  CDC INTEGER,
  DENOMINACAO CHAR(2),
  DATA_EMISSAO DATE,
  HORA_EMISSAO VARCHAR(8),
  HASH_REGISTRO VARCHAR(32),
  DATA_SINCRONIZACAO DATE,
  HORA_SINCRONIZACAO VARCHAR(8),
  CONSTRAINT pk_ecf_r06 PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- ECF_R07
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ECF_R07 (
  ID SERIAL NOT NULL,
  NOME_CAIXA VARCHAR(8),
  ID_GERADO_CAIXA INTEGER,
  ID_EMPRESA INTEGER,
  ID_ECF_R06 INTEGER,
  CCF INTEGER,
  MEIO_PAGAMENTO VARCHAR(20),
  VALOR_PAGAMENTO NUMERIC(18,6),
  ESTORNO CHAR(1),
  VALOR_ESTORNO NUMERIC(18,6),
  HASH_REGISTRO VARCHAR(32),
  DATA_SINCRONIZACAO DATE,
  HORA_SINCRONIZACAO VARCHAR(8),
  CONSTRAINT pk_ecf_r07 PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- SEFIP_CODIGO_RECOLHIMENTO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS SEFIP_CODIGO_RECOLHIMENTO (
  ID SERIAL NOT NULL,
  CODIGO INTEGER,
  DESCRICAO TEXT,
  APLICACAO TEXT,
  CONSTRAINT pk_sefip_codigo_recolhimento PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- SEFIP_CATEGORIA_TRABALHO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS SEFIP_CATEGORIA_TRABALHO (
  ID SERIAL NOT NULL,
  CODIGO INTEGER,
  NOME TEXT,
  CONSTRAINT pk_sefip_categoria_trabalho PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- SEFIP_CODIGO_MOVIMENTACAO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS SEFIP_CODIGO_MOVIMENTACAO (
  ID SERIAL NOT NULL,
  CODIGO CHAR(2),
  DESCRICAO TEXT,
  APLICACAO TEXT,
  CONSTRAINT pk_sefip_codigo_movimentacao PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- FPAS
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FPAS (
  ID SERIAL NOT NULL,
  CODIGO INTEGER,
  CNAE VARCHAR(14),
  ALIQUOTA_SAT NUMERIC(18,2),
  DESCRICAO VARCHAR(250),
  PERCENTUAL_INSS_PATRONAL NUMERIC(18,6),
  CODIGO_TERCEIRO CHAR(4),
  PERCENTUAL_TERCEIROS NUMERIC(18,6),
  CONSTRAINT pk_fpas PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CODIGO_GPS
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CODIGO_GPS (
  ID SERIAL NOT NULL,
  CODIGO INTEGER,
  DESCRICAO VARCHAR(250),
  CONSTRAINT pk_codigo_gps PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- FAP
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FAP (
  ID SERIAL NOT NULL,
  FAP NUMERIC(18,6),
  DATA_INICIAL DATE,
  DATA_FINAL DATE,
  CONSTRAINT pk_fap PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- TIPO_RECEITA_DACON
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS TIPO_RECEITA_DACON (
  ID SERIAL NOT NULL,
  CODIGO INTEGER,
  DESCRICAO VARCHAR(50),
  OBSERVACAO TEXT,
  CONSTRAINT pk_tipo_receita_dacon PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- EFD_TABELA_435
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS EFD_TABELA_435 (
  ID SERIAL NOT NULL,
  CODIGO CHAR(2),
  DESCRICAO VARCHAR(100),
  CONSTRAINT pk_efd_tabela_435 PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- COD_APURACAO_RECEITA_DACON
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS COD_APURACAO_RECEITA_DACON (
  ID SERIAL NOT NULL,
  ID_CODIGO_APURACAO_EFD INTEGER NOT NULL,
  ID_TIPO_RECEITA_DACON INTEGER NOT NULL,
  CONSTRAINT pk_cod_apuracao_receita_dacon PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- TIPO_RECEITA_DIPI
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS TIPO_RECEITA_DIPI (
  ID SERIAL NOT NULL,
  DESCRICAO VARCHAR(100),
  CONSTRAINT pk_tipo_receita_dipi PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- ORCAMENTO_FLUXO_CAIXA_PERIODO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ORCAMENTO_FLUXO_CAIXA_PERIODO (
  ID SERIAL NOT NULL,
  ID_BANCO_CONTA_CAIXA INTEGER NOT NULL,
  PERIODO CHAR(2),
  NOME VARCHAR(30),
  CONSTRAINT pk_orcamento_fluxo_caixa_periodo PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- ORCAMENTO_FLUXO_CAIXA
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ORCAMENTO_FLUXO_CAIXA (
  ID SERIAL NOT NULL,
  ID_ORC_FLUXO_CAIXA_PERIODO INTEGER NOT NULL,
  NOME VARCHAR(30),
  DESCRICAO TEXT,
  DATA_INICIAL DATE,
  NUMERO_PERIODOS INTEGER,
  DATA_BASE DATE,
  CONSTRAINT pk_orcamento_fluxo_caixa PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- ORCAMENTO_FLUXO_CAIXA_DETALHE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ORCAMENTO_FLUXO_CAIXA_DETALHE (
  ID SERIAL NOT NULL,
  ID_ORCAMENTO_FLUXO_CAIXA INTEGER NOT NULL,
  ID_FIN_NATUREZA_FINANCEIRA INTEGER NOT NULL,
  PERIODO VARCHAR(10),
  VALOR_ORCADO NUMERIC(18,6),
  VALOR_REALIZADO NUMERIC(18,6),
  TAXA_VARIACAO NUMERIC(18,6),
  VALOR_VARIACAO NUMERIC(18,6),
  CONSTRAINT pk_orcamento_fluxo_caixa_detalhe PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- REGISTRO_CARTORIO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS REGISTRO_CARTORIO (
  ID SERIAL NOT NULL,
  NOME_CARTORIO VARCHAR(100),
  DATA_REGISTRO DATE,
  NUMERO INTEGER,
  FOLHA INTEGER,
  LIVRO INTEGER,
  NIRE VARCHAR(11),
  CONSTRAINT pk_registro_cartorio PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CONTABIL_PARAMETRO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CONTABIL_PARAMETRO (
  ID SERIAL NOT NULL,
  MASCARA VARCHAR(30),
  NIVEIS INTEGER,
  INFORMAR_CONTA_POR CHAR(1),
  COMPARTILHA_PLANO_CONTA CHAR(1),
  COMPARTILHA_HISTORICOS CHAR(1),
  ALTERA_LANCAMENTO_OUTRO CHAR(1),
  HISTORICO_OBRIGATORIO CHAR(1),
  PERMITE_LANCAMENTO_ZERADO CHAR(1),
  GERA_INFORMATIVO_SPED CHAR(1),
  SPED_FORMA_ESCRIT_DIARIO CHAR(3),
  SPED_NOME_LIVRO_DIARIO VARCHAR(100),
  ASSINATURA_DIREITA TEXT,
  ASSINATURA_ESQUERDA TEXT,
  CONTA_ATIVO VARCHAR(30),
  CONTA_PASSIVO VARCHAR(30),
  CONTA_PATRIMONIO_LIQUIDO VARCHAR(30),
  CONTA_DEPRECIACAO_ACUMULADA VARCHAR(30),
  CONTA_CAPITAL_SOCIAL VARCHAR(30),
  CONTA_RESULTADO_EXERCICIO VARCHAR(30),
  CONTA_PREJUIZO_ACUMULADO VARCHAR(30),
  CONTA_LUCRO_ACUMULADO VARCHAR(30),
  CONTA_TITULO_PAGAR VARCHAR(30),
  CONTA_TITULO_RECEBER VARCHAR(30),
  CONTA_JUROS_PASSIVO VARCHAR(30),
  CONTA_JUROS_ATIVO VARCHAR(30),
  CONTA_DESCONTO_OBTIDO VARCHAR(30),
  CONTA_DESCONTO_CONCEDIDO VARCHAR(30),
  CONTA_CMV VARCHAR(30),
  CONTA_VENDA VARCHAR(30),
  CONTA_VENDA_SERVICO VARCHAR(30),
  CONTA_ESTOQUE VARCHAR(30),
  CONTA_APURA_RESULTADO VARCHAR(30),
  CONTA_JUROS_APROPRIAR VARCHAR(30),
  ID_HIST_PADRAO_RESULTADO INTEGER,
  ID_HIST_PADRAO_LUCRO INTEGER,
  ID_HIST_PADRAO_PREJUIZO INTEGER,
  CONSTRAINT pk_contabil_parametro PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CONTABIL_CONTA
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CONTABIL_CONTA (
  ID SERIAL NOT NULL,
  ID_PLANO_CONTA INTEGER NOT NULL,
  ID_CONTABIL_CONTA INTEGER,
  ID_PLANO_CONTA_REF_SPED INTEGER NOT NULL,
  CLASSIFICACAO VARCHAR(30),
  TIPO CHAR(1),
  DESCRICAO VARCHAR(100),
  DATA_INCLUSAO DATE,
  SITUACAO CHAR(1),
  NATUREZA CHAR(1),
  PATRIMONIO_RESULTADO CHAR(1),
  LIVRO_CAIXA CHAR(1),
  DFC CHAR(1),
  ORDEM VARCHAR(20),
  CODIGO_REDUZIDO VARCHAR(10),
  CODIGO_EFD CHAR(2),
  CONSTRAINT pk_contabil_conta PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CONTABIL_HISTORICO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CONTABIL_HISTORICO (
  ID SERIAL NOT NULL,
  DESCRICAO VARCHAR(100),
  HISTORICO VARCHAR(250),
  PEDE_COMPLEMENTO CHAR(1),
  CONSTRAINT pk_contabil_historico PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CONTABIL_LANCAMENTO_PADRAO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CONTABIL_LANCAMENTO_PADRAO (
  ID SERIAL NOT NULL,
  DESCRICAO VARCHAR(100),
  HISTORICO VARCHAR(250),
  ID_CONTA_DEBITO INTEGER,
  ID_CONTA_CREDITO INTEGER,
  CONSTRAINT pk_contabil_lancamento_padrao PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CONTABIL_LANCAMENTO_CABECALHO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CONTABIL_LANCAMENTO_CABECALHO (
  ID SERIAL NOT NULL,
  ID_CONTABIL_LOTE INTEGER,
  DATA_LANCAMENTO DATE,
  DATA_INCLUSAO DATE,
  TIPO CHAR(4),
  LIBERADO CHAR(1),
  VALOR NUMERIC(18,6),
  CONSTRAINT pk_contabil_lancamento_cabecalho PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CONTABIL_LANCAMENTO_DETALHE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CONTABIL_LANCAMENTO_DETALHE (
  ID SERIAL NOT NULL,
  ID_CONTABIL_CONTA INTEGER NOT NULL,
  ID_CONTABIL_HISTORICO INTEGER,
  ID_CONTABIL_LANCAMENTO_CAB INTEGER NOT NULL,
  HISTORICO VARCHAR(250),
  VALOR NUMERIC(18,6),
  TIPO CHAR(1),
  CONSTRAINT pk_contabil_lancamento_detalhe PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CONTABIL_LANCAMENTO_ORCADO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CONTABIL_LANCAMENTO_ORCADO (
  ID SERIAL NOT NULL,
  ID_CONTABIL_CONTA INTEGER NOT NULL,
  ANO CHAR(4),
  JANEIRO NUMERIC(18,6),
  FEVEREIRO NUMERIC(18,6),
  MARCO NUMERIC(18,6),
  ABRIL NUMERIC(18,6),
  MAIO NUMERIC(18,6),
  JUNHO NUMERIC(18,6),
  JULHO NUMERIC(18,6),
  AGOSTO NUMERIC(18,6),
  SETEMBRO NUMERIC(18,6),
  OUTUBRO NUMERIC(18,6),
  NOVEMBRO NUMERIC(18,6),
  DEZEMBRO NUMERIC(18,6),
  CONSTRAINT pk_contabil_lancamento_orcado PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PLANO_CONTA_REF_SPED
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PLANO_CONTA_REF_SPED (
  ID SERIAL NOT NULL,
  COD_CTA_REF VARCHAR(30),
  DESCRICAO TEXT,
  ORIENTACOES TEXT,
  INICIO_VALIDADE DATE,
  FIM_VALIDADE DATE,
  TIPO CHAR(1),
  CONSTRAINT pk_plano_conta_ref_sped PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CONTABIL_LOTE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CONTABIL_LOTE (
  ID SERIAL NOT NULL,
  DESCRICAO VARCHAR(100),
  LIBERADO CHAR(1),
  DATA_INCLUSAO DATE,
  DATA_LIBERACAO DATE,
  PROGRAMADO CHAR(1),
  VALOR NUMERIC(18,6),
  CONSTRAINT pk_contabil_lote PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CONTABIL_DRE_CABECALHO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CONTABIL_DRE_CABECALHO (
  ID SERIAL NOT NULL,
  DESCRICAO VARCHAR(100),
  PADRAO CHAR(1),
  PERIODO_INICIAL VARCHAR(7),
  PERIODO_FINAL VARCHAR(7),
  CONSTRAINT pk_contabil_dre_cabecalho PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CONTABIL_DRE_DETALHE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CONTABIL_DRE_DETALHE (
  ID SERIAL NOT NULL,
  ID_CONTABIL_DRE_CABECALHO INTEGER NOT NULL,
  CLASSIFICACAO VARCHAR(30),
  DESCRICAO VARCHAR(100),
  FORMA_CALCULO CHAR(1),
  SINAL CHAR(1),
  NATUREZA CHAR(1),
  VALOR NUMERIC(18,6),
  CONSTRAINT pk_contabil_dre_detalhe PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CONTABIL_LIVRO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CONTABIL_LIVRO (
  ID SERIAL NOT NULL,
  DESCRICAO VARCHAR(50),
  COMPETENCIA VARCHAR(7),
  FORMA_ESCRITURACAO CHAR(1),
  CONSTRAINT pk_contabil_livro PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CONTABIL_TERMO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CONTABIL_TERMO (
  ID SERIAL NOT NULL,
  ID_CONTABIL_LIVRO INTEGER NOT NULL,
  ABERTURA_ENCERRAMENTO CHAR(1),
  NUMERO INTEGER,
  PAGINA_INICIAL INTEGER,
  PAGINA_FINAL INTEGER,
  REGISTRADO VARCHAR(100),
  NUMERO_REGISTRO VARCHAR(50),
  DATA_DESPACHO DATE,
  DATA_ABERTURA DATE,
  DATA_ENCERRAMENTO DATE,
  ESCRITURACAO_INICIO DATE,
  ESCRITURACAO_FIM DATE,
  TEXTO TEXT,
  CONSTRAINT pk_contabil_termo PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CONTABIL_ENCERRAMENTO_EXE_CAB
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CONTABIL_ENCERRAMENTO_EXE_CAB (
  ID SERIAL NOT NULL,
  DATA_INICIO DATE,
  DATA_FIM DATE,
  DATA_INCLUSAO DATE,
  MOTIVO VARCHAR(100),
  CONSTRAINT pk_contabil_encerramento_exe_cab PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CONTABIL_ENCERRAMENTO_EXE_DET
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CONTABIL_ENCERRAMENTO_EXE_DET (
  ID SERIAL NOT NULL,
  ID_CONTABIL_CONTA INTEGER NOT NULL,
  ID_CONTABIL_ENCERRAMENTO_EXE INTEGER NOT NULL,
  SALDO_ANTERIOR NUMERIC(18,6),
  VALOR_DEBITO NUMERIC(18,6),
  VALOR_CREDITO NUMERIC(18,6),
  SALDO NUMERIC(18,6),
  CONSTRAINT pk_contabil_encerramento_exe_det PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- LANCA_CENTRO_RESULTADO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS LANCA_CENTRO_RESULTADO (
  ID SERIAL NOT NULL,
  ID_CENTRO_RESULTADO INTEGER NOT NULL,
  VALOR NUMERIC(18,6),
  HISTORICO VARCHAR(250),
  DATA_LANCAMENTO DATE,
  DATA_INCLUSAO DATE,
  ORIGEM_DE_RATEIO CHAR(1),
  CONSTRAINT pk_lanca_centro_resultado PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CENTRO_RESULTADO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CENTRO_RESULTADO (
  ID SERIAL NOT NULL,
  ID_PLANO_CENTRO_RESULTADO INTEGER NOT NULL,
  CLASSIFICACAO VARCHAR(30),
  DESCRICAO VARCHAR(100),
  SOFRE_RATEIRO CHAR(1),
  CONSTRAINT pk_centro_resultado PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- RATEIO_CENTRO_RESULTADO_CAB
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS RATEIO_CENTRO_RESULTADO_CAB (
  ID SERIAL NOT NULL,
  ID_CENTRO_RESULTADO INTEGER NOT NULL,
  DESCRICAO VARCHAR(100),
  CONSTRAINT pk_rateio_centro_resultado_cab PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- RATEIO_CENTRO_RESULTADO_DET
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS RATEIO_CENTRO_RESULTADO_DET (
  ID SERIAL NOT NULL,
  ID_CENTRO_RESULTADO_DESTINO INTEGER NOT NULL,
  ID_RATEIO_CENTRO_RESUL_CAB INTEGER NOT NULL,
  PORCENTO_RATEIO NUMERIC(18,6),
  CONSTRAINT pk_rateio_centro_resultado_det PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PLANO_CONTA
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PLANO_CONTA (
  ID SERIAL NOT NULL,
  NOME VARCHAR(100),
  DATA_INCLUSAO DATE,
  MASCARA VARCHAR(50),
  NIVEIS INTEGER,
  CONSTRAINT pk_plano_conta PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PLANO_CENTRO_RESULTADO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PLANO_CENTRO_RESULTADO (
  ID SERIAL NOT NULL,
  NOME VARCHAR(100),
  MASCARA VARCHAR(50),
  NIVEIS INTEGER,
  DATA_INCLUSAO DATE,
  CONSTRAINT pk_plano_centro_resultado PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- ENCERRA_CENTRO_RESULTADO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ENCERRA_CENTRO_RESULTADO (
  ID SERIAL NOT NULL,
  ID_CENTRO_RESULTADO INTEGER NOT NULL,
  COMPETENCIA VARCHAR(7),
  VALOR_TOTAL NUMERIC(18,6),
  VALOR_SUB_RATEIO NUMERIC(18,6),
  CONSTRAINT pk_encerra_centro_resultado PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- FOLHA_LANCAMENTO_COMISSAO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FOLHA_LANCAMENTO_COMISSAO (
  ID SERIAL NOT NULL,
  ID_VENDEDOR INTEGER NOT NULL,
  COMPETENCIA VARCHAR(7),
  VENCIMENTO DATE,
  BASE_CALCULO NUMERIC(18,6),
  VALOR_COMISSAO NUMERIC(18,6),
  CONSTRAINT pk_folha_lancamento_comissao PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CONTABIL_CONTA_RATEIO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CONTABIL_CONTA_RATEIO (
  ID SERIAL NOT NULL,
  ID_CENTRO_RESULTADO INTEGER NOT NULL,
  ID_CONTABIL_CONTA INTEGER NOT NULL,
  PORCENTO_RATEIO NUMERIC(18,6),
  CONSTRAINT pk_contabil_conta_rateio PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- LOG_IMPORTACAO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS LOG_IMPORTACAO (
  ID SERIAL NOT NULL,
  DATA_IMPORTACAO DATE,
  HORA_IMPORTACAO VARCHAR(8),
  ERRO TEXT,
  REGISTRO TEXT,
  CONSTRAINT pk_log_importacao PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- LOG_EXPORTACAO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS LOG_EXPORTACAO (
  ID SERIAL NOT NULL,
  DATA_EXPORTACAO DATE,
  HORA_EXPORTACAO VARCHAR(8),
  ERRO TEXT,
  REGISTRO TEXT,
  CONSTRAINT pk_log_exportacao PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- INTEGRACAO_PDV
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS INTEGRACAO_PDV (
  ID SERIAL NOT NULL,
  IDENTIFICA VARCHAR(50),
  DATA_INTEGRACAO DATE,
  HORA_INTEGRACAO VARCHAR(8),
  CONSTRAINT pk_integracao_pdv PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- EFD_TABELA_436
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS EFD_TABELA_436 (
  ID SERIAL NOT NULL,
  CODIGO INTEGER,
  DESCRICAO VARCHAR(250),
  CONSTRAINT pk_efd_tabela_436 PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- EFD_TABELA_437
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS EFD_TABELA_437 (
  ID SERIAL NOT NULL,
  CODIGO CHAR(2),
  DESCRICAO VARCHAR(250),
  CONSTRAINT pk_efd_tabela_437 PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- EFD_TABELA_4316
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS EFD_TABELA_4316 (
  ID SERIAL NOT NULL,
  CODIGO INTEGER,
  DESCRICAO TEXT,
  OBSERVACAO TEXT,
  INICIO_VIGENCIA DATE,
  FIM_VIGENCIA DATE,
  CONSTRAINT pk_efd_tabela_4316 PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- EFD_TABELA_4315
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS EFD_TABELA_4315 (
  ID SERIAL NOT NULL,
  CODIGO INTEGER,
  DESCRICAO TEXT,
  OBSERVACAO TEXT,
  INICIO_VIGENCIA DATE,
  FIM_VIGENCIA DATE,
  CONSTRAINT pk_efd_tabela_4315 PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- EFD_TABELA_4314
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS EFD_TABELA_4314 (
  ID SERIAL NOT NULL,
  CODIGO INTEGER,
  DESCRICAO TEXT,
  OBSERVACAO TEXT,
  INICIO_VIGENCIA DATE,
  FIM_VIGENCIA DATE,
  CONSTRAINT pk_efd_tabela_4314 PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- EFD_TABELA_4313
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS EFD_TABELA_4313 (
  ID SERIAL NOT NULL,
  CODIGO INTEGER,
  DESCRICAO TEXT,
  OBSERVACAO TEXT,
  INICIO_VIGENCIA DATE,
  FIM_VIGENCIA DATE,
  CONSTRAINT pk_efd_tabela_4313 PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- EFD_TABELA_439
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS EFD_TABELA_439 (
  ID SERIAL NOT NULL,
  CODIGO INTEGER,
  DESCRICAO TEXT,
  OBSERVACAO TEXT,
  INICIO_VIGENCIA DATE,
  FIM_VIGENCIA DATE,
  CONSTRAINT pk_efd_tabela_439 PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- EFD_TABELA_4310
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS EFD_TABELA_4310 (
  ID SERIAL NOT NULL,
  CODIGO INTEGER,
  DESCRICAO TEXT,
  OBSERVACAO TEXT,
  INICIO_VIGENCIA DATE,
  FIM_VIGENCIA DATE,
  CONSTRAINT pk_efd_tabela_4310 PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- EMPRESA_CNAE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS EMPRESA_CNAE (
  ID SERIAL NOT NULL,
  ID_EMPRESA INTEGER NOT NULL,
  ID_CNAE INTEGER NOT NULL,
  PRINCIPAL CHAR(1),
  RAMO_ATIVIDADE VARCHAR(50),
  OBJETO_SOCIAL TEXT,
  CONSTRAINT pk_empresa_cnae PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- INVENTARIO_CONTAGEM_CAB
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS INVENTARIO_CONTAGEM_CAB (
  ID SERIAL NOT NULL,
  DATA_CONTAGEM DATE,
  ESTOQUE_ATUALIZADO CHAR(1),
  TIPO CHAR(1),
  CONSTRAINT pk_inventario_contagem_cab PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- INVENTARIO_CONTAGEM_DET
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS INVENTARIO_CONTAGEM_DET (
  ID SERIAL NOT NULL,
  ID_INVENTARIO_CONTAGEM_CAB INTEGER NOT NULL,
  ID_PRODUTO INTEGER NOT NULL,
  CONTAGEM01 NUMERIC(18,6),
  CONTAGEM02 NUMERIC(18,6),
  CONTAGEM03 NUMERIC(18,6),
  FECHADO_CONTAGEM CHAR(2),
  QUANTIDADE_SISTEMA NUMERIC(18,6),
  ACURACIDADE NUMERIC(18,6),
  DIVERGENCIA NUMERIC(18,6),
  CONSTRAINT pk_inventario_contagem_det PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- ORCAMENTO_EMPRESARIAL
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ORCAMENTO_EMPRESARIAL (
  ID SERIAL NOT NULL,
  ID_ORCAMENTO_PERIODO INTEGER NOT NULL,
  NOME VARCHAR(30),
  DESCRICAO TEXT,
  DATA_INICIAL DATE,
  NUMERO_PERIODOS INTEGER,
  DATA_BASE DATE,
  CONSTRAINT pk_orcamento_empresarial PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- ORCAMENTO_PERIODO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ORCAMENTO_PERIODO (
  ID SERIAL NOT NULL,
  PERIODO CHAR(2),
  NOME VARCHAR(30),
  CONSTRAINT pk_orcamento_periodo PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- ORCAMENTO_DETALHE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ORCAMENTO_DETALHE (
  ID SERIAL NOT NULL,
  ID_ORCAMENTO_EMPRESARIAL INTEGER NOT NULL,
  ID_FIN_NATUREZA_FINANCEIRA INTEGER NOT NULL,
  PERIODO VARCHAR(10),
  VALOR_ORCADO NUMERIC(18,6),
  VALOR_REALIZADO NUMERIC(18,6),
  TAXA_VARIACAO NUMERIC(18,6),
  VALOR_VARIACAO NUMERIC(18,6),
  CONSTRAINT pk_orcamento_detalhe PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PATRIM_INDICE_ATUALIZACAO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PATRIM_INDICE_ATUALIZACAO (
  ID SERIAL NOT NULL,
  DATA_INDICE DATE,
  NOME VARCHAR(10),
  VALOR NUMERIC(18,6),
  VALOR_ALTERNATIVO NUMERIC(18,6),
  CONSTRAINT pk_patrim_indice_atualizacao PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PATRIM_TAXA_DEPRECIACAO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PATRIM_TAXA_DEPRECIACAO (
  ID SERIAL NOT NULL,
  NCM VARCHAR(8),
  BEM VARCHAR(250),
  VIDA NUMERIC(18,6),
  TAXA NUMERIC(18,6),
  CONSTRAINT pk_patrim_taxa_depreciacao PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PATRIM_BEM
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PATRIM_BEM (
  ID SERIAL NOT NULL,
  ID_CENTRO_RESULTADO INTEGER NOT NULL,
  ID_PATRIM_TIPO_AQUISICAO_BEM INTEGER NOT NULL,
  ID_PATRIM_ESTADO_CONSERVACAO INTEGER NOT NULL,
  ID_PATRIM_GRUPO_BEM INTEGER NOT NULL,
  ID_FORNECEDOR INTEGER NOT NULL,
  ID_COLABORADOR INTEGER NOT NULL,
  ID_SETOR INTEGER NOT NULL,
  NUMERO_NB VARCHAR(20),
  NOME VARCHAR(100),
  DESCRICAO TEXT,
  NUMERO_SERIE VARCHAR(50),
  DATA_AQUISICAO DATE,
  DATA_ACEITE DATE,
  DATA_CADASTRO DATE,
  DATA_CONTABILIZADO DATE,
  DATA_VISTORIA DATE,
  DATA_MARCACAO DATE,
  DATA_BAIXA DATE,
  VENCIMENTO_GARANTIA DATE,
  NUMERO_NOTA_FISCAL VARCHAR(50),
  CHAVE_NFE VARCHAR(44),
  VALOR_ORIGINAL NUMERIC(18,6),
  VALOR_COMPRA NUMERIC(18,6),
  VALOR_ATUALIZADO NUMERIC(18,6),
  VALOR_BAIXA NUMERIC(18,6),
  DEPRECIA CHAR(1),
  METODO_DEPRECIACAO CHAR(1),
  INICIO_DEPRECIACAO DATE,
  ULTIMA_DEPRECIACAO DATE,
  TIPO_DEPRECIACAO CHAR(1),
  TAXA_ANUAL_DEPRECIACAO NUMERIC(18,6),
  TAXA_MENSAL_DEPRECIACAO NUMERIC(18,6),
  TAXA_DEPRECIACAO_ACELERADA NUMERIC(18,6),
  TAXA_DEPRECIACAO_INCENTIVADA NUMERIC(18,6),
  FUNCAO TEXT,
  CONSTRAINT pk_patrim_bem PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PATRIM_TIPO_AQUISICAO_BEM
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PATRIM_TIPO_AQUISICAO_BEM (
  ID SERIAL NOT NULL,
  TIPO CHAR(2),
  NOME VARCHAR(50),
  DESCRICAO TEXT,
  CONSTRAINT pk_patrim_tipo_aquisicao_bem PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- SEGURADORA
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS SEGURADORA (
  ID SERIAL NOT NULL,
  NOME VARCHAR(50),
  CONTATO VARCHAR(50),
  TELEFONE VARCHAR(14),
  CONSTRAINT pk_seguradora PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PATRIM_DOCUMENTO_BEM
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PATRIM_DOCUMENTO_BEM (
  ID SERIAL NOT NULL,
  ID_PATRIM_BEM INTEGER NOT NULL,
  NOME VARCHAR(50),
  DESCRICAO TEXT,
  IMAGEM TEXT,
  CONSTRAINT pk_patrim_documento_bem PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PATRIM_DEPRECIACAO_BEM
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PATRIM_DEPRECIACAO_BEM (
  ID SERIAL NOT NULL,
  ID_PATRIM_BEM INTEGER NOT NULL,
  DATA_DEPRECIACAO DATE,
  DIAS INTEGER,
  TAXA NUMERIC(18,6),
  INDICE NUMERIC(18,6),
  VALOR NUMERIC(18,6),
  DEPRECIACAO_ACUMULADA NUMERIC(18,6),
  CONSTRAINT pk_patrim_depreciacao_bem PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PATRIM_MOVIMENTACAO_BEM
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PATRIM_MOVIMENTACAO_BEM (
  ID SERIAL NOT NULL,
  ID_PATRIM_BEM INTEGER NOT NULL,
  ID_PATRIM_TIPO_MOVIMENTACAO INTEGER NOT NULL,
  DATA_MOVIMENTACAO DATE,
  RESPONSAVEL VARCHAR(50),
  CONSTRAINT pk_patrim_movimentacao_bem PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PATRIM_TIPO_MOVIMENTACAO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PATRIM_TIPO_MOVIMENTACAO (
  ID SERIAL NOT NULL,
  TIPO CHAR(2),
  NOME VARCHAR(50),
  DESCRICAO TEXT,
  CONSTRAINT pk_patrim_tipo_movimentacao PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PATRIM_ESTADO_CONSERVACAO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PATRIM_ESTADO_CONSERVACAO (
  ID SERIAL NOT NULL,
  CODIGO CHAR(2),
  NOME VARCHAR(50),
  DESCRICAO TEXT,
  CONSTRAINT pk_patrim_estado_conservacao PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PATRIM_APOLICE_SEGURO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PATRIM_APOLICE_SEGURO (
  ID SERIAL NOT NULL,
  ID_PATRIM_BEM INTEGER NOT NULL,
  ID_SEGURADORA INTEGER NOT NULL,
  NUMERO VARCHAR(20),
  DATA_CONTRATACAO DATE,
  DATA_VENCIMENTO DATE,
  VALOR_PREMIO NUMERIC(18,6),
  VALOR_SEGURADO NUMERIC(18,6),
  OBSERVACAO TEXT,
  IMAGEM TEXT,
  CONSTRAINT pk_patrim_apolice_seguro PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PATRIM_GRUPO_BEM
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PATRIM_GRUPO_BEM (
  ID SERIAL NOT NULL,
  CODIGO CHAR(3),
  NOME VARCHAR(50),
  DESCRICAO TEXT,
  CONTA_ATIVO_IMOBILIZADO VARCHAR(30),
  CONTA_DEPRECIACAO_ACUMULADA VARCHAR(30),
  CONTA_DESPESA_DEPRECIACAO VARCHAR(30),
  CODIGO_HISTORICO INTEGER,
  CONSTRAINT pk_patrim_grupo_bem PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- FISCAL_PARAMETRO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FISCAL_PARAMETRO (
  ID SERIAL NOT NULL,
  ID_FISCAL_ESTADUAL_PORTE INTEGER,
  ID_FISCAL_ESTADUAL_REGIME INTEGER,
  ID_FISCAL_MUNICIPAL_REGIME INTEGER,
  VIGENCIA VARCHAR(7),
  DESCRICAO_VIGENCIA VARCHAR(100),
  CRITERIO_LANCAMENTO CHAR(1),
  APURACAO CHAR(1),
  MICROEMPREE_INDIVIDUAL CHAR(1),
  CALC_PIS_COFINS_EFD CHAR(2),
  SIMPLES_CODIGO_ACESSO VARCHAR(50),
  SIMPLES_TABELA CHAR(1),
  SIMPLES_ATIVIDADE CHAR(2),
  PERFIL_SPED CHAR(1),
  APURACAO_CONSOLIDADA CHAR(1),
  SUBSTITUICAO_TRIBUTARIA CHAR(1),
  FORMA_CALCULO_ISS CHAR(2),
  CONSTRAINT pk_fiscal_parametro PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- FISCAL_LIVRO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FISCAL_LIVRO (
  ID SERIAL NOT NULL,
  DESCRICAO VARCHAR(50),
  CONSTRAINT pk_fiscal_livro PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- FISCAL_TERMO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FISCAL_TERMO (
  ID SERIAL NOT NULL,
  ID_FISCAL_LIVRO INTEGER NOT NULL,
  ABERTURA_ENCERRAMENTO CHAR(1),
  NUMERO INTEGER,
  PAGINA_INICIAL INTEGER,
  PAGINA_FINAL INTEGER,
  REGISTRADO VARCHAR(100),
  NUMERO_REGISTRO VARCHAR(50),
  DATA_DESPACHO DATE,
  DATA_ABERTURA DATE,
  DATA_ENCERRAMENTO DATE,
  ESCRITURACAO_INICIO DATE,
  ESCRITURACAO_FIM DATE,
  TEXTO TEXT,
  CONSTRAINT pk_fiscal_termo PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- FISCAL_ESTADUAL_REGIME
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FISCAL_ESTADUAL_REGIME (
  ID SERIAL NOT NULL,
  UF CHAR(2),
  CODIGO VARCHAR(20),
  NOME VARCHAR(50),
  CONSTRAINT pk_fiscal_estadual_regime PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- FISCAL_ESTADUAL_PORTE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FISCAL_ESTADUAL_PORTE (
  ID SERIAL NOT NULL,
  UF CHAR(2),
  CODIGO VARCHAR(20),
  NOME VARCHAR(50),
  CONSTRAINT pk_fiscal_estadual_porte PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- FISCAL_INSCRICOES_SUBSTITUTAS
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FISCAL_INSCRICOES_SUBSTITUTAS (
  ID SERIAL NOT NULL,
  ID_FISCAL_PARAMETROS INTEGER NOT NULL,
  UF CHAR(2),
  INSCRICAO_ESTADUAL VARCHAR(30),
  PMPF CHAR(1),
  CONSTRAINT pk_fiscal_inscricoes_substitutas PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- FISCAL_MUNICIPAL_REGIME
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FISCAL_MUNICIPAL_REGIME (
  ID SERIAL NOT NULL,
  UF CHAR(2),
  CODIGO VARCHAR(20),
  NOME VARCHAR(50),
  CONSTRAINT pk_fiscal_municipal_regime PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- SIMPLES_NACIONAL_CABECALHO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS SIMPLES_NACIONAL_CABECALHO (
  ID SERIAL NOT NULL,
  VIGENCIA_INICIAL DATE,
  VIGENCIA_FINAL DATE,
  ANEXO VARCHAR(10),
  TABELA VARCHAR(10),
  CONSTRAINT pk_simples_nacional_cabecalho PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- SIMPLES_NACIONAL_DETALHE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS SIMPLES_NACIONAL_DETALHE (
  ID SERIAL NOT NULL,
  ID_SIMPLES_NACIONAL_CABECALHO INTEGER NOT NULL,
  FAIXA INTEGER,
  VALOR_INICIAL NUMERIC(18,6),
  VALOR_FINAL NUMERIC(18,6),
  ALIQUOTA NUMERIC(18,6),
  IRPJ NUMERIC(18,6),
  CSLL NUMERIC(18,6),
  COFINS NUMERIC(18,6),
  PIS_PASEP NUMERIC(18,6),
  CPP NUMERIC(18,6),
  ICMS NUMERIC(18,6),
  IPI NUMERIC(18,6),
  ISS NUMERIC(18,6),
  CONSTRAINT pk_simples_nacional_detalhe PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- FISCAL_NOTA_FISCAL_ENTRADA
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FISCAL_NOTA_FISCAL_ENTRADA (
  ID SERIAL NOT NULL,
  ID_NFE_CABECALHO INTEGER NOT NULL,
  COMPETENCIA VARCHAR(7),
  CFOP_ENTRADA INTEGER,
  VALOR_RATEIO_FRETE NUMERIC(18,6),
  VALOR_CUSTO_MEDIO NUMERIC(18,6),
  VALOR_ICMS_ANTECIPADO NUMERIC(18,6),
  VALOR_BC_ICMS_ANTECIPADO NUMERIC(18,6),
  VALOR_BC_ICMS_CREDITADO NUMERIC(18,6),
  VALOR_BC_PIS_CREDITADO NUMERIC(18,6),
  VALOR_BC_COFINS_CREDITADO NUMERIC(18,6),
  VALOR_BC_IPI_CREDITADO NUMERIC(18,6),
  CST_CREDITO_ICMS CHAR(3),
  CST_CREDITO_PIS CHAR(2),
  CST_CREDITO_COFINS CHAR(2),
  CST_CREDITO_IPI CHAR(2),
  VALOR_ICMS_CREDITADO NUMERIC(18,6),
  VALOR_PIS_CREDITADO NUMERIC(18,6),
  VALOR_COFINS_CREDITADO NUMERIC(18,6),
  VALOR_IPI_CREDITADO NUMERIC(18,6),
  QTDE_PARCELA_CREDITO_PIS INTEGER,
  QTDE_PARCELA_CREDITO_COFINS INTEGER,
  QTDE_PARCELA_CREDITO_ICMS INTEGER,
  QTDE_PARCELA_CREDITO_IPI INTEGER,
  ALIQUOTA_CREDITO_ICMS NUMERIC(18,6),
  ALIQUOTA_CREDITO_PIS NUMERIC(18,6),
  ALIQUOTA_CREDITO_COFINS NUMERIC(18,6),
  ALIQUOTA_CREDITO_IPI NUMERIC(18,6),
  CONSTRAINT pk_fiscal_nota_fiscal_entrada PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- FOLHA_PARAMETRO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FOLHA_PARAMETRO (
  ID SERIAL NOT NULL,
  COMPETENCIA VARCHAR(7),
  CONTRIBUI_PIS CHAR(1),
  ALIQUOTA_PIS NUMERIC(18,6),
  DISCRIMINAR_DSR CHAR(1),
  DIA_PAGAMENTO CHAR(2),
  CALCULO_PROPORCIONALIDADE CHAR(1),
  DESCONTAR_FALTAS_13 CHAR(1),
  PAGAR_ADICIONAIS_13 CHAR(1),
  PAGAR_ESTAGIARIOS_13 CHAR(1),
  MES_ADIANTAMENTO_13 CHAR(2),
  PERCENTUAL_ADIANTAM_13 NUMERIC(18,6),
  FERIAS_DESCONTAR_FALTAS CHAR(1),
  FERIAS_PAGAR_ADICIONAIS CHAR(1),
  FERIAS_ADIANTAR_13 CHAR(1),
  FERIAS_PAGAR_ESTAGIARIOS CHAR(1),
  FERIAS_CALC_JUSTA_CAUSA CHAR(1),
  FERIAS_MOVIMENTO_MENSAL CHAR(1),
  CONSTRAINT pk_folha_parametro PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- GUIAS_ACUMULADAS
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS GUIAS_ACUMULADAS (
  ID SERIAL NOT NULL,
  GPS_TIPO CHAR(1),
  GPS_COMPETENCIA VARCHAR(7),
  GPS_VALOR_INSS NUMERIC(18,6),
  GPS_VALOR_OUTRAS_ENT NUMERIC(18,6),
  GPS_DATA_PAGAMENTO DATE,
  IRRF_COMPETENCIA VARCHAR(7),
  IRRF_CODIGO_RECOLHIMENTO INTEGER,
  IRRF_VALOR_ACUMULADO NUMERIC(18,6),
  IRRF_DATA_PAGAMENTO DATE,
  PIS_COMPETENCIA VARCHAR(7),
  PIS_VALOR_ACUMULADO NUMERIC(18,6),
  PIS_DATA_PAGAMENTO DATE,
  CONSTRAINT pk_guias_acumuladas PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- FOLHA_FECHAMENTO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FOLHA_FECHAMENTO (
  ID SERIAL NOT NULL,
  FECHAMENTO_ATUAL VARCHAR(7),
  PROXIMO_FECHAMENTO VARCHAR(7),
  CONSTRAINT pk_folha_fechamento PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- FERIAS_PERIODO_AQUISITIVO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FERIAS_PERIODO_AQUISITIVO (
  ID SERIAL NOT NULL,
  ID_COLABORADOR INTEGER NOT NULL,
  DATA_INICIO DATE,
  DATA_FIM DATE,
  SITUACAO CHAR(1),
  LIMITE_PARA_GOZO DATE,
  DESCONTAR_FALTAS CHAR(1),
  DESCONSIDERAR_AFASTAMENTO CHAR(1),
  AFASTAMENTO_PREVIDENCIA INTEGER,
  AFASTAMENTO_SEM_REMUN INTEGER,
  AFASTAMENTO_COM_REMUN INTEGER,
  DIAS_DIREITO INTEGER,
  DIAS_GOZADOS INTEGER,
  DIAS_FALTAS INTEGER,
  DIAS_RESTANTES INTEGER,
  CONSTRAINT pk_ferias_periodo_aquisitivo PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- FOLHA_TIPO_AFASTAMENTO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FOLHA_TIPO_AFASTAMENTO (
  ID SERIAL NOT NULL,
  CODIGO CHAR(3),
  NOME VARCHAR(100),
  DESCRICAO TEXT,
  CODIGO_ESOCIAL CHAR(2),
  CONSTRAINT pk_folha_tipo_afastamento PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- FOLHA_AFASTAMENTO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FOLHA_AFASTAMENTO (
  ID SERIAL NOT NULL,
  ID_FOLHA_TIPO_AFASTAMENTO INTEGER NOT NULL,
  ID_COLABORADOR INTEGER NOT NULL,
  DATA_INICIO DATE,
  DATA_FIM DATE,
  DIAS_AFASTADO INTEGER,
  CONSTRAINT pk_folha_afastamento PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- FOLHA_PLANO_SAUDE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FOLHA_PLANO_SAUDE (
  ID SERIAL NOT NULL,
  ID_COLABORADOR INTEGER NOT NULL,
  ID_OPERADORA_PLANO_SAUDE INTEGER NOT NULL,
  DATA_INICIO DATE,
  BENEFICIARIO CHAR(1),
  CONSTRAINT pk_folha_plano_saude PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- FOLHA_EVENTO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FOLHA_EVENTO (
  ID SERIAL NOT NULL,
  CODIGO CHAR(3),
  NOME VARCHAR(100),
  DESCRICAO TEXT,
  TIPO CHAR(1),
  UNIDADE CHAR(1),
  BASE_CALCULO CHAR(2),
  TAXA NUMERIC(18,6),
  RUBRICA_ESOCIAL CHAR(4),
  COD_INCIDENCIA_PREVIDENCIA CHAR(2),
  COD_INCIDENCIA_IRRF CHAR(2),
  COD_INCIDENCIA_FGTS CHAR(2),
  COD_INCIDENCIA_SINDICATO CHAR(2),
  REPERCUTE_DSR CHAR(1),
  REPERCUTE_13 CHAR(1),
  REPERCUTE_FERIAS CHAR(1),
  REPERCUTE_AVISO CHAR(1),
  CONSTRAINT pk_folha_evento PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- FOLHA_RESCISAO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FOLHA_RESCISAO (
  ID SERIAL NOT NULL,
  ID_COLABORADOR INTEGER NOT NULL,
  DATA_DEMISSAO DATE,
  DATA_PAGAMENTO DATE,
  MOTIVO VARCHAR(100),
  MOTIVO_ESOCIAL CHAR(2),
  DATA_AVISO_PREVIO DATE,
  DIAS_AVISO_PREVIO INTEGER,
  COMPROVOU_NOVO_EMPREGO CHAR(1),
  DISPENSOU_EMPREGADO CHAR(1),
  PENSAO_ALIMENTICIA NUMERIC(18,6),
  PENSAO_ALIMENTICIA_FGTS NUMERIC(18,6),
  FGTS_VALOR_RESCISAO NUMERIC(18,6),
  FGTS_SALDO_BANCO NUMERIC(18,6),
  FGTS_COMPLEMENTO_SALDO NUMERIC(18,6),
  FGTS_CODIGO_AFASTAMENTO VARCHAR(10),
  FGTS_CODIGO_SAQUE VARCHAR(10),
  CONSTRAINT pk_folha_rescisao PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- FOLHA_LANCAMENTO_CABECALHO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FOLHA_LANCAMENTO_CABECALHO (
  ID SERIAL NOT NULL,
  ID_COLABORADOR INTEGER NOT NULL,
  COMPETENCIA VARCHAR(7),
  TIPO CHAR(1),
  CONSTRAINT pk_folha_lancamento_cabecalho PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- FOLHA_LANCAMENTO_DETALHE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FOLHA_LANCAMENTO_DETALHE (
  ID SERIAL NOT NULL,
  ID_FOLHA_EVENTO INTEGER NOT NULL,
  ID_FOLHA_LANCAMENTO_CABECALHO INTEGER NOT NULL,
  ORIGEM NUMERIC(18,6),
  PROVENTO NUMERIC(18,6),
  DESCONTO NUMERIC(18,6),
  CONSTRAINT pk_folha_lancamento_detalhe PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- FOLHA_FERIAS_COLETIVAS
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FOLHA_FERIAS_COLETIVAS (
  ID SERIAL NOT NULL,
  DATA_INICIO DATE,
  DATA_FIM DATE,
  DIAS_GOZO INTEGER,
  ABONO_PECUNIARIO_INICIO DATE,
  ABONO_PECUNIARIO_FIM DATE,
  DIAS_ABONO INTEGER,
  DATA_PAGAMENTO DATE,
  CONSTRAINT pk_folha_ferias_coletivas PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- FOLHA_VALE_TRANSPORTE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FOLHA_VALE_TRANSPORTE (
  ID SERIAL NOT NULL,
  ID_EMPRESA_TRANSP_ITIN INTEGER NOT NULL,
  ID_COLABORADOR INTEGER NOT NULL,
  QUANTIDADE INTEGER,
  CONSTRAINT pk_folha_vale_transporte PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- FOLHA_INSS
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FOLHA_INSS (
  ID SERIAL NOT NULL,
  COMPETENCIA VARCHAR(7),
  CONSTRAINT pk_folha_inss PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- FOLHA_INSS_RETENCAO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FOLHA_INSS_RETENCAO (
  ID SERIAL NOT NULL,
  ID_FOLHA_INSS INTEGER NOT NULL,
  ID_FOLHA_INSS_SERVICO INTEGER NOT NULL,
  VALOR_MENSAL NUMERIC(18,6),
  VALOR_13 NUMERIC(18,6),
  CONSTRAINT pk_folha_inss_retencao PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- FOLHA_INSS_SERVICO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FOLHA_INSS_SERVICO (
  ID SERIAL NOT NULL,
  CODIGO CHAR(3),
  NOME VARCHAR(100),
  CONSTRAINT pk_folha_inss_servico PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- FOLHA_PPP
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FOLHA_PPP (
  ID SERIAL NOT NULL,
  ID_COLABORADOR INTEGER NOT NULL,
  OBSERVACAO TEXT,
  CONSTRAINT pk_folha_ppp PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- FOLHA_PPP_CAT
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FOLHA_PPP_CAT (
  ID SERIAL NOT NULL,
  ID_FOLHA_PPP INTEGER NOT NULL,
  NUMERO_CAT INTEGER,
  DATA_AFASTAMENTO DATE,
  DATA_REGISTRO DATE,
  CONSTRAINT pk_folha_ppp_cat PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- FOLHA_PPP_ATIVIDADE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FOLHA_PPP_ATIVIDADE (
  ID SERIAL NOT NULL,
  ID_FOLHA_PPP INTEGER NOT NULL,
  DATA_INICIO DATE,
  DATA_FIM DATE,
  DESCRICAO TEXT,
  CONSTRAINT pk_folha_ppp_atividade PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- FOLHA_PPP_FATOR_RISCO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FOLHA_PPP_FATOR_RISCO (
  ID SERIAL NOT NULL,
  ID_FOLHA_PPP INTEGER NOT NULL,
  DATA_INICIO DATE,
  DATA_FIM DATE,
  TIPO CHAR(1),
  FATOR_RISCO VARCHAR(40),
  INTENSIDADE VARCHAR(15),
  TECNICA_UTILIZADA VARCHAR(40),
  EPC_EFICAZ CHAR(1),
  EPI_EFICAZ CHAR(1),
  CA_EPI INTEGER,
  ATENDIMENTO_NR06_1 CHAR(1),
  ATENDIMENTO_NR06_2 CHAR(1),
  ATENDIMENTO_NR06_3 CHAR(1),
  ATENDIMENTO_NR06_4 CHAR(1),
  ATENDIMENTO_NR06_5 CHAR(1),
  CONSTRAINT pk_folha_ppp_fator_risco PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- FOLHA_PPP_EXAME_MEDICO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FOLHA_PPP_EXAME_MEDICO (
  ID SERIAL NOT NULL,
  ID_FOLHA_PPP INTEGER NOT NULL,
  DATA_ULTIMO DATE,
  TIPO CHAR(1),
  NATUREZA VARCHAR(50),
  EXAME CHAR(1),
  INDICACAO_RESULTADOS VARCHAR(50),
  CONSTRAINT pk_folha_ppp_exame_medico PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- FOLHA_HISTORICO_SALARIAL
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FOLHA_HISTORICO_SALARIAL (
  ID SERIAL NOT NULL,
  ID_COLABORADOR INTEGER NOT NULL,
  COMPETENCIA VARCHAR(7),
  SALARIO_ATUAL NUMERIC(18,6),
  PERCENTUAL_AUMENTO NUMERIC(18,6),
  SALARIO_NOVO NUMERIC(18,6),
  VALIDO_A_PARTIR VARCHAR(7),
  MOTIVO VARCHAR(100),
  CONSTRAINT pk_folha_historico_salarial PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CONTRATO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CONTRATO (
  ID INTEGER NOT NULL,
  ID_SOLICITACAO_SERVICO INTEGER NOT NULL,
  ID_TIPO_CONTRATO INTEGER NOT NULL,
  NUMERO VARCHAR(50),
  NOME VARCHAR(100),
  DESCRICAO TEXT,
  DATA_CADASTRO DATE,
  DATA_INICIO_VIGENCIA DATE,
  DATA_FIM_VIGENCIA DATE,
  DIA_FATURAMENTO CHAR(2),
  VALOR NUMERIC(18,6),
  QUANTIDADE_PARCELAS INTEGER,
  INTERVALO_ENTRE_PARCELAS INTEGER,
  OBSERVACAO TEXT,
  CLASSIFICACAO_CONTABIL_CONTA VARCHAR(30),
  CONSTRAINT pk_contrato PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- TIPO_CONTRATO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS TIPO_CONTRATO (
  ID SERIAL NOT NULL,
  NOME VARCHAR(50),
  DESCRICAO TEXT,
  CONSTRAINT pk_tipo_contrato PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CONTRATO_SOLICITACAO_SERVICO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CONTRATO_SOLICITACAO_SERVICO (
  ID SERIAL NOT NULL,
  ID_CONTRATO_TIPO_SERVICO INTEGER NOT NULL,
  ID_SETOR INTEGER NOT NULL,
  ID_COLABORADOR INTEGER NOT NULL,
  ID_CLIENTE INTEGER,
  ID_FORNECEDOR INTEGER,
  DATA_SOLICITACAO DATE,
  DATA_DESEJADA_INICIO DATE,
  URGENTE CHAR(1),
  STATUS_SOLICITACAO CHAR(1),
  DESCRICAO VARCHAR(100),
  CONSTRAINT pk_contrato_solicitacao_servico PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CONTRATO_TIPO_SERVICO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CONTRATO_TIPO_SERVICO (
  ID SERIAL NOT NULL,
  NOME VARCHAR(50),
  DESCRICAO TEXT,
  CONSTRAINT pk_contrato_tipo_servico PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CONTRATO_HISTORICO_REAJUSTE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CONTRATO_HISTORICO_REAJUSTE (
  ID SERIAL NOT NULL,
  ID_CONTRATO INTEGER NOT NULL,
  INDICE NUMERIC(18,6),
  VALOR_ANTERIOR NUMERIC(18,6),
  VALOR_ATUAL NUMERIC(18,6),
  DATA_REAJUSTE DATE,
  OBSERVACAO TEXT,
  CONSTRAINT pk_contrato_historico_reajuste PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CONTRATO_PREV_FATURAMENTO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CONTRATO_PREV_FATURAMENTO (
  ID SERIAL NOT NULL,
  ID_CONTRATO INTEGER NOT NULL,
  DATA_PREVISTA DATE,
  VALOR NUMERIC(18,6),
  CONSTRAINT pk_contrato_prev_faturamento PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CONTRATO_HIST_FATURAMENTO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CONTRATO_HIST_FATURAMENTO (
  ID SERIAL NOT NULL,
  ID_CONTRATO INTEGER NOT NULL,
  DATA_FATURA DATE,
  VALOR NUMERIC(18,6),
  CONSTRAINT pk_contrato_hist_faturamento PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- FERIADOS
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FERIADOS (
  ID SERIAL NOT NULL,
  ANO CHAR(4),
  NOME VARCHAR(50),
  ABRANGENCIA CHAR(1),
  UF CHAR(2),
  MUNICIPIO_IBGE INTEGER,
  TIPO CHAR(1),
  DATA_FERIADO DATE,
  CONSTRAINT pk_feriados PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PONTO_PARAMETRO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PONTO_PARAMETRO (
  ID SERIAL NOT NULL,
  MES_ANO VARCHAR(7),
  DIA_INICIAL_APURACAO INTEGER,
  HORA_NOTURNA_INICIO VARCHAR(8),
  HORA_NOTURNA_FIM VARCHAR(8),
  PERIODO_MINIMO_INTERJORNADA VARCHAR(8),
  PERCENTUAL_HE_DIURNA NUMERIC(18,6),
  PERCENTUAL_HE_NOTURNA NUMERIC(18,6),
  DURACAO_HORA_NOTURNA VARCHAR(8),
  TRATAMENTO_HORA_MAIS CHAR(1),
  TRATAMENTO_HORA_MENOS CHAR(1),
  CONSTRAINT pk_ponto_parametro PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PONTO_HORARIO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PONTO_HORARIO (
  ID SERIAL NOT NULL,
  TIPO CHAR(1),
  CODIGO CHAR(4),
  NOME VARCHAR(50),
  TIPO_TRABALHO CHAR(1),
  CARGA_HORARIA VARCHAR(8),
  ENTRADA01 VARCHAR(8),
  SAIDA01 VARCHAR(8),
  ENTRADA02 VARCHAR(8),
  SAIDA02 VARCHAR(8),
  ENTRADA03 VARCHAR(8),
  SAIDA03 VARCHAR(8),
  ENTRADA04 VARCHAR(8),
  SAIDA04 VARCHAR(8),
  ENTRADA05 VARCHAR(8),
  SAIDA05 VARCHAR(8),
  HORA_INICIO_JORNADA VARCHAR(8),
  HORA_FIM_JORNADA VARCHAR(8),
  CONSTRAINT pk_ponto_horario PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PONTO_ESCALA
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PONTO_ESCALA (
  ID SERIAL NOT NULL,
  NOME VARCHAR(50),
  DESCONTO_HORA_DIA VARCHAR(8),
  DESCONTO_DSR VARCHAR(8),
  CODIGO_HORARIO_DOMINGO CHAR(4),
  CODIGO_HORARIO_SEGUNDA CHAR(4),
  CODIGO_HORARIO_TERCA CHAR(4),
  CODIGO_HORARIO_QUARTA CHAR(4),
  CODIGO_HORARIO_QUINTA CHAR(4),
  CODIGO_HORARIO_SEXTA CHAR(4),
  CODIGO_HORARIO_SABADO CHAR(4),
  CONSTRAINT pk_ponto_escala PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PONTO_RELOGIO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PONTO_RELOGIO (
  ID SERIAL NOT NULL,
  LOCALIZACAO VARCHAR(50),
  MARCA VARCHAR(30),
  FABRICANTE VARCHAR(30),
  NUMERO_SERIE VARCHAR(50),
  UTILIZACAO CHAR(1),
  CONSTRAINT pk_ponto_relogio PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PONTO_TURMA
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PONTO_TURMA (
  ID SERIAL NOT NULL,
  ID_PONTO_ESCALA INTEGER NOT NULL,
  CODIGO CHAR(5),
  NOME VARCHAR(50),
  CONSTRAINT pk_ponto_turma PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PONTO_MARCACAO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PONTO_MARCACAO (
  ID SERIAL NOT NULL,
  ID_PONTO_RELOGIO INTEGER,
  ID_COLABORADOR INTEGER NOT NULL,
  NSR INTEGER,
  DATA_MARCACAO DATE,
  HORA_MARCACAO VARCHAR(8),
  TIPO_MARCACAO CHAR(1),
  TIPO_REGISTRO CHAR(1),
  PAR_ENTRADA_SAIDA CHAR(2),
  JUSTIFICATIVA VARCHAR(100),
  CONSTRAINT pk_ponto_marcacao PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PONTO_BANCO_HORAS
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PONTO_BANCO_HORAS (
  ID SERIAL NOT NULL,
  ID_COLABORADOR INTEGER NOT NULL,
  DATA_TRABALHO DATE,
  QUANTIDADE VARCHAR(8),
  SITUACAO CHAR(1),
  CONSTRAINT pk_ponto_banco_horas PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PONTO_CLASSIFICACAO_JORNADA
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PONTO_CLASSIFICACAO_JORNADA (
  ID SERIAL NOT NULL,
  CODIGO CHAR(3),
  NOME VARCHAR(50),
  DESCRICAO TEXT,
  PADRAO CHAR(1),
  DESCONTAR_HORAS CHAR(1),
  CONSTRAINT pk_ponto_classificacao_jornada PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PONTO_HORARIO_AUTORIZADO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PONTO_HORARIO_AUTORIZADO (
  ID SERIAL NOT NULL,
  ID_COLABORADOR INTEGER NOT NULL,
  DATA_HORARIO DATE,
  TIPO CHAR(1),
  CARGA_HORARIA VARCHAR(8),
  ENTRADA01 VARCHAR(8),
  SAIDA01 VARCHAR(8),
  ENTRADA02 VARCHAR(8),
  SAIDA02 VARCHAR(8),
  ENTRADA03 VARCHAR(8),
  SAIDA03 VARCHAR(8),
  ENTRADA04 VARCHAR(8),
  SAIDA04 VARCHAR(8),
  ENTRADA05 VARCHAR(8),
  SAIDA05 VARCHAR(8),
  HORA_FECHAMENTO_DIA VARCHAR(8),
  CONSTRAINT pk_ponto_horario_autorizado PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PONTO_ABONO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PONTO_ABONO (
  ID SERIAL NOT NULL,
  ID_COLABORADOR INTEGER NOT NULL,
  QUANTIDADE INTEGER,
  UTILIZADO INTEGER,
  SALDO INTEGER,
  DATA_CADASTRO DATE,
  INICIO_UTILIZACAO DATE,
  OBSERVACAO TEXT,
  CONSTRAINT pk_ponto_abono PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PONTO_ABONO_UTILIZACAO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PONTO_ABONO_UTILIZACAO (
  ID SERIAL NOT NULL,
  ID_PONTO_ABONO INTEGER NOT NULL,
  DATA_UTILIZACAO DATE,
  OBSERVACAO TEXT,
  CONSTRAINT pk_ponto_abono_utilizacao PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- DAV_CABECALHO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS DAV_CABECALHO (
  ID SERIAL NOT NULL,
  ID_PESSOA INTEGER NOT NULL,
  NUMERO_DAV VARCHAR(10),
  NUMERO_ECF VARCHAR(4),
  CCF INTEGER,
  COO INTEGER,
  NOME_DESTINATARIO VARCHAR(100),
  CPF_CNPJ_DESTINATARIO VARCHAR(14),
  DATA_EMISSAO DATE,
  HORA_EMISSAO VARCHAR(8),
  SITUACAO CHAR(1),
  TAXA_ACRESCIMO NUMERIC(18,6),
  ACRESCIMO NUMERIC(18,6),
  TAXA_DESCONTO NUMERIC(18,6),
  DESCONTO NUMERIC(18,6),
  SUBTOTAL NUMERIC(18,6),
  VALOR NUMERIC(18,6),
  IMPRESSO CHAR(1),
  HASH_REGISTRO VARCHAR(32),
  CONSTRAINT pk_dav_cabecalho PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- DAV_DETALHE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS DAV_DETALHE (
  ID SERIAL NOT NULL,
  ID_DAV_CABECALHO INTEGER NOT NULL,
  ID_PRODUTO INTEGER NOT NULL,
  NUMERO_DAV VARCHAR(10),
  DATA_EMISSAO DATE,
  ITEM INTEGER,
  QUANTIDADE NUMERIC(18,6),
  VALOR_UNITARIO NUMERIC(18,6),
  VALOR_TOTAL NUMERIC(18,6),
  CANCELADO CHAR(1),
  MESCLA_PRODUTO CHAR(1),
  GTIN_PRODUTO VARCHAR(14),
  NOME_PRODUTO VARCHAR(100),
  UNIDADE_PRODUTO VARCHAR(10),
  TOTALIZADOR_PARCIAL VARCHAR(10),
  SERVICO_FORMULA TEXT,
  HASH_REGISTRO VARCHAR(32),
  CONSTRAINT pk_dav_detalhe PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PRE_VENDA_CABECALHO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PRE_VENDA_CABECALHO (
  ID SERIAL NOT NULL,
  ID_PESSOA INTEGER NOT NULL,
  DATA_EMISSAO DATE,
  HORA_EMISSAO VARCHAR(8),
  SITUACAO CHAR(1),
  CCF INTEGER,
  VALOR NUMERIC(18,6),
  NOME_DESTINATARIO VARCHAR(100),
  CPF_CNPJ_DESTINATARIO VARCHAR(14),
  SUBTOTAL NUMERIC(18,6),
  DESCONTO NUMERIC(18,6),
  ACRESCIMO NUMERIC(18,6),
  TAXA_ACRESCIMO NUMERIC(18,6),
  TAXA_DESCONTO NUMERIC(18,6),
  CONSTRAINT pk_pre_venda_cabecalho PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PRE_VENDA_DETALHE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PRE_VENDA_DETALHE (
  ID SERIAL NOT NULL,
  ID_PRE_VENDA_CABECALHO INTEGER NOT NULL,
  ID_PRODUTO INTEGER NOT NULL,
  ITEM INTEGER,
  QUANTIDADE NUMERIC(18,6),
  VALOR_UNITARIO NUMERIC(18,6),
  VALOR_TOTAL NUMERIC(18,6),
  CANCELADO CHAR(1),
  GTIN_PRODUTO VARCHAR(14),
  NOME_PRODUTO VARCHAR(100),
  UNIDADE_PRODUTO VARCHAR(10),
  ECF_ICMS_ST VARCHAR(4),
  CONSTRAINT pk_pre_venda_detalhe PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CONTABIL_FECHAMENTO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CONTABIL_FECHAMENTO (
  ID SERIAL NOT NULL,
  DATA_INICIO DATE,
  DATA_FIM DATE,
  CRITERIO_LANCAMENTO CHAR(1),
  CONSTRAINT pk_contabil_fechamento PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CONTABIL_INDICE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CONTABIL_INDICE (
  ID SERIAL NOT NULL,
  INDICE VARCHAR(50),
  PERIODICIDADE CHAR(1) NOT NULL,
  DIARIO_A_PARTIR_DE DATE,
  MENSAL_MES_ANO VARCHAR(7),
  CONSTRAINT pk_contabil_indice PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CONTABIL_INDICE_VALOR
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CONTABIL_INDICE_VALOR (
  ID SERIAL NOT NULL,
  ID_CONTABIL_INDICE INTEGER NOT NULL,
  DATA_INDICE DATE,
  VALOR NUMERIC(18,6),
  CONSTRAINT pk_contabil_indice_valor PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- QUADRO_SOCIETARIO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS QUADRO_SOCIETARIO (
  ID SERIAL NOT NULL,
  DATA_REGISTRO DATE,
  CAPITAL_SOCIAL NUMERIC(18,6),
  VALOR_QUOTA NUMERIC(18,6),
  QUANTIDADE_COTAS INTEGER,
  CONSTRAINT pk_quadro_societario PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CONTRATO_TEMPLATE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CONTRATO_TEMPLATE (
  ID SERIAL NOT NULL,
  NOME VARCHAR(100),
  DESCRICAO TEXT,
  CONSTRAINT pk_contrato_template PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PONTO_BANCO_HORAS_UTILIZACAO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PONTO_BANCO_HORAS_UTILIZACAO (
  ID SERIAL NOT NULL,
  ID_PONTO_BANCO_HORAS INTEGER NOT NULL,
  DATA_UTILIZACAO DATE,
  QUANTIDADE_UTILIZADA VARCHAR(8),
  OBSERVACAO TEXT,
  CONSTRAINT pk_ponto_banco_horas_utilizacao PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PONTO_FECHAMENTO_JORNADA
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PONTO_FECHAMENTO_JORNADA (
  ID SERIAL NOT NULL,
  ID_PONTO_CLASSIFICACAO_JORNADA INTEGER NOT NULL,
  ID_COLABORADOR INTEGER NOT NULL,
  DATA_FECHAMENTO DATE,
  DIA_SEMANA VARCHAR(7),
  CODIGO_HORARIO CHAR(4),
  CARGA_HORARIA_ESPERADA VARCHAR(8),
  CARGA_HORARIA_DIURNA VARCHAR(8),
  CARGA_HORARIA_NOTURNA VARCHAR(8),
  CARGA_HORARIA_TOTAL VARCHAR(8),
  ENTRADA01 VARCHAR(8),
  SAIDA01 VARCHAR(8),
  ENTRADA02 VARCHAR(8),
  SAIDA02 VARCHAR(8),
  ENTRADA03 VARCHAR(8),
  SAIDA03 VARCHAR(8),
  ENTRADA04 VARCHAR(8),
  SAIDA04 VARCHAR(8),
  ENTRADA05 VARCHAR(8),
  SAIDA05 VARCHAR(8),
  HORA_INICIO_JORNADA VARCHAR(8),
  HORA_FIM_JORNADA VARCHAR(8),
  HORA_EXTRA01 VARCHAR(8),
  PERCENTUAL_HORA_EXTRA01 NUMERIC(18,6),
  MODALIDADE_HORA_EXTRA01 CHAR(1),
  HORA_EXTRA02 VARCHAR(8),
  PERCENTUAL_HORA_EXTRA02 NUMERIC(18,6),
  MODALIDADE_HORA_EXTRA02 CHAR(1),
  HORA_EXTRA03 VARCHAR(8),
  PERCENTUAL_HORA_EXTRA03 NUMERIC(18,6),
  MODALIDADE_HORA_EXTRA03 CHAR(1),
  HORA_EXTRA04 VARCHAR(8),
  PERCENTUAL_HORA_EXTRA04 NUMERIC(18,6),
  MODALIDADE_HORA_EXTRA04 CHAR(1),
  FALTA_ATRASO VARCHAR(8),
  COMPENSAR CHAR(1),
  BANCO_HORAS VARCHAR(8),
  OBSERVACAO VARCHAR(250),
  CONSTRAINT pk_ponto_fechamento_jornada PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- ADM_MODULO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ADM_MODULO (
  ID SERIAL NOT NULL,
  CODIGO CHAR(3),
  NOME VARCHAR(100),
  DESCRICAO TEXT,
  CONSTRAINT pk_adm_modulo PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CT_RESULTADO_NT_FINANCEIRA
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CT_RESULTADO_NT_FINANCEIRA (
  ID SERIAL NOT NULL,
  ID_CENTRO_RESULTADO INTEGER NOT NULL,
  ID_FIN_NATUREZA_FINANCEIRA INTEGER NOT NULL,
  PERCENTUAL_RATEIO NUMERIC(18,6),
  CONSTRAINT pk_ct_resultado_nt_financeira PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- ECF_ALIQUOTAS
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ECF_ALIQUOTAS (
  ID SERIAL NOT NULL,
  TOTALIZADOR_PARCIAL VARCHAR(10),
  ECF_ICMS_ST VARCHAR(4),
  PAF_P_ST CHAR(1),
  CONSTRAINT pk_ecf_aliquotas PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- AUDITORIA
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS AUDITORIA (
  ID SERIAL NOT NULL,
  DATA_REGISTRO DATE,
  HORA_REGISTRO VARCHAR(8),
  JANELA_CONTROLLER VARCHAR(50),
  ACAO VARCHAR(50),
  CONTEUDO TEXT,
  CONSTRAINT pk_auditoria PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PRODUTO_ALTERACAO_ITEM
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PRODUTO_ALTERACAO_ITEM (
  ID SERIAL NOT NULL,
  ID_PRODUTO INTEGER NOT NULL,
  CODIGO VARCHAR(14),
  NOME VARCHAR(100),
  DATA_INICIAL DATE,
  DATA_FINAL DATE,
  CONSTRAINT pk_produto_alteracao_item PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- FISCAL_APURACAO_ICMS
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FISCAL_APURACAO_ICMS (
  ID SERIAL NOT NULL,
  COMPETENCIA VARCHAR(7),
  VALOR_TOTAL_DEBITO NUMERIC(18,6),
  VALOR_AJUSTE_DEBITO NUMERIC(18,6),
  VALOR_TOTAL_AJUSTE_DEBITO NUMERIC(18,6),
  VALOR_ESTORNO_CREDITO NUMERIC(18,6),
  VALOR_TOTAL_CREDITO NUMERIC(18,6),
  VALOR_AJUSTE_CREDITO NUMERIC(18,6),
  VALOR_TOTAL_AJUSTE_CREDITO NUMERIC(18,6),
  VALOR_ESTORNO_DEBITO NUMERIC(18,6),
  VALOR_SALDO_CREDOR_ANTERIOR NUMERIC(18,6),
  VALOR_SALDO_APURADO NUMERIC(18,6),
  VALOR_TOTAL_DEDUCAO NUMERIC(18,6),
  VALOR_ICMS_RECOLHER NUMERIC(18,6),
  VALOR_SALDO_CREDOR_TRANSP NUMERIC(18,6),
  VALOR_DEBITO_ESPECIAL NUMERIC(18,6),
  CONSTRAINT pk_fiscal_apuracao_icms PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- FISCAL_NOTA_FISCAL_SAIDA
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FISCAL_NOTA_FISCAL_SAIDA (
  ID SERIAL NOT NULL,
  ID_NFE_CABECALHO INTEGER NOT NULL,
  COMPETENCIA VARCHAR(7),
  CONSTRAINT pk_fiscal_nota_fiscal_saida PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- ECF_SINTEGRA_60M
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ECF_SINTEGRA_60M (
  ID SERIAL NOT NULL,
  NOME_CAIXA VARCHAR(8),
  ID_GERADO_CAIXA INTEGER,
  ID_EMPRESA INTEGER,
  DATA_EMISSAO DATE,
  NUMERO_SERIE_ECF VARCHAR(20),
  NUMERO_EQUIPAMENTO INTEGER,
  MODELO_DOCUMENTO_FISCAL CHAR(2),
  COO_INICIAL INTEGER,
  COO_FINAL INTEGER,
  CRZ INTEGER,
  CRO INTEGER,
  VALOR_VENDA_BRUTA NUMERIC(18,6),
  VALOR_GRANDE_TOTAL NUMERIC(18,6),
  DATA_SINCRONIZACAO DATE,
  HORA_SINCRONIZACAO VARCHAR(8),
  CONSTRAINT pk_ecf_sintegra_60m PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- ECF_SINTEGRA_60A
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ECF_SINTEGRA_60A (
  ID SERIAL NOT NULL,
  NOME_CAIXA VARCHAR(8),
  ID_GERADO_CAIXA INTEGER,
  ID_EMPRESA INTEGER,
  ID_ECF_SINTEGRA_60M INTEGER,
  SITUACAO_TRIBUTARIA VARCHAR(4),
  VALOR NUMERIC(18,6),
  DATA_SINCRONIZACAO DATE,
  HORA_SINCRONIZACAO VARCHAR(32),
  CONSTRAINT pk_ecf_sintegra_60a PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- ADM_PARAMETRO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ADM_PARAMETRO (
  ID SERIAL NOT NULL,
  FIN_PARCELA_ABERTO INTEGER,
  FIN_PARCELA_QUITADO INTEGER,
  FIN_PARCELA_QUITADO_PARCIAL INTEGER,
  FIN_TIPO_RECEBIMENTO_EDI INTEGER,
  COMPRA_FIN_DOC_ORIGEM INTEGER,
  COMPRA_CONTA_CAIXA INTEGER,
  CONSTRAINT pk_adm_parametro PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- ECF_E3
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ECF_E3 (
  ID SERIAL NOT NULL,
  SERIE_ECF VARCHAR(20),
  MF_ADICIONAL CHAR(1),
  TIPO_ECF VARCHAR(7),
  MARCA_ECF VARCHAR(20),
  MODELO_ECF VARCHAR(20),
  DATA_ESTOQUE DATE,
  HORA_ESTOQUE VARCHAR(8),
  CONSTRAINT pk_ecf_e3 PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PESSOA_ALTERACAO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PESSOA_ALTERACAO (
  ID SERIAL NOT NULL,
  ID_PESSOA INTEGER NOT NULL,
  DATA_ALTERACAO DATE,
  OBJETO_ANTIGO TEXT,
  OBJETO_NOVO TEXT,
  CONSTRAINT pk_pessoa_alteracao PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- DAV_DETALHE_ALTERACAO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS DAV_DETALHE_ALTERACAO (
  ID SERIAL NOT NULL,
  ID_DAV_DETALHE INTEGER NOT NULL,
  DATA_ALTERACAO DATE,
  HORA_ALTERACAO VARCHAR(8),
  TIPO_ALTERACAO CHAR(1),
  OBJETO TEXT,
  CONSTRAINT pk_dav_detalhe_alteracao PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PDV_SANGRIA
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PDV_SANGRIA (
  ID SERIAL NOT NULL,
  NOME_CAIXA VARCHAR(30),
  ID_GERADO_CAIXA INTEGER,
  ID_EMPRESA INTEGER,
  ID_PDV_MOVIMENTO INTEGER,
  DATA_SANGRIA DATE,
  VALOR NUMERIC(18,6),
  DATA_SINCRONIZACAO DATE,
  HORA_SINCRONIZACAO VARCHAR(8),
  CONSTRAINT pk_pdv_sangria PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- MALOTE_DIGITAL_DOCUMENTO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS MALOTE_DIGITAL_DOCUMENTO (
  ID SERIAL NOT NULL,
  ID_COLABORADOR INTEGER NOT NULL,
  NOME VARCHAR(100),
  NOME_ARQUIVO INTEGER,
  FORMATO CHAR(3),
  TAMANHO INTEGER,
  ASSINADO CHAR(1),
  DATA_ENVIO DATE,
  ASSUNTO VARCHAR(100),
  CONSTRAINT pk_malote_digital_documento PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- MALOTE_DIGITAL_DESTINATARIO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS MALOTE_DIGITAL_DESTINATARIO (
  ID SERIAL NOT NULL,
  ID_MALOTE_DIGITAL_DOCUMENTO INTEGER NOT NULL,
  ID_COLABORADOR INTEGER NOT NULL,
  CONSTRAINT pk_malote_digital_destinatario PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- MALOTE_DIGITAL_ACESSO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS MALOTE_DIGITAL_ACESSO (
  ID SERIAL NOT NULL,
  ID_MALOTE_DIGITAL_DESTINATARIO INTEGER NOT NULL,
  DATA_ACESSO DATE,
  HORA_ACESSO VARCHAR(8),
  CONSTRAINT pk_malote_digital_acesso PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- ETIQUETA_LAYOUT
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ETIQUETA_LAYOUT (
  ID SERIAL NOT NULL,
  ID_FORMATO_PAPEL INTEGER NOT NULL,
  CODIGO_FABRICANTE VARCHAR(50),
  QUANTIDADE INTEGER,
  QUANTIDADE_HORIZONTAL INTEGER,
  QUANTIDADE_VERTICAL INTEGER,
  MARGEM_SUPERIOR INTEGER,
  MARGEM_INFERIOR INTEGER,
  MARGEM_ESQUERDA INTEGER,
  MARGEM_DIREITA INTEGER,
  ESPACAMENTO_HORIZONTAL INTEGER,
  ESPACAMENTO_VERTICAL INTEGER,
  CONSTRAINT pk_etiqueta_layout PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- ETIQUETA_FORMATO_PAPEL
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ETIQUETA_FORMATO_PAPEL (
  ID SERIAL NOT NULL,
  NOME VARCHAR(50),
  ALTURA INTEGER,
  LARGURA INTEGER,
  CONSTRAINT pk_etiqueta_formato_papel PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- ETIQUETA_TEMPLATE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ETIQUETA_TEMPLATE (
  ID SERIAL NOT NULL,
  ID_ETIQUETA_LAYOUT INTEGER NOT NULL,
  TABELA VARCHAR(50),
  CAMPO VARCHAR(50),
  FORMATO INTEGER,
  QUANTIDADE_REPETICOES INTEGER,
  FILTRO VARCHAR(100),
  CONSTRAINT pk_etiqueta_template PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- AGENDA_COMPROMISSO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS AGENDA_COMPROMISSO (
  ID SERIAL NOT NULL,
  ID_AGENDA_CATEGORIA_COMPROMISSO INTEGER NOT NULL,
  ID_COLABORADOR INTEGER NOT NULL,
  DATA_COMPROMISSO DATE,
  HORA VARCHAR(8),
  DURACAO INTEGER,
  ONDE VARCHAR(100),
  DESCRICAO VARCHAR(100),
  TIPO CHAR(1),
  CONSTRAINT pk_agenda_compromisso PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- AGENDA_CATEGORIA_COMPROMISSO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS AGENDA_CATEGORIA_COMPROMISSO (
  ID SERIAL NOT NULL,
  NOME VARCHAR(100),
  COR VARCHAR(50),
  CONSTRAINT pk_agenda_categoria_compromisso PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- AGENDA_NOTIFICACAO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS AGENDA_NOTIFICACAO (
  ID SERIAL NOT NULL,
  ID_AGENDA_COMPROMISSO INTEGER NOT NULL,
  DATA_NOTIFICACAO DATE,
  HORA VARCHAR(8),
  TIPO INTEGER,
  CONSTRAINT pk_agenda_notificacao PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- AGENDA_COMPROMISSO_CONVIDADO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS AGENDA_COMPROMISSO_CONVIDADO (
  ID SERIAL NOT NULL,
  ID_AGENDA_COMPROMISSO INTEGER NOT NULL,
  ID_COLABORADOR INTEGER NOT NULL,
  CONSTRAINT pk_agenda_compromisso_convidado PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- REUNIAO_SALA
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS REUNIAO_SALA (
  ID SERIAL NOT NULL,
  PREDIO VARCHAR(100),
  ANDAR VARCHAR(10),
  NUMERO VARCHAR(10),
  CONSTRAINT pk_reuniao_sala PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- REUNIAO_SALA_EVENTO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS REUNIAO_SALA_EVENTO (
  ID SERIAL NOT NULL,
  ID_AGENDA_COMPROMISSO INTEGER NOT NULL,
  ID_REUNIAO_SALA INTEGER NOT NULL,
  DATA_RESERVA DATE,
  CONSTRAINT pk_reuniao_sala_evento PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- RECADO_REMETENTE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS RECADO_REMETENTE (
  ID SERIAL NOT NULL,
  ID_COLABORADOR INTEGER NOT NULL,
  DATA_ENVIO DATE,
  HORA_ENVIO VARCHAR(8),
  ASSUNTO VARCHAR(100),
  TEXTO TEXT,
  CONSTRAINT pk_recado_remetente PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- RECADO_DESTINATARIO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS RECADO_DESTINATARIO (
  ID SERIAL NOT NULL,
  ID_RECADO_REMETENTE INTEGER NOT NULL,
  ID_COLABORADOR INTEGER NOT NULL,
  CONSTRAINT pk_recado_destinatario PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- ESOCIAL_NATUREZA_JURIDICA
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ESOCIAL_NATUREZA_JURIDICA (
  ID SERIAL NOT NULL,
  GRUPO INTEGER,
  CODIGO VARCHAR(5),
  DESCRICAO VARCHAR(100),
  CONSTRAINT pk_esocial_natureza_juridica PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- ESOCIAL_CLASSIFICACAO_TRIBUT
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ESOCIAL_CLASSIFICACAO_TRIBUT (
  ID SERIAL NOT NULL,
  CODIGO CHAR(2),
  DESCRICAO VARCHAR(100),
  CONSTRAINT pk_esocial_classificacao_tribut PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- ESOCIAL_RUBRICA
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ESOCIAL_RUBRICA (
  ID SERIAL NOT NULL,
  CODIGO CHAR(4),
  NOME VARCHAR(100),
  DESCRICAO TEXT,
  CONSTRAINT pk_esocial_rubrica PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- ESOCIAL_TIPO_AFASTAMENTO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ESOCIAL_TIPO_AFASTAMENTO (
  ID SERIAL NOT NULL,
  CODIGO CHAR(2),
  DESCRICAO TEXT,
  CONSTRAINT pk_esocial_tipo_afastamento PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- ESOCIAL_MOTIVO_DESLIGAMENTO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ESOCIAL_MOTIVO_DESLIGAMENTO (
  ID SERIAL NOT NULL,
  CODIGO CHAR(2),
  DESCRICAO TEXT,
  CONSTRAINT pk_esocial_motivo_desligamento PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PCP_OP_CABECALHO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PCP_OP_CABECALHO (
  ID SERIAL NOT NULL,
  INICIO DATE,
  PREVISAO_ENTREGA DATE,
  TERMINO DATE,
  CUSTO_TOTAL_PREVISTO NUMERIC(18,6),
  CUSTO_TOTAL_REALIZADO NUMERIC(18,6),
  PORCENTO_VENDA NUMERIC(18,6),
  PORCENTO_ESTOQUE NUMERIC(18,6),
  CONSTRAINT pk_pcp_op_cabecalho PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PCP_OP_DETALHE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PCP_OP_DETALHE (
  ID SERIAL NOT NULL,
  ID_PCP_OP_CABECALHO INTEGER NOT NULL,
  ID_PRODUTO INTEGER NOT NULL,
  QUANTIDADE_PRODUZIR NUMERIC(18,6),
  QUANTIDADE_PRODUZIDA NUMERIC(18,6),
  QUANTIDADE_ENTREGUE NUMERIC(18,6),
  CUSTO_PREVISTO NUMERIC(18,6),
  CUSTO_REALIZADO NUMERIC(18,6),
  CONSTRAINT pk_pcp_op_detalhe PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PCP_SERVICO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PCP_SERVICO (
  ID SERIAL NOT NULL,
  ID_PCP_OP_DETALHE INTEGER NOT NULL,
  INICIO_REALIZADO DATE,
  TERMINO_REALIZADO DATE,
  HORAS_REALIZADO INTEGER,
  MINUTOS_REALIZADO INTEGER,
  SEGUNDOS_REALIZADO INTEGER,
  CUSTO_REALIZADO NUMERIC(18,6),
  INICIO_PREVISTO DATE,
  TERMINO_PREVISTO DATE,
  HORAS_PREVISTO INTEGER,
  MINUTOS_PREVISTO INTEGER,
  SEGUNDOS_PREVISTO INTEGER,
  CUSTO_PREVISTO NUMERIC(18,6),
  CONSTRAINT pk_pcp_servico PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PCP_SERVICO_COLABORADOR
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PCP_SERVICO_COLABORADOR (
  ID SERIAL NOT NULL,
  ID_PCP_SERVICO INTEGER NOT NULL,
  ID_COLABORADOR INTEGER NOT NULL,
  CONSTRAINT pk_pcp_servico_colaborador PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PCP_INSTRUCAO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PCP_INSTRUCAO (
  ID SERIAL NOT NULL,
  CODIGO CHAR(3),
  DESCRICAO VARCHAR(100),
  CONSTRAINT pk_pcp_instrucao PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PCP_INSTRUCAO_OP
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PCP_INSTRUCAO_OP (
  ID SERIAL NOT NULL,
  ID_PCP_INSTRUCAO INTEGER NOT NULL,
  ID_PCP_OP_CABECALHO INTEGER NOT NULL,
  CONSTRAINT pk_pcp_instrucao_op PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PCP_SERVICO_EQUIPAMENTO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PCP_SERVICO_EQUIPAMENTO (
  ID SERIAL NOT NULL,
  ID_PATRIM_BEM INTEGER NOT NULL,
  ID_PCP_SERVICO INTEGER NOT NULL,
  CONSTRAINT pk_pcp_servico_equipamento PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- WMS_AGENDAMENTO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS WMS_AGENDAMENTO (
  ID SERIAL NOT NULL,
  DATA_OPERACAO DATE,
  HORA_OPERACAO VARCHAR(8),
  LOCAL_OPERACAO VARCHAR(100),
  QUANTIDADE_VOLUME INTEGER,
  PESO_TOTAL_VOLUME NUMERIC(18,6),
  QUANTIDADE_PESSOA INTEGER,
  QUANTIDADE_HORA INTEGER,
  CONSTRAINT pk_wms_agendamento PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- WMS_PARAMETRO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS WMS_PARAMETRO (
  ID SERIAL NOT NULL,
  HORA_POR_VOLUME INTEGER,
  PESSOA_POR_VOLUME INTEGER,
  HORA_POR_PESO INTEGER,
  PESSOA_POR_PESO INTEGER,
  ITEM_DIFERENTE_CAIXA CHAR(1),
  CONSTRAINT pk_wms_parametro PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- WMS_RECEBIMENTO_CABECALHO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS WMS_RECEBIMENTO_CABECALHO (
  ID SERIAL NOT NULL,
  ID_WMS_AGENDAMENTO INTEGER NOT NULL,
  DATA_RECEBIMENTO DATE,
  HORA_INICIO VARCHAR(8),
  HORA_FIM VARCHAR(8),
  VOLUME_RECEBIDO INTEGER,
  PESO_RECEBIDO NUMERIC(18,6),
  INCONSISTENCIA CHAR(1),
  OBSERVACAO TEXT,
  CONSTRAINT pk_wms_recebimento_cabecalho PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- WMS_RECEBIMENTO_DETALHE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS WMS_RECEBIMENTO_DETALHE (
  ID SERIAL NOT NULL,
  ID_WMS_RECEBIMENTO_CABECALHO INTEGER NOT NULL,
  ID_PRODUTO INTEGER NOT NULL,
  QUANTIDADE_VOLUME INTEGER,
  QUANTIDADE_ITEM_POR_VOLUME INTEGER,
  QUANTIDADE_RECEBIDA INTEGER,
  DESTINO CHAR(1),
  CONSTRAINT pk_wms_recebimento_detalhe PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- WMS_RUA
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS WMS_RUA (
  ID SERIAL NOT NULL,
  CODIGO VARCHAR(10),
  NOME VARCHAR(100),
  QUANTIDADE_ESTANTE INTEGER,
  CONSTRAINT pk_wms_rua PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- WMS_ESTANTE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS WMS_ESTANTE (
  ID SERIAL NOT NULL,
  ID_WMS_RUA INTEGER NOT NULL,
  CODIGO VARCHAR(10),
  QUANTIDADE_CAIXA INTEGER,
  CONSTRAINT pk_wms_estante PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- WMS_CAIXA
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS WMS_CAIXA (
  ID SERIAL NOT NULL,
  ID_WMS_ESTANTE INTEGER NOT NULL,
  CODIGO VARCHAR(10),
  ALTURA INTEGER,
  LARGURA INTEGER,
  PROFUNDIDADE INTEGER,
  CONSTRAINT pk_wms_caixa PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- WMS_ARMAZENAMENTO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS WMS_ARMAZENAMENTO (
  ID SERIAL NOT NULL,
  ID_WMS_CAIXA INTEGER NOT NULL,
  ID_WMS_RECEBIMENTO_DETALHE INTEGER NOT NULL,
  QUANTIDADE INTEGER,
  CONSTRAINT pk_wms_armazenamento PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- WMS_ORDEM_SEPARACAO_CAB
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS WMS_ORDEM_SEPARACAO_CAB (
  ID SERIAL NOT NULL,
  ORIGEM CHAR(1),
  DATA_SOLICITACAO DATE,
  DATA_LIMITE DATE,
  CONSTRAINT pk_wms_ordem_separacao_cab PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- WMS_ORDEM_SEPARACAO_DET
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS WMS_ORDEM_SEPARACAO_DET (
  ID SERIAL NOT NULL,
  ID_WMS_ORDEM_SEPARACAO_CAB INTEGER NOT NULL,
  ID_PRODUTO INTEGER NOT NULL,
  QUANTIDADE INTEGER,
  CONSTRAINT pk_wms_ordem_separacao_det PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- WMS_EXPEDICAO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS WMS_EXPEDICAO (
  ID SERIAL NOT NULL,
  ID_WMS_ORDEM_SEPARACAO_DET INTEGER NOT NULL,
  ID_WMS_ARMAZENAMENTO INTEGER NOT NULL,
  QUANTIDADE INTEGER,
  DATA_SAIDA DATE,
  CONSTRAINT pk_wms_expedicao PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- IBPT
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS IBPT (
  ID SERIAL NOT NULL,
  NCM VARCHAR(8),
  EX CHAR(2),
  TIPO CHAR(1),
  DESCRICAO TEXT,
  NACIONAL_FEDERAL NUMERIC(18,6),
  IMPORTADOS_FEDERAL NUMERIC(18,6),
  ESTADUAL NUMERIC(18,6),
  MUNICIPAL NUMERIC(18,6),
  VIGENCIA_INICIO DATE,
  VIGENCIA_FIM DATE,
  CHAVE VARCHAR(6),
  VERSAO VARCHAR(6),
  FONTE VARCHAR(34),
  CONSTRAINT pk_ibpt PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- MDFE_CABECALHO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS MDFE_CABECALHO (
  ID SERIAL NOT NULL,
  UF INTEGER,
  TIPO_AMBIENTE INTEGER,
  TIPO_EMITENTE INTEGER,
  TIPO_TRANSPORTADORA INTEGER,
  MODELO CHAR(2),
  SERIE VARCHAR(3),
  NUMERO_MDFE VARCHAR(9),
  CODIGO_NUMERICO VARCHAR(8),
  CHAVE_ACESSO VARCHAR(44),
  DIGITO_VERIFICADOR INTEGER,
  MODAL INTEGER,
  DATA_HORA_EMISSAO TEXT,
  TIPO_EMISSAO INTEGER,
  PROCESSO_EMISSAO INTEGER,
  VERSAO_PROCESSO_EMISSAO VARCHAR(20),
  UF_INICIO CHAR(2),
  UF_FIM CHAR(2),
  DATA_HORA_PREVISAO_VIAGEM TEXT,
  QUANTIDADE_TOTAL_CTE INTEGER,
  QUANTIDADE_TOTAL_NFE INTEGER,
  QUANTIDADE_TOTAL_MDFE INTEGER,
  CODIGO_UNIDADE_MEDIDA CHAR(2),
  PESO_BRUTO_CARGA NUMERIC(18,6),
  VALOR_CARGA NUMERIC(18,6),
  NUMERO_PROTOCOLO VARCHAR(15),
  CONSTRAINT pk_mdfe_cabecalho PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- MDFE_LACRE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS MDFE_LACRE (
  ID SERIAL NOT NULL,
  ID_MDFE_CABECALHO INTEGER NOT NULL,
  NUMERO_LACRE VARCHAR(20),
  CONSTRAINT pk_mdfe_lacre PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- MDFE_INFORMACAO_CTE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS MDFE_INFORMACAO_CTE (
  ID SERIAL NOT NULL,
  ID_MDFE_MUNICIPIO_DESCARREGA INTEGER NOT NULL,
  CHAVE_CTE VARCHAR(44),
  SEGUNDO_CODIGO_BARRA VARCHAR(36),
  INDICADOR_REENTREGA INTEGER,
  CONSTRAINT pk_mdfe_informacao_cte PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- MDFE_INFORMACAO_NFE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS MDFE_INFORMACAO_NFE (
  ID SERIAL NOT NULL,
  ID_MDFE_MUNICIPIO_DESCARREGA INTEGER NOT NULL,
  CHAVE_NFE VARCHAR(44),
  SEGUNDO_CODIGO_BARRA VARCHAR(36),
  INDICADOR_REENTREGA INTEGER,
  CONSTRAINT pk_mdfe_informacao_nfe PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- MDFE_EMITENTE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS MDFE_EMITENTE (
  ID SERIAL NOT NULL,
  ID_MDFE_CABECALHO INTEGER NOT NULL,
  NOME VARCHAR(60),
  FANTASIA VARCHAR(60),
  CNPJ VARCHAR(14),
  IE INTEGER,
  LOGRADOURO VARCHAR(60),
  NUMERO VARCHAR(60),
  COMPLEMENTO VARCHAR(60),
  BAIRRO VARCHAR(60),
  CODIGO_MUNICIPIO VARCHAR(7),
  NOME_MUNICIPIO VARCHAR(60),
  CEP VARCHAR(8),
  UF CHAR(2),
  TELEFONE VARCHAR(12),
  EMAIL VARCHAR(60),
  CONSTRAINT pk_mdfe_emitente PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- MDFE_PERCURSO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS MDFE_PERCURSO (
  ID SERIAL NOT NULL,
  ID_MDFE_CABECALHO INTEGER NOT NULL,
  UF_PERCURSO CHAR(2),
  DATA_INICIO_VIAGEM DATE,
  CONSTRAINT pk_mdfe_percurso PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- MDFE_MUNICIPIO_CARREGAMENTO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS MDFE_MUNICIPIO_CARREGAMENTO (
  ID SERIAL NOT NULL,
  ID_MDFE_CABECALHO INTEGER NOT NULL,
  NOME_MUNICIPIO VARCHAR(60),
  CODIGO_MUNICIPIO VARCHAR(7),
  CONSTRAINT pk_mdfe_municipio_carregamento PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- MDFE_RODOVIARIO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS MDFE_RODOVIARIO (
  ID SERIAL NOT NULL,
  ID_MDFE_CABECALHO INTEGER NOT NULL,
  RNTRC VARCHAR(8),
  CODIGO_AGENDAMENTO VARCHAR(16),
  CONSTRAINT pk_mdfe_rodoviario PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- MDFE_RODOVIARIO_MOTORISTA
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS MDFE_RODOVIARIO_MOTORISTA (
  ID SERIAL NOT NULL,
  ID_MDFE_RODOVIARIO INTEGER NOT NULL,
  NOME VARCHAR(60),
  CPF VARCHAR(11),
  CONSTRAINT pk_mdfe_rodoviario_motorista PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- MDFE_RODOVIARIO_VEICULO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS MDFE_RODOVIARIO_VEICULO (
  ID SERIAL NOT NULL,
  ID_MDFE_RODOVIARIO INTEGER NOT NULL,
  CODIGO_INTERNO VARCHAR(10),
  PLACA VARCHAR(7),
  RENAVAM VARCHAR(11),
  TARA INTEGER,
  CAPACIDADE_KG INTEGER,
  CAPACIDADE_M3 INTEGER,
  TIPO_RODADO CHAR(2),
  TIPO_CARROCERIA CHAR(2),
  UF_LICENCIAMENTO CHAR(2),
  PROPRIETARIO_CPF VARCHAR(11),
  PROPRIETARIO_CNPJ VARCHAR(14),
  PROPRIETARIO_RNTRC VARCHAR(8),
  PROPRIETARIO_NOME VARCHAR(60),
  PROPRIETARIO_IE VARCHAR(2),
  PROPRIETARIO_TIPO INTEGER,
  CONSTRAINT pk_mdfe_rodoviario_veiculo PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- MDFE_MUNICIPIO_DESCARREGA
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS MDFE_MUNICIPIO_DESCARREGA (
  ID SERIAL NOT NULL,
  ID_MDFE_CABECALHO INTEGER NOT NULL,
  NOME_MUNICIPIO VARCHAR(60),
  CODIGO_MUNICIPIO VARCHAR(7),
  CONSTRAINT pk_mdfe_municipio_descarrega PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- MDFE_INFORMACAO_SEGURO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS MDFE_INFORMACAO_SEGURO (
  ID SERIAL NOT NULL,
  ID_MDFE_CABECALHO INTEGER NOT NULL,
  RESPONSAVEL INTEGER,
  CNPJ_CPF VARCHAR(14),
  SEGURADORA VARCHAR(11),
  CNPJ_SEGURADORA VARCHAR(14),
  APOLICE VARCHAR(20),
  AVERBACAO VARCHAR(40),
  CONSTRAINT pk_mdfe_informacao_seguro PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- MDFE_RODOVIARIO_PEDAGIO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS MDFE_RODOVIARIO_PEDAGIO (
  ID SERIAL NOT NULL,
  ID_MDFE_RODOVIARIO INTEGER NOT NULL,
  CNPJ_FORNECEDOR VARCHAR(14),
  CNPJ_RESPONSAVEL VARCHAR(14),
  CPF_RESPONSAVEL VARCHAR(11),
  NUMERO_COMPROVANTE VARCHAR(20),
  VALOR NUMERIC(18,6),
  CONSTRAINT pk_mdfe_rodoviario_pedagio PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- MDFE_RODOVIARIO_CIOT
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS MDFE_RODOVIARIO_CIOT (
  ID SERIAL NOT NULL,
  ID_MDFE_RODOVIARIO INTEGER NOT NULL,
  CIOT VARCHAR(12),
  CPF VARCHAR(11),
  CNPJ VARCHAR(14),
  CONSTRAINT pk_mdfe_rodoviario_ciot PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- FROTA_VEICULO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FROTA_VEICULO (
  ID SERIAL NOT NULL,
  ID_FROTA_VEICULO_TIPO INTEGER NOT NULL,
  ID_FROTA_COMBUSTIVEL_TIPO INTEGER NOT NULL,
  RENAVAM VARCHAR(11),
  IPVA_MES_VENCIMENTO CHAR(2),
  DPVAT_MES_VENCIMENTO CHAR(2),
  PLACA VARCHAR(7),
  MARCA VARCHAR(100),
  MODELO VARCHAR(100),
  MODELO_ANO CHAR(4),
  CODIGO_FIPE VARCHAR(7),
  CONSTRAINT pk_frota_veiculo PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- FROTA_VEICULO_TIPO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FROTA_VEICULO_TIPO (
  ID SERIAL NOT NULL,
  CODIGO CHAR(2),
  NOME VARCHAR(100),
  CONSTRAINT pk_frota_veiculo_tipo PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- FROTA_IPVA_CONTROLE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FROTA_IPVA_CONTROLE (
  ID SERIAL NOT NULL,
  ID_FROTA_VEICULO INTEGER NOT NULL,
  PARCELA CHAR(2),
  DATA_VENCIMENTO DATE,
  DATA_PAGAMENTO DATE,
  VALOR NUMERIC(18,6),
  CONSTRAINT pk_frota_ipva_controle PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- FROTA_DPVAT_CONTROLE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FROTA_DPVAT_CONTROLE (
  ID SERIAL NOT NULL,
  ID_FROTA_VEICULO INTEGER NOT NULL,
  PARCELA CHAR(2),
  DATA_VENCIMENTO DATE,
  DATA_PAGAMENTO DATE,
  VALOR NUMERIC(18,6),
  CONSTRAINT pk_frota_dpvat_controle PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- FROTA_COMBUSTIVEL_TIPO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FROTA_COMBUSTIVEL_TIPO (
  ID SERIAL NOT NULL,
  CODIGO CHAR(2),
  NOME VARCHAR(100),
  CONSTRAINT pk_frota_combustivel_tipo PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- FROTA_MOTORISTA
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FROTA_MOTORISTA (
  ID SERIAL NOT NULL,
  ID_PESSOA_FISICA INTEGER NOT NULL,
  NUMERO_CNH VARCHAR(11),
  CNH_CATEGORIA CHAR(2),
  CONSTRAINT pk_frota_motorista PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- FROTA_VEICULO_SINISTRO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FROTA_VEICULO_SINISTRO (
  ID SERIAL NOT NULL,
  ID_FROTA_VEICULO INTEGER NOT NULL,
  DATA_SINISTRO DATE,
  OBSERVACAO TEXT,
  CONSTRAINT pk_frota_veiculo_sinistro PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- FROTA_VEICULO_MOVIMENTACAO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FROTA_VEICULO_MOVIMENTACAO (
  ID SERIAL NOT NULL,
  ID_FROTA_MOTORISTA INTEGER NOT NULL,
  ID_FROTA_VEICULO INTEGER NOT NULL,
  DATA_SAIDA DATE,
  HORA_SAIDA VARCHAR(8),
  DATA_ENTRADA DATE,
  HORA_ENTRADA VARCHAR(8),
  OBSERVACAO TEXT,
  CONSTRAINT pk_frota_veiculo_movimentacao PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- FROTA_VEICULO_PNEU
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FROTA_VEICULO_PNEU (
  ID SERIAL NOT NULL,
  DATA_TROCA DATE,
  VALOR_TROCA NUMERIC(18,6),
  POSICAO_PNEU VARCHAR(100),
  MARCA_PNEU VARCHAR(100),
  ID_FROTA_VEICULO INTEGER NOT NULL,
  CONSTRAINT pk_frota_veiculo_pneu PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- FROTA_VEICULO_MANUTENCAO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FROTA_VEICULO_MANUTENCAO (
  ID SERIAL NOT NULL,
  ID_FROTA_VEICULO INTEGER NOT NULL,
  TIPO CHAR(1),
  DATA_MANUTENCAO DATE,
  VALOR_MANUTENCAO NUMERIC(18,6),
  OBSERVACAO TEXT,
  CONSTRAINT pk_frota_veiculo_manutencao PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- FROTA_MULTA_CONTROLE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FROTA_MULTA_CONTROLE (
  ID SERIAL NOT NULL,
  ID_FROTA_VEICULO INTEGER NOT NULL,
  DATA_MULTA DATE,
  PONTOS INTEGER,
  VALOR NUMERIC(18,6),
  OBSERVACAO TEXT,
  CONSTRAINT pk_frota_multa_controle PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- FROTA_COMBUSTIVEL_CONTROLE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS FROTA_COMBUSTIVEL_CONTROLE (
  ID SERIAL NOT NULL,
  ID_FROTA_VEICULO INTEGER NOT NULL,
  DATA_ABASTECIMENTO DATE,
  HORA_ABASTECIMENTO VARCHAR(8),
  VALOR_ABASTECIMENTO NUMERIC(18,6),
  CONSTRAINT pk_frota_combustivel_controle PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- GONDOLA_RUA
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS GONDOLA_RUA (
  ID SERIAL NOT NULL,
  CODIGO VARCHAR(10),
  NOME VARCHAR(100),
  QUANTIDADE_ESTANTE INTEGER,
  CONSTRAINT pk_gondola_rua PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- GONDOLA_CAIXA
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS GONDOLA_CAIXA (
  ID SERIAL NOT NULL,
  ID_GONDOLA_ESTANTE INTEGER NOT NULL,
  CODIGO VARCHAR(10),
  ALTURA INTEGER,
  LARGURA INTEGER,
  PROFUNDIDADE INTEGER,
  CONSTRAINT pk_gondola_caixa PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- GONDOLA_ESTANTE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS GONDOLA_ESTANTE (
  ID SERIAL NOT NULL,
  ID_GONDOLA_RUA INTEGER NOT NULL,
  CODIGO VARCHAR(10),
  QUANTIDADE_CAIXA INTEGER,
  CONSTRAINT pk_gondola_estante PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- GONDOLA_ARMAZENAMENTO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS GONDOLA_ARMAZENAMENTO (
  ID SERIAL NOT NULL,
  ID_GONDOLA_CAIXA INTEGER NOT NULL,
  ID_PRODUTO INTEGER NOT NULL,
  QUANTIDADE INTEGER,
  CONSTRAINT pk_gondola_armazenamento PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PROJETO_PRINCIPAL
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PROJETO_PRINCIPAL (
  ID SERIAL NOT NULL,
  NOME VARCHAR(100),
  DATA_INICIO DATE,
  DATA_PREVISAO_FIM DATE,
  DATA_FIM DATE,
  LINK_QUADRO_TRELLO VARCHAR(100),
  VALOR_ORCAMENTO NUMERIC(18,6),
  OBSERVACAO TEXT,
  CONSTRAINT pk_projeto_principal PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PROJETO_CRONOGRAMA
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PROJETO_CRONOGRAMA (
  ID SERIAL NOT NULL,
  ID_PROJETO_PRINCIPAL INTEGER NOT NULL,
  TAREFA VARCHAR(100),
  DATA_TAREFA DATE,
  DESCRICAO TEXT,
  CONSTRAINT pk_projeto_cronograma PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PROJETO_STAKEHOLDERS
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PROJETO_STAKEHOLDERS (
  ID SERIAL NOT NULL,
  ID_PROJETO_DADOS INTEGER NOT NULL,
  ID_COLABORADOR INTEGER NOT NULL,
  CONSTRAINT pk_projeto_stakeholders PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PROJETO_RISCO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PROJETO_RISCO (
  ID SERIAL NOT NULL,
  ID_PROJETO_PRINCIPAL INTEGER NOT NULL,
  NOME VARCHAR(100),
  DESCRICAO TEXT,
  PROBABILIDADE INTEGER,
  IMPACTO INTEGER,
  CONSTRAINT pk_projeto_risco PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- PROJETO_CUSTO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS PROJETO_CUSTO (
  ID SERIAL NOT NULL,
  ID_PROJETO_PRINCIPAL INTEGER NOT NULL,
  ID_FIN_NATUREZA_FINANCEIRA INTEGER NOT NULL,
  NOME VARCHAR(100),
  JUSTIFICATIVA TEXT,
  VALOR_MENSAL NUMERIC(18,6),
  VALOR_TOTAL NUMERIC(18,6),
  CONSTRAINT pk_projeto_custo PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- BPE_CABECALHO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS BPE_CABECALHO (
  ID SERIAL NOT NULL,
  UF_EMITENTE INTEGER,
  AMBIENTE CHAR(1),
  MODELO CHAR(2),
  SERIE CHAR(3),
  NUMERO VARCHAR(9),
  CODIGO_NUMERICO VARCHAR(8),
  CHAVE_ACESSO VARCHAR(44),
  DIGITO_CHAVE_ACESSO CHAR(1),
  MODAL CHAR(2),
  DATA_HORA_EMISSAO TEXT,
  TIPO_EMISSAO CHAR(1),
  VERSAO_PROCESSO_EMISSAO VARCHAR(20),
  TIPO_BPE CHAR(1),
  CONSUMIDOR_PRESENCA CHAR(1),
  UF_INICIO_VIAGEM CHAR(2),
  CODIGO_MUNICIPIO_INICIO_VIAGEM INTEGER,
  UF_FIM_VIAGEM CHAR(2),
  CODIGO_MUNICIPIO_FIM_VIAGEM INTEGER,
  VALOR_BILHETE NUMERIC(18,6),
  VALOR_DESCONTO NUMERIC(18,6),
  VALOR_PAGO NUMERIC(18,6),
  VALOR_TROCO NUMERIC(18,6),
  TIPO_DESCONTO CHAR(2),
  DESCONTO_DESCRICAO VARCHAR(100),
  DESCONTO_CONCEDIDO_OUTROS VARCHAR(20),
  FORMA_PAGAMENTO CHAR(2),
  FORMA_PAGAMENTO_OUTROS VARCHAR(100),
  FORMA_PAGAMENTO_DOCUMENTO VARCHAR(20),
  CST CHAR(2),
  BASE_CALCULO_ICMS NUMERIC(18,6),
  ALIQUOTA_ICMS NUMERIC(18,6),
  VALOR_ICMS NUMERIC(18,6),
  PERCENTUAL_REDUCAO_BC_ICMS NUMERIC(18,6),
  INFORMACOES_ADD_FISCO TEXT,
  CONSTRAINT pk_bpe_cabecalho PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- BPE_EMITENTE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS BPE_EMITENTE (
  ID SERIAL NOT NULL,
  ID_BPE_CABECALHO INTEGER NOT NULL,
  CNPJ VARCHAR(14),
  IE VARCHAR(14),
  IEST VARCHAR(14),
  IM VARCHAR(15),
  CNAE VARCHAR(7),
  CRT INTEGER,
  NOME VARCHAR(60),
  FANTASIA VARCHAR(60),
  LOGRADOURO VARCHAR(60),
  NUMERO VARCHAR(60),
  COMPLEMENTO VARCHAR(60),
  BAIRRO VARCHAR(60),
  CODIGO_MUNICIPIO INTEGER,
  NOME_MUNICIPIO VARCHAR(60),
  UF CHAR(2),
  CEP VARCHAR(8),
  TELEFONE VARCHAR(14),
  CONSTRAINT pk_bpe_emitente PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- BPE_PASSAGEIRO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS BPE_PASSAGEIRO (
  ID SERIAL NOT NULL,
  ID_BPE_CABECALHO INTEGER NOT NULL,
  NOME VARCHAR(60),
  CPF VARCHAR(11),
  TIPO_DOCUMENTO_IDENTIFICACAO CHAR(1),
  NUMERO_DOCUMENTO VARCHAR(20),
  DOCUMENTO_OUTROS_DESCRICAO VARCHAR(100),
  DATA_NASCIMENTO DATE,
  TELEFONE VARCHAR(12),
  EMAIL VARCHAR(60),
  CONSTRAINT pk_bpe_passageiro PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- BPE_COMPRADOR
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS BPE_COMPRADOR (
  ID SERIAL NOT NULL,
  ID_BPE_CABECALHO INTEGER NOT NULL,
  CNPJ VARCHAR(14),
  CPF VARCHAR(11),
  IE VARCHAR(20),
  NOME VARCHAR(60),
  FANTASIA VARCHAR(60),
  TELEFONE VARCHAR(14),
  LOGRADOURO VARCHAR(250),
  NUMERO VARCHAR(60),
  COMPLEMENTO VARCHAR(60),
  BAIRRO VARCHAR(60),
  CODIGO_MUNICIPIO INTEGER,
  NOME_MUNICIPIO VARCHAR(60),
  UF CHAR(2),
  CEP VARCHAR(8),
  CODIGO_PAIS INTEGER,
  NOME_PAIS VARCHAR(60),
  EMAIL VARCHAR(60),
  CONSTRAINT pk_bpe_comprador PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- BPE_VIAGEM
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS BPE_VIAGEM (
  ID SERIAL NOT NULL,
  ID_BPE_CABECALHO INTEGER NOT NULL,
  CODIGO_PERCURSO VARCHAR(20),
  DESCRICAO_PERCURSO VARCHAR(100),
  TIPO_VIAGEM CHAR(2),
  TIPO_SERVICO CHAR(1),
  TIPO_ACOMODACAO CHAR(1),
  TIPO_TRECHO CHAR(1),
  DATA_HORA_VIAGEM TEXT,
  DATA_HORA_CONEXAO TEXT,
  PREFIXO_LINHA VARCHAR(20),
  POLTRONA CHAR(3),
  PLATAFORMA VARCHAR(10),
  CONSTRAINT pk_bpe_viagem PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- BPE_AGENCIA
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS BPE_AGENCIA (
  ID SERIAL NOT NULL,
  ID_BPE_CABECALHO INTEGER NOT NULL,
  CNPJ VARCHAR(14),
  NOME VARCHAR(60),
  TELEFONE VARCHAR(14),
  LOGRADOURO VARCHAR(250),
  NUMERO VARCHAR(60),
  COMPLEMENTO VARCHAR(60),
  BAIRRO VARCHAR(60),
  CODIGO_MUNICIPIO INTEGER,
  NOME_MUNICIPIO VARCHAR(60),
  UF CHAR(2),
  CEP VARCHAR(8),
  CODIGO_PAIS INTEGER,
  NOME_PAIS VARCHAR(60),
  EMAIL VARCHAR(60),
  CONSTRAINT pk_bpe_agencia PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- BPE_PASSAGEM
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS BPE_PASSAGEM (
  ID SERIAL NOT NULL,
  ID_BPE_CABECALHO INTEGER NOT NULL,
  CODIGO_LOCALIDADE_ORIGEM VARCHAR(7),
  DESCRICAO_LOCALIDADE_ORIGEM VARCHAR(60),
  CODIGO_LOCALIDADE_DESTINO VARCHAR(7),
  DESCRICAO_LOCALIDADE_DESTINO VARCHAR(60),
  DATA_HORA_EMBARQUE TEXT,
  DATA_HORA_VALIDADE TEXT,
  CONSTRAINT pk_bpe_passagem PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CRM_SAC_CABECALHO
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CRM_SAC_CABECALHO (
  ID SERIAL NOT NULL,
  DATA_ABERTURA DATE,
  HORA_ABERTURA VARCHAR(8),
  NUMERO_PROTOCOLO VARCHAR(100),
  NIVEL_RECLAMACAO CHAR(1),
  ID_CLIENTE INTEGER NOT NULL,
  CONSTRAINT pk_crm_sac_cabecalho PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CRM_SAC_DETALHE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CRM_SAC_DETALHE (
  ID SERIAL NOT NULL,
  ID_CRM_SAC_CABECALHO INTEGER NOT NULL,
  DATA_REGISTRO DATE,
  HORA_REGISTRO VARCHAR(8),
  HISTORICO TEXT,
  CONSTRAINT pk_crm_sac_detalhe PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CRM_BUSCAS_CLIENTE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CRM_BUSCAS_CLIENTE (
  ID SERIAL NOT NULL,
  DATA_BUSCA DATE,
  HORA_BUSCA VARCHAR(8),
  DETALHES TEXT,
  ID_CLIENTE INTEGER NOT NULL,
  CONSTRAINT pk_crm_buscas_cliente PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CRM_CARTEIRA_CLIENTE
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CRM_CARTEIRA_CLIENTE (
  ID SERIAL NOT NULL,
  ID_CRM_CARTEIRA_CLIENTE_PERFIL INTEGER NOT NULL,
  ID_CLIENTE INTEGER NOT NULL,
  CONSTRAINT pk_crm_carteira_cliente PRIMARY KEY (ID)
);

-- ----------------------------------------------------------------
-- CRM_CARTEIRA_CLIENTE_PERFIL
-- ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CRM_CARTEIRA_CLIENTE_PERFIL (
  ID SERIAL NOT NULL,
  CODIGO CHAR(2),
  NOME VARCHAR(100),
  CONSTRAINT pk_crm_carteira_cliente_perfil PRIMARY KEY (ID)
);

-- ================================================================
-- Índices
-- ================================================================
CREATE INDEX IF NOT EXISTS idx_pessoa_fisica_fk_pessoa_fisica_pessoa1_idx ON PESSOA_FISICA (ID_PESSOA);
CREATE INDEX IF NOT EXISTS idx_pessoa_fisica_fk_pessoa_fisica_nivel_formacao1_idx ON PESSOA_FISICA (ID_NIVEL_FORMACAO);
CREATE INDEX IF NOT EXISTS idx_pessoa_fisica_fk_pessoa_fisica_estado_civil1_idx ON PESSOA_FISICA (ID_ESTADO_CIVIL);
CREATE INDEX IF NOT EXISTS idx_pessoa_juridica_fk_pessoa_juridica_pessoa1_idx ON PESSOA_JURIDICA (ID_PESSOA);
CREATE INDEX IF NOT EXISTS idx_cliente_fk_cliente_pessoa_idx ON CLIENTE (ID_PESSOA);
CREATE INDEX IF NOT EXISTS idx_cliente_fk_cliente_tabela_preco1_idx ON CLIENTE (ID_TABELA_PRECO);
CREATE INDEX IF NOT EXISTS idx_fornecedor_fk_fornecedor_pessoa1_idx ON FORNECEDOR (ID_PESSOA);
CREATE INDEX IF NOT EXISTS idx_transportadora_fk_transportadora_pessoa1_idx ON TRANSPORTADORA (ID_PESSOA);
CREATE INDEX IF NOT EXISTS idx_contador_fk_contador_pessoa1_idx ON CONTADOR (ID_PESSOA);
CREATE INDEX IF NOT EXISTS idx_colaborador_fk_colaborador_pessoa1_idx ON COLABORADOR (ID_PESSOA);
CREATE INDEX IF NOT EXISTS idx_colaborador_fk_colaborador_cargo1_idx ON COLABORADOR (ID_CARGO);
CREATE INDEX IF NOT EXISTS idx_colaborador_fk_colaborador_setor1_idx ON COLABORADOR (ID_SETOR);
CREATE INDEX IF NOT EXISTS idx_colaborador_fk_colaborador_colaborador_situacao1_idx ON COLABORADOR (ID_COLABORADOR_SITUACAO);
CREATE INDEX IF NOT EXISTS idx_colaborador_fk_colaborador_tipo_admissao1_idx ON COLABORADOR (ID_TIPO_ADMISSAO);
CREATE INDEX IF NOT EXISTS idx_colaborador_fk_colaborador_colaborador_tipo1_idx ON COLABORADOR (ID_COLABORADOR_TIPO);
CREATE INDEX IF NOT EXISTS idx_colaborador_fk_colaborador_sindicato1_idx ON COLABORADOR (ID_SINDICATO);
CREATE INDEX IF NOT EXISTS idx_vendedor_fk_vendedor_colaborador1_idx ON VENDEDOR (ID_COLABORADOR);
CREATE INDEX IF NOT EXISTS idx_vendedor_fk_vendedor_comissao_perfil1_idx ON VENDEDOR (ID_COMISSAO_PERFIL);
CREATE INDEX IF NOT EXISTS idx_pessoa_endereco_fk_pessoa_endereco_pessoa1_idx ON PESSOA_ENDERECO (ID_PESSOA);
CREATE INDEX IF NOT EXISTS idx_pessoa_contato_fk_pessoa_contato_pessoa1_idx ON PESSOA_CONTATO (ID_PESSOA);
CREATE INDEX IF NOT EXISTS idx_pessoa_telefone_fk_pessoa_telefone_pessoa1_idx ON PESSOA_TELEFONE (ID_PESSOA);
CREATE INDEX IF NOT EXISTS idx_usuario_fk_usuario_colaborador1_idx ON USUARIO (ID_COLABORADOR);
CREATE INDEX IF NOT EXISTS idx_usuario_fk_usuario_papel1_idx ON USUARIO (ID_PAPEL);
CREATE INDEX IF NOT EXISTS idx_papel_funcao_fk_papel_funcao_papel1_idx ON PAPEL_FUNCAO (ID_PAPEL);
CREATE INDEX IF NOT EXISTS idx_papel_funcao_fk_papel_funcao_funcao1_idx ON PAPEL_FUNCAO (ID_FUNCAO);
CREATE INDEX IF NOT EXISTS idx_produto_fk_produto_produto_subgrupo1_idx ON PRODUTO (ID_PRODUTO_SUBGRUPO);
CREATE INDEX IF NOT EXISTS idx_produto_fk_produto_produto_marca1_idx ON PRODUTO (ID_PRODUTO_MARCA);
CREATE INDEX IF NOT EXISTS idx_produto_fk_produto_produto_unidade1_idx ON PRODUTO (ID_PRODUTO_UNIDADE);
CREATE INDEX IF NOT EXISTS idx_produto_fk_produto_tribut_icms_custom_cab1_idx ON PRODUTO (ID_TRIBUT_ICMS_CUSTOM_CAB);
CREATE INDEX IF NOT EXISTS idx_produto_fk_produto_tribut_grupo_tributario1_idx ON PRODUTO (ID_TRIBUT_GRUPO_TRIBUTARIO);
CREATE INDEX IF NOT EXISTS idx_produto_subgrupo_fk_produto_subgrupo_produto_grupo1_idx ON PRODUTO_SUBGRUPO (ID_PRODUTO_GRUPO);
CREATE INDEX IF NOT EXISTS idx_banco_agencia_fk_banco_agencia_banco1_idx ON BANCO_AGENCIA (ID_BANCO);
CREATE INDEX IF NOT EXISTS idx_banco_conta_caixa_fk_banco_conta_caixa_banco_agencia1_idx ON BANCO_CONTA_CAIXA (ID_BANCO_AGENCIA);
CREATE INDEX IF NOT EXISTS idx_municipio_fk_municipio_uf1_idx ON MUNICIPIO (ID_UF);
CREATE INDEX IF NOT EXISTS idx_empresa_endereco_fk_empresa_endereco_empresa1_idx ON EMPRESA_ENDERECO (ID_EMPRESA);
CREATE INDEX IF NOT EXISTS idx_empresa_contato_fk_empresa_contato_empresa1_idx ON EMPRESA_CONTATO (ID_EMPRESA);
CREATE INDEX IF NOT EXISTS idx_empresa_telefone_fk_empresa_telefone_empresa1_idx ON EMPRESA_TELEFONE (ID_EMPRESA);
CREATE INDEX IF NOT EXISTS idx_talonario_cheque_fk_talonario_cheque_banco_conta_caixa1_i ON TALONARIO_CHEQUE (ID_BANCO_CONTA_CAIXA);
CREATE INDEX IF NOT EXISTS idx_cheque_fk_talonario_cheque ON CHEQUE (ID_TALONARIO_CHEQUE);
CREATE INDEX IF NOT EXISTS idx_fin_fechamento_caixa_banco_fk_fin_fechamento_caixa_banco_banco_cont ON FIN_FECHAMENTO_CAIXA_BANCO (ID_BANCO_CONTA_CAIXA);
CREATE INDEX IF NOT EXISTS idx_fin_extrato_conta_banco_fk_fin_extrato_conta_banco_banco_conta_c ON FIN_EXTRATO_CONTA_BANCO (ID_BANCO_CONTA_CAIXA);
CREATE INDEX IF NOT EXISTS idx_fin_lancamento_pagar_fk_doc_orig_lcto_pagar ON FIN_LANCAMENTO_PAGAR (ID_FIN_DOCUMENTO_ORIGEM);
CREATE INDEX IF NOT EXISTS idx_fin_lancamento_pagar_fk_fin_lancamento_pagar_fin_natureza_fin ON FIN_LANCAMENTO_PAGAR (ID_FIN_NATUREZA_FINANCEIRA);
CREATE INDEX IF NOT EXISTS idx_fin_lancamento_pagar_fk_fin_lancamento_pagar_fornecedor1_idx ON FIN_LANCAMENTO_PAGAR (ID_FORNECEDOR);
CREATE INDEX IF NOT EXISTS idx_fin_lancamento_pagar_fk_fin_lancamento_pagar_banco_conta_caix ON FIN_LANCAMENTO_PAGAR (ID_BANCO_CONTA_CAIXA);
CREATE INDEX IF NOT EXISTS idx_fin_parcela_pagar_fk_status_parcela_pagar ON FIN_PARCELA_PAGAR (ID_FIN_STATUS_PARCELA);
CREATE INDEX IF NOT EXISTS idx_fin_parcela_pagar_fk_lancamento_parcela ON FIN_PARCELA_PAGAR (ID_FIN_LANCAMENTO_PAGAR);
CREATE INDEX IF NOT EXISTS idx_fin_parcela_pagar_fk_fin_parcela_pagar_fin_tipo_pagamento1 ON FIN_PARCELA_PAGAR (ID_FIN_TIPO_PAGAMENTO);
CREATE INDEX IF NOT EXISTS idx_fin_parcela_pagar_fk_fin_parcela_pagar_fin_cheque_emitido1 ON FIN_PARCELA_PAGAR (ID_FIN_CHEQUE_EMITIDO);
CREATE INDEX IF NOT EXISTS idx_fin_cheque_emitido_fk_cheque_emitido ON FIN_CHEQUE_EMITIDO (ID_CHEQUE);
CREATE INDEX IF NOT EXISTS idx_fin_lancamento_receber_fk_doc_ori_lanc_receber ON FIN_LANCAMENTO_RECEBER (ID_FIN_DOCUMENTO_ORIGEM);
CREATE INDEX IF NOT EXISTS idx_fin_lancamento_receber_fk_fin_lancamento_receber_fin_natureza_f ON FIN_LANCAMENTO_RECEBER (ID_FIN_NATUREZA_FINANCEIRA);
CREATE INDEX IF NOT EXISTS idx_fin_lancamento_receber_fk_fin_lancamento_receber_cliente1_idx ON FIN_LANCAMENTO_RECEBER (ID_CLIENTE);
CREATE INDEX IF NOT EXISTS idx_fin_lancamento_receber_fk_fin_lancamento_receber_banco_conta_ca ON FIN_LANCAMENTO_RECEBER (ID_BANCO_CONTA_CAIXA);
CREATE INDEX IF NOT EXISTS idx_fin_parcela_receber_fk_lancamento_parcela_receber ON FIN_PARCELA_RECEBER (ID_FIN_LANCAMENTO_RECEBER);
CREATE INDEX IF NOT EXISTS idx_fin_parcela_receber_fk_status_parcela_receber ON FIN_PARCELA_RECEBER (ID_FIN_STATUS_PARCELA);
CREATE INDEX IF NOT EXISTS idx_fin_parcela_receber_fk_fin_parcela_receber_fin_tipo_recebime ON FIN_PARCELA_RECEBER (ID_FIN_TIPO_RECEBIMENTO);
CREATE INDEX IF NOT EXISTS idx_fin_parcela_receber_fk_fin_parcela_receber_fin_cheque_recebi ON FIN_PARCELA_RECEBER (ID_FIN_CHEQUE_RECEBIDO);
CREATE INDEX IF NOT EXISTS idx_fin_cheque_recebido_fk_fin_cheque_recebido_pessoa1_idx ON FIN_CHEQUE_RECEBIDO (ID_PESSOA);
CREATE INDEX IF NOT EXISTS idx_fin_configuracao_boleto_fk_fin_configuracao_boleto_banco_conta_c ON FIN_CONFIGURACAO_BOLETO (ID_BANCO_CONTA_CAIXA);
CREATE INDEX IF NOT EXISTS idx_tribut_icms_uf_fk_config_of_gt_icms ON TRIBUT_ICMS_UF (ID_TRIBUT_CONFIGURA_OF_GT);
CREATE INDEX IF NOT EXISTS idx_tribut_pis_fk_config_of_gt_pis ON TRIBUT_PIS (ID_TRIBUT_CONFIGURA_OF_GT);
CREATE INDEX IF NOT EXISTS idx_tribut_cofins_fk_config_of_gt_cofins ON TRIBUT_COFINS (ID_TRIBUT_CONFIGURA_OF_GT);
CREATE INDEX IF NOT EXISTS idx_tribut_ipi_fk_config_of_gt_ipi ON TRIBUT_IPI (ID_TRIBUT_CONFIGURA_OF_GT);
CREATE INDEX IF NOT EXISTS idx_tribut_iss_fk_tribut_op_fiscal_iss ON TRIBUT_ISS (ID_TRIBUT_OPERACAO_FISCAL);
CREATE INDEX IF NOT EXISTS idx_compra_requisicao_fk_tipo_req_compra ON COMPRA_REQUISICAO (ID_COMPRA_TIPO_REQUISICAO);
CREATE INDEX IF NOT EXISTS idx_compra_requisicao_fk_compra_requisicao_colaborador1_idx ON COMPRA_REQUISICAO (ID_COLABORADOR);
CREATE INDEX IF NOT EXISTS idx_compra_requisicao_detalhe_fk_requisicao_compra_detalhe ON COMPRA_REQUISICAO_DETALHE (ID_COMPRA_REQUISICAO);
CREATE INDEX IF NOT EXISTS idx_compra_requisicao_detalhe_fk_compra_requisicao_detalhe_produto1_id ON COMPRA_REQUISICAO_DETALHE (ID_PRODUTO);
CREATE INDEX IF NOT EXISTS idx_compra_cotacao_fk_compra_cotacao_compra_requisicao1_idx ON COMPRA_COTACAO (ID_COMPRA_REQUISICAO);
CREATE INDEX IF NOT EXISTS idx_compra_fornecedor_cotacao_fk_cotacao_fornecedor ON COMPRA_FORNECEDOR_COTACAO (ID_COMPRA_COTACAO);
CREATE INDEX IF NOT EXISTS idx_compra_fornecedor_cotacao_fk_compra_fornecedor_cotacao_fornecedor1 ON COMPRA_FORNECEDOR_COTACAO (ID_FORNECEDOR);
CREATE INDEX IF NOT EXISTS idx_compra_cotacao_detalhe_fk_fornecedor_cotacao_detalhe ON COMPRA_COTACAO_DETALHE (ID_COMPRA_FORNECEDOR_COTACAO);
CREATE INDEX IF NOT EXISTS idx_compra_cotacao_detalhe_fk_compra_cotacao_detalhe_produto1_idx ON COMPRA_COTACAO_DETALHE (ID_PRODUTO);
CREATE INDEX IF NOT EXISTS idx_compra_pedido_fk_tipo_pedido_compra ON COMPRA_PEDIDO (ID_COMPRA_TIPO_PEDIDO);
CREATE INDEX IF NOT EXISTS idx_compra_pedido_fk_compra_pedido_fornecedor1_idx ON COMPRA_PEDIDO (ID_FORNECEDOR);
CREATE INDEX IF NOT EXISTS idx_compra_pedido_fk_compra_pedido_colaborador1_idx ON COMPRA_PEDIDO (ID_COLABORADOR);
CREATE INDEX IF NOT EXISTS idx_compra_pedido_detalhe_fk_pedido_compra_detalhe ON COMPRA_PEDIDO_DETALHE (ID_COMPRA_PEDIDO);
CREATE INDEX IF NOT EXISTS idx_compra_pedido_detalhe_fk_compra_pedido_detalhe_produto1_idx ON COMPRA_PEDIDO_DETALHE (ID_PRODUTO);
CREATE INDEX IF NOT EXISTS idx_venda_orcamento_cabecalho_fk_cond_pgto_orc_ped_venda ON VENDA_ORCAMENTO_CABECALHO (ID_VENDA_CONDICOES_PAGAMENTO);
CREATE INDEX IF NOT EXISTS idx_venda_orcamento_cabecalho_fk_venda_orcamento_cabecalho_vendedor1_i ON VENDA_ORCAMENTO_CABECALHO (ID_VENDEDOR);
CREATE INDEX IF NOT EXISTS idx_venda_orcamento_cabecalho_fk_venda_orcamento_cabecalho_cliente1_id ON VENDA_ORCAMENTO_CABECALHO (ID_CLIENTE);
CREATE INDEX IF NOT EXISTS idx_venda_orcamento_cabecalho_fk_venda_orcamento_cabecalho_transportad ON VENDA_ORCAMENTO_CABECALHO (ID_TRANSPORTADORA);
CREATE INDEX IF NOT EXISTS idx_nota_fiscal_tipo_fk_nf_tipo_modelo ON NOTA_FISCAL_TIPO (ID_NOTA_FISCAL_MODELO);
CREATE INDEX IF NOT EXISTS idx_venda_orcamento_detalhe_fk_venda_orcamento_cab_det ON VENDA_ORCAMENTO_DETALHE (ID_VENDA_ORCAMENTO_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_venda_orcamento_detalhe_fk_venda_orcamento_detalhe_produto1_idx ON VENDA_ORCAMENTO_DETALHE (ID_PRODUTO);
CREATE INDEX IF NOT EXISTS idx_venda_cabecalho_fk_orcamento_venda ON VENDA_CABECALHO (ID_VENDA_ORCAMENTO_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_venda_cabecalho_fk_venda_cab_condicoes ON VENDA_CABECALHO (ID_VENDA_CONDICOES_PAGAMENTO);
CREATE INDEX IF NOT EXISTS idx_venda_cabecalho_fk_tipo_nf_venda_cab ON VENDA_CABECALHO (ID_NOTA_FISCAL_TIPO);
CREATE INDEX IF NOT EXISTS idx_venda_cabecalho_fk_venda_cabecalho_cliente1_idx ON VENDA_CABECALHO (ID_CLIENTE);
CREATE INDEX IF NOT EXISTS idx_venda_cabecalho_fk_venda_cabecalho_transportadora1_idx ON VENDA_CABECALHO (ID_TRANSPORTADORA);
CREATE INDEX IF NOT EXISTS idx_venda_cabecalho_fk_venda_cabecalho_vendedor1_idx ON VENDA_CABECALHO (ID_VENDEDOR);
CREATE INDEX IF NOT EXISTS idx_venda_detalhe_fk_venda_cab_det ON VENDA_DETALHE (ID_VENDA_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_venda_detalhe_fk_venda_detalhe_produto1_idx ON VENDA_DETALHE (ID_PRODUTO);
CREATE INDEX IF NOT EXISTS idx_venda_condicoes_parcelas_fk_condicoes_parcelas ON VENDA_CONDICOES_PARCELAS (ID_VENDA_CONDICOES_PAGAMENTO);
CREATE INDEX IF NOT EXISTS idx_venda_frete_fk_venda_cabecalho_frete ON VENDA_FRETE (ID_VENDA_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_venda_frete_fk_venda_frete_transportadora1_idx ON VENDA_FRETE (ID_TRANSPORTADORA);
CREATE INDEX IF NOT EXISTS idx_venda_comissao_fk_venda_comissao ON VENDA_COMISSAO (ID_VENDA_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_venda_comissao_fk_venda_comissao_vendedor1_idx ON VENDA_COMISSAO (ID_VENDEDOR);
CREATE INDEX IF NOT EXISTS idx_requisicao_interna_cabecalho_fk_requisicao_interna_cabecalho_colabora ON REQUISICAO_INTERNA_CABECALHO (ID_COLABORADOR);
CREATE INDEX IF NOT EXISTS idx_requisicao_interna_detalhe_fk_req_interna_cab_det ON REQUISICAO_INTERNA_DETALHE (ID_REQUISICAO_INTERNA_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_requisicao_interna_detalhe_fk_requisicao_interna_detalhe_produto1_i ON REQUISICAO_INTERNA_DETALHE (ID_PRODUTO);
CREATE INDEX IF NOT EXISTS idx_estoque_reajuste_cabecalho_fk_estoque_reajuste_cabecalho_colaborado ON ESTOQUE_REAJUSTE_CABECALHO (ID_COLABORADOR);
CREATE INDEX IF NOT EXISTS idx_estoque_reajuste_detalhe_fk_estoque_reajuste_cab_det ON ESTOQUE_REAJUSTE_DETALHE (ID_ESTOQUE_REAJUSTE_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_estoque_reajuste_detalhe_fk_estoque_reajuste_detalhe_produto1_idx ON ESTOQUE_REAJUSTE_DETALHE (ID_PRODUTO);
CREATE INDEX IF NOT EXISTS idx_estoque_grade_fk_estoque_cor_grade ON ESTOQUE_GRADE (ID_ESTOQUE_COR);
CREATE INDEX IF NOT EXISTS idx_estoque_grade_fk_estoque_tamanho_grade ON ESTOQUE_GRADE (ID_ESTOQUE_TAMANHO);
CREATE INDEX IF NOT EXISTS idx_estoque_grade_fk_estoque_sabor ON ESTOQUE_GRADE (ID_ESTOQUE_SABOR);
CREATE INDEX IF NOT EXISTS idx_estoque_grade_fk_estoque_marca ON ESTOQUE_GRADE (ID_ESTOQUE_MARCA);
CREATE INDEX IF NOT EXISTS idx_estoque_grade_fk_estoque_grade_produto1_idx ON ESTOQUE_GRADE (ID_PRODUTO);
CREATE INDEX IF NOT EXISTS idx_tribut_configura_of_gt_fk_op_fiscal_configura ON TRIBUT_CONFIGURA_OF_GT (ID_TRIBUT_OPERACAO_FISCAL);
CREATE INDEX IF NOT EXISTS idx_tribut_configura_of_gt_fk_grupo_trib_configura ON TRIBUT_CONFIGURA_OF_GT (ID_TRIBUT_GRUPO_TRIBUTARIO);
CREATE INDEX IF NOT EXISTS idx_tribut_icms_custom_det_fk_icms_custom_cab_det ON TRIBUT_ICMS_CUSTOM_DET (ID_TRIBUT_ICMS_CUSTOM_CAB);
CREATE INDEX IF NOT EXISTS idx_nfe_cabecalho_fk_nfe_cabecalho_vendedor1_idx ON NFE_CABECALHO (ID_VENDEDOR);
CREATE INDEX IF NOT EXISTS idx_nfe_cabecalho_fk_nfe_cabecalho_fornecedor1_idx ON NFE_CABECALHO (ID_FORNECEDOR);
CREATE INDEX IF NOT EXISTS idx_nfe_cabecalho_fk_nfe_cabecalho_nfce_movimento1_idx ON NFE_CABECALHO (ID_NFCE_MOVIMENTO);
CREATE INDEX IF NOT EXISTS idx_nfe_cabecalho_fk_nfe_cabecalho_venda_cabecalho1_idx ON NFE_CABECALHO (ID_VENDA_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_nfe_cabecalho_fk_nfe_cabecalho_tribut_operacao_fiscal1 ON NFE_CABECALHO (ID_TRIBUT_OPERACAO_FISCAL);
CREATE INDEX IF NOT EXISTS idx_nfe_cabecalho_fk_nfe_cabecalho_cliente1_idx ON NFE_CABECALHO (ID_CLIENTE);
CREATE INDEX IF NOT EXISTS idx_nfe_detalhe_fk_nfe_cab_det ON NFE_DETALHE (ID_NFE_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_nfe_detalhe_fk_nfe_detalhe_produto1_idx ON NFE_DETALHE (ID_PRODUTO);
CREATE INDEX IF NOT EXISTS idx_nfe_referenciada_fk_nfe_referenciada ON NFE_REFERENCIADA (ID_NFE_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_nfe_emitente_fk_nfe_emitente ON NFE_EMITENTE (ID_NFE_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_nfe_destinatario_fk_nfe_destinatario ON NFE_DESTINATARIO (ID_NFE_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_nfe_local_retirada_fk_nfe_local_retirada ON NFE_LOCAL_RETIRADA (ID_NFE_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_nfe_local_entrega_fk_nfe_local_entrega ON NFE_LOCAL_ENTREGA (ID_NFE_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_nfe_det_especifico_veiculo_fk_nfe_det_especifico_veiculo ON NFE_DET_ESPECIFICO_VEICULO (ID_NFE_DETALHE);
CREATE INDEX IF NOT EXISTS idx_nfe_det_especifico_medicamento_fk_nfe_det_esp_medicamento ON NFE_DET_ESPECIFICO_MEDICAMENTO (ID_NFE_DETALHE);
CREATE INDEX IF NOT EXISTS idx_nfe_det_especifico_armamento_fk_nfe_det_esp_armamento ON NFE_DET_ESPECIFICO_ARMAMENTO (ID_NFE_DETALHE);
CREATE INDEX IF NOT EXISTS idx_nfe_det_especifico_combustivel_fk_nfe_det_esp_combustivel ON NFE_DET_ESPECIFICO_COMBUSTIVEL (ID_NFE_DETALHE);
CREATE INDEX IF NOT EXISTS idx_nfe_transporte_fk_nfe_transporte ON NFE_TRANSPORTE (ID_NFE_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_nfe_transporte_fk_nfe_transporte_transportadora1_idx ON NFE_TRANSPORTE (ID_TRANSPORTADORA);
CREATE INDEX IF NOT EXISTS idx_nfe_fatura_fk_nfe_cab_fatura ON NFE_FATURA (ID_NFE_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_nfe_duplicata_fk_nfe_duplicata_nfe_fatura1_idx ON NFE_DUPLICATA (ID_NFE_FATURA);
CREATE INDEX IF NOT EXISTS idx_nfe_declaracao_importacao_fk_nfe_det_dec_importacao ON NFE_DECLARACAO_IMPORTACAO (ID_NFE_DETALHE);
CREATE INDEX IF NOT EXISTS idx_nfe_importacao_detalhe_fk_nfe_importacao_detalhe ON NFE_IMPORTACAO_DETALHE (ID_NFE_DECLARACAO_IMPORTACAO);
CREATE INDEX IF NOT EXISTS idx_nfe_cana_fk_nfe_cab_cana ON NFE_CANA (ID_NFE_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_nfe_cana_fornecimento_diario_fk_nfe_cana_fornecimento ON NFE_CANA_FORNECIMENTO_DIARIO (ID_NFE_CANA);
CREATE INDEX IF NOT EXISTS idx_nfe_cana_deducoes_safra_fk_nfe_cana_deducoes ON NFE_CANA_DEDUCOES_SAFRA (ID_NFE_CANA);
CREATE INDEX IF NOT EXISTS idx_nfe_cupom_fiscal_referenciado_fk_nfe_cf_referenciado ON NFE_CUPOM_FISCAL_REFERENCIADO (ID_NFE_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_nfe_prod_rural_referenciada_fk_nfe_rural_referenciado ON NFE_PROD_RURAL_REFERENCIADA (ID_NFE_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_nfe_nf_referenciada_fk_nfe_nf_referenciada ON NFE_NF_REFERENCIADA (ID_NFE_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_nfe_detalhe_imposto_icms_fk_nfe_det_icms ON NFE_DETALHE_IMPOSTO_ICMS (ID_NFE_DETALHE);
CREATE INDEX IF NOT EXISTS idx_nfe_detalhe_imposto_ipi_fk_nfe_det_ipi ON NFE_DETALHE_IMPOSTO_IPI (ID_NFE_DETALHE);
CREATE INDEX IF NOT EXISTS idx_nfe_detalhe_imposto_ii_fk_nfe_det_ii ON NFE_DETALHE_IMPOSTO_II (ID_NFE_DETALHE);
CREATE INDEX IF NOT EXISTS idx_nfe_detalhe_imposto_pis_fk_nfe_det_pis ON NFE_DETALHE_IMPOSTO_PIS (ID_NFE_DETALHE);
CREATE INDEX IF NOT EXISTS idx_nfe_detalhe_imposto_cofins_fk_nfe_det_cofins ON NFE_DETALHE_IMPOSTO_COFINS (ID_NFE_DETALHE);
CREATE INDEX IF NOT EXISTS idx_nfe_detalhe_imposto_issqn_fk_nfe_det_issqn ON NFE_DETALHE_IMPOSTO_ISSQN (ID_NFE_DETALHE);
CREATE INDEX IF NOT EXISTS idx_nfe_transporte_reboque_fk_nfe_transp_reboque ON NFE_TRANSPORTE_REBOQUE (ID_NFE_TRANSPORTE);
CREATE INDEX IF NOT EXISTS idx_nfe_transporte_volume_fk_transp_volume ON NFE_TRANSPORTE_VOLUME (ID_NFE_TRANSPORTE);
CREATE INDEX IF NOT EXISTS idx_nfe_transporte_volume_lacre_fk_nfe_transp_vol_lacre ON NFE_TRANSPORTE_VOLUME_LACRE (ID_NFE_TRANSPORTE_VOLUME);
CREATE INDEX IF NOT EXISTS idx_nfe_processo_referenciado_nfe_cab_proc_ref ON NFE_PROCESSO_REFERENCIADO (ID_NFE_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_nfe_cte_referenciado_fk_nfe_cte_referenciado ON NFE_CTE_REFERENCIADO (ID_NFE_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_nfe_acesso_xml_fk_acesso_xml ON NFE_ACESSO_XML (ID_NFE_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_nfe_exportacao_fk_nfe_exportacao ON NFE_EXPORTACAO (ID_NFE_DETALHE);
CREATE INDEX IF NOT EXISTS idx_nfe_informacao_pagamento_fk_nfe_forma_pagamento ON NFE_INFORMACAO_PAGAMENTO (ID_NFE_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_nfe_item_rastreado_fk_nfe_item_rastreado_nfe_detalhe1_idx ON NFE_ITEM_RASTREADO (ID_NFE_DETALHE);
CREATE INDEX IF NOT EXISTS idx_nfe_detalhe_imposto_pis_st_fk_nfe_det_pis ON NFE_DETALHE_IMPOSTO_PIS_ST (ID_NFE_DETALHE);
CREATE INDEX IF NOT EXISTS idx_nfe_detalhe_imposto_icms_ufdest_fk_nfe_det_icms ON NFE_DETALHE_IMPOSTO_ICMS_UFDEST (ID_NFE_DETALHE);
CREATE INDEX IF NOT EXISTS idx_nfe_detalhe_imposto_cofins_st_fk_nfe_det_cofins ON NFE_DETALHE_IMPOSTO_COFINS_ST (ID_NFE_DETALHE);
CREATE INDEX IF NOT EXISTS idx_nfe_responsavel_tecnico_fk_nfe_responsavel_tecnico_nfe_cabecalho ON NFE_RESPONSAVEL_TECNICO (ID_NFE_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_tabela_preco_produto_fk_tabela_preco ON TABELA_PRECO_PRODUTO (ID_TABELA_PRECO);
CREATE INDEX IF NOT EXISTS idx_tabela_preco_produto_fk_tabela_preco_produto_produto1_idx ON TABELA_PRECO_PRODUTO (ID_PRODUTO);
CREATE INDEX IF NOT EXISTS idx_ged_documento_detalhe_fk_ged_tipo_documento ON GED_DOCUMENTO_DETALHE (ID_GED_TIPO_DOCUMENTO);
CREATE INDEX IF NOT EXISTS idx_ged_documento_detalhe_fk_ged_documento_cab_det ON GED_DOCUMENTO_DETALHE (ID_GED_DOCUMENTO_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_ged_versao_documento_fk_ged_doc_versao_doc ON GED_VERSAO_DOCUMENTO (ID_GED_DOCUMENTO_DETALHE);
CREATE INDEX IF NOT EXISTS idx_ged_versao_documento_fk_ged_versao_documento_colaborador1_idx ON GED_VERSAO_DOCUMENTO (ID_COLABORADOR);
CREATE INDEX IF NOT EXISTS idx_os_abertura_fk_os_status_abertura ON OS_ABERTURA (ID_OS_STATUS);
CREATE INDEX IF NOT EXISTS idx_os_abertura_fk_os_abertura_cliente1_idx ON OS_ABERTURA (ID_CLIENTE);
CREATE INDEX IF NOT EXISTS idx_os_abertura_fk_os_abertura_colaborador1_idx ON OS_ABERTURA (ID_COLABORADOR);
CREATE INDEX IF NOT EXISTS idx_os_abertura_equipamento_fk_os_abert_equip ON OS_ABERTURA_EQUIPAMENTO (ID_OS_ABERTURA);
CREATE INDEX IF NOT EXISTS idx_os_abertura_equipamento_fk_os_equip_abert ON OS_ABERTURA_EQUIPAMENTO (ID_OS_EQUIPAMENTO);
CREATE INDEX IF NOT EXISTS idx_os_produto_servico_fk_os_abert_prod_serv ON OS_PRODUTO_SERVICO (ID_OS_ABERTURA);
CREATE INDEX IF NOT EXISTS idx_os_produto_servico_fk_os_produto_servico_produto1_idx ON OS_PRODUTO_SERVICO (ID_PRODUTO);
CREATE INDEX IF NOT EXISTS idx_os_evolucao_os_evolucao_fkindex1 ON OS_EVOLUCAO (ID_OS_ABERTURA);
CREATE INDEX IF NOT EXISTS idx_comissao_objetivo_fk_comissao_perfil_objetivo ON COMISSAO_OBJETIVO (ID_COMISSAO_PERFIL);
CREATE INDEX IF NOT EXISTS idx_comissao_objetivo_fk_comissao_objetivo_produto1_idx ON COMISSAO_OBJETIVO (ID_PRODUTO);
CREATE INDEX IF NOT EXISTS idx_vendedor_rota_fk_vendedor_rota_vendedor1_idx ON VENDEDOR_ROTA (ID_VENDEDOR);
CREATE INDEX IF NOT EXISTS idx_vendedor_rota_fk_vendedor_rota_cliente1_idx ON VENDEDOR_ROTA (ID_CLIENTE);
CREATE INDEX IF NOT EXISTS idx_vendedor_meta_fk_vendedor_meta_vendedor1_idx ON VENDEDOR_META (ID_VENDEDOR);
CREATE INDEX IF NOT EXISTS idx_vendedor_meta_fk_vendedor_meta_cliente1_idx ON VENDEDOR_META (ID_CLIENTE);
CREATE INDEX IF NOT EXISTS idx_nfce_sangria_fk_nfce_mov_sangria ON NFCE_SANGRIA (ID_NFCE_MOVIMENTO);
CREATE INDEX IF NOT EXISTS idx_nfce_movimento_fk_nfce_operador_mov ON NFCE_MOVIMENTO (ID_NFCE_OPERADOR);
CREATE INDEX IF NOT EXISTS idx_nfce_movimento_fk_nfce_caixa_mov ON NFCE_MOVIMENTO (ID_NFCE_CAIXA);
CREATE INDEX IF NOT EXISTS idx_nfce_operador_fk_nfce_operador_colaborador1_idx ON NFCE_OPERADOR (ID_COLABORADOR);
CREATE INDEX IF NOT EXISTS idx_nfce_fechamento_fk_nfce_mov_fecha ON NFCE_FECHAMENTO (ID_NFCE_MOVIMENTO);
CREATE INDEX IF NOT EXISTS idx_nfce_fechamento_fk_nfce_fechamento_nfce_tipo_pagamento1_ ON NFCE_FECHAMENTO (ID_NFCE_TIPO_PAGAMENTO);
CREATE INDEX IF NOT EXISTS idx_nfce_suprimento_fk_nfce_mov_suprimento ON NFCE_SUPRIMENTO (ID_NFCE_MOVIMENTO);
CREATE INDEX IF NOT EXISTS idx_nfse_cabecalho_fk_nfse_cabecalho_os_abertura1_idx ON NFSE_CABECALHO (ID_OS_ABERTURA);
CREATE INDEX IF NOT EXISTS idx_nfse_cabecalho_fk_nfse_cabecalho_cliente1_idx ON NFSE_CABECALHO (ID_CLIENTE);
CREATE INDEX IF NOT EXISTS idx_nfse_detalhe_fk_nfse_cab_det ON NFSE_DETALHE (ID_NFSE_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_nfse_detalhe_fk_lista_ser_det ON NFSE_DETALHE (ID_NFSE_LISTA_SERVICO);
CREATE INDEX IF NOT EXISTS idx_nfse_intermediario_fk_nfse_intermediario ON NFSE_INTERMEDIARIO (ID_NFSE_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_cte_emitente_fk_cte_cab_emitente ON CTE_EMITENTE (ID_CTE_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_cte_local_coleta_fk_cte_cab_coleta ON CTE_LOCAL_COLETA (ID_CTE_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_cte_tomador_fk_cte_cab_tomador ON CTE_TOMADOR (ID_CTE_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_cte_passagem_fk_cte_cab_passagem ON CTE_PASSAGEM (ID_CTE_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_cte_remetente_fk_cte_cab_remetente ON CTE_REMETENTE (ID_CTE_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_cte_expedidor_fk_cte_cab_expedidor ON CTE_EXPEDIDOR (ID_CTE_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_cte_recebedor_fk_cte_cab_recebedor ON CTE_RECEBEDOR (ID_CTE_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_cte_destinatario_fk_cte_cab_destinatario ON CTE_DESTINATARIO (ID_CTE_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_cte_local_entrega_fk_cte_cab_entrega ON CTE_LOCAL_ENTREGA (ID_CTE_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_cte_componente_fk_cte_cab_componente ON CTE_COMPONENTE (ID_CTE_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_cte_carga_fk_cte_cab_carga ON CTE_CARGA (ID_CTE_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_cte_informacao_nf_outros_fk_cte_cab_informacao_nf ON CTE_INFORMACAO_NF_OUTROS (ID_CTE_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_cte_informacao_nf_transporte_fk_cte_inf_nf_transp ON CTE_INFORMACAO_NF_TRANSPORTE (ID_CTE_INFORMACAO_NF);
CREATE INDEX IF NOT EXISTS idx_cte_inf_nf_transporte_lacre_fk_cte_inf_nf_trans_lacre ON CTE_INF_NF_TRANSPORTE_LACRE (ID_CTE_INFORMACAO_NF_TRANSPORTE);
CREATE INDEX IF NOT EXISTS idx_cte_informacao_nf_carga_fk_cte_inf_nf_carga ON CTE_INFORMACAO_NF_CARGA (ID_CTE_INFORMACAO_NF);
CREATE INDEX IF NOT EXISTS idx_cte_inf_nf_carga_lacre_fk_cte_inf_carga_lacre ON CTE_INF_NF_CARGA_LACRE (ID_CTE_INFORMACAO_NF_CARGA);
CREATE INDEX IF NOT EXISTS idx_cte_documento_anterior_fk_cte_cab_doc_anterior ON CTE_DOCUMENTO_ANTERIOR (ID_CTE_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_cte_documento_anterior_id_fk_cte_doc_anterior_id ON CTE_DOCUMENTO_ANTERIOR_ID (ID_CTE_DOCUMENTO_ANTERIOR);
CREATE INDEX IF NOT EXISTS idx_cte_seguro_fk_cte_cab_seguro ON CTE_SEGURO (ID_CTE_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_cte_perigoso_fk_cte_cab_perigo ON CTE_PERIGOSO (ID_CTE_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_cte_veiculo_novo_fk_cte_cab_veiculo_novo ON CTE_VEICULO_NOVO (ID_CTE_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_cte_fatura_fk_cte_cab_fatura ON CTE_FATURA (ID_CTE_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_cte_duplicata_fk_cte_cab_duplicata ON CTE_DUPLICATA (ID_CTE_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_cte_rodoviario_fk_cte_cab_rodoviario ON CTE_RODOVIARIO (ID_CTE_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_cte_rodoviario_occ_fk_cte_rod_occ ON CTE_RODOVIARIO_OCC (ID_CTE_RODOVIARIO);
CREATE INDEX IF NOT EXISTS idx_cte_rodoviario_pedagio_fk_cte_rod_pedagio ON CTE_RODOVIARIO_PEDAGIO (ID_CTE_RODOVIARIO);
CREATE INDEX IF NOT EXISTS idx_cte_rodoviario_veiculo_fk_cte_rod_veiculo ON CTE_RODOVIARIO_VEICULO (ID_CTE_RODOVIARIO);
CREATE INDEX IF NOT EXISTS idx_cte_rodoviario_lacre_fk_cte_rod_lacre ON CTE_RODOVIARIO_LACRE (ID_CTE_RODOVIARIO);
CREATE INDEX IF NOT EXISTS idx_cte_rodoviario_motorista_fk_cte_rod_motorista ON CTE_RODOVIARIO_MOTORISTA (ID_CTE_RODOVIARIO);
CREATE INDEX IF NOT EXISTS idx_cte_aereo_fk_cte_cab_aereo ON CTE_AEREO (ID_CTE_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_cte_aquaviario_fk_cte_cab_aquaviario ON CTE_AQUAVIARIO (ID_CTE_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_cte_aquaviario_balsa_fk_cte_aqua_balsa ON CTE_AQUAVIARIO_BALSA (ID_CTE_AQUAVIARIO);
CREATE INDEX IF NOT EXISTS idx_cte_ferroviario_fk_cte_cab_ferroviario ON CTE_FERROVIARIO (ID_CTE_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_cte_ferroviario_ferrovia_fk_cte_ferro_via ON CTE_FERROVIARIO_FERROVIA (ID_CTE_FERROVIARIO);
CREATE INDEX IF NOT EXISTS idx_cte_ferroviario_vagao_fk_cte_ferro_vagao ON CTE_FERROVIARIO_VAGAO (ID_CTE_FERROVIARIO);
CREATE INDEX IF NOT EXISTS idx_cte_dutoviario_fk_cte_cab_duto ON CTE_DUTOVIARIO (ID_CTE_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_cte_multimodal_fk_cte_cab_multi ON CTE_MULTIMODAL (ID_CTE_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_operadora_cartao_fk_operadora_cartao_banco_conta_caixa1_i ON OPERADORA_CARTAO (ID_BANCO_CONTA_CAIXA);
CREATE INDEX IF NOT EXISTS idx_colaborador_relacionamento_fk_tipo_rel_colaborador ON COLABORADOR_RELACIONAMENTO (ID_TIPO_RELACIONAMENTO);
CREATE INDEX IF NOT EXISTS idx_colaborador_relacionamento_fk_colaborador_relacionamento_colaborado ON COLABORADOR_RELACIONAMENTO (ID_COLABORADOR);
CREATE INDEX IF NOT EXISTS idx_fornecedor_produto_fk_fornecedor_produto_produto1_idx ON FORNECEDOR_PRODUTO (ID_PRODUTO);
CREATE INDEX IF NOT EXISTS idx_fornecedor_produto_fk_fornecedor_produto_fornecedor1_idx ON FORNECEDOR_PRODUTO (ID_FORNECEDOR);
CREATE INDEX IF NOT EXISTS idx_produto_promocao_fk_produto_promocao_produto1_idx ON PRODUTO_PROMOCAO (ID_PRODUTO);
CREATE INDEX IF NOT EXISTS idx_produto_ficha_tecnica_fk_produto_ficha_tecnica_produto1_idx ON PRODUTO_FICHA_TECNICA (ID_PRODUTO);
CREATE INDEX IF NOT EXISTS idx_produto_codigo_adicional_fk_produto_codigo_adicional_produto1_idx ON PRODUTO_CODIGO_ADICIONAL (ID_PRODUTO);
CREATE INDEX IF NOT EXISTS idx_irrf_detalhe_fk_irrf_detalhe ON IRRF_DETALHE (ID_IRRF);
CREATE INDEX IF NOT EXISTS idx_inss_detalhe_fk_inss_detalhe ON INSS_DETALHE (ID_INSS);
CREATE INDEX IF NOT EXISTS idx_salario_familia_fk_inss_salario_familia ON SALARIO_FAMILIA (ID_INSS);
CREATE INDEX IF NOT EXISTS idx_contrib_sind_patronal_cab_fk_sind_patro_contr ON CONTRIB_SIND_PATRONAL_CAB (ID_SINDICATO);
CREATE INDEX IF NOT EXISTS idx_contrib_sind_patronal_det_fk_contr_sind_patronal ON CONTRIB_SIND_PATRONAL_DET (ID_CONTRIB_SIND_PATRONAL_CAB);
CREATE INDEX IF NOT EXISTS idx_empresa_transporte_itinerario_fk_emp_trans_itiner ON EMPRESA_TRANSPORTE_ITINERARIO (ID_EMPRESA_TRANSPORTE);
CREATE INDEX IF NOT EXISTS idx_cod_apuracao_receita_dacon_fk_tipo_rec_dacon ON COD_APURACAO_RECEITA_DACON (ID_TIPO_RECEITA_DACON);
CREATE INDEX IF NOT EXISTS idx_cod_apuracao_receita_dacon_fk_cod_apura_dacon ON COD_APURACAO_RECEITA_DACON (ID_CODIGO_APURACAO_EFD);
CREATE INDEX IF NOT EXISTS idx_orcamento_fluxo_caixa_periodo_fk_orcamento_fluxo_caixa_periodo_banco_c ON ORCAMENTO_FLUXO_CAIXA_PERIODO (ID_BANCO_CONTA_CAIXA);
CREATE INDEX IF NOT EXISTS idx_orcamento_fluxo_caixa_fk_fluxo_cx_periodo ON ORCAMENTO_FLUXO_CAIXA (ID_ORC_FLUXO_CAIXA_PERIODO);
CREATE INDEX IF NOT EXISTS idx_orcamento_fluxo_caixa_detalhe_fk_fluxo_caixa_detalhe ON ORCAMENTO_FLUXO_CAIXA_DETALHE (ID_ORCAMENTO_FLUXO_CAIXA);
CREATE INDEX IF NOT EXISTS idx_orcamento_fluxo_caixa_detalhe_fk_orcamento_fluxo_caixa_detalhe_fin_nat ON ORCAMENTO_FLUXO_CAIXA_DETALHE (ID_FIN_NATUREZA_FINANCEIRA);
CREATE INDEX IF NOT EXISTS idx_contabil_conta_fk_conta_sped_conta ON CONTABIL_CONTA (ID_PLANO_CONTA_REF_SPED);
CREATE INDEX IF NOT EXISTS idx_contabil_conta_fk_contabil_conta_conta ON CONTABIL_CONTA (ID_CONTABIL_CONTA);
CREATE INDEX IF NOT EXISTS idx_contabil_conta_fk_plano_conta_conta ON CONTABIL_CONTA (ID_PLANO_CONTA);
CREATE INDEX IF NOT EXISTS idx_contabil_lancamento_cabecalho_fk_lote_lanc_cab ON CONTABIL_LANCAMENTO_CABECALHO (ID_CONTABIL_LOTE);
CREATE INDEX IF NOT EXISTS idx_contabil_lancamento_detalhe_fk_contabil_lancamento ON CONTABIL_LANCAMENTO_DETALHE (ID_CONTABIL_LANCAMENTO_CAB);
CREATE INDEX IF NOT EXISTS idx_contabil_lancamento_detalhe_fk_hist_lancamento ON CONTABIL_LANCAMENTO_DETALHE (ID_CONTABIL_HISTORICO);
CREATE INDEX IF NOT EXISTS idx_contabil_lancamento_detalhe_fk_conta_lancamento ON CONTABIL_LANCAMENTO_DETALHE (ID_CONTABIL_CONTA);
CREATE INDEX IF NOT EXISTS idx_contabil_lancamento_orcado_fk_conta_lanc_orcado ON CONTABIL_LANCAMENTO_ORCADO (ID_CONTABIL_CONTA);
CREATE INDEX IF NOT EXISTS idx_contabil_dre_detalhe_fk_dre_cab_det ON CONTABIL_DRE_DETALHE (ID_CONTABIL_DRE_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_contabil_termo_fk_contabil_livro_termo ON CONTABIL_TERMO (ID_CONTABIL_LIVRO);
CREATE INDEX IF NOT EXISTS idx_contabil_encerramento_exe_det_fk_enc_exe_cab_det ON CONTABIL_ENCERRAMENTO_EXE_DET (ID_CONTABIL_ENCERRAMENTO_EXE);
CREATE INDEX IF NOT EXISTS idx_contabil_encerramento_exe_det_fk_contabil_conta_enc_det ON CONTABIL_ENCERRAMENTO_EXE_DET (ID_CONTABIL_CONTA);
CREATE INDEX IF NOT EXISTS idx_lanca_centro_resultado_fk_centro_lanca ON LANCA_CENTRO_RESULTADO (ID_CENTRO_RESULTADO);
CREATE INDEX IF NOT EXISTS idx_centro_resultado_fk_plano_centro ON CENTRO_RESULTADO (ID_PLANO_CENTRO_RESULTADO);
CREATE INDEX IF NOT EXISTS idx_rateio_centro_resultado_cab_fk_centro_rateio_cab ON RATEIO_CENTRO_RESULTADO_CAB (ID_CENTRO_RESULTADO);
CREATE INDEX IF NOT EXISTS idx_rateio_centro_resultado_det_fk_rateio_cab_det ON RATEIO_CENTRO_RESULTADO_DET (ID_RATEIO_CENTRO_RESUL_CAB);
CREATE INDEX IF NOT EXISTS idx_rateio_centro_resultado_det_fk_centro_rateio ON RATEIO_CENTRO_RESULTADO_DET (ID_CENTRO_RESULTADO_DESTINO);
CREATE INDEX IF NOT EXISTS idx_encerra_centro_resultado_fk_centro_encerra ON ENCERRA_CENTRO_RESULTADO (ID_CENTRO_RESULTADO);
CREATE INDEX IF NOT EXISTS idx_folha_lancamento_comissao_fk_folha_lancamento_comissao_vendedor1_i ON FOLHA_LANCAMENTO_COMISSAO (ID_VENDEDOR);
CREATE INDEX IF NOT EXISTS idx_contabil_conta_rateio_fk_contabil_conta_rateio ON CONTABIL_CONTA_RATEIO (ID_CONTABIL_CONTA);
CREATE INDEX IF NOT EXISTS idx_contabil_conta_rateio_fk_centro_resultado_rateio ON CONTABIL_CONTA_RATEIO (ID_CENTRO_RESULTADO);
CREATE INDEX IF NOT EXISTS idx_empresa_cnae_fk_empresa_cnae_empresa1_idx ON EMPRESA_CNAE (ID_EMPRESA);
CREATE INDEX IF NOT EXISTS idx_empresa_cnae_fk_empresa_cnae_cnae1_idx ON EMPRESA_CNAE (ID_CNAE);
CREATE INDEX IF NOT EXISTS idx_inventario_contagem_det_fk_contagem_cab_det ON INVENTARIO_CONTAGEM_DET (ID_INVENTARIO_CONTAGEM_CAB);
CREATE INDEX IF NOT EXISTS idx_inventario_contagem_det_fk_inventario_contagem_det_produto1_idx ON INVENTARIO_CONTAGEM_DET (ID_PRODUTO);
CREATE INDEX IF NOT EXISTS idx_orcamento_empresarial_fk_orcamento_periodo_orc ON ORCAMENTO_EMPRESARIAL (ID_ORCAMENTO_PERIODO);
CREATE INDEX IF NOT EXISTS idx_orcamento_detalhe_fk_orc_empresarial_cab_det ON ORCAMENTO_DETALHE (ID_ORCAMENTO_EMPRESARIAL);
CREATE INDEX IF NOT EXISTS idx_orcamento_detalhe_fk_orcamento_detalhe_fin_natureza_financ ON ORCAMENTO_DETALHE (ID_FIN_NATUREZA_FINANCEIRA);
CREATE INDEX IF NOT EXISTS idx_patrim_bem_fk_patrim_grupo_bem ON PATRIM_BEM (ID_PATRIM_GRUPO_BEM);
CREATE INDEX IF NOT EXISTS idx_patrim_bem_fk_tipo_aquisicao_bem ON PATRIM_BEM (ID_PATRIM_TIPO_AQUISICAO_BEM);
CREATE INDEX IF NOT EXISTS idx_patrim_bem_fk_estado_conservacao_bem ON PATRIM_BEM (ID_PATRIM_ESTADO_CONSERVACAO);
CREATE INDEX IF NOT EXISTS idx_patrim_bem_fk_centro_res_bem ON PATRIM_BEM (ID_CENTRO_RESULTADO);
CREATE INDEX IF NOT EXISTS idx_patrim_bem_fk_patrim_bem_fornecedor1_idx ON PATRIM_BEM (ID_FORNECEDOR);
CREATE INDEX IF NOT EXISTS idx_patrim_bem_fk_patrim_bem_colaborador1_idx ON PATRIM_BEM (ID_COLABORADOR);
CREATE INDEX IF NOT EXISTS idx_patrim_bem_fk_patrim_bem_setor1_idx ON PATRIM_BEM (ID_SETOR);
CREATE INDEX IF NOT EXISTS idx_patrim_documento_bem_fk_patrim_documento_bem ON PATRIM_DOCUMENTO_BEM (ID_PATRIM_BEM);
CREATE INDEX IF NOT EXISTS idx_patrim_depreciacao_bem_fk_patrim_bem_depreciacao ON PATRIM_DEPRECIACAO_BEM (ID_PATRIM_BEM);
CREATE INDEX IF NOT EXISTS idx_patrim_movimentacao_bem_fk_tipo_mov_bem_mov_bem ON PATRIM_MOVIMENTACAO_BEM (ID_PATRIM_TIPO_MOVIMENTACAO);
CREATE INDEX IF NOT EXISTS idx_patrim_movimentacao_bem_fk_patrim_bem_movimentacao ON PATRIM_MOVIMENTACAO_BEM (ID_PATRIM_BEM);
CREATE INDEX IF NOT EXISTS idx_patrim_apolice_seguro_fk_segurada_apolice ON PATRIM_APOLICE_SEGURO (ID_SEGURADORA);
CREATE INDEX IF NOT EXISTS idx_patrim_apolice_seguro_fk_patrim_apolice_bem ON PATRIM_APOLICE_SEGURO (ID_PATRIM_BEM);
CREATE INDEX IF NOT EXISTS idx_fiscal_parametro_fk_regime_mun_par ON FISCAL_PARAMETRO (ID_FISCAL_MUNICIPAL_REGIME);
CREATE INDEX IF NOT EXISTS idx_fiscal_parametro_fk_regime_est_par ON FISCAL_PARAMETRO (ID_FISCAL_ESTADUAL_REGIME);
CREATE INDEX IF NOT EXISTS idx_fiscal_parametro_fk_porte_est_par ON FISCAL_PARAMETRO (ID_FISCAL_ESTADUAL_PORTE);
CREATE INDEX IF NOT EXISTS idx_fiscal_termo_fk_fiscal_livro_termo ON FISCAL_TERMO (ID_FISCAL_LIVRO);
CREATE INDEX IF NOT EXISTS idx_fiscal_inscricoes_substitutas_fk_par_insc_substituta ON FISCAL_INSCRICOES_SUBSTITUTAS (ID_FISCAL_PARAMETROS);
CREATE INDEX IF NOT EXISTS idx_simples_nacional_detalhe_fk_simples_nacional_cab_det ON SIMPLES_NACIONAL_DETALHE (ID_SIMPLES_NACIONAL_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_fiscal_nota_fiscal_entrada_fk_fiscal_nota_fiscal_entrada_nfe_cabeca ON FISCAL_NOTA_FISCAL_ENTRADA (ID_NFE_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_ferias_periodo_aquisitivo_fk_ferias_periodo_aquisitivo_colaborador ON FERIAS_PERIODO_AQUISITIVO (ID_COLABORADOR);
CREATE INDEX IF NOT EXISTS idx_folha_afastamento_fk_folha_tipo_afastamento ON FOLHA_AFASTAMENTO (ID_FOLHA_TIPO_AFASTAMENTO);
CREATE INDEX IF NOT EXISTS idx_folha_afastamento_fk_folha_afastamento_colaborador1_idx ON FOLHA_AFASTAMENTO (ID_COLABORADOR);
CREATE INDEX IF NOT EXISTS idx_folha_plano_saude_fk_folha_plano_saude_colaborador1_idx ON FOLHA_PLANO_SAUDE (ID_COLABORADOR);
CREATE INDEX IF NOT EXISTS idx_folha_plano_saude_fk_folha_plano_saude_operadora_plano_sau ON FOLHA_PLANO_SAUDE (ID_OPERADORA_PLANO_SAUDE);
CREATE INDEX IF NOT EXISTS idx_folha_rescisao_fk_folha_rescisao_colaborador1_idx ON FOLHA_RESCISAO (ID_COLABORADOR);
CREATE INDEX IF NOT EXISTS idx_folha_lancamento_cabecalho_fk_folha_lancamento_cabecalho_colaborado ON FOLHA_LANCAMENTO_CABECALHO (ID_COLABORADOR);
CREATE INDEX IF NOT EXISTS idx_folha_lancamento_detalhe_fk_folha_lancamento_cab_det ON FOLHA_LANCAMENTO_DETALHE (ID_FOLHA_LANCAMENTO_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_folha_lancamento_detalhe_fk_folha_evento_lancamento ON FOLHA_LANCAMENTO_DETALHE (ID_FOLHA_EVENTO);
CREATE INDEX IF NOT EXISTS idx_folha_vale_transporte_fk_emp_tra_itin_val_tra ON FOLHA_VALE_TRANSPORTE (ID_EMPRESA_TRANSP_ITIN);
CREATE INDEX IF NOT EXISTS idx_folha_vale_transporte_fk_folha_vale_transporte_colaborador1_id ON FOLHA_VALE_TRANSPORTE (ID_COLABORADOR);
CREATE INDEX IF NOT EXISTS idx_folha_inss_retencao_fk_folha_inss_serv_retencao ON FOLHA_INSS_RETENCAO (ID_FOLHA_INSS_SERVICO);
CREATE INDEX IF NOT EXISTS idx_folha_inss_retencao_fk_folha_inss_retencao ON FOLHA_INSS_RETENCAO (ID_FOLHA_INSS);
CREATE INDEX IF NOT EXISTS idx_folha_ppp_fk_folha_ppp_colaborador1_idx ON FOLHA_PPP (ID_COLABORADOR);
CREATE INDEX IF NOT EXISTS idx_folha_ppp_cat_fk_folha_ppp_cat ON FOLHA_PPP_CAT (ID_FOLHA_PPP);
CREATE INDEX IF NOT EXISTS idx_folha_ppp_atividade_fk_folha_ppp_atividade ON FOLHA_PPP_ATIVIDADE (ID_FOLHA_PPP);
CREATE INDEX IF NOT EXISTS idx_folha_ppp_fator_risco_fk_folha_ppp_fator_risco ON FOLHA_PPP_FATOR_RISCO (ID_FOLHA_PPP);
CREATE INDEX IF NOT EXISTS idx_folha_ppp_exame_medico_fk_folha_ppp_exame_medido ON FOLHA_PPP_EXAME_MEDICO (ID_FOLHA_PPP);
CREATE INDEX IF NOT EXISTS idx_folha_historico_salarial_fk_folha_historico_salarial_colaborador1 ON FOLHA_HISTORICO_SALARIAL (ID_COLABORADOR);
CREATE INDEX IF NOT EXISTS idx_contrato_fk_tipo_contrato_contrato ON CONTRATO (ID_TIPO_CONTRATO);
CREATE INDEX IF NOT EXISTS idx_contrato_fk_sol_servico_contrato ON CONTRATO (ID_SOLICITACAO_SERVICO);
CREATE INDEX IF NOT EXISTS idx_contrato_solicitacao_servico_fk_contrato_tipo_servico_sol ON CONTRATO_SOLICITACAO_SERVICO (ID_CONTRATO_TIPO_SERVICO);
CREATE INDEX IF NOT EXISTS idx_contrato_solicitacao_servico_fk_contrato_solicitacao_servico_setor1_i ON CONTRATO_SOLICITACAO_SERVICO (ID_SETOR);
CREATE INDEX IF NOT EXISTS idx_contrato_solicitacao_servico_fk_contrato_solicitacao_servico_colabora ON CONTRATO_SOLICITACAO_SERVICO (ID_COLABORADOR);
CREATE INDEX IF NOT EXISTS idx_contrato_solicitacao_servico_fk_contrato_solicitacao_servico_cliente1 ON CONTRATO_SOLICITACAO_SERVICO (ID_CLIENTE);
CREATE INDEX IF NOT EXISTS idx_contrato_solicitacao_servico_fk_contrato_solicitacao_servico_forneced ON CONTRATO_SOLICITACAO_SERVICO (ID_FORNECEDOR);
CREATE INDEX IF NOT EXISTS idx_contrato_historico_reajuste_fk_contrato_historico_reajuste ON CONTRATO_HISTORICO_REAJUSTE (ID_CONTRATO);
CREATE INDEX IF NOT EXISTS idx_contrato_prev_faturamento_fk_contrato_prev_faturamento ON CONTRATO_PREV_FATURAMENTO (ID_CONTRATO);
CREATE INDEX IF NOT EXISTS idx_contrato_hist_faturamento_fk_contrato_hist_faturamento ON CONTRATO_HIST_FATURAMENTO (ID_CONTRATO);
CREATE INDEX IF NOT EXISTS idx_ponto_turma_fk_ponto_escala_turma ON PONTO_TURMA (ID_PONTO_ESCALA);
CREATE INDEX IF NOT EXISTS idx_ponto_marcacao_fk_ponto_relogio_marcacao ON PONTO_MARCACAO (ID_PONTO_RELOGIO);
CREATE INDEX IF NOT EXISTS idx_ponto_marcacao_fk_ponto_marcacao_colaborador1_idx ON PONTO_MARCACAO (ID_COLABORADOR);
CREATE INDEX IF NOT EXISTS idx_ponto_banco_horas_fk_ponto_banco_horas_colaborador1_idx ON PONTO_BANCO_HORAS (ID_COLABORADOR);
CREATE INDEX IF NOT EXISTS idx_ponto_horario_autorizado_fk_ponto_horario_autorizado_colaborador1 ON PONTO_HORARIO_AUTORIZADO (ID_COLABORADOR);
CREATE INDEX IF NOT EXISTS idx_ponto_abono_fk_ponto_abono_colaborador1_idx ON PONTO_ABONO (ID_COLABORADOR);
CREATE INDEX IF NOT EXISTS idx_ponto_abono_utilizacao_fk_ponto_abono_utilizacao ON PONTO_ABONO_UTILIZACAO (ID_PONTO_ABONO);
CREATE INDEX IF NOT EXISTS idx_dav_cabecalho_fk_dav_cabecalho_pessoa1_idx ON DAV_CABECALHO (ID_PESSOA);
CREATE INDEX IF NOT EXISTS idx_dav_detalhe_fk_dav_cab_det ON DAV_DETALHE (ID_DAV_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_dav_detalhe_fk_dav_detalhe_produto1_idx ON DAV_DETALHE (ID_PRODUTO);
CREATE INDEX IF NOT EXISTS idx_pre_venda_cabecalho_fk_pre_venda_cabecalho_pessoa1_idx ON PRE_VENDA_CABECALHO (ID_PESSOA);
CREATE INDEX IF NOT EXISTS idx_pre_venda_detalhe_fk_pre_venda_cab_det ON PRE_VENDA_DETALHE (ID_PRE_VENDA_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_pre_venda_detalhe_fk_pre_venda_detalhe_produto1_idx ON PRE_VENDA_DETALHE (ID_PRODUTO);
CREATE INDEX IF NOT EXISTS idx_contabil_indice_valor_fk_contabil_indice_valor ON CONTABIL_INDICE_VALOR (ID_CONTABIL_INDICE);
CREATE INDEX IF NOT EXISTS idx_ponto_banco_horas_utilizacao_fk_banco_hora_utilizacao ON PONTO_BANCO_HORAS_UTILIZACAO (ID_PONTO_BANCO_HORAS);
CREATE INDEX IF NOT EXISTS idx_ponto_fechamento_jornada_fk_ponto_classificacao_jornada ON PONTO_FECHAMENTO_JORNADA (ID_PONTO_CLASSIFICACAO_JORNADA);
CREATE INDEX IF NOT EXISTS idx_ponto_fechamento_jornada_fk_ponto_fechamento_jornada_colaborador1 ON PONTO_FECHAMENTO_JORNADA (ID_COLABORADOR);
CREATE INDEX IF NOT EXISTS idx_ct_resultado_nt_financeira_fk_cr_nf ON CT_RESULTADO_NT_FINANCEIRA (ID_CENTRO_RESULTADO);
CREATE INDEX IF NOT EXISTS idx_ct_resultado_nt_financeira_fk_ct_resultado_nt_financeira_fin_nature ON CT_RESULTADO_NT_FINANCEIRA (ID_FIN_NATUREZA_FINANCEIRA);
CREATE INDEX IF NOT EXISTS idx_produto_alteracao_item_fk_produto_alteracao_item_produto1_idx ON PRODUTO_ALTERACAO_ITEM (ID_PRODUTO);
CREATE INDEX IF NOT EXISTS idx_fiscal_nota_fiscal_saida_fk_fiscal_nota_fiscal_saida_nfe_cabecalh ON FISCAL_NOTA_FISCAL_SAIDA (ID_NFE_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_pessoa_alteracao_fk_pessoa_alteracao_pessoa1_idx ON PESSOA_ALTERACAO (ID_PESSOA);
CREATE INDEX IF NOT EXISTS idx_dav_detalhe_alteracao_dav_detalhe_alteracao_fkindex1 ON DAV_DETALHE_ALTERACAO (ID_DAV_DETALHE);
CREATE INDEX IF NOT EXISTS idx_malote_digital_documento_fk_malote_digital_documento_colaborador1 ON MALOTE_DIGITAL_DOCUMENTO (ID_COLABORADOR);
CREATE INDEX IF NOT EXISTS idx_malote_digital_destinatario_fk_malote_digital_dest ON MALOTE_DIGITAL_DESTINATARIO (ID_MALOTE_DIGITAL_DOCUMENTO);
CREATE INDEX IF NOT EXISTS idx_malote_digital_destinatario_fk_malote_digital_destinatario_colaborad ON MALOTE_DIGITAL_DESTINATARIO (ID_COLABORADOR);
CREATE INDEX IF NOT EXISTS idx_malote_digital_acesso_fk_malote_dig_dest_acesso ON MALOTE_DIGITAL_ACESSO (ID_MALOTE_DIGITAL_DESTINATARIO);
CREATE INDEX IF NOT EXISTS idx_etiqueta_layout_fk_papel_etiqueta ON ETIQUETA_LAYOUT (ID_FORMATO_PAPEL);
CREATE INDEX IF NOT EXISTS idx_etiqueta_template_fk_etiqueta_template ON ETIQUETA_TEMPLATE (ID_ETIQUETA_LAYOUT);
CREATE INDEX IF NOT EXISTS idx_agenda_compromisso_fk_categoria_compromisso ON AGENDA_COMPROMISSO (ID_AGENDA_CATEGORIA_COMPROMISSO);
CREATE INDEX IF NOT EXISTS idx_agenda_compromisso_fk_agenda_compromisso_colaborador1_idx ON AGENDA_COMPROMISSO (ID_COLABORADOR);
CREATE INDEX IF NOT EXISTS idx_agenda_notificacao_fk_compromisso_notificacao ON AGENDA_NOTIFICACAO (ID_AGENDA_COMPROMISSO);
CREATE INDEX IF NOT EXISTS idx_agenda_compromisso_convidado_fk_compromisso_convidado ON AGENDA_COMPROMISSO_CONVIDADO (ID_AGENDA_COMPROMISSO);
CREATE INDEX IF NOT EXISTS idx_agenda_compromisso_convidado_fk_agenda_compromisso_convidado_colabora ON AGENDA_COMPROMISSO_CONVIDADO (ID_COLABORADOR);
CREATE INDEX IF NOT EXISTS idx_reuniao_sala_evento_fk_sala_evento ON REUNIAO_SALA_EVENTO (ID_REUNIAO_SALA);
CREATE INDEX IF NOT EXISTS idx_reuniao_sala_evento_fk_compromisso_sala ON REUNIAO_SALA_EVENTO (ID_AGENDA_COMPROMISSO);
CREATE INDEX IF NOT EXISTS idx_recado_remetente_fk_recado_remetente_colaborador1_idx ON RECADO_REMETENTE (ID_COLABORADOR);
CREATE INDEX IF NOT EXISTS idx_recado_destinatario_fk_recado_rem_dest ON RECADO_DESTINATARIO (ID_RECADO_REMETENTE);
CREATE INDEX IF NOT EXISTS idx_recado_destinatario_fk_recado_destinatario_colaborador1_idx ON RECADO_DESTINATARIO (ID_COLABORADOR);
CREATE INDEX IF NOT EXISTS idx_pcp_op_detalhe_fk_pcp_op_cab_det ON PCP_OP_DETALHE (ID_PCP_OP_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_pcp_op_detalhe_fk_pcp_op_detalhe_produto1_idx ON PCP_OP_DETALHE (ID_PRODUTO);
CREATE INDEX IF NOT EXISTS idx_pcp_servico_fk_pcp_servico_realizado ON PCP_SERVICO (ID_PCP_OP_DETALHE);
CREATE INDEX IF NOT EXISTS idx_pcp_servico_colaborador_fk_pcp_servico_colaborador ON PCP_SERVICO_COLABORADOR (ID_PCP_SERVICO);
CREATE INDEX IF NOT EXISTS idx_pcp_servico_colaborador_fk_pcp_servico_colaborador_colaborador1_ ON PCP_SERVICO_COLABORADOR (ID_COLABORADOR);
CREATE INDEX IF NOT EXISTS idx_pcp_instrucao_op_fk_pcp_op_instrucao ON PCP_INSTRUCAO_OP (ID_PCP_OP_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_pcp_instrucao_op_fk_pcp_instrucao_op ON PCP_INSTRUCAO_OP (ID_PCP_INSTRUCAO);
CREATE INDEX IF NOT EXISTS idx_pcp_servico_equipamento_fk_pcp_serv_equip ON PCP_SERVICO_EQUIPAMENTO (ID_PCP_SERVICO);
CREATE INDEX IF NOT EXISTS idx_pcp_servico_equipamento_fk_pcp_equip_serv ON PCP_SERVICO_EQUIPAMENTO (ID_PATRIM_BEM);
CREATE INDEX IF NOT EXISTS idx_wms_recebimento_cabecalho_fk_wms_agenda_recebe ON WMS_RECEBIMENTO_CABECALHO (ID_WMS_AGENDAMENTO);
CREATE INDEX IF NOT EXISTS idx_wms_recebimento_detalhe_fk_wms_rec_cab_det ON WMS_RECEBIMENTO_DETALHE (ID_WMS_RECEBIMENTO_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_wms_recebimento_detalhe_fk_wms_recebimento_detalhe_produto1_idx ON WMS_RECEBIMENTO_DETALHE (ID_PRODUTO);
CREATE INDEX IF NOT EXISTS idx_wms_estante_fk_wms_rua_estante ON WMS_ESTANTE (ID_WMS_RUA);
CREATE INDEX IF NOT EXISTS idx_wms_caixa_fk_wms_estante_caixa ON WMS_CAIXA (ID_WMS_ESTANTE);
CREATE INDEX IF NOT EXISTS idx_wms_armazenamento_fk_caixa_armazena ON WMS_ARMAZENAMENTO (ID_WMS_CAIXA);
CREATE INDEX IF NOT EXISTS idx_wms_armazenamento_fk_rece_armazena ON WMS_ARMAZENAMENTO (ID_WMS_RECEBIMENTO_DETALHE);
CREATE INDEX IF NOT EXISTS idx_wms_ordem_separacao_det_fk_wms_os_cab_det ON WMS_ORDEM_SEPARACAO_DET (ID_WMS_ORDEM_SEPARACAO_CAB);
CREATE INDEX IF NOT EXISTS idx_wms_ordem_separacao_det_fk_wms_ordem_separacao_det_produto1_idx ON WMS_ORDEM_SEPARACAO_DET (ID_PRODUTO);
CREATE INDEX IF NOT EXISTS idx_wms_expedicao_fk_wms_armaz_exped ON WMS_EXPEDICAO (ID_WMS_ARMAZENAMENTO);
CREATE INDEX IF NOT EXISTS idx_wms_expedicao_fk_wms_os_det_exped ON WMS_EXPEDICAO (ID_WMS_ORDEM_SEPARACAO_DET);
CREATE INDEX IF NOT EXISTS idx_mdfe_lacre_fk_mdfe_lacre ON MDFE_LACRE (ID_MDFE_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_mdfe_informacao_cte_fk_mdfe_informacao_cte ON MDFE_INFORMACAO_CTE (ID_MDFE_MUNICIPIO_DESCARREGA);
CREATE INDEX IF NOT EXISTS idx_mdfe_informacao_nfe_fk_mdfe_informacao_nfe ON MDFE_INFORMACAO_NFE (ID_MDFE_MUNICIPIO_DESCARREGA);
CREATE INDEX IF NOT EXISTS idx_mdfe_emitente_fk_mdfe_cab_emit ON MDFE_EMITENTE (ID_MDFE_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_mdfe_percurso_fk_mdfe_percurso ON MDFE_PERCURSO (ID_MDFE_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_mdfe_municipio_carregamento_fk_mdfe_municipio_carregamento ON MDFE_MUNICIPIO_CARREGAMENTO (ID_MDFE_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_mdfe_rodoviario_fk_mdfe_cab_rodo ON MDFE_RODOVIARIO (ID_MDFE_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_mdfe_rodoviario_motorista_fk_mdfe_rodoviario_motorista ON MDFE_RODOVIARIO_MOTORISTA (ID_MDFE_RODOVIARIO);
CREATE INDEX IF NOT EXISTS idx_mdfe_rodoviario_veiculo_fk_mdfe_rodoviario_veiculo ON MDFE_RODOVIARIO_VEICULO (ID_MDFE_RODOVIARIO);
CREATE INDEX IF NOT EXISTS idx_mdfe_municipio_descarrega_fk_mdfe_municipio_descarregamento ON MDFE_MUNICIPIO_DESCARREGA (ID_MDFE_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_mdfe_informacao_seguro_fk_mdfe_informacao_seguro ON MDFE_INFORMACAO_SEGURO (ID_MDFE_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_mdfe_rodoviario_pedagio_fk_mdfe_rodoviario_pedagio ON MDFE_RODOVIARIO_PEDAGIO (ID_MDFE_RODOVIARIO);
CREATE INDEX IF NOT EXISTS idx_mdfe_rodoviario_ciot_fk_mdfe_rod_ciot ON MDFE_RODOVIARIO_CIOT (ID_MDFE_RODOVIARIO);
CREATE INDEX IF NOT EXISTS idx_frota_veiculo_fk_frota_veiculo_frota_veiculo_tipo1_idx ON FROTA_VEICULO (ID_FROTA_VEICULO_TIPO);
CREATE INDEX IF NOT EXISTS idx_frota_veiculo_fk_frota_veiculo_frota_combustivel_tipo1 ON FROTA_VEICULO (ID_FROTA_COMBUSTIVEL_TIPO);
CREATE INDEX IF NOT EXISTS idx_frota_ipva_controle_fk_frota_ipva_controle_frota_veiculo1_id ON FROTA_IPVA_CONTROLE (ID_FROTA_VEICULO);
CREATE INDEX IF NOT EXISTS idx_frota_dpvat_controle_fk_frota_ipva_controle_frota_veiculo1_id ON FROTA_DPVAT_CONTROLE (ID_FROTA_VEICULO);
CREATE INDEX IF NOT EXISTS idx_frota_motorista_fk_frota_motorista_pessoa_fisica1_idx ON FROTA_MOTORISTA (ID_PESSOA_FISICA);
CREATE INDEX IF NOT EXISTS idx_frota_veiculo_sinistro_fk_frota_sinistro_frota_veiculo1_idx ON FROTA_VEICULO_SINISTRO (ID_FROTA_VEICULO);
CREATE INDEX IF NOT EXISTS idx_frota_veiculo_movimentacao_fk_frota_veiculo_movimentacao_frota_moto ON FROTA_VEICULO_MOVIMENTACAO (ID_FROTA_MOTORISTA);
CREATE INDEX IF NOT EXISTS idx_frota_veiculo_movimentacao_fk_frota_veiculo_movimentacao_frota_veic ON FROTA_VEICULO_MOVIMENTACAO (ID_FROTA_VEICULO);
CREATE INDEX IF NOT EXISTS idx_frota_veiculo_pneu_fk_frota_veiculo_pneu_frota_veiculo1_idx ON FROTA_VEICULO_PNEU (ID_FROTA_VEICULO);
CREATE INDEX IF NOT EXISTS idx_frota_veiculo_manutencao_fk_frota_veiculo_manutencao_frota_veicul ON FROTA_VEICULO_MANUTENCAO (ID_FROTA_VEICULO);
CREATE INDEX IF NOT EXISTS idx_frota_multa_controle_fk_frota_multa_controle_frota_veiculo1_i ON FROTA_MULTA_CONTROLE (ID_FROTA_VEICULO);
CREATE INDEX IF NOT EXISTS idx_frota_combustivel_controle_fk_frota_combustivel_controle_frota_veic ON FROTA_COMBUSTIVEL_CONTROLE (ID_FROTA_VEICULO);
CREATE INDEX IF NOT EXISTS idx_gondola_caixa_fk_wms_estante_caixa ON GONDOLA_CAIXA (ID_GONDOLA_ESTANTE);
CREATE INDEX IF NOT EXISTS idx_gondola_estante_fk_wms_rua_estante ON GONDOLA_ESTANTE (ID_GONDOLA_RUA);
CREATE INDEX IF NOT EXISTS idx_gondola_armazenamento_fk_caixa_armazena ON GONDOLA_ARMAZENAMENTO (ID_GONDOLA_CAIXA);
CREATE INDEX IF NOT EXISTS idx_gondola_armazenamento_fk_gondola_armazenamento_produto1_idx ON GONDOLA_ARMAZENAMENTO (ID_PRODUTO);
CREATE INDEX IF NOT EXISTS idx_projeto_cronograma_fk_projeto_cronograma_projeto_dados1_idx ON PROJETO_CRONOGRAMA (ID_PROJETO_PRINCIPAL);
CREATE INDEX IF NOT EXISTS idx_projeto_stakeholders_fk_projeto_stakeholders_projeto_dados1_i ON PROJETO_STAKEHOLDERS (ID_PROJETO_DADOS);
CREATE INDEX IF NOT EXISTS idx_projeto_stakeholders_fk_projeto_stakeholders_colaborador1_idx ON PROJETO_STAKEHOLDERS (ID_COLABORADOR);
CREATE INDEX IF NOT EXISTS idx_projeto_risco_fk_projeto_risco_projeto_principal1_idx ON PROJETO_RISCO (ID_PROJETO_PRINCIPAL);
CREATE INDEX IF NOT EXISTS idx_projeto_custo_fk_projeto_custo_projeto_principal1_idx ON PROJETO_CUSTO (ID_PROJETO_PRINCIPAL);
CREATE INDEX IF NOT EXISTS idx_projeto_custo_fk_projeto_custo_fin_natureza_financeira ON PROJETO_CUSTO (ID_FIN_NATUREZA_FINANCEIRA);
CREATE INDEX IF NOT EXISTS idx_bpe_emitente_fk_cte_cab_emitente ON BPE_EMITENTE (ID_BPE_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_bpe_passageiro_fk_cte_cab_tomador ON BPE_PASSAGEIRO (ID_BPE_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_bpe_comprador_fk_cte_cab_remetente ON BPE_COMPRADOR (ID_BPE_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_bpe_viagem_fk_cte_cab_expedidor ON BPE_VIAGEM (ID_BPE_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_bpe_agencia_fk_cte_cab_destinatario ON BPE_AGENCIA (ID_BPE_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_bpe_passagem_fk_cte_cab_carga ON BPE_PASSAGEM (ID_BPE_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_crm_sac_cabecalho_fk_crm_sac_cabecalho_cliente1_idx ON CRM_SAC_CABECALHO (ID_CLIENTE);
CREATE INDEX IF NOT EXISTS idx_crm_sac_detalhe_fk_crm_sac_detalhe_crm_sac_cabecalho1_id ON CRM_SAC_DETALHE (ID_CRM_SAC_CABECALHO);
CREATE INDEX IF NOT EXISTS idx_crm_buscas_cliente_fk_crm_buscas_cliente_cliente1_idx ON CRM_BUSCAS_CLIENTE (ID_CLIENTE);
CREATE INDEX IF NOT EXISTS idx_crm_carteira_cliente_fk_crm_carteira_cliente_crm_carteira_cli ON CRM_CARTEIRA_CLIENTE (ID_CRM_CARTEIRA_CLIENTE_PERFIL);
CREATE INDEX IF NOT EXISTS idx_crm_carteira_cliente_fk_crm_carteira_cliente_cliente1_idx ON CRM_CARTEIRA_CLIENTE (ID_CLIENTE);

-- ================================================================
-- Chaves Estrangeiras
-- ================================================================
ALTER TABLE PESSOA_FISICA ADD CONSTRAINT fk_PESSOA_FISICA_PESSOA1 FOREIGN KEY (ID_PESSOA) REFERENCES PESSOA (ID);
ALTER TABLE PESSOA_FISICA ADD CONSTRAINT fk_PESSOA_FISICA_NIVEL_FORMACAO1 FOREIGN KEY (ID_NIVEL_FORMACAO) REFERENCES NIVEL_FORMACAO (ID);
ALTER TABLE PESSOA_FISICA ADD CONSTRAINT fk_PESSOA_FISICA_ESTADO_CIVIL1 FOREIGN KEY (ID_ESTADO_CIVIL) REFERENCES ESTADO_CIVIL (ID);
ALTER TABLE PESSOA_JURIDICA ADD CONSTRAINT fk_PESSOA_JURIDICA_PESSOA1 FOREIGN KEY (ID_PESSOA) REFERENCES PESSOA (ID);
ALTER TABLE CLIENTE ADD CONSTRAINT fk_CLIENTE_PESSOA FOREIGN KEY (ID_PESSOA) REFERENCES PESSOA (ID);
ALTER TABLE CLIENTE ADD CONSTRAINT fk_CLIENTE_TABELA_PRECO1 FOREIGN KEY (ID_TABELA_PRECO) REFERENCES TABELA_PRECO (ID);
ALTER TABLE FORNECEDOR ADD CONSTRAINT fk_FORNECEDOR_PESSOA1 FOREIGN KEY (ID_PESSOA) REFERENCES PESSOA (ID);
ALTER TABLE TRANSPORTADORA ADD CONSTRAINT fk_TRANSPORTADORA_PESSOA1 FOREIGN KEY (ID_PESSOA) REFERENCES PESSOA (ID);
ALTER TABLE CONTADOR ADD CONSTRAINT fk_CONTADOR_PESSOA1 FOREIGN KEY (ID_PESSOA) REFERENCES PESSOA (ID);
ALTER TABLE COLABORADOR ADD CONSTRAINT fk_COLABORADOR_PESSOA1 FOREIGN KEY (ID_PESSOA) REFERENCES PESSOA (ID);
ALTER TABLE COLABORADOR ADD CONSTRAINT fk_COLABORADOR_CARGO1 FOREIGN KEY (ID_CARGO) REFERENCES CARGO (ID);
ALTER TABLE COLABORADOR ADD CONSTRAINT fk_COLABORADOR_SETOR1 FOREIGN KEY (ID_SETOR) REFERENCES SETOR (ID);
ALTER TABLE COLABORADOR ADD CONSTRAINT fk_COLABORADOR_COLABORADOR_SITUACAO1 FOREIGN KEY (ID_COLABORADOR_SITUACAO) REFERENCES COLABORADOR_SITUACAO (ID);
ALTER TABLE COLABORADOR ADD CONSTRAINT fk_COLABORADOR_TIPO_ADMISSAO1 FOREIGN KEY (ID_TIPO_ADMISSAO) REFERENCES TIPO_ADMISSAO (ID);
ALTER TABLE COLABORADOR ADD CONSTRAINT fk_COLABORADOR_COLABORADOR_TIPO1 FOREIGN KEY (ID_COLABORADOR_TIPO) REFERENCES COLABORADOR_TIPO (ID);
ALTER TABLE COLABORADOR ADD CONSTRAINT fk_COLABORADOR_SINDICATO1 FOREIGN KEY (ID_SINDICATO) REFERENCES SINDICATO (ID);
ALTER TABLE VENDEDOR ADD CONSTRAINT fk_VENDEDOR_COLABORADOR1 FOREIGN KEY (ID_COLABORADOR) REFERENCES COLABORADOR (ID);
ALTER TABLE VENDEDOR ADD CONSTRAINT fk_VENDEDOR_COMISSAO_PERFIL1 FOREIGN KEY (ID_COMISSAO_PERFIL) REFERENCES COMISSAO_PERFIL (ID);
ALTER TABLE PESSOA_ENDERECO ADD CONSTRAINT fk_PESSOA_ENDERECO_PESSOA1 FOREIGN KEY (ID_PESSOA) REFERENCES PESSOA (ID);
ALTER TABLE PESSOA_CONTATO ADD CONSTRAINT fk_PESSOA_CONTATO_PESSOA1 FOREIGN KEY (ID_PESSOA) REFERENCES PESSOA (ID);
ALTER TABLE PESSOA_TELEFONE ADD CONSTRAINT fk_PESSOA_TELEFONE_PESSOA1 FOREIGN KEY (ID_PESSOA) REFERENCES PESSOA (ID);
ALTER TABLE USUARIO ADD CONSTRAINT fk_USUARIO_COLABORADOR1 FOREIGN KEY (ID_COLABORADOR) REFERENCES COLABORADOR (ID);
ALTER TABLE USUARIO ADD CONSTRAINT fk_USUARIO_PAPEL1 FOREIGN KEY (ID_PAPEL) REFERENCES PAPEL (ID);
ALTER TABLE PAPEL_FUNCAO ADD CONSTRAINT fk_PAPEL_FUNCAO_PAPEL1 FOREIGN KEY (ID_PAPEL) REFERENCES PAPEL (ID);
ALTER TABLE PAPEL_FUNCAO ADD CONSTRAINT fk_PAPEL_FUNCAO_FUNCAO1 FOREIGN KEY (ID_FUNCAO) REFERENCES FUNCAO (ID);
ALTER TABLE PRODUTO ADD CONSTRAINT fk_PRODUTO_PRODUTO_SUBGRUPO1 FOREIGN KEY (ID_PRODUTO_SUBGRUPO) REFERENCES PRODUTO_SUBGRUPO (ID);
ALTER TABLE PRODUTO ADD CONSTRAINT fk_PRODUTO_PRODUTO_MARCA1 FOREIGN KEY (ID_PRODUTO_MARCA) REFERENCES PRODUTO_MARCA (ID);
ALTER TABLE PRODUTO ADD CONSTRAINT fk_PRODUTO_PRODUTO_UNIDADE1 FOREIGN KEY (ID_PRODUTO_UNIDADE) REFERENCES PRODUTO_UNIDADE (ID);
ALTER TABLE PRODUTO ADD CONSTRAINT fk_PRODUTO_TRIBUT_ICMS_CUSTOM_CAB1 FOREIGN KEY (ID_TRIBUT_ICMS_CUSTOM_CAB) REFERENCES TRIBUT_ICMS_CUSTOM_CAB (ID);
ALTER TABLE PRODUTO ADD CONSTRAINT fk_PRODUTO_TRIBUT_GRUPO_TRIBUTARIO1 FOREIGN KEY (ID_TRIBUT_GRUPO_TRIBUTARIO) REFERENCES TRIBUT_GRUPO_TRIBUTARIO (ID);
ALTER TABLE PRODUTO_SUBGRUPO ADD CONSTRAINT fk_PRODUTO_SUBGRUPO_PRODUTO_GRUPO1 FOREIGN KEY (ID_PRODUTO_GRUPO) REFERENCES PRODUTO_GRUPO (ID);
ALTER TABLE BANCO_AGENCIA ADD CONSTRAINT fk_BANCO_AGENCIA_BANCO1 FOREIGN KEY (ID_BANCO) REFERENCES BANCO (ID);
ALTER TABLE BANCO_CONTA_CAIXA ADD CONSTRAINT fk_BANCO_CONTA_CAIXA_BANCO_AGENCIA1 FOREIGN KEY (ID_BANCO_AGENCIA) REFERENCES BANCO_AGENCIA (ID);
ALTER TABLE MUNICIPIO ADD CONSTRAINT fk_MUNICIPIO_UF1 FOREIGN KEY (ID_UF) REFERENCES UF (ID);
ALTER TABLE EMPRESA_ENDERECO ADD CONSTRAINT fk_EMPRESA_ENDERECO_EMPRESA1 FOREIGN KEY (ID_EMPRESA) REFERENCES EMPRESA (ID);
ALTER TABLE EMPRESA_CONTATO ADD CONSTRAINT fk_EMPRESA_CONTATO_EMPRESA1 FOREIGN KEY (ID_EMPRESA) REFERENCES EMPRESA (ID);
ALTER TABLE EMPRESA_TELEFONE ADD CONSTRAINT fk_EMPRESA_TELEFONE_EMPRESA1 FOREIGN KEY (ID_EMPRESA) REFERENCES EMPRESA (ID);
ALTER TABLE TALONARIO_CHEQUE ADD CONSTRAINT fk_TALONARIO_CHEQUE_BANCO_CONTA_CAIXA1 FOREIGN KEY (ID_BANCO_CONTA_CAIXA) REFERENCES BANCO_CONTA_CAIXA (ID);
ALTER TABLE CHEQUE ADD CONSTRAINT fk_{E7B18D4F-5CF4-4A5D-AC05-B57A05559CA6} FOREIGN KEY (ID_TALONARIO_CHEQUE) REFERENCES TALONARIO_CHEQUE (ID);
ALTER TABLE FIN_FECHAMENTO_CAIXA_BANCO ADD CONSTRAINT fk_FIN_FECHAMENTO_CAIXA_BANCO_BANCO_CONTA_CAIXA1 FOREIGN KEY (ID_BANCO_CONTA_CAIXA) REFERENCES BANCO_CONTA_CAIXA (ID);
ALTER TABLE FIN_EXTRATO_CONTA_BANCO ADD CONSTRAINT fk_FIN_EXTRATO_CONTA_BANCO_BANCO_CONTA_CAIXA1 FOREIGN KEY (ID_BANCO_CONTA_CAIXA) REFERENCES BANCO_CONTA_CAIXA (ID);
ALTER TABLE FIN_LANCAMENTO_PAGAR ADD CONSTRAINT fk_{78F2F6A7-9A1B-4960-9786-757E3E77873A} FOREIGN KEY (ID_FIN_DOCUMENTO_ORIGEM) REFERENCES FIN_DOCUMENTO_ORIGEM (ID);
ALTER TABLE FIN_LANCAMENTO_PAGAR ADD CONSTRAINT fk_FIN_LANCAMENTO_PAGAR_FIN_NATUREZA_FINANCEIRA1 FOREIGN KEY (ID_FIN_NATUREZA_FINANCEIRA) REFERENCES FIN_NATUREZA_FINANCEIRA (ID);
ALTER TABLE FIN_LANCAMENTO_PAGAR ADD CONSTRAINT fk_FIN_LANCAMENTO_PAGAR_FORNECEDOR1 FOREIGN KEY (ID_FORNECEDOR) REFERENCES FORNECEDOR (ID);
ALTER TABLE FIN_LANCAMENTO_PAGAR ADD CONSTRAINT fk_FIN_LANCAMENTO_PAGAR_BANCO_CONTA_CAIXA1 FOREIGN KEY (ID_BANCO_CONTA_CAIXA) REFERENCES BANCO_CONTA_CAIXA (ID);
ALTER TABLE FIN_PARCELA_PAGAR ADD CONSTRAINT fk_{56615208-C2D0-4DD9-802B-2B99BFF4EF53} FOREIGN KEY (ID_FIN_STATUS_PARCELA) REFERENCES FIN_STATUS_PARCELA (ID);
ALTER TABLE FIN_PARCELA_PAGAR ADD CONSTRAINT fk_{06A2AAB2-9856-4010-AEDB-BB0F0EC86ABF} FOREIGN KEY (ID_FIN_LANCAMENTO_PAGAR) REFERENCES FIN_LANCAMENTO_PAGAR (ID);
ALTER TABLE FIN_PARCELA_PAGAR ADD CONSTRAINT fk_FIN_PARCELA_PAGAR_FIN_TIPO_PAGAMENTO1 FOREIGN KEY (ID_FIN_TIPO_PAGAMENTO) REFERENCES FIN_TIPO_PAGAMENTO (ID);
ALTER TABLE FIN_PARCELA_PAGAR ADD CONSTRAINT fk_FIN_PARCELA_PAGAR_FIN_CHEQUE_EMITIDO1 FOREIGN KEY (ID_FIN_CHEQUE_EMITIDO) REFERENCES FIN_CHEQUE_EMITIDO (ID);
ALTER TABLE FIN_CHEQUE_EMITIDO ADD CONSTRAINT fk_{75F21313-9E6B-4319-9C96-B460CCA89916} FOREIGN KEY (ID_CHEQUE) REFERENCES CHEQUE (ID);
ALTER TABLE FIN_LANCAMENTO_RECEBER ADD CONSTRAINT fk_{B290D08D-4B6D-4B5C-8C08-29AE67AB180C} FOREIGN KEY (ID_FIN_DOCUMENTO_ORIGEM) REFERENCES FIN_DOCUMENTO_ORIGEM (ID);
ALTER TABLE FIN_LANCAMENTO_RECEBER ADD CONSTRAINT fk_FIN_LANCAMENTO_RECEBER_FIN_NATUREZA_FINANCEIRA1 FOREIGN KEY (ID_FIN_NATUREZA_FINANCEIRA) REFERENCES FIN_NATUREZA_FINANCEIRA (ID);
ALTER TABLE FIN_LANCAMENTO_RECEBER ADD CONSTRAINT fk_FIN_LANCAMENTO_RECEBER_CLIENTE1 FOREIGN KEY (ID_CLIENTE) REFERENCES CLIENTE (ID);
ALTER TABLE FIN_LANCAMENTO_RECEBER ADD CONSTRAINT fk_FIN_LANCAMENTO_RECEBER_BANCO_CONTA_CAIXA1 FOREIGN KEY (ID_BANCO_CONTA_CAIXA) REFERENCES BANCO_CONTA_CAIXA (ID);
ALTER TABLE FIN_PARCELA_RECEBER ADD CONSTRAINT fk_{8779D373-1258-4798-A769-5765822422BB} FOREIGN KEY (ID_FIN_LANCAMENTO_RECEBER) REFERENCES FIN_LANCAMENTO_RECEBER (ID);
ALTER TABLE FIN_PARCELA_RECEBER ADD CONSTRAINT fk_{DCA2496F-0D8C-484B-95D4-A7DCDE607642} FOREIGN KEY (ID_FIN_STATUS_PARCELA) REFERENCES FIN_STATUS_PARCELA (ID);
ALTER TABLE FIN_PARCELA_RECEBER ADD CONSTRAINT fk_FIN_PARCELA_RECEBER_FIN_TIPO_RECEBIMENTO1 FOREIGN KEY (ID_FIN_TIPO_RECEBIMENTO) REFERENCES FIN_TIPO_RECEBIMENTO (ID);
ALTER TABLE FIN_PARCELA_RECEBER ADD CONSTRAINT fk_FIN_PARCELA_RECEBER_FIN_CHEQUE_RECEBIDO1 FOREIGN KEY (ID_FIN_CHEQUE_RECEBIDO) REFERENCES FIN_CHEQUE_RECEBIDO (ID);
ALTER TABLE FIN_CHEQUE_RECEBIDO ADD CONSTRAINT fk_FIN_CHEQUE_RECEBIDO_PESSOA1 FOREIGN KEY (ID_PESSOA) REFERENCES PESSOA (ID);
ALTER TABLE FIN_CONFIGURACAO_BOLETO ADD CONSTRAINT fk_FIN_CONFIGURACAO_BOLETO_BANCO_CONTA_CAIXA1 FOREIGN KEY (ID_BANCO_CONTA_CAIXA) REFERENCES BANCO_CONTA_CAIXA (ID);
ALTER TABLE TRIBUT_ICMS_UF ADD CONSTRAINT fk_{19D06CF5-5DC7-480E-A49D-BECF75F651EE} FOREIGN KEY (ID_TRIBUT_CONFIGURA_OF_GT) REFERENCES TRIBUT_CONFIGURA_OF_GT (ID);
ALTER TABLE TRIBUT_PIS ADD CONSTRAINT fk_{6400E21E-AE1E-47EB-9DD4-FD8D4F5F00B9} FOREIGN KEY (ID_TRIBUT_CONFIGURA_OF_GT) REFERENCES TRIBUT_CONFIGURA_OF_GT (ID);
ALTER TABLE TRIBUT_COFINS ADD CONSTRAINT fk_{F13F47B6-BC52-4363-9CE2-39CED083A615} FOREIGN KEY (ID_TRIBUT_CONFIGURA_OF_GT) REFERENCES TRIBUT_CONFIGURA_OF_GT (ID);
ALTER TABLE TRIBUT_IPI ADD CONSTRAINT fk_{C143DDE4-2A66-4AD3-9C39-E7151907C43F} FOREIGN KEY (ID_TRIBUT_CONFIGURA_OF_GT) REFERENCES TRIBUT_CONFIGURA_OF_GT (ID);
ALTER TABLE TRIBUT_ISS ADD CONSTRAINT fk_{63899E57-57EC-423C-9D38-DD9E673F4159} FOREIGN KEY (ID_TRIBUT_OPERACAO_FISCAL) REFERENCES TRIBUT_OPERACAO_FISCAL (ID);
ALTER TABLE COMPRA_REQUISICAO ADD CONSTRAINT fk_{38C90B1B-4612-4019-8BC4-DB19CB8591F3} FOREIGN KEY (ID_COMPRA_TIPO_REQUISICAO) REFERENCES COMPRA_TIPO_REQUISICAO (ID);
ALTER TABLE COMPRA_REQUISICAO ADD CONSTRAINT fk_COMPRA_REQUISICAO_COLABORADOR1 FOREIGN KEY (ID_COLABORADOR) REFERENCES COLABORADOR (ID);
ALTER TABLE COMPRA_REQUISICAO_DETALHE ADD CONSTRAINT fk_{ECA5555D-212D-4D7B-A79C-D5560C161C8F} FOREIGN KEY (ID_COMPRA_REQUISICAO) REFERENCES COMPRA_REQUISICAO (ID);
ALTER TABLE COMPRA_REQUISICAO_DETALHE ADD CONSTRAINT fk_COMPRA_REQUISICAO_DETALHE_PRODUTO1 FOREIGN KEY (ID_PRODUTO) REFERENCES PRODUTO (ID);
ALTER TABLE COMPRA_COTACAO ADD CONSTRAINT fk_COMPRA_COTACAO_COMPRA_REQUISICAO1 FOREIGN KEY (ID_COMPRA_REQUISICAO) REFERENCES COMPRA_REQUISICAO (ID);
ALTER TABLE COMPRA_FORNECEDOR_COTACAO ADD CONSTRAINT fk_{F28D90D4-59C0-49A3-8AF2-94BA6F6B55CE} FOREIGN KEY (ID_COMPRA_COTACAO) REFERENCES COMPRA_COTACAO (ID);
ALTER TABLE COMPRA_FORNECEDOR_COTACAO ADD CONSTRAINT fk_COMPRA_FORNECEDOR_COTACAO_FORNECEDOR1 FOREIGN KEY (ID_FORNECEDOR) REFERENCES FORNECEDOR (ID);
ALTER TABLE COMPRA_COTACAO_DETALHE ADD CONSTRAINT fk_{2DE08AA3-A7B9-41A3-A33E-5F3FBEF89674} FOREIGN KEY (ID_COMPRA_FORNECEDOR_COTACAO) REFERENCES COMPRA_FORNECEDOR_COTACAO (ID);
ALTER TABLE COMPRA_COTACAO_DETALHE ADD CONSTRAINT fk_COMPRA_COTACAO_DETALHE_PRODUTO1 FOREIGN KEY (ID_PRODUTO) REFERENCES PRODUTO (ID);
ALTER TABLE COMPRA_PEDIDO ADD CONSTRAINT fk_{E9033C3C-AFA4-444D-8A06-165419B51DD3} FOREIGN KEY (ID_COMPRA_TIPO_PEDIDO) REFERENCES COMPRA_TIPO_PEDIDO (ID);
ALTER TABLE COMPRA_PEDIDO ADD CONSTRAINT fk_COMPRA_PEDIDO_FORNECEDOR1 FOREIGN KEY (ID_FORNECEDOR) REFERENCES FORNECEDOR (ID);
ALTER TABLE COMPRA_PEDIDO ADD CONSTRAINT fk_COMPRA_PEDIDO_COLABORADOR1 FOREIGN KEY (ID_COLABORADOR) REFERENCES COLABORADOR (ID);
ALTER TABLE COMPRA_PEDIDO_DETALHE ADD CONSTRAINT fk_{F87F64FC-8F40-43C6-9A94-7E84A1551C3A} FOREIGN KEY (ID_COMPRA_PEDIDO) REFERENCES COMPRA_PEDIDO (ID);
ALTER TABLE COMPRA_PEDIDO_DETALHE ADD CONSTRAINT fk_COMPRA_PEDIDO_DETALHE_PRODUTO1 FOREIGN KEY (ID_PRODUTO) REFERENCES PRODUTO (ID);
ALTER TABLE VENDA_ORCAMENTO_CABECALHO ADD CONSTRAINT fk_{013A2B4A-7CC7-4170-AE92-55132D36367E} FOREIGN KEY (ID_VENDA_CONDICOES_PAGAMENTO) REFERENCES VENDA_CONDICOES_PAGAMENTO (ID);
ALTER TABLE VENDA_ORCAMENTO_CABECALHO ADD CONSTRAINT fk_VENDA_ORCAMENTO_CABECALHO_VENDEDOR1 FOREIGN KEY (ID_VENDEDOR) REFERENCES VENDEDOR (ID);
ALTER TABLE VENDA_ORCAMENTO_CABECALHO ADD CONSTRAINT fk_VENDA_ORCAMENTO_CABECALHO_CLIENTE1 FOREIGN KEY (ID_CLIENTE) REFERENCES CLIENTE (ID);
ALTER TABLE VENDA_ORCAMENTO_CABECALHO ADD CONSTRAINT fk_VENDA_ORCAMENTO_CABECALHO_TRANSPORTADORA1 FOREIGN KEY (ID_TRANSPORTADORA) REFERENCES TRANSPORTADORA (ID);
ALTER TABLE NOTA_FISCAL_TIPO ADD CONSTRAINT fk_{5365C99B-97BA-432A-A1B4-5139D0F192AA} FOREIGN KEY (ID_NOTA_FISCAL_MODELO) REFERENCES NOTA_FISCAL_MODELO (ID);
ALTER TABLE VENDA_ORCAMENTO_DETALHE ADD CONSTRAINT fk_{E312F633-27BF-4104-95C5-4A093136448D} FOREIGN KEY (ID_VENDA_ORCAMENTO_CABECALHO) REFERENCES VENDA_ORCAMENTO_CABECALHO (ID);
ALTER TABLE VENDA_ORCAMENTO_DETALHE ADD CONSTRAINT fk_VENDA_ORCAMENTO_DETALHE_PRODUTO1 FOREIGN KEY (ID_PRODUTO) REFERENCES PRODUTO (ID);
ALTER TABLE VENDA_CABECALHO ADD CONSTRAINT fk_{0B6B64FC-0B7F-439D-9BC9-FE77D46D7A07} FOREIGN KEY (ID_VENDA_ORCAMENTO_CABECALHO) REFERENCES VENDA_ORCAMENTO_CABECALHO (ID);
ALTER TABLE VENDA_CABECALHO ADD CONSTRAINT fk_{67810BBB-E8C9-4BC1-AA83-E96DC12A98E1} FOREIGN KEY (ID_VENDA_CONDICOES_PAGAMENTO) REFERENCES VENDA_CONDICOES_PAGAMENTO (ID);
ALTER TABLE VENDA_CABECALHO ADD CONSTRAINT fk_{91559D47-8B0E-4A62-ACEB-4953401CE72A} FOREIGN KEY (ID_NOTA_FISCAL_TIPO) REFERENCES NOTA_FISCAL_TIPO (ID);
ALTER TABLE VENDA_CABECALHO ADD CONSTRAINT fk_VENDA_CABECALHO_CLIENTE1 FOREIGN KEY (ID_CLIENTE) REFERENCES CLIENTE (ID);
ALTER TABLE VENDA_CABECALHO ADD CONSTRAINT fk_VENDA_CABECALHO_TRANSPORTADORA1 FOREIGN KEY (ID_TRANSPORTADORA) REFERENCES TRANSPORTADORA (ID);
ALTER TABLE VENDA_CABECALHO ADD CONSTRAINT fk_VENDA_CABECALHO_VENDEDOR1 FOREIGN KEY (ID_VENDEDOR) REFERENCES VENDEDOR (ID);
ALTER TABLE VENDA_DETALHE ADD CONSTRAINT fk_{69C29C33-DFCD-49FA-8F5F-105E19884FEE} FOREIGN KEY (ID_VENDA_CABECALHO) REFERENCES VENDA_CABECALHO (ID);
ALTER TABLE VENDA_DETALHE ADD CONSTRAINT fk_VENDA_DETALHE_PRODUTO1 FOREIGN KEY (ID_PRODUTO) REFERENCES PRODUTO (ID);
ALTER TABLE VENDA_CONDICOES_PARCELAS ADD CONSTRAINT fk_{BED0D350-FF66-4FF7-8CE2-3CEE91CB7EBC} FOREIGN KEY (ID_VENDA_CONDICOES_PAGAMENTO) REFERENCES VENDA_CONDICOES_PAGAMENTO (ID);
ALTER TABLE VENDA_FRETE ADD CONSTRAINT fk_{1ABD2167-8D93-47C8-B224-4799D3AC3986} FOREIGN KEY (ID_VENDA_CABECALHO) REFERENCES VENDA_CABECALHO (ID);
ALTER TABLE VENDA_FRETE ADD CONSTRAINT fk_VENDA_FRETE_TRANSPORTADORA1 FOREIGN KEY (ID_TRANSPORTADORA) REFERENCES TRANSPORTADORA (ID);
ALTER TABLE VENDA_COMISSAO ADD CONSTRAINT fk_{E8EEED49-135C-4572-A661-9D85DFB65356} FOREIGN KEY (ID_VENDA_CABECALHO) REFERENCES VENDA_CABECALHO (ID);
ALTER TABLE VENDA_COMISSAO ADD CONSTRAINT fk_VENDA_COMISSAO_VENDEDOR1 FOREIGN KEY (ID_VENDEDOR) REFERENCES VENDEDOR (ID);
ALTER TABLE REQUISICAO_INTERNA_CABECALHO ADD CONSTRAINT fk_REQUISICAO_INTERNA_CABECALHO_COLABORADOR1 FOREIGN KEY (ID_COLABORADOR) REFERENCES COLABORADOR (ID);
ALTER TABLE REQUISICAO_INTERNA_DETALHE ADD CONSTRAINT fk_{34AD1B31-03E7-4FE2-80FC-9EB2E4AF025E} FOREIGN KEY (ID_REQUISICAO_INTERNA_CABECALHO) REFERENCES REQUISICAO_INTERNA_CABECALHO (ID);
ALTER TABLE REQUISICAO_INTERNA_DETALHE ADD CONSTRAINT fk_REQUISICAO_INTERNA_DETALHE_PRODUTO1 FOREIGN KEY (ID_PRODUTO) REFERENCES PRODUTO (ID);
ALTER TABLE ESTOQUE_REAJUSTE_CABECALHO ADD CONSTRAINT fk_ESTOQUE_REAJUSTE_CABECALHO_COLABORADOR1 FOREIGN KEY (ID_COLABORADOR) REFERENCES COLABORADOR (ID);
ALTER TABLE ESTOQUE_REAJUSTE_DETALHE ADD CONSTRAINT fk_{4CC49A7E-B388-4C3C-8F2A-E307C07CE241} FOREIGN KEY (ID_ESTOQUE_REAJUSTE_CABECALHO) REFERENCES ESTOQUE_REAJUSTE_CABECALHO (ID);
ALTER TABLE ESTOQUE_REAJUSTE_DETALHE ADD CONSTRAINT fk_ESTOQUE_REAJUSTE_DETALHE_PRODUTO1 FOREIGN KEY (ID_PRODUTO) REFERENCES PRODUTO (ID);
ALTER TABLE ESTOQUE_GRADE ADD CONSTRAINT fk_{B599518C-2BAD-4EE0-A146-E41754BEE49D} FOREIGN KEY (ID_ESTOQUE_COR) REFERENCES ESTOQUE_COR (ID);
ALTER TABLE ESTOQUE_GRADE ADD CONSTRAINT fk_{08CB887D-2458-4189-957A-2B8DC12F08C4} FOREIGN KEY (ID_ESTOQUE_TAMANHO) REFERENCES ESTOQUE_TAMANHO (ID);
ALTER TABLE ESTOQUE_GRADE ADD CONSTRAINT fk_{F4C36775-73AD-4D90-AB42-1DB3E5EDF85D} FOREIGN KEY (ID_ESTOQUE_SABOR) REFERENCES ESTOQUE_SABOR (ID);
ALTER TABLE ESTOQUE_GRADE ADD CONSTRAINT fk_{5E639E1C-5C60-46BE-A862-D3802D631C3C} FOREIGN KEY (ID_ESTOQUE_MARCA) REFERENCES ESTOQUE_MARCA (ID);
ALTER TABLE ESTOQUE_GRADE ADD CONSTRAINT fk_ESTOQUE_GRADE_PRODUTO1 FOREIGN KEY (ID_PRODUTO) REFERENCES PRODUTO (ID);
ALTER TABLE TRIBUT_CONFIGURA_OF_GT ADD CONSTRAINT fk_{6AF0FD4D-0B2B-495D-951B-03F72360D2F8} FOREIGN KEY (ID_TRIBUT_OPERACAO_FISCAL) REFERENCES TRIBUT_OPERACAO_FISCAL (ID);
ALTER TABLE TRIBUT_CONFIGURA_OF_GT ADD CONSTRAINT fk_{7992BFAD-59FB-4EF4-9024-FFD46F78BC5E} FOREIGN KEY (ID_TRIBUT_GRUPO_TRIBUTARIO) REFERENCES TRIBUT_GRUPO_TRIBUTARIO (ID);
ALTER TABLE TRIBUT_ICMS_CUSTOM_DET ADD CONSTRAINT fk_{BD28B261-3A95-45B9-9E5F-59D51A1B2B0A} FOREIGN KEY (ID_TRIBUT_ICMS_CUSTOM_CAB) REFERENCES TRIBUT_ICMS_CUSTOM_CAB (ID);
ALTER TABLE NFE_CABECALHO ADD CONSTRAINT fk_NFE_CABECALHO_VENDEDOR1 FOREIGN KEY (ID_VENDEDOR) REFERENCES VENDEDOR (ID);
ALTER TABLE NFE_CABECALHO ADD CONSTRAINT fk_NFE_CABECALHO_FORNECEDOR1 FOREIGN KEY (ID_FORNECEDOR) REFERENCES FORNECEDOR (ID);
ALTER TABLE NFE_CABECALHO ADD CONSTRAINT fk_NFE_CABECALHO_NFCE_MOVIMENTO1 FOREIGN KEY (ID_NFCE_MOVIMENTO) REFERENCES NFCE_MOVIMENTO (ID);
ALTER TABLE NFE_CABECALHO ADD CONSTRAINT fk_NFE_CABECALHO_VENDA_CABECALHO1 FOREIGN KEY (ID_VENDA_CABECALHO) REFERENCES VENDA_CABECALHO (ID);
ALTER TABLE NFE_CABECALHO ADD CONSTRAINT fk_NFE_CABECALHO_TRIBUT_OPERACAO_FISCAL1 FOREIGN KEY (ID_TRIBUT_OPERACAO_FISCAL) REFERENCES TRIBUT_OPERACAO_FISCAL (ID);
ALTER TABLE NFE_CABECALHO ADD CONSTRAINT fk_NFE_CABECALHO_CLIENTE1 FOREIGN KEY (ID_CLIENTE) REFERENCES CLIENTE (ID);
ALTER TABLE NFE_DETALHE ADD CONSTRAINT fk_{C0606BAB-4C4A-4C16-AC2D-F3605E698BF0} FOREIGN KEY (ID_NFE_CABECALHO) REFERENCES NFE_CABECALHO (ID);
ALTER TABLE NFE_DETALHE ADD CONSTRAINT fk_NFE_DETALHE_PRODUTO1 FOREIGN KEY (ID_PRODUTO) REFERENCES PRODUTO (ID);
ALTER TABLE NFE_REFERENCIADA ADD CONSTRAINT fk_{AFFD7A57-423B-4616-90AA-D7C269FF9C5E} FOREIGN KEY (ID_NFE_CABECALHO) REFERENCES NFE_CABECALHO (ID);
ALTER TABLE NFE_EMITENTE ADD CONSTRAINT fk_{49365C97-491E-489C-9F44-C5B537E8913D} FOREIGN KEY (ID_NFE_CABECALHO) REFERENCES NFE_CABECALHO (ID);
ALTER TABLE NFE_DESTINATARIO ADD CONSTRAINT fk_{11F2D433-04D6-44FD-BAA8-D5B266160973} FOREIGN KEY (ID_NFE_CABECALHO) REFERENCES NFE_CABECALHO (ID);
ALTER TABLE NFE_LOCAL_RETIRADA ADD CONSTRAINT fk_{8CDD5E8C-6254-41DE-A520-F318A3809796} FOREIGN KEY (ID_NFE_CABECALHO) REFERENCES NFE_CABECALHO (ID);
ALTER TABLE NFE_LOCAL_ENTREGA ADD CONSTRAINT fk_{BABA4BA0-DE05-4541-A1B6-03B53B66C5B1} FOREIGN KEY (ID_NFE_CABECALHO) REFERENCES NFE_CABECALHO (ID);
ALTER TABLE NFE_DET_ESPECIFICO_VEICULO ADD CONSTRAINT fk_{02840D51-CFB3-4D99-AC7B-F82104B522C2} FOREIGN KEY (ID_NFE_DETALHE) REFERENCES NFE_DETALHE (ID);
ALTER TABLE NFE_DET_ESPECIFICO_MEDICAMENTO ADD CONSTRAINT fk_{EE95E781-991D-48B7-815A-4BC87F24190B} FOREIGN KEY (ID_NFE_DETALHE) REFERENCES NFE_DETALHE (ID);
ALTER TABLE NFE_DET_ESPECIFICO_ARMAMENTO ADD CONSTRAINT fk_{AA2001E7-A2C4-4E15-89D2-693E8939F1BD} FOREIGN KEY (ID_NFE_DETALHE) REFERENCES NFE_DETALHE (ID);
ALTER TABLE NFE_DET_ESPECIFICO_COMBUSTIVEL ADD CONSTRAINT fk_{723B7CE2-E4EB-44C4-B2EA-C44402D5DCB4} FOREIGN KEY (ID_NFE_DETALHE) REFERENCES NFE_DETALHE (ID);
ALTER TABLE NFE_TRANSPORTE ADD CONSTRAINT fk_{BDFB69FA-15C2-4D43-ABDF-E39AB5044709} FOREIGN KEY (ID_NFE_CABECALHO) REFERENCES NFE_CABECALHO (ID);
ALTER TABLE NFE_TRANSPORTE ADD CONSTRAINT fk_NFE_TRANSPORTE_TRANSPORTADORA1 FOREIGN KEY (ID_TRANSPORTADORA) REFERENCES TRANSPORTADORA (ID);
ALTER TABLE NFE_FATURA ADD CONSTRAINT fk_{FB825C01-BAC2-48B6-8B14-6D37BE3DAFF8} FOREIGN KEY (ID_NFE_CABECALHO) REFERENCES NFE_CABECALHO (ID);
ALTER TABLE NFE_DUPLICATA ADD CONSTRAINT fk_NFE_DUPLICATA_NFE_FATURA1 FOREIGN KEY (ID_NFE_FATURA) REFERENCES NFE_FATURA (ID);
ALTER TABLE NFE_DECLARACAO_IMPORTACAO ADD CONSTRAINT fk_{1771AE4C-E276-4F94-99EB-BDA61D415790} FOREIGN KEY (ID_NFE_DETALHE) REFERENCES NFE_DETALHE (ID);
ALTER TABLE NFE_IMPORTACAO_DETALHE ADD CONSTRAINT fk_{788F333A-DCB0-4371-AECF-18A42ABF93B6} FOREIGN KEY (ID_NFE_DECLARACAO_IMPORTACAO) REFERENCES NFE_DECLARACAO_IMPORTACAO (ID);
ALTER TABLE NFE_CANA ADD CONSTRAINT fk_{D05C4271-B5E5-47EB-BD5B-3885FEA3E899} FOREIGN KEY (ID_NFE_CABECALHO) REFERENCES NFE_CABECALHO (ID);
ALTER TABLE NFE_CANA_FORNECIMENTO_DIARIO ADD CONSTRAINT fk_{71A66239-C538-4B83-AD23-EFC8F3FA0AB4} FOREIGN KEY (ID_NFE_CANA) REFERENCES NFE_CANA (ID);
ALTER TABLE NFE_CANA_DEDUCOES_SAFRA ADD CONSTRAINT fk_{3C5FF51C-922A-47C7-B352-E32615CA2327} FOREIGN KEY (ID_NFE_CANA) REFERENCES NFE_CANA (ID);
ALTER TABLE NFE_CUPOM_FISCAL_REFERENCIADO ADD CONSTRAINT fk_{0B096A6D-C97B-4DE5-B93D-254B25C37CC5} FOREIGN KEY (ID_NFE_CABECALHO) REFERENCES NFE_CABECALHO (ID);
ALTER TABLE NFE_PROD_RURAL_REFERENCIADA ADD CONSTRAINT fk_{7C9760BE-F8ED-418D-AED9-1F65ACB76F67} FOREIGN KEY (ID_NFE_CABECALHO) REFERENCES NFE_CABECALHO (ID);
ALTER TABLE NFE_NF_REFERENCIADA ADD CONSTRAINT fk_{172BA844-7467-4E30-BB11-F98E00D75E8F} FOREIGN KEY (ID_NFE_CABECALHO) REFERENCES NFE_CABECALHO (ID);
ALTER TABLE NFE_DETALHE_IMPOSTO_ICMS ADD CONSTRAINT fk_{2ECA610C-69B9-43E7-B65D-F30EDC701A59} FOREIGN KEY (ID_NFE_DETALHE) REFERENCES NFE_DETALHE (ID);
ALTER TABLE NFE_DETALHE_IMPOSTO_IPI ADD CONSTRAINT fk_{848512E8-6818-4FF8-85B2-FD9773A5AAA8} FOREIGN KEY (ID_NFE_DETALHE) REFERENCES NFE_DETALHE (ID);
ALTER TABLE NFE_DETALHE_IMPOSTO_II ADD CONSTRAINT fk_{DD990476-FEE7-4709-BD8D-A6D372781AE1} FOREIGN KEY (ID_NFE_DETALHE) REFERENCES NFE_DETALHE (ID);
ALTER TABLE NFE_DETALHE_IMPOSTO_PIS ADD CONSTRAINT fk_{A901B4CB-EECC-4E0D-8163-E9C48092FBB3} FOREIGN KEY (ID_NFE_DETALHE) REFERENCES NFE_DETALHE (ID);
ALTER TABLE NFE_DETALHE_IMPOSTO_COFINS ADD CONSTRAINT fk_{45F41988-B667-4183-8517-DD1800D74792} FOREIGN KEY (ID_NFE_DETALHE) REFERENCES NFE_DETALHE (ID);
ALTER TABLE NFE_DETALHE_IMPOSTO_ISSQN ADD CONSTRAINT fk_{D3EADE39-4BA1-402D-9AE5-F55A6327DA3B} FOREIGN KEY (ID_NFE_DETALHE) REFERENCES NFE_DETALHE (ID);
ALTER TABLE NFE_TRANSPORTE_REBOQUE ADD CONSTRAINT fk_{33120FEA-84FA-45B1-9F95-183D64AC0F6F} FOREIGN KEY (ID_NFE_TRANSPORTE) REFERENCES NFE_TRANSPORTE (ID);
ALTER TABLE NFE_TRANSPORTE_VOLUME ADD CONSTRAINT fk_{683237C6-9879-4C55-BBD3-8CD3F1AF00EF} FOREIGN KEY (ID_NFE_TRANSPORTE) REFERENCES NFE_TRANSPORTE (ID);
ALTER TABLE NFE_TRANSPORTE_VOLUME_LACRE ADD CONSTRAINT fk_{C379B512-7C71-41D4-8D32-7A543923DC1E} FOREIGN KEY (ID_NFE_TRANSPORTE_VOLUME) REFERENCES NFE_TRANSPORTE_VOLUME (ID);
ALTER TABLE NFE_PROCESSO_REFERENCIADO ADD CONSTRAINT fk_{9C752FAA-B71F-425A-ACB6-A3E8972E6FF4} FOREIGN KEY (ID_NFE_CABECALHO) REFERENCES NFE_CABECALHO (ID);
ALTER TABLE NFE_CTE_REFERENCIADO ADD CONSTRAINT fk_{43CDCD03-AB6A-4120-BB27-CBDB6C26B4A7} FOREIGN KEY (ID_NFE_CABECALHO) REFERENCES NFE_CABECALHO (ID);
ALTER TABLE NFE_ACESSO_XML ADD CONSTRAINT fk_{B466EFD3-8C2D-4EFD-B9AA-9DCEAAF57FA8} FOREIGN KEY (ID_NFE_CABECALHO) REFERENCES NFE_CABECALHO (ID);
ALTER TABLE NFE_EXPORTACAO ADD CONSTRAINT fk_{29DDD06F-DDD4-4255-94EE-1E32334EB138} FOREIGN KEY (ID_NFE_DETALHE) REFERENCES NFE_DETALHE (ID);
ALTER TABLE NFE_INFORMACAO_PAGAMENTO ADD CONSTRAINT fk_{BFB74DEB-FAC6-4F44-8FDA-F52BFEC321ED} FOREIGN KEY (ID_NFE_CABECALHO) REFERENCES NFE_CABECALHO (ID);
ALTER TABLE NFE_ITEM_RASTREADO ADD CONSTRAINT fk_NFE_ITEM_RASTREADO_NFE_DETALHE1 FOREIGN KEY (ID_NFE_DETALHE) REFERENCES NFE_DETALHE (ID);
ALTER TABLE NFE_DETALHE_IMPOSTO_PIS_ST ADD CONSTRAINT fk_{A901B4CB-EECC-4E0D-8163-E9C48092FBB3}0 FOREIGN KEY (ID_NFE_DETALHE) REFERENCES NFE_DETALHE (ID);
ALTER TABLE NFE_DETALHE_IMPOSTO_ICMS_UFDEST ADD CONSTRAINT fk_{2ECA610C-69B9-43E7-B65D-F30EDC701A59}0 FOREIGN KEY (ID_NFE_DETALHE) REFERENCES NFE_DETALHE (ID);
ALTER TABLE NFE_DETALHE_IMPOSTO_COFINS_ST ADD CONSTRAINT fk_{45F41988-B667-4183-8517-DD1800D74792}0 FOREIGN KEY (ID_NFE_DETALHE) REFERENCES NFE_DETALHE (ID);
ALTER TABLE NFE_RESPONSAVEL_TECNICO ADD CONSTRAINT fk_NFE_RESPONSAVEL_TECNICO_NFE_CABECALHO1 FOREIGN KEY (ID_NFE_CABECALHO) REFERENCES NFE_CABECALHO (ID);
ALTER TABLE TABELA_PRECO_PRODUTO ADD CONSTRAINT fk_{1C28A567-0398-406B-9243-4403C0E93099} FOREIGN KEY (ID_TABELA_PRECO) REFERENCES TABELA_PRECO (ID);
ALTER TABLE TABELA_PRECO_PRODUTO ADD CONSTRAINT fk_TABELA_PRECO_PRODUTO_PRODUTO1 FOREIGN KEY (ID_PRODUTO) REFERENCES PRODUTO (ID);
ALTER TABLE GED_DOCUMENTO_DETALHE ADD CONSTRAINT fk_{57544F31-81AC-4880-AB10-168655128E85} FOREIGN KEY (ID_GED_TIPO_DOCUMENTO) REFERENCES GED_TIPO_DOCUMENTO (ID);
ALTER TABLE GED_DOCUMENTO_DETALHE ADD CONSTRAINT fk_{CF2C5E46-A149-422F-B16C-A9731C76F40B} FOREIGN KEY (ID_GED_DOCUMENTO_CABECALHO) REFERENCES GED_DOCUMENTO_CABECALHO (ID);
ALTER TABLE GED_VERSAO_DOCUMENTO ADD CONSTRAINT fk_{B1B3E93F-737D-4043-9164-AD1418B05011} FOREIGN KEY (ID_GED_DOCUMENTO_DETALHE) REFERENCES GED_DOCUMENTO_DETALHE (ID);
ALTER TABLE GED_VERSAO_DOCUMENTO ADD CONSTRAINT fk_GED_VERSAO_DOCUMENTO_COLABORADOR1 FOREIGN KEY (ID_COLABORADOR) REFERENCES COLABORADOR (ID);
ALTER TABLE OS_ABERTURA ADD CONSTRAINT fk_{6BCAE8D3-8EF5-45FD-8A45-38B20DFF9FB0} FOREIGN KEY (ID_OS_STATUS) REFERENCES OS_STATUS (ID);
ALTER TABLE OS_ABERTURA ADD CONSTRAINT fk_OS_ABERTURA_CLIENTE1 FOREIGN KEY (ID_CLIENTE) REFERENCES CLIENTE (ID);
ALTER TABLE OS_ABERTURA ADD CONSTRAINT fk_OS_ABERTURA_COLABORADOR1 FOREIGN KEY (ID_COLABORADOR) REFERENCES COLABORADOR (ID);
ALTER TABLE OS_ABERTURA_EQUIPAMENTO ADD CONSTRAINT fk_{810B527C-FC00-4178-9F83-0DCE34F553A7} FOREIGN KEY (ID_OS_ABERTURA) REFERENCES OS_ABERTURA (ID);
ALTER TABLE OS_ABERTURA_EQUIPAMENTO ADD CONSTRAINT fk_{22CA1568-F45B-42E9-B840-4C2FDA5D9D90} FOREIGN KEY (ID_OS_EQUIPAMENTO) REFERENCES OS_EQUIPAMENTO (ID);
ALTER TABLE OS_PRODUTO_SERVICO ADD CONSTRAINT fk_{1076F74A-D810-46A7-BC95-BC173A02F8E1} FOREIGN KEY (ID_OS_ABERTURA) REFERENCES OS_ABERTURA (ID);
ALTER TABLE OS_PRODUTO_SERVICO ADD CONSTRAINT fk_OS_PRODUTO_SERVICO_PRODUTO1 FOREIGN KEY (ID_PRODUTO) REFERENCES PRODUTO (ID);
ALTER TABLE OS_EVOLUCAO ADD CONSTRAINT fk_{6EFF3578-C97B-4E12-8768-F5D4247D08A9} FOREIGN KEY (ID_OS_ABERTURA) REFERENCES OS_ABERTURA (ID);
ALTER TABLE COMISSAO_OBJETIVO ADD CONSTRAINT fk_{351EF9CB-7F6D-4EDE-A2C3-E35B9EF1F796} FOREIGN KEY (ID_COMISSAO_PERFIL) REFERENCES COMISSAO_PERFIL (ID);
ALTER TABLE COMISSAO_OBJETIVO ADD CONSTRAINT fk_COMISSAO_OBJETIVO_PRODUTO1 FOREIGN KEY (ID_PRODUTO) REFERENCES PRODUTO (ID);
ALTER TABLE VENDEDOR_ROTA ADD CONSTRAINT fk_VENDEDOR_ROTA_VENDEDOR1 FOREIGN KEY (ID_VENDEDOR) REFERENCES VENDEDOR (ID);
ALTER TABLE VENDEDOR_ROTA ADD CONSTRAINT fk_VENDEDOR_ROTA_CLIENTE1 FOREIGN KEY (ID_CLIENTE) REFERENCES CLIENTE (ID);
ALTER TABLE VENDEDOR_META ADD CONSTRAINT fk_VENDEDOR_META_VENDEDOR1 FOREIGN KEY (ID_VENDEDOR) REFERENCES VENDEDOR (ID);
ALTER TABLE VENDEDOR_META ADD CONSTRAINT fk_VENDEDOR_META_CLIENTE1 FOREIGN KEY (ID_CLIENTE) REFERENCES CLIENTE (ID);
ALTER TABLE NFCE_SANGRIA ADD CONSTRAINT fk_{2777AC82-DFA3-4F0E-9EE3-1F4AE5C53CF3} FOREIGN KEY (ID_NFCE_MOVIMENTO) REFERENCES NFCE_MOVIMENTO (ID);
ALTER TABLE NFCE_MOVIMENTO ADD CONSTRAINT fk_{B756D09A-C3D6-4012-A7D6-79F83A8EFBE7} FOREIGN KEY (ID_NFCE_OPERADOR) REFERENCES NFCE_OPERADOR (ID);
ALTER TABLE NFCE_MOVIMENTO ADD CONSTRAINT fk_{C40AD05D-651F-4DE6-A93A-F0B3CF973D36} FOREIGN KEY (ID_NFCE_CAIXA) REFERENCES NFCE_CAIXA (ID);
ALTER TABLE NFCE_OPERADOR ADD CONSTRAINT fk_NFCE_OPERADOR_COLABORADOR1 FOREIGN KEY (ID_COLABORADOR) REFERENCES COLABORADOR (ID);
ALTER TABLE NFCE_FECHAMENTO ADD CONSTRAINT fk_{7EE389FF-4DBB-42FE-8EC6-50DA93B8778E} FOREIGN KEY (ID_NFCE_MOVIMENTO) REFERENCES NFCE_MOVIMENTO (ID);
ALTER TABLE NFCE_FECHAMENTO ADD CONSTRAINT fk_NFCE_FECHAMENTO_NFCE_TIPO_PAGAMENTO1 FOREIGN KEY (ID_NFCE_TIPO_PAGAMENTO) REFERENCES NFCE_TIPO_PAGAMENTO (ID);
ALTER TABLE NFCE_SUPRIMENTO ADD CONSTRAINT fk_{2B61D0B4-58A2-49F5-A893-B0C551865C45} FOREIGN KEY (ID_NFCE_MOVIMENTO) REFERENCES NFCE_MOVIMENTO (ID);
ALTER TABLE NFSE_CABECALHO ADD CONSTRAINT fk_NFSE_CABECALHO_OS_ABERTURA1 FOREIGN KEY (ID_OS_ABERTURA) REFERENCES OS_ABERTURA (ID);
ALTER TABLE NFSE_CABECALHO ADD CONSTRAINT fk_NFSE_CABECALHO_CLIENTE1 FOREIGN KEY (ID_CLIENTE) REFERENCES CLIENTE (ID);
ALTER TABLE NFSE_DETALHE ADD CONSTRAINT fk_{A4D96B77-6862-43DE-9D90-6CE7C219395A} FOREIGN KEY (ID_NFSE_CABECALHO) REFERENCES NFSE_CABECALHO (ID);
ALTER TABLE NFSE_DETALHE ADD CONSTRAINT fk_{250949FC-A04F-43DA-B79F-E473F538AA92} FOREIGN KEY (ID_NFSE_LISTA_SERVICO) REFERENCES NFSE_LISTA_SERVICO (ID);
ALTER TABLE NFSE_INTERMEDIARIO ADD CONSTRAINT fk_{239E588F-852E-4B34-8B15-85253428F291} FOREIGN KEY (ID_NFSE_CABECALHO) REFERENCES NFSE_CABECALHO (ID);
ALTER TABLE CTE_EMITENTE ADD CONSTRAINT fk_{8E0EA66C-EA89-4C1F-8CF4-778365C7AE3B} FOREIGN KEY (ID_CTE_CABECALHO) REFERENCES CTE_CABECALHO (ID);
ALTER TABLE CTE_LOCAL_COLETA ADD CONSTRAINT fk_{BB10E3A1-3572-4882-ADE2-B20451A6C58A} FOREIGN KEY (ID_CTE_CABECALHO) REFERENCES CTE_CABECALHO (ID);
ALTER TABLE CTE_TOMADOR ADD CONSTRAINT fk_{FB54EDC5-F918-4617-A828-70539984BB46} FOREIGN KEY (ID_CTE_CABECALHO) REFERENCES CTE_CABECALHO (ID);
ALTER TABLE CTE_PASSAGEM ADD CONSTRAINT fk_{08191DFB-E061-4102-A065-34C8E0503CDA} FOREIGN KEY (ID_CTE_CABECALHO) REFERENCES CTE_CABECALHO (ID);
ALTER TABLE CTE_REMETENTE ADD CONSTRAINT fk_{44C5AE01-875B-414A-B141-210DE88D5716} FOREIGN KEY (ID_CTE_CABECALHO) REFERENCES CTE_CABECALHO (ID);
ALTER TABLE CTE_EXPEDIDOR ADD CONSTRAINT fk_{B49F680D-20F5-4D89-945B-ED7A99C5EBFF} FOREIGN KEY (ID_CTE_CABECALHO) REFERENCES CTE_CABECALHO (ID);
ALTER TABLE CTE_RECEBEDOR ADD CONSTRAINT fk_{73407675-AEAC-4EF4-80E5-3EF4401CF4D3} FOREIGN KEY (ID_CTE_CABECALHO) REFERENCES CTE_CABECALHO (ID);
ALTER TABLE CTE_DESTINATARIO ADD CONSTRAINT fk_{BE7E7FC1-4115-40C2-AB9E-A9B2B1B52D98} FOREIGN KEY (ID_CTE_CABECALHO) REFERENCES CTE_CABECALHO (ID);
ALTER TABLE CTE_LOCAL_ENTREGA ADD CONSTRAINT fk_{754026B8-770A-45E5-B53C-385E92689A57} FOREIGN KEY (ID_CTE_CABECALHO) REFERENCES CTE_CABECALHO (ID);
ALTER TABLE CTE_COMPONENTE ADD CONSTRAINT fk_{6A4B28DA-0868-47B1-B135-35B9AB1D1598} FOREIGN KEY (ID_CTE_CABECALHO) REFERENCES CTE_CABECALHO (ID);
ALTER TABLE CTE_CARGA ADD CONSTRAINT fk_{9B8A42CB-E13A-475F-81FE-5E7C48ED6E2F} FOREIGN KEY (ID_CTE_CABECALHO) REFERENCES CTE_CABECALHO (ID);
ALTER TABLE CTE_INFORMACAO_NF_OUTROS ADD CONSTRAINT fk_{9E6856B9-7569-4D16-BE24-71BF8F64DC1E} FOREIGN KEY (ID_CTE_CABECALHO) REFERENCES CTE_CABECALHO (ID);
ALTER TABLE CTE_INFORMACAO_NF_TRANSPORTE ADD CONSTRAINT fk_{A8CC2C9B-5112-4914-AA89-D8E0D2B6E646} FOREIGN KEY (ID_CTE_INFORMACAO_NF) REFERENCES CTE_INFORMACAO_NF_OUTROS (ID);
ALTER TABLE CTE_INF_NF_TRANSPORTE_LACRE ADD CONSTRAINT fk_{95A36096-9355-464E-A5DB-22B8F81E9908} FOREIGN KEY (ID_CTE_INFORMACAO_NF_TRANSPORTE) REFERENCES CTE_INFORMACAO_NF_TRANSPORTE (ID);
ALTER TABLE CTE_INFORMACAO_NF_CARGA ADD CONSTRAINT fk_{5DB05F41-B797-49A1-B003-D7B4DF8BF69C} FOREIGN KEY (ID_CTE_INFORMACAO_NF) REFERENCES CTE_INFORMACAO_NF_OUTROS (ID);
ALTER TABLE CTE_INF_NF_CARGA_LACRE ADD CONSTRAINT fk_{54ED8F7F-282E-4133-B2EF-771071F016AC} FOREIGN KEY (ID_CTE_INFORMACAO_NF_CARGA) REFERENCES CTE_INFORMACAO_NF_CARGA (ID);
ALTER TABLE CTE_DOCUMENTO_ANTERIOR ADD CONSTRAINT fk_{A53759A7-D844-4D7F-A5EF-B72EACB5ED21} FOREIGN KEY (ID_CTE_CABECALHO) REFERENCES CTE_CABECALHO (ID);
ALTER TABLE CTE_DOCUMENTO_ANTERIOR_ID ADD CONSTRAINT fk_{9A75406F-0C01-483F-8130-100DDC289E23} FOREIGN KEY (ID_CTE_DOCUMENTO_ANTERIOR) REFERENCES CTE_DOCUMENTO_ANTERIOR (ID);
ALTER TABLE CTE_SEGURO ADD CONSTRAINT fk_{C775F390-C782-4417-A741-5F64688574C5} FOREIGN KEY (ID_CTE_CABECALHO) REFERENCES CTE_CABECALHO (ID);
ALTER TABLE CTE_PERIGOSO ADD CONSTRAINT fk_{B945A292-6A0E-4DF9-83F2-A595019696D1} FOREIGN KEY (ID_CTE_CABECALHO) REFERENCES CTE_CABECALHO (ID);
ALTER TABLE CTE_VEICULO_NOVO ADD CONSTRAINT fk_{7276AE5B-E77E-49F1-B481-FA55D8680C6D} FOREIGN KEY (ID_CTE_CABECALHO) REFERENCES CTE_CABECALHO (ID);
ALTER TABLE CTE_FATURA ADD CONSTRAINT fk_{6438723E-81DB-4412-ABEC-40020AAE5DF6} FOREIGN KEY (ID_CTE_CABECALHO) REFERENCES CTE_CABECALHO (ID);
ALTER TABLE CTE_DUPLICATA ADD CONSTRAINT fk_{59427324-F43F-494C-B707-2C3544786351} FOREIGN KEY (ID_CTE_CABECALHO) REFERENCES CTE_CABECALHO (ID);
ALTER TABLE CTE_RODOVIARIO ADD CONSTRAINT fk_{F5250044-0CC7-4629-AFFF-D28B8FDA5EA1} FOREIGN KEY (ID_CTE_CABECALHO) REFERENCES CTE_CABECALHO (ID);
ALTER TABLE CTE_RODOVIARIO_OCC ADD CONSTRAINT fk_{DD4F9E16-BFDD-4934-A6A0-AFAD56955E2A} FOREIGN KEY (ID_CTE_RODOVIARIO) REFERENCES CTE_RODOVIARIO (ID);
ALTER TABLE CTE_RODOVIARIO_PEDAGIO ADD CONSTRAINT fk_{1DD17407-7E79-4DC1-B8EC-40D707A49A50} FOREIGN KEY (ID_CTE_RODOVIARIO) REFERENCES CTE_RODOVIARIO (ID);
ALTER TABLE CTE_RODOVIARIO_VEICULO ADD CONSTRAINT fk_{8F53C9C0-2DBD-4833-9A6F-65464DB09C72} FOREIGN KEY (ID_CTE_RODOVIARIO) REFERENCES CTE_RODOVIARIO (ID);
ALTER TABLE CTE_RODOVIARIO_LACRE ADD CONSTRAINT fk_{004EE9FA-6941-4146-834D-227A24BAD2A6} FOREIGN KEY (ID_CTE_RODOVIARIO) REFERENCES CTE_RODOVIARIO (ID);
ALTER TABLE CTE_RODOVIARIO_MOTORISTA ADD CONSTRAINT fk_{C8EBA555-FAA4-4B1E-BBD6-6544E2BC65B6} FOREIGN KEY (ID_CTE_RODOVIARIO) REFERENCES CTE_RODOVIARIO (ID);
ALTER TABLE CTE_AEREO ADD CONSTRAINT fk_{582ED563-2B8F-4348-9777-94FA1657E73D} FOREIGN KEY (ID_CTE_CABECALHO) REFERENCES CTE_CABECALHO (ID);
ALTER TABLE CTE_AQUAVIARIO ADD CONSTRAINT fk_{EDB7A037-01B1-41C0-935C-32998709A4CA} FOREIGN KEY (ID_CTE_CABECALHO) REFERENCES CTE_CABECALHO (ID);
ALTER TABLE CTE_AQUAVIARIO_BALSA ADD CONSTRAINT fk_{C55A2FC7-979F-4114-A228-699EFFDFF750} FOREIGN KEY (ID_CTE_AQUAVIARIO) REFERENCES CTE_AQUAVIARIO (ID);
ALTER TABLE CTE_FERROVIARIO ADD CONSTRAINT fk_{9633509A-D7F9-476B-B37E-8210A6404789} FOREIGN KEY (ID_CTE_CABECALHO) REFERENCES CTE_CABECALHO (ID);
ALTER TABLE CTE_FERROVIARIO_FERROVIA ADD CONSTRAINT fk_{AB21B268-A4C7-48C0-AB57-87A4561FC4F2} FOREIGN KEY (ID_CTE_FERROVIARIO) REFERENCES CTE_FERROVIARIO (ID);
ALTER TABLE CTE_FERROVIARIO_VAGAO ADD CONSTRAINT fk_{3913F060-202C-40F7-8696-5C45BD7ED67A} FOREIGN KEY (ID_CTE_FERROVIARIO) REFERENCES CTE_FERROVIARIO (ID);
ALTER TABLE CTE_DUTOVIARIO ADD CONSTRAINT fk_{9FEE0E93-DDB5-4B3F-ADA6-8301E12F3CD9} FOREIGN KEY (ID_CTE_CABECALHO) REFERENCES CTE_CABECALHO (ID);
ALTER TABLE CTE_MULTIMODAL ADD CONSTRAINT fk_{D4D31624-133A-4E99-9505-EFF8AA9EE66C} FOREIGN KEY (ID_CTE_CABECALHO) REFERENCES CTE_CABECALHO (ID);
ALTER TABLE OPERADORA_CARTAO ADD CONSTRAINT fk_OPERADORA_CARTAO_BANCO_CONTA_CAIXA1 FOREIGN KEY (ID_BANCO_CONTA_CAIXA) REFERENCES BANCO_CONTA_CAIXA (ID);
ALTER TABLE COLABORADOR_RELACIONAMENTO ADD CONSTRAINT fk_{195AEAA0-25CF-41CB-B13F-5AAA18580AC8} FOREIGN KEY (ID_TIPO_RELACIONAMENTO) REFERENCES TIPO_RELACIONAMENTO (ID);
ALTER TABLE COLABORADOR_RELACIONAMENTO ADD CONSTRAINT fk_COLABORADOR_RELACIONAMENTO_COLABORADOR1 FOREIGN KEY (ID_COLABORADOR) REFERENCES COLABORADOR (ID);
ALTER TABLE FORNECEDOR_PRODUTO ADD CONSTRAINT fk_FORNECEDOR_PRODUTO_PRODUTO1 FOREIGN KEY (ID_PRODUTO) REFERENCES PRODUTO (ID);
ALTER TABLE FORNECEDOR_PRODUTO ADD CONSTRAINT fk_FORNECEDOR_PRODUTO_FORNECEDOR1 FOREIGN KEY (ID_FORNECEDOR) REFERENCES FORNECEDOR (ID);
ALTER TABLE PRODUTO_PROMOCAO ADD CONSTRAINT fk_PRODUTO_PROMOCAO_PRODUTO1 FOREIGN KEY (ID_PRODUTO) REFERENCES PRODUTO (ID);
ALTER TABLE PRODUTO_FICHA_TECNICA ADD CONSTRAINT fk_PRODUTO_FICHA_TECNICA_PRODUTO1 FOREIGN KEY (ID_PRODUTO) REFERENCES PRODUTO (ID);
ALTER TABLE PRODUTO_CODIGO_ADICIONAL ADD CONSTRAINT fk_PRODUTO_CODIGO_ADICIONAL_PRODUTO1 FOREIGN KEY (ID_PRODUTO) REFERENCES PRODUTO (ID);
ALTER TABLE IRRF_DETALHE ADD CONSTRAINT fk_{5C43C789-8DD4-40E6-BEDC-2EF8F4646E21} FOREIGN KEY (ID_IRRF) REFERENCES IRRF (ID);
ALTER TABLE INSS_DETALHE ADD CONSTRAINT fk_{460758BF-536F-4B1D-B83C-D7D676CCA7FD} FOREIGN KEY (ID_INSS) REFERENCES INSS (ID);
ALTER TABLE SALARIO_FAMILIA ADD CONSTRAINT fk_{460A3E57-743B-45D3-BC2F-89C6779EB22A} FOREIGN KEY (ID_INSS) REFERENCES INSS (ID);
ALTER TABLE CONTRIB_SIND_PATRONAL_CAB ADD CONSTRAINT fk_{3B251EB4-F260-4A83-8C67-BFCF190AEC38} FOREIGN KEY (ID_SINDICATO) REFERENCES SINDICATO (ID);
ALTER TABLE CONTRIB_SIND_PATRONAL_DET ADD CONSTRAINT fk_{107BD546-819B-41B2-B009-646739BD5837} FOREIGN KEY (ID_CONTRIB_SIND_PATRONAL_CAB) REFERENCES CONTRIB_SIND_PATRONAL_CAB (ID);
ALTER TABLE EMPRESA_TRANSPORTE_ITINERARIO ADD CONSTRAINT fk_{8FE3D483-E7D9-4361-B2E8-464F7D802A73} FOREIGN KEY (ID_EMPRESA_TRANSPORTE) REFERENCES EMPRESA_TRANSPORTE (ID);
ALTER TABLE COD_APURACAO_RECEITA_DACON ADD CONSTRAINT fk_{871BBBAD-37B7-4523-9FF5-7DDC7049997C} FOREIGN KEY (ID_TIPO_RECEITA_DACON) REFERENCES TIPO_RECEITA_DACON (ID);
ALTER TABLE COD_APURACAO_RECEITA_DACON ADD CONSTRAINT fk_{A797B44B-92E2-4EDF-A831-52EE511664F6} FOREIGN KEY (ID_CODIGO_APURACAO_EFD) REFERENCES EFD_TABELA_435 (ID);
ALTER TABLE ORCAMENTO_FLUXO_CAIXA_PERIODO ADD CONSTRAINT fk_ORCAMENTO_FLUXO_CAIXA_PERIODO_BANCO_CONTA_CAIXA1 FOREIGN KEY (ID_BANCO_CONTA_CAIXA) REFERENCES BANCO_CONTA_CAIXA (ID);
ALTER TABLE ORCAMENTO_FLUXO_CAIXA ADD CONSTRAINT fk_{DAE02892-954D-49C1-95AD-159E01E5B882} FOREIGN KEY (ID_ORC_FLUXO_CAIXA_PERIODO) REFERENCES ORCAMENTO_FLUXO_CAIXA_PERIODO (ID);
ALTER TABLE ORCAMENTO_FLUXO_CAIXA_DETALHE ADD CONSTRAINT fk_{7DA41A8E-71FF-4158-A2F6-284EFD0C66C0} FOREIGN KEY (ID_ORCAMENTO_FLUXO_CAIXA) REFERENCES ORCAMENTO_FLUXO_CAIXA (ID);
ALTER TABLE ORCAMENTO_FLUXO_CAIXA_DETALHE ADD CONSTRAINT fk_ORCAMENTO_FLUXO_CAIXA_DETALHE_FIN_NATUREZA_FINANCEIRA1 FOREIGN KEY (ID_FIN_NATUREZA_FINANCEIRA) REFERENCES FIN_NATUREZA_FINANCEIRA (ID);
ALTER TABLE CONTABIL_CONTA ADD CONSTRAINT fk_{B91BDB7E-3C89-47F2-B87F-EF076C65C6F9} FOREIGN KEY (ID_PLANO_CONTA_REF_SPED) REFERENCES PLANO_CONTA_REF_SPED (ID);
ALTER TABLE CONTABIL_CONTA ADD CONSTRAINT fk_{1A1B29A3-97FA-4561-BCC1-98667B3C27B1} FOREIGN KEY (ID_CONTABIL_CONTA) REFERENCES CONTABIL_CONTA (ID);
ALTER TABLE CONTABIL_CONTA ADD CONSTRAINT fk_{115D906C-AFF4-472A-B675-4F4FF01593D7} FOREIGN KEY (ID_PLANO_CONTA) REFERENCES PLANO_CONTA (ID);
ALTER TABLE CONTABIL_LANCAMENTO_CABECALHO ADD CONSTRAINT fk_{792712E2-E225-495D-A777-E44DE2565BE7} FOREIGN KEY (ID_CONTABIL_LOTE) REFERENCES CONTABIL_LOTE (ID);
ALTER TABLE CONTABIL_LANCAMENTO_DETALHE ADD CONSTRAINT fk_{91277FE7-0BBC-47D5-AF99-7477DA2CDE13} FOREIGN KEY (ID_CONTABIL_LANCAMENTO_CAB) REFERENCES CONTABIL_LANCAMENTO_CABECALHO (ID);
ALTER TABLE CONTABIL_LANCAMENTO_DETALHE ADD CONSTRAINT fk_{105193A2-FC4D-4B16-A6AD-6C6C337D8FF7} FOREIGN KEY (ID_CONTABIL_HISTORICO) REFERENCES CONTABIL_HISTORICO (ID);
ALTER TABLE CONTABIL_LANCAMENTO_DETALHE ADD CONSTRAINT fk_{E1CB8197-3D7D-44A6-82F6-C882BA9FAA40} FOREIGN KEY (ID_CONTABIL_CONTA) REFERENCES CONTABIL_CONTA (ID);
ALTER TABLE CONTABIL_LANCAMENTO_ORCADO ADD CONSTRAINT fk_{9821838A-9514-48E9-8385-17A587D1A2C1} FOREIGN KEY (ID_CONTABIL_CONTA) REFERENCES CONTABIL_CONTA (ID);
ALTER TABLE CONTABIL_DRE_DETALHE ADD CONSTRAINT fk_{6DDCBE08-695E-44C5-8412-EBA846C11BDB} FOREIGN KEY (ID_CONTABIL_DRE_CABECALHO) REFERENCES CONTABIL_DRE_CABECALHO (ID);
ALTER TABLE CONTABIL_TERMO ADD CONSTRAINT fk_{90B322A0-2DA8-4EF0-9D6A-4D8467F07F59} FOREIGN KEY (ID_CONTABIL_LIVRO) REFERENCES CONTABIL_LIVRO (ID);
ALTER TABLE CONTABIL_ENCERRAMENTO_EXE_DET ADD CONSTRAINT fk_{E3F23D1A-CCDC-467F-A8F2-9E0A03FD6C63} FOREIGN KEY (ID_CONTABIL_ENCERRAMENTO_EXE) REFERENCES CONTABIL_ENCERRAMENTO_EXE_CAB (ID);
ALTER TABLE CONTABIL_ENCERRAMENTO_EXE_DET ADD CONSTRAINT fk_{74FD9080-F3C3-4C60-A10D-D7A2F34EBE60} FOREIGN KEY (ID_CONTABIL_CONTA) REFERENCES CONTABIL_CONTA (ID);
ALTER TABLE LANCA_CENTRO_RESULTADO ADD CONSTRAINT fk_{F9581400-B548-4933-B0AE-9DA6EE5FB941} FOREIGN KEY (ID_CENTRO_RESULTADO) REFERENCES CENTRO_RESULTADO (ID);
ALTER TABLE CENTRO_RESULTADO ADD CONSTRAINT fk_{A188D698-8145-4182-9A82-AFD03C7BCD15} FOREIGN KEY (ID_PLANO_CENTRO_RESULTADO) REFERENCES PLANO_CENTRO_RESULTADO (ID);
ALTER TABLE RATEIO_CENTRO_RESULTADO_CAB ADD CONSTRAINT fk_{5030A2EA-FFE1-4F33-8380-AE8B4D236121} FOREIGN KEY (ID_CENTRO_RESULTADO) REFERENCES CENTRO_RESULTADO (ID);
ALTER TABLE RATEIO_CENTRO_RESULTADO_DET ADD CONSTRAINT fk_{B3EC49D9-B1D3-47BB-B51B-FF23F144819C} FOREIGN KEY (ID_RATEIO_CENTRO_RESUL_CAB) REFERENCES RATEIO_CENTRO_RESULTADO_CAB (ID);
ALTER TABLE RATEIO_CENTRO_RESULTADO_DET ADD CONSTRAINT fk_{9AC87DD8-9BFC-4D4C-B4B9-6B39B2A16C49} FOREIGN KEY (ID_CENTRO_RESULTADO_DESTINO) REFERENCES CENTRO_RESULTADO (ID);
ALTER TABLE ENCERRA_CENTRO_RESULTADO ADD CONSTRAINT fk_{CA4C3C76-2109-472E-A979-8CA8A104070C} FOREIGN KEY (ID_CENTRO_RESULTADO) REFERENCES CENTRO_RESULTADO (ID);
ALTER TABLE FOLHA_LANCAMENTO_COMISSAO ADD CONSTRAINT fk_FOLHA_LANCAMENTO_COMISSAO_VENDEDOR1 FOREIGN KEY (ID_VENDEDOR) REFERENCES VENDEDOR (ID);
ALTER TABLE CONTABIL_CONTA_RATEIO ADD CONSTRAINT fk_{846C5684-4DCA-4EF2-8210-D5E1A11E71FE} FOREIGN KEY (ID_CONTABIL_CONTA) REFERENCES CONTABIL_CONTA (ID);
ALTER TABLE CONTABIL_CONTA_RATEIO ADD CONSTRAINT fk_{21B68C00-3BFB-469C-AAA0-AD350248A949} FOREIGN KEY (ID_CENTRO_RESULTADO) REFERENCES CENTRO_RESULTADO (ID);
ALTER TABLE EMPRESA_CNAE ADD CONSTRAINT fk_EMPRESA_CNAE_EMPRESA1 FOREIGN KEY (ID_EMPRESA) REFERENCES EMPRESA (ID);
ALTER TABLE EMPRESA_CNAE ADD CONSTRAINT fk_EMPRESA_CNAE_CNAE1 FOREIGN KEY (ID_CNAE) REFERENCES CNAE (ID);
ALTER TABLE INVENTARIO_CONTAGEM_DET ADD CONSTRAINT fk_{0FF2B94B-9A4B-47D1-A536-25332FAF4CFA} FOREIGN KEY (ID_INVENTARIO_CONTAGEM_CAB) REFERENCES INVENTARIO_CONTAGEM_CAB (ID);
ALTER TABLE INVENTARIO_CONTAGEM_DET ADD CONSTRAINT fk_INVENTARIO_CONTAGEM_DET_PRODUTO1 FOREIGN KEY (ID_PRODUTO) REFERENCES PRODUTO (ID);
ALTER TABLE ORCAMENTO_EMPRESARIAL ADD CONSTRAINT fk_{34B87EE9-0908-4947-9A62-962274B9E2E6} FOREIGN KEY (ID_ORCAMENTO_PERIODO) REFERENCES ORCAMENTO_PERIODO (ID);
ALTER TABLE ORCAMENTO_DETALHE ADD CONSTRAINT fk_{579ED741-CDCD-4302-923C-704283061EFB} FOREIGN KEY (ID_ORCAMENTO_EMPRESARIAL) REFERENCES ORCAMENTO_EMPRESARIAL (ID);
ALTER TABLE ORCAMENTO_DETALHE ADD CONSTRAINT fk_ORCAMENTO_DETALHE_FIN_NATUREZA_FINANCEIRA1 FOREIGN KEY (ID_FIN_NATUREZA_FINANCEIRA) REFERENCES FIN_NATUREZA_FINANCEIRA (ID);
ALTER TABLE PATRIM_BEM ADD CONSTRAINT fk_{6763D73F-CAD3-45F5-B326-F15F787593C8} FOREIGN KEY (ID_PATRIM_GRUPO_BEM) REFERENCES PATRIM_GRUPO_BEM (ID);
ALTER TABLE PATRIM_BEM ADD CONSTRAINT fk_{308BF881-15EC-4EDB-A8D9-031C5760DD18} FOREIGN KEY (ID_PATRIM_TIPO_AQUISICAO_BEM) REFERENCES PATRIM_TIPO_AQUISICAO_BEM (ID);
ALTER TABLE PATRIM_BEM ADD CONSTRAINT fk_{5E078F04-ADF7-48EE-A482-6E2B657F63C7} FOREIGN KEY (ID_PATRIM_ESTADO_CONSERVACAO) REFERENCES PATRIM_ESTADO_CONSERVACAO (ID);
ALTER TABLE PATRIM_BEM ADD CONSTRAINT fk_{791E6013-2F02-480A-B5B6-5DD83DBE5125} FOREIGN KEY (ID_CENTRO_RESULTADO) REFERENCES CENTRO_RESULTADO (ID);
ALTER TABLE PATRIM_BEM ADD CONSTRAINT fk_PATRIM_BEM_FORNECEDOR1 FOREIGN KEY (ID_FORNECEDOR) REFERENCES FORNECEDOR (ID);
ALTER TABLE PATRIM_BEM ADD CONSTRAINT fk_PATRIM_BEM_COLABORADOR1 FOREIGN KEY (ID_COLABORADOR) REFERENCES COLABORADOR (ID);
ALTER TABLE PATRIM_BEM ADD CONSTRAINT fk_PATRIM_BEM_SETOR1 FOREIGN KEY (ID_SETOR) REFERENCES SETOR (ID);
ALTER TABLE PATRIM_DOCUMENTO_BEM ADD CONSTRAINT fk_{7A0C1480-E244-4328-B2CB-2AB8A169B89F} FOREIGN KEY (ID_PATRIM_BEM) REFERENCES PATRIM_BEM (ID);
ALTER TABLE PATRIM_DEPRECIACAO_BEM ADD CONSTRAINT fk_{3702F0F7-CF21-41C8-AAAB-A7D9A723936E} FOREIGN KEY (ID_PATRIM_BEM) REFERENCES PATRIM_BEM (ID);
ALTER TABLE PATRIM_MOVIMENTACAO_BEM ADD CONSTRAINT fk_{59673D06-99DA-4BF3-95DC-3A4AB382D4D1} FOREIGN KEY (ID_PATRIM_TIPO_MOVIMENTACAO) REFERENCES PATRIM_TIPO_MOVIMENTACAO (ID);
ALTER TABLE PATRIM_MOVIMENTACAO_BEM ADD CONSTRAINT fk_{AD129E44-F68B-4EA3-9952-207A4E51D786} FOREIGN KEY (ID_PATRIM_BEM) REFERENCES PATRIM_BEM (ID);
ALTER TABLE PATRIM_APOLICE_SEGURO ADD CONSTRAINT fk_{51FF0562-515B-417C-894C-C79DDBFCDFE3} FOREIGN KEY (ID_SEGURADORA) REFERENCES SEGURADORA (ID);
ALTER TABLE PATRIM_APOLICE_SEGURO ADD CONSTRAINT fk_{1072F0B3-8A3C-4836-9F4D-77CCAEDC3279} FOREIGN KEY (ID_PATRIM_BEM) REFERENCES PATRIM_BEM (ID);
ALTER TABLE FISCAL_PARAMETRO ADD CONSTRAINT fk_{98296489-0EE6-403B-9EAF-D990246B28D1} FOREIGN KEY (ID_FISCAL_MUNICIPAL_REGIME) REFERENCES FISCAL_MUNICIPAL_REGIME (ID);
ALTER TABLE FISCAL_PARAMETRO ADD CONSTRAINT fk_{3A841007-27D6-43C3-A356-56427E03924F} FOREIGN KEY (ID_FISCAL_ESTADUAL_REGIME) REFERENCES FISCAL_ESTADUAL_REGIME (ID);
ALTER TABLE FISCAL_PARAMETRO ADD CONSTRAINT fk_{D9548E2C-5E6B-4C6C-88C1-2CD968DA496C} FOREIGN KEY (ID_FISCAL_ESTADUAL_PORTE) REFERENCES FISCAL_ESTADUAL_PORTE (ID);
ALTER TABLE FISCAL_TERMO ADD CONSTRAINT fk_{A4F4C576-8F6F-4FF9-9BD1-DE2E881A7252} FOREIGN KEY (ID_FISCAL_LIVRO) REFERENCES FISCAL_LIVRO (ID);
ALTER TABLE FISCAL_INSCRICOES_SUBSTITUTAS ADD CONSTRAINT fk_{8B1F8BD0-2A38-4B9B-91EF-E8D9FBA98567} FOREIGN KEY (ID_FISCAL_PARAMETROS) REFERENCES FISCAL_PARAMETRO (ID);
ALTER TABLE SIMPLES_NACIONAL_DETALHE ADD CONSTRAINT fk_{6638A7A1-0BA3-4D46-A720-BE1BBC8966A0} FOREIGN KEY (ID_SIMPLES_NACIONAL_CABECALHO) REFERENCES SIMPLES_NACIONAL_CABECALHO (ID);
ALTER TABLE FISCAL_NOTA_FISCAL_ENTRADA ADD CONSTRAINT fk_FISCAL_NOTA_FISCAL_ENTRADA_NFE_CABECALHO1 FOREIGN KEY (ID_NFE_CABECALHO) REFERENCES NFE_CABECALHO (ID);
ALTER TABLE FERIAS_PERIODO_AQUISITIVO ADD CONSTRAINT fk_FERIAS_PERIODO_AQUISITIVO_COLABORADOR1 FOREIGN KEY (ID_COLABORADOR) REFERENCES COLABORADOR (ID);
ALTER TABLE FOLHA_AFASTAMENTO ADD CONSTRAINT fk_{26D6C2DC-E017-4773-81D1-87F4CA4DB521} FOREIGN KEY (ID_FOLHA_TIPO_AFASTAMENTO) REFERENCES FOLHA_TIPO_AFASTAMENTO (ID);
ALTER TABLE FOLHA_AFASTAMENTO ADD CONSTRAINT fk_FOLHA_AFASTAMENTO_COLABORADOR1 FOREIGN KEY (ID_COLABORADOR) REFERENCES COLABORADOR (ID);
ALTER TABLE FOLHA_PLANO_SAUDE ADD CONSTRAINT fk_FOLHA_PLANO_SAUDE_COLABORADOR1 FOREIGN KEY (ID_COLABORADOR) REFERENCES COLABORADOR (ID);
ALTER TABLE FOLHA_PLANO_SAUDE ADD CONSTRAINT fk_FOLHA_PLANO_SAUDE_OPERADORA_PLANO_SAUDE1 FOREIGN KEY (ID_OPERADORA_PLANO_SAUDE) REFERENCES OPERADORA_PLANO_SAUDE (ID);
ALTER TABLE FOLHA_RESCISAO ADD CONSTRAINT fk_FOLHA_RESCISAO_COLABORADOR1 FOREIGN KEY (ID_COLABORADOR) REFERENCES COLABORADOR (ID);
ALTER TABLE FOLHA_LANCAMENTO_CABECALHO ADD CONSTRAINT fk_FOLHA_LANCAMENTO_CABECALHO_COLABORADOR1 FOREIGN KEY (ID_COLABORADOR) REFERENCES COLABORADOR (ID);
ALTER TABLE FOLHA_LANCAMENTO_DETALHE ADD CONSTRAINT fk_{69A27780-AD58-4027-A361-69821375B7E3} FOREIGN KEY (ID_FOLHA_LANCAMENTO_CABECALHO) REFERENCES FOLHA_LANCAMENTO_CABECALHO (ID);
ALTER TABLE FOLHA_LANCAMENTO_DETALHE ADD CONSTRAINT fk_{A20D00A9-82D2-4C0A-8319-25FB9531AA16} FOREIGN KEY (ID_FOLHA_EVENTO) REFERENCES FOLHA_EVENTO (ID);
ALTER TABLE FOLHA_VALE_TRANSPORTE ADD CONSTRAINT fk_{DFEFE399-D353-4963-A41E-26A38DB31853} FOREIGN KEY (ID_EMPRESA_TRANSP_ITIN) REFERENCES EMPRESA_TRANSPORTE_ITINERARIO (ID);
ALTER TABLE FOLHA_VALE_TRANSPORTE ADD CONSTRAINT fk_FOLHA_VALE_TRANSPORTE_COLABORADOR1 FOREIGN KEY (ID_COLABORADOR) REFERENCES COLABORADOR (ID);
ALTER TABLE FOLHA_INSS_RETENCAO ADD CONSTRAINT fk_{2D85FCF0-30DF-40F9-8182-DCA007E88A1D} FOREIGN KEY (ID_FOLHA_INSS_SERVICO) REFERENCES FOLHA_INSS_SERVICO (ID);
ALTER TABLE FOLHA_INSS_RETENCAO ADD CONSTRAINT fk_{5265F7ED-9310-4991-A56C-C0541E246DCE} FOREIGN KEY (ID_FOLHA_INSS) REFERENCES FOLHA_INSS (ID);
ALTER TABLE FOLHA_PPP ADD CONSTRAINT fk_FOLHA_PPP_COLABORADOR1 FOREIGN KEY (ID_COLABORADOR) REFERENCES COLABORADOR (ID);
ALTER TABLE FOLHA_PPP_CAT ADD CONSTRAINT fk_{8C91D200-46D5-4C33-A1EB-74F1C11AC8B5} FOREIGN KEY (ID_FOLHA_PPP) REFERENCES FOLHA_PPP (ID);
ALTER TABLE FOLHA_PPP_ATIVIDADE ADD CONSTRAINT fk_{F750F228-A23B-4262-A967-E271B442CAF0} FOREIGN KEY (ID_FOLHA_PPP) REFERENCES FOLHA_PPP (ID);
ALTER TABLE FOLHA_PPP_FATOR_RISCO ADD CONSTRAINT fk_{0FFE40C7-1419-4FFD-9298-1D1468DAA9F2} FOREIGN KEY (ID_FOLHA_PPP) REFERENCES FOLHA_PPP (ID);
ALTER TABLE FOLHA_PPP_EXAME_MEDICO ADD CONSTRAINT fk_{1521EFA1-7447-4A6C-AC0C-853B15624864} FOREIGN KEY (ID_FOLHA_PPP) REFERENCES FOLHA_PPP (ID);
ALTER TABLE FOLHA_HISTORICO_SALARIAL ADD CONSTRAINT fk_FOLHA_HISTORICO_SALARIAL_COLABORADOR1 FOREIGN KEY (ID_COLABORADOR) REFERENCES COLABORADOR (ID);
ALTER TABLE CONTRATO ADD CONSTRAINT fk_{361E6865-AACA-4AAE-835D-69951506B97C} FOREIGN KEY (ID_TIPO_CONTRATO) REFERENCES TIPO_CONTRATO (ID);
ALTER TABLE CONTRATO ADD CONSTRAINT fk_{26AD0339-9A7F-44D5-A937-974AF985C5C6} FOREIGN KEY (ID_SOLICITACAO_SERVICO) REFERENCES CONTRATO_SOLICITACAO_SERVICO (ID);
ALTER TABLE CONTRATO_SOLICITACAO_SERVICO ADD CONSTRAINT fk_{11550058-0569-4D22-9D52-79ECED1CB6F4} FOREIGN KEY (ID_CONTRATO_TIPO_SERVICO) REFERENCES CONTRATO_TIPO_SERVICO (ID);
ALTER TABLE CONTRATO_SOLICITACAO_SERVICO ADD CONSTRAINT fk_CONTRATO_SOLICITACAO_SERVICO_SETOR1 FOREIGN KEY (ID_SETOR) REFERENCES SETOR (ID);
ALTER TABLE CONTRATO_SOLICITACAO_SERVICO ADD CONSTRAINT fk_CONTRATO_SOLICITACAO_SERVICO_COLABORADOR1 FOREIGN KEY (ID_COLABORADOR) REFERENCES COLABORADOR (ID);
ALTER TABLE CONTRATO_SOLICITACAO_SERVICO ADD CONSTRAINT fk_CONTRATO_SOLICITACAO_SERVICO_CLIENTE1 FOREIGN KEY (ID_CLIENTE) REFERENCES CLIENTE (ID);
ALTER TABLE CONTRATO_SOLICITACAO_SERVICO ADD CONSTRAINT fk_CONTRATO_SOLICITACAO_SERVICO_FORNECEDOR1 FOREIGN KEY (ID_FORNECEDOR) REFERENCES FORNECEDOR (ID);
ALTER TABLE CONTRATO_HISTORICO_REAJUSTE ADD CONSTRAINT fk_{5930B5F3-8D84-48F3-ADE0-546A1D58EF8A} FOREIGN KEY (ID_CONTRATO) REFERENCES CONTRATO (ID);
ALTER TABLE CONTRATO_PREV_FATURAMENTO ADD CONSTRAINT fk_{08124560-2F8F-419E-911B-8193C17AC936} FOREIGN KEY (ID_CONTRATO) REFERENCES CONTRATO (ID);
ALTER TABLE CONTRATO_HIST_FATURAMENTO ADD CONSTRAINT fk_{04A46B13-CDC1-42A8-A029-987FD4C07CC3} FOREIGN KEY (ID_CONTRATO) REFERENCES CONTRATO (ID);
ALTER TABLE PONTO_TURMA ADD CONSTRAINT fk_{24DAD7DC-0965-4EDF-8059-E958A0821AA1} FOREIGN KEY (ID_PONTO_ESCALA) REFERENCES PONTO_ESCALA (ID);
ALTER TABLE PONTO_MARCACAO ADD CONSTRAINT fk_{41E0724D-FD60-49CE-B95C-119CDB59790C} FOREIGN KEY (ID_PONTO_RELOGIO) REFERENCES PONTO_RELOGIO (ID);
ALTER TABLE PONTO_MARCACAO ADD CONSTRAINT fk_PONTO_MARCACAO_COLABORADOR1 FOREIGN KEY (ID_COLABORADOR) REFERENCES COLABORADOR (ID);
ALTER TABLE PONTO_BANCO_HORAS ADD CONSTRAINT fk_PONTO_BANCO_HORAS_COLABORADOR1 FOREIGN KEY (ID_COLABORADOR) REFERENCES COLABORADOR (ID);
ALTER TABLE PONTO_HORARIO_AUTORIZADO ADD CONSTRAINT fk_PONTO_HORARIO_AUTORIZADO_COLABORADOR1 FOREIGN KEY (ID_COLABORADOR) REFERENCES COLABORADOR (ID);
ALTER TABLE PONTO_ABONO ADD CONSTRAINT fk_PONTO_ABONO_COLABORADOR1 FOREIGN KEY (ID_COLABORADOR) REFERENCES COLABORADOR (ID);
ALTER TABLE PONTO_ABONO_UTILIZACAO ADD CONSTRAINT fk_{5E373E19-7D30-4782-BBBC-5C35C10CB2D9} FOREIGN KEY (ID_PONTO_ABONO) REFERENCES PONTO_ABONO (ID);
ALTER TABLE DAV_CABECALHO ADD CONSTRAINT fk_DAV_CABECALHO_PESSOA1 FOREIGN KEY (ID_PESSOA) REFERENCES PESSOA (ID);
ALTER TABLE DAV_DETALHE ADD CONSTRAINT fk_{01AF191E-A00C-44B1-95BE-FCA329907DA1} FOREIGN KEY (ID_DAV_CABECALHO) REFERENCES DAV_CABECALHO (ID);
ALTER TABLE DAV_DETALHE ADD CONSTRAINT fk_DAV_DETALHE_PRODUTO1 FOREIGN KEY (ID_PRODUTO) REFERENCES PRODUTO (ID);
ALTER TABLE PRE_VENDA_CABECALHO ADD CONSTRAINT fk_PRE_VENDA_CABECALHO_PESSOA1 FOREIGN KEY (ID_PESSOA) REFERENCES PESSOA (ID);
ALTER TABLE PRE_VENDA_DETALHE ADD CONSTRAINT fk_{B35253D2-3EE9-435C-8911-6FAA488C3BAF} FOREIGN KEY (ID_PRE_VENDA_CABECALHO) REFERENCES PRE_VENDA_CABECALHO (ID);
ALTER TABLE PRE_VENDA_DETALHE ADD CONSTRAINT fk_PRE_VENDA_DETALHE_PRODUTO1 FOREIGN KEY (ID_PRODUTO) REFERENCES PRODUTO (ID);
ALTER TABLE CONTABIL_INDICE_VALOR ADD CONSTRAINT fk_{7B3E8135-BFC8-4495-AD53-62286EAAC690} FOREIGN KEY (ID_CONTABIL_INDICE) REFERENCES CONTABIL_INDICE (ID);
ALTER TABLE PONTO_BANCO_HORAS_UTILIZACAO ADD CONSTRAINT fk_{95E38BE7-8889-4039-A9EF-9B3F06C021C1} FOREIGN KEY (ID_PONTO_BANCO_HORAS) REFERENCES PONTO_BANCO_HORAS (ID);
ALTER TABLE PONTO_FECHAMENTO_JORNADA ADD CONSTRAINT fk_{46D94076-83BD-47CF-81A8-CFB7358E7852} FOREIGN KEY (ID_PONTO_CLASSIFICACAO_JORNADA) REFERENCES PONTO_CLASSIFICACAO_JORNADA (ID);
ALTER TABLE PONTO_FECHAMENTO_JORNADA ADD CONSTRAINT fk_PONTO_FECHAMENTO_JORNADA_COLABORADOR1 FOREIGN KEY (ID_COLABORADOR) REFERENCES COLABORADOR (ID);
ALTER TABLE CT_RESULTADO_NT_FINANCEIRA ADD CONSTRAINT fk_{858FCE59-EBDE-45C6-BA90-BE4EE82F5897} FOREIGN KEY (ID_CENTRO_RESULTADO) REFERENCES CENTRO_RESULTADO (ID);
ALTER TABLE CT_RESULTADO_NT_FINANCEIRA ADD CONSTRAINT fk_CT_RESULTADO_NT_FINANCEIRA_FIN_NATUREZA_FINANCEIRA1 FOREIGN KEY (ID_FIN_NATUREZA_FINANCEIRA) REFERENCES FIN_NATUREZA_FINANCEIRA (ID);
ALTER TABLE PRODUTO_ALTERACAO_ITEM ADD CONSTRAINT fk_PRODUTO_ALTERACAO_ITEM_PRODUTO1 FOREIGN KEY (ID_PRODUTO) REFERENCES PRODUTO (ID);
ALTER TABLE FISCAL_NOTA_FISCAL_SAIDA ADD CONSTRAINT fk_FISCAL_NOTA_FISCAL_SAIDA_NFE_CABECALHO1 FOREIGN KEY (ID_NFE_CABECALHO) REFERENCES NFE_CABECALHO (ID);
ALTER TABLE PESSOA_ALTERACAO ADD CONSTRAINT fk_PESSOA_ALTERACAO_PESSOA1 FOREIGN KEY (ID_PESSOA) REFERENCES PESSOA (ID);
ALTER TABLE DAV_DETALHE_ALTERACAO ADD CONSTRAINT fk_{38EB7611-F536-4209-BEFD-EE739D12E364} FOREIGN KEY (ID_DAV_DETALHE) REFERENCES DAV_DETALHE (ID);
ALTER TABLE MALOTE_DIGITAL_DOCUMENTO ADD CONSTRAINT fk_MALOTE_DIGITAL_DOCUMENTO_COLABORADOR1 FOREIGN KEY (ID_COLABORADOR) REFERENCES COLABORADOR (ID);
ALTER TABLE MALOTE_DIGITAL_DESTINATARIO ADD CONSTRAINT fk_{F02D780C-73D7-42A1-B054-410048C997D8} FOREIGN KEY (ID_MALOTE_DIGITAL_DOCUMENTO) REFERENCES MALOTE_DIGITAL_DOCUMENTO (ID);
ALTER TABLE MALOTE_DIGITAL_DESTINATARIO ADD CONSTRAINT fk_MALOTE_DIGITAL_DESTINATARIO_COLABORADOR1 FOREIGN KEY (ID_COLABORADOR) REFERENCES COLABORADOR (ID);
ALTER TABLE MALOTE_DIGITAL_ACESSO ADD CONSTRAINT fk_{040820C8-9AB6-47E2-8A77-B292404C61D4} FOREIGN KEY (ID_MALOTE_DIGITAL_DESTINATARIO) REFERENCES MALOTE_DIGITAL_DESTINATARIO (ID);
ALTER TABLE ETIQUETA_LAYOUT ADD CONSTRAINT fk_{870DB90A-1372-4E58-B205-C25BB2C7365F} FOREIGN KEY (ID_FORMATO_PAPEL) REFERENCES ETIQUETA_FORMATO_PAPEL (ID);
ALTER TABLE ETIQUETA_TEMPLATE ADD CONSTRAINT fk_{433B10D1-3F6E-494B-AD5E-DBF791DFA501} FOREIGN KEY (ID_ETIQUETA_LAYOUT) REFERENCES ETIQUETA_LAYOUT (ID);
ALTER TABLE AGENDA_COMPROMISSO ADD CONSTRAINT fk_{FC824681-33D0-4247-BFDF-526A153CD722} FOREIGN KEY (ID_AGENDA_CATEGORIA_COMPROMISSO) REFERENCES AGENDA_CATEGORIA_COMPROMISSO (ID);
ALTER TABLE AGENDA_COMPROMISSO ADD CONSTRAINT fk_AGENDA_COMPROMISSO_COLABORADOR1 FOREIGN KEY (ID_COLABORADOR) REFERENCES COLABORADOR (ID);
ALTER TABLE AGENDA_NOTIFICACAO ADD CONSTRAINT fk_{399131FD-404B-48BF-AF89-C823DD44767F} FOREIGN KEY (ID_AGENDA_COMPROMISSO) REFERENCES AGENDA_COMPROMISSO (ID);
ALTER TABLE AGENDA_COMPROMISSO_CONVIDADO ADD CONSTRAINT fk_{4E85396E-52A3-46E0-86BA-E662BE304E59} FOREIGN KEY (ID_AGENDA_COMPROMISSO) REFERENCES AGENDA_COMPROMISSO (ID);
ALTER TABLE AGENDA_COMPROMISSO_CONVIDADO ADD CONSTRAINT fk_AGENDA_COMPROMISSO_CONVIDADO_COLABORADOR1 FOREIGN KEY (ID_COLABORADOR) REFERENCES COLABORADOR (ID);
ALTER TABLE REUNIAO_SALA_EVENTO ADD CONSTRAINT fk_{166E3AAB-2DB5-44FC-BCDE-62D0E052AD18} FOREIGN KEY (ID_REUNIAO_SALA) REFERENCES REUNIAO_SALA (ID);
ALTER TABLE REUNIAO_SALA_EVENTO ADD CONSTRAINT fk_{C71E2EDC-9C69-4A00-ABBD-5127B0E9FBA0} FOREIGN KEY (ID_AGENDA_COMPROMISSO) REFERENCES AGENDA_COMPROMISSO (ID);
ALTER TABLE RECADO_REMETENTE ADD CONSTRAINT fk_RECADO_REMETENTE_COLABORADOR1 FOREIGN KEY (ID_COLABORADOR) REFERENCES COLABORADOR (ID);
ALTER TABLE RECADO_DESTINATARIO ADD CONSTRAINT fk_{0E54BF34-67CE-451E-B4A0-778D89F84D5F} FOREIGN KEY (ID_RECADO_REMETENTE) REFERENCES RECADO_REMETENTE (ID);
ALTER TABLE RECADO_DESTINATARIO ADD CONSTRAINT fk_RECADO_DESTINATARIO_COLABORADOR1 FOREIGN KEY (ID_COLABORADOR) REFERENCES COLABORADOR (ID);
ALTER TABLE PCP_OP_DETALHE ADD CONSTRAINT fk_{38BB45EA-9D0E-47DD-A72F-3FA45738D406} FOREIGN KEY (ID_PCP_OP_CABECALHO) REFERENCES PCP_OP_CABECALHO (ID);
ALTER TABLE PCP_OP_DETALHE ADD CONSTRAINT fk_PCP_OP_DETALHE_PRODUTO1 FOREIGN KEY (ID_PRODUTO) REFERENCES PRODUTO (ID);
ALTER TABLE PCP_SERVICO ADD CONSTRAINT fk_{8826F024-B03D-4D57-8619-410C8743C47B} FOREIGN KEY (ID_PCP_OP_DETALHE) REFERENCES PCP_OP_DETALHE (ID);
ALTER TABLE PCP_SERVICO_COLABORADOR ADD CONSTRAINT fk_{664764E5-3488-4030-BFB1-15E4D34A5446} FOREIGN KEY (ID_PCP_SERVICO) REFERENCES PCP_SERVICO (ID);
ALTER TABLE PCP_SERVICO_COLABORADOR ADD CONSTRAINT fk_PCP_SERVICO_COLABORADOR_COLABORADOR1 FOREIGN KEY (ID_COLABORADOR) REFERENCES COLABORADOR (ID);
ALTER TABLE PCP_INSTRUCAO_OP ADD CONSTRAINT fk_{7C1E7E45-BEB5-4DE3-AD45-217B1C481440} FOREIGN KEY (ID_PCP_OP_CABECALHO) REFERENCES PCP_OP_CABECALHO (ID);
ALTER TABLE PCP_INSTRUCAO_OP ADD CONSTRAINT fk_{1711BD28-6B33-449F-8C2F-E6CDBFCEF130} FOREIGN KEY (ID_PCP_INSTRUCAO) REFERENCES PCP_INSTRUCAO (ID);
ALTER TABLE PCP_SERVICO_EQUIPAMENTO ADD CONSTRAINT fk_{6D48A2C9-2A21-4A7A-B1A5-4882369D9E49} FOREIGN KEY (ID_PCP_SERVICO) REFERENCES PCP_SERVICO (ID);
ALTER TABLE PCP_SERVICO_EQUIPAMENTO ADD CONSTRAINT fk_{34E8FAB1-88F5-4369-A7E0-0EDFD616F5EB} FOREIGN KEY (ID_PATRIM_BEM) REFERENCES PATRIM_BEM (ID);
ALTER TABLE WMS_RECEBIMENTO_CABECALHO ADD CONSTRAINT fk_{8B28EFA0-D32C-4AAC-B55C-219A5F910E4B} FOREIGN KEY (ID_WMS_AGENDAMENTO) REFERENCES WMS_AGENDAMENTO (ID);
ALTER TABLE WMS_RECEBIMENTO_DETALHE ADD CONSTRAINT fk_{25A6AC1D-7A1E-4F97-AAC7-246CC689D258} FOREIGN KEY (ID_WMS_RECEBIMENTO_CABECALHO) REFERENCES WMS_RECEBIMENTO_CABECALHO (ID);
ALTER TABLE WMS_RECEBIMENTO_DETALHE ADD CONSTRAINT fk_WMS_RECEBIMENTO_DETALHE_PRODUTO1 FOREIGN KEY (ID_PRODUTO) REFERENCES PRODUTO (ID);
ALTER TABLE WMS_ESTANTE ADD CONSTRAINT fk_{54ED3A4A-0685-4EAD-A483-FB2085C30584} FOREIGN KEY (ID_WMS_RUA) REFERENCES WMS_RUA (ID);
ALTER TABLE WMS_CAIXA ADD CONSTRAINT fk_{1716794B-B0D8-4C32-B29A-8322E86A49F3} FOREIGN KEY (ID_WMS_ESTANTE) REFERENCES WMS_ESTANTE (ID);
ALTER TABLE WMS_ARMAZENAMENTO ADD CONSTRAINT fk_{734FF4E6-A808-433A-AB15-84F96C5547EA} FOREIGN KEY (ID_WMS_CAIXA) REFERENCES WMS_CAIXA (ID);
ALTER TABLE WMS_ARMAZENAMENTO ADD CONSTRAINT fk_{7BE115CD-47DC-43BC-B71A-9767FBCC9E9D} FOREIGN KEY (ID_WMS_RECEBIMENTO_DETALHE) REFERENCES WMS_RECEBIMENTO_DETALHE (ID);
ALTER TABLE WMS_ORDEM_SEPARACAO_DET ADD CONSTRAINT fk_{9A2509D6-849E-4636-8BD3-A38F16B050B0} FOREIGN KEY (ID_WMS_ORDEM_SEPARACAO_CAB) REFERENCES WMS_ORDEM_SEPARACAO_CAB (ID);
ALTER TABLE WMS_ORDEM_SEPARACAO_DET ADD CONSTRAINT fk_WMS_ORDEM_SEPARACAO_DET_PRODUTO1 FOREIGN KEY (ID_PRODUTO) REFERENCES PRODUTO (ID);
ALTER TABLE WMS_EXPEDICAO ADD CONSTRAINT fk_{2ADE2A79-7150-4915-83A1-9D60624AE78A} FOREIGN KEY (ID_WMS_ARMAZENAMENTO) REFERENCES WMS_ARMAZENAMENTO (ID);
ALTER TABLE WMS_EXPEDICAO ADD CONSTRAINT fk_{46626029-1FD9-41A4-99BC-3883E02C29A1} FOREIGN KEY (ID_WMS_ORDEM_SEPARACAO_DET) REFERENCES WMS_ORDEM_SEPARACAO_DET (ID);
ALTER TABLE MDFE_LACRE ADD CONSTRAINT fk_{11DFA71D-CDD9-4355-B607-9EF9FB3034F1} FOREIGN KEY (ID_MDFE_CABECALHO) REFERENCES MDFE_CABECALHO (ID);
ALTER TABLE MDFE_INFORMACAO_CTE ADD CONSTRAINT fk_{433CD8D0-D22E-4E1C-BD4A-4B4EC39A50E3} FOREIGN KEY (ID_MDFE_MUNICIPIO_DESCARREGA) REFERENCES MDFE_MUNICIPIO_DESCARREGA (ID);
ALTER TABLE MDFE_INFORMACAO_NFE ADD CONSTRAINT fk_{D3B14FCD-37DE-4878-8493-00FCD857A050} FOREIGN KEY (ID_MDFE_MUNICIPIO_DESCARREGA) REFERENCES MDFE_MUNICIPIO_DESCARREGA (ID);
ALTER TABLE MDFE_EMITENTE ADD CONSTRAINT fk_{BC2F7392-73CF-4AEF-A351-4C51F4407448} FOREIGN KEY (ID_MDFE_CABECALHO) REFERENCES MDFE_CABECALHO (ID);
ALTER TABLE MDFE_PERCURSO ADD CONSTRAINT fk_{453DD9E0-0984-40C3-8B61-45D63EC9ED04} FOREIGN KEY (ID_MDFE_CABECALHO) REFERENCES MDFE_CABECALHO (ID);
ALTER TABLE MDFE_MUNICIPIO_CARREGAMENTO ADD CONSTRAINT fk_{33283B7A-BB2C-46E3-9C46-58CDE9D5A014} FOREIGN KEY (ID_MDFE_CABECALHO) REFERENCES MDFE_CABECALHO (ID);
ALTER TABLE MDFE_RODOVIARIO ADD CONSTRAINT fk_{D84E9FF2-A5EA-4C9D-B212-0ECE0AA9E7E5} FOREIGN KEY (ID_MDFE_CABECALHO) REFERENCES MDFE_CABECALHO (ID);
ALTER TABLE MDFE_RODOVIARIO_MOTORISTA ADD CONSTRAINT fk_{935170E7-7829-4199-9F73-10BAC5597794} FOREIGN KEY (ID_MDFE_RODOVIARIO) REFERENCES MDFE_RODOVIARIO (ID);
ALTER TABLE MDFE_RODOVIARIO_VEICULO ADD CONSTRAINT fk_{B32E660B-84F3-4833-9495-4A51C0513400} FOREIGN KEY (ID_MDFE_RODOVIARIO) REFERENCES MDFE_RODOVIARIO (ID);
ALTER TABLE MDFE_MUNICIPIO_DESCARREGA ADD CONSTRAINT fk_{CC00C956-3DE9-44E1-AA51-17D2000EE6C1} FOREIGN KEY (ID_MDFE_CABECALHO) REFERENCES MDFE_CABECALHO (ID);
ALTER TABLE MDFE_INFORMACAO_SEGURO ADD CONSTRAINT fk_{A88CA6D6-C161-4CD1-B1DE-A51628EC6CBA} FOREIGN KEY (ID_MDFE_CABECALHO) REFERENCES MDFE_CABECALHO (ID);
ALTER TABLE MDFE_RODOVIARIO_PEDAGIO ADD CONSTRAINT fk_{DFFAAED9-7A4C-4738-A240-CEE1D14B9113} FOREIGN KEY (ID_MDFE_RODOVIARIO) REFERENCES MDFE_RODOVIARIO (ID);
ALTER TABLE MDFE_RODOVIARIO_CIOT ADD CONSTRAINT fk_{072B68BD-2B5C-4B82-BCFE-5E424C22D7BA} FOREIGN KEY (ID_MDFE_RODOVIARIO) REFERENCES MDFE_RODOVIARIO (ID);
ALTER TABLE FROTA_VEICULO ADD CONSTRAINT fk_FROTA_VEICULO_FROTA_VEICULO_TIPO1 FOREIGN KEY (ID_FROTA_VEICULO_TIPO) REFERENCES FROTA_VEICULO_TIPO (ID);
ALTER TABLE FROTA_VEICULO ADD CONSTRAINT fk_FROTA_VEICULO_FROTA_COMBUSTIVEL_TIPO1 FOREIGN KEY (ID_FROTA_COMBUSTIVEL_TIPO) REFERENCES FROTA_COMBUSTIVEL_TIPO (ID);
ALTER TABLE FROTA_IPVA_CONTROLE ADD CONSTRAINT fk_FROTA_IPVA_CONTROLE_FROTA_VEICULO1 FOREIGN KEY (ID_FROTA_VEICULO) REFERENCES FROTA_VEICULO (ID);
ALTER TABLE FROTA_DPVAT_CONTROLE ADD CONSTRAINT fk_FROTA_IPVA_CONTROLE_FROTA_VEICULO10 FOREIGN KEY (ID_FROTA_VEICULO) REFERENCES FROTA_VEICULO (ID);
ALTER TABLE FROTA_MOTORISTA ADD CONSTRAINT fk_FROTA_MOTORISTA_PESSOA_FISICA1 FOREIGN KEY (ID_PESSOA_FISICA) REFERENCES PESSOA_FISICA (ID);
ALTER TABLE FROTA_VEICULO_SINISTRO ADD CONSTRAINT fk_FROTA_SINISTRO_FROTA_VEICULO1 FOREIGN KEY (ID_FROTA_VEICULO) REFERENCES FROTA_VEICULO (ID);
ALTER TABLE FROTA_VEICULO_MOVIMENTACAO ADD CONSTRAINT fk_FROTA_VEICULO_MOVIMENTACAO_FROTA_MOTORISTA1 FOREIGN KEY (ID_FROTA_MOTORISTA) REFERENCES FROTA_MOTORISTA (ID);
ALTER TABLE FROTA_VEICULO_MOVIMENTACAO ADD CONSTRAINT fk_FROTA_VEICULO_MOVIMENTACAO_FROTA_VEICULO1 FOREIGN KEY (ID_FROTA_VEICULO) REFERENCES FROTA_VEICULO (ID);
ALTER TABLE FROTA_VEICULO_PNEU ADD CONSTRAINT fk_FROTA_VEICULO_PNEU_FROTA_VEICULO1 FOREIGN KEY (ID_FROTA_VEICULO) REFERENCES FROTA_VEICULO (ID);
ALTER TABLE FROTA_VEICULO_MANUTENCAO ADD CONSTRAINT fk_FROTA_VEICULO_MANUTENCAO_FROTA_VEICULO1 FOREIGN KEY (ID_FROTA_VEICULO) REFERENCES FROTA_VEICULO (ID);
ALTER TABLE FROTA_MULTA_CONTROLE ADD CONSTRAINT fk_FROTA_MULTA_CONTROLE_FROTA_VEICULO1 FOREIGN KEY (ID_FROTA_VEICULO) REFERENCES FROTA_VEICULO (ID);
ALTER TABLE FROTA_COMBUSTIVEL_CONTROLE ADD CONSTRAINT fk_FROTA_COMBUSTIVEL_CONTROLE_FROTA_VEICULO1 FOREIGN KEY (ID_FROTA_VEICULO) REFERENCES FROTA_VEICULO (ID);
ALTER TABLE GONDOLA_CAIXA ADD CONSTRAINT fk_{1716794B-B0D8-4C32-B29A-8322E86A49F3}0 FOREIGN KEY (ID_GONDOLA_ESTANTE) REFERENCES GONDOLA_ESTANTE (ID);
ALTER TABLE GONDOLA_ESTANTE ADD CONSTRAINT fk_{54ED3A4A-0685-4EAD-A483-FB2085C30584}0 FOREIGN KEY (ID_GONDOLA_RUA) REFERENCES GONDOLA_RUA (ID);
ALTER TABLE GONDOLA_ARMAZENAMENTO ADD CONSTRAINT fk_{734FF4E6-A808-433A-AB15-84F96C5547EA}0 FOREIGN KEY (ID_GONDOLA_CAIXA) REFERENCES GONDOLA_CAIXA (ID);
ALTER TABLE GONDOLA_ARMAZENAMENTO ADD CONSTRAINT fk_GONDOLA_ARMAZENAMENTO_PRODUTO1 FOREIGN KEY (ID_PRODUTO) REFERENCES PRODUTO (ID);
ALTER TABLE PROJETO_CRONOGRAMA ADD CONSTRAINT fk_PROJETO_CRONOGRAMA_PROJETO_DADOS1 FOREIGN KEY (ID_PROJETO_PRINCIPAL) REFERENCES PROJETO_PRINCIPAL (ID);
ALTER TABLE PROJETO_STAKEHOLDERS ADD CONSTRAINT fk_PROJETO_STAKEHOLDERS_PROJETO_DADOS1 FOREIGN KEY (ID_PROJETO_DADOS) REFERENCES PROJETO_PRINCIPAL (ID);
ALTER TABLE PROJETO_STAKEHOLDERS ADD CONSTRAINT fk_PROJETO_STAKEHOLDERS_COLABORADOR1 FOREIGN KEY (ID_COLABORADOR) REFERENCES COLABORADOR (ID);
ALTER TABLE PROJETO_RISCO ADD CONSTRAINT fk_PROJETO_RISCO_PROJETO_PRINCIPAL1 FOREIGN KEY (ID_PROJETO_PRINCIPAL) REFERENCES PROJETO_PRINCIPAL (ID);
ALTER TABLE PROJETO_CUSTO ADD CONSTRAINT fk_PROJETO_CUSTO_PROJETO_PRINCIPAL1 FOREIGN KEY (ID_PROJETO_PRINCIPAL) REFERENCES PROJETO_PRINCIPAL (ID);
ALTER TABLE PROJETO_CUSTO ADD CONSTRAINT fk_PROJETO_CUSTO_FIN_NATUREZA_FINANCEIRA1 FOREIGN KEY (ID_FIN_NATUREZA_FINANCEIRA) REFERENCES FIN_NATUREZA_FINANCEIRA (ID);
ALTER TABLE BPE_EMITENTE ADD CONSTRAINT fk_{8E0EA66C-EA89-4C1F-8CF4-778365C7AE3B}0 FOREIGN KEY (ID_BPE_CABECALHO) REFERENCES BPE_CABECALHO (ID);
ALTER TABLE BPE_PASSAGEIRO ADD CONSTRAINT fk_{FB54EDC5-F918-4617-A828-70539984BB46}0 FOREIGN KEY (ID_BPE_CABECALHO) REFERENCES BPE_CABECALHO (ID);
ALTER TABLE BPE_COMPRADOR ADD CONSTRAINT fk_{44C5AE01-875B-414A-B141-210DE88D5716}0 FOREIGN KEY (ID_BPE_CABECALHO) REFERENCES BPE_CABECALHO (ID);
ALTER TABLE BPE_VIAGEM ADD CONSTRAINT fk_{B49F680D-20F5-4D89-945B-ED7A99C5EBFF}0 FOREIGN KEY (ID_BPE_CABECALHO) REFERENCES BPE_CABECALHO (ID);
ALTER TABLE BPE_AGENCIA ADD CONSTRAINT fk_{BE7E7FC1-4115-40C2-AB9E-A9B2B1B52D98}0 FOREIGN KEY (ID_BPE_CABECALHO) REFERENCES BPE_CABECALHO (ID);
ALTER TABLE BPE_PASSAGEM ADD CONSTRAINT fk_{9B8A42CB-E13A-475F-81FE-5E7C48ED6E2F}0 FOREIGN KEY (ID_BPE_CABECALHO) REFERENCES BPE_CABECALHO (ID);
ALTER TABLE CRM_SAC_CABECALHO ADD CONSTRAINT fk_CRM_SAC_CABECALHO_CLIENTE1 FOREIGN KEY (ID_CLIENTE) REFERENCES CLIENTE (ID);
ALTER TABLE CRM_SAC_DETALHE ADD CONSTRAINT fk_CRM_SAC_DETALHE_CRM_SAC_CABECALHO1 FOREIGN KEY (ID_CRM_SAC_CABECALHO) REFERENCES CRM_SAC_CABECALHO (ID);
ALTER TABLE CRM_BUSCAS_CLIENTE ADD CONSTRAINT fk_CRM_BUSCAS_CLIENTE_CLIENTE1 FOREIGN KEY (ID_CLIENTE) REFERENCES CLIENTE (ID);
ALTER TABLE CRM_CARTEIRA_CLIENTE ADD CONSTRAINT fk_CRM_CARTEIRA_CLIENTE_CRM_CARTEIRA_CLIENTE_PERFIL1 FOREIGN KEY (ID_CRM_CARTEIRA_CLIENTE_PERFIL) REFERENCES CRM_CARTEIRA_CLIENTE_PERFIL (ID);
ALTER TABLE CRM_CARTEIRA_CLIENTE ADD CONSTRAINT fk_CRM_CARTEIRA_CLIENTE_CLIENTE1 FOREIGN KEY (ID_CLIENTE) REFERENCES CLIENTE (ID);

-- ================================================================
-- Fim do script PostgreSQL — Fênix ERP
-- ================================================================