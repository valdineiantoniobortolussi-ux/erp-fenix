from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.view_pessoa_colaborador_service import ViewPessoaColaboradorService

view_pessoa_colaborador_bp = Blueprint('view-pessoa-colaborador', __name__)
service = ViewPessoaColaboradorService()

@view_pessoa_colaborador_bp.route('/view-pessoa-colaborador', methods=['GET'])
@view_pessoa_colaborador_bp.route('/view-pessoa-colaborador/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@view_pessoa_colaborador_bp.route('/view-pessoa-colaborador/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@view_pessoa_colaborador_bp.route('/view-pessoa-colaborador', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@view_pessoa_colaborador_bp.route('/view-pessoa-colaborador', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@view_pessoa_colaborador_bp.route('/view-pessoa-colaborador/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})