# Guia de Implantação Rápida - ERP Fenix (Software Livre)

## Visão Geral
Este documento descreve a estratégia de implantação do ERP Fenix utilizando exclusivamente softwares de código aberto para minimizar custos e acelerar a entrega aos clientes.

## Stack de Software Livre Recomendada
- **Sistema Operacional:** Ubuntu Server LTS
- **Orquestração:** Docker & Docker Compose (Fase 1) $\rightarrow$ K3s/K8s (Fase 2)
- **Banco de Dados:** MySQL Community Edition
- **Servidor Web/Proxy:** Nginx (Open Source)
- **Monitoramento:** Prometheus & Grafana (OSS)
- **Logs:** Loki & Promtail

## Estratégia de Deploy Rápido
Para colocar o sistema em funcionamento rapidamente em clientes, utilizaremos a abordagem de **Single-Node Docker Compose**:
1. Um único servidor com Docker instalado.
2. Arquivo `docker-compose.yml` definindo todos os microserviços Flask e o MySQL.
3. Nginx como porta de entrada única (Reverse Proxy).
4. Volume externo para persistência do banco de dados.

## Fluxo de Consumo (Frontend $\rightarrow$ Backend)
- O Frontend (Flutter Web) será hospedado como arquivos estáticos no Nginx.
- Todas as requisições serão direcionadas para o Backend Flask via endpoints REST.
- A navegação será unificada em um menu global que intercala os módulos.
