from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.fiscal_livro_service import FiscalLivroService

fiscal_livro_bp = Blueprint('fiscal-livro', __name__)
service = FiscalLivroService()

@fiscal_livro_bp.route('/fiscal-livro', methods=['GET'])
@fiscal_livro_bp.route('/fiscal-livro/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@fiscal_livro_bp.route('/fiscal-livro/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@fiscal_livro_bp.route('/fiscal-livro', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@fiscal_livro_bp.route('/fiscal-livro', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@fiscal_livro_bp.route('/fiscal-livro/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})