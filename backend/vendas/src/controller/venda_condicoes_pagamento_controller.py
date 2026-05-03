from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.venda_condicoes_pagamento_service import VendaCondicoesPagamentoService

venda_condicoes_pagamento_bp = Blueprint('venda-condicoes-pagamento', __name__)
service = VendaCondicoesPagamentoService()

@venda_condicoes_pagamento_bp.route('/venda-condicoes-pagamento', methods=['GET'])
@venda_condicoes_pagamento_bp.route('/venda-condicoes-pagamento/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@venda_condicoes_pagamento_bp.route('/venda-condicoes-pagamento/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@venda_condicoes_pagamento_bp.route('/venda-condicoes-pagamento', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@venda_condicoes_pagamento_bp.route('/venda-condicoes-pagamento', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@venda_condicoes_pagamento_bp.route('/venda-condicoes-pagamento/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})