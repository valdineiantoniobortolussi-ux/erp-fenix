from flask import Blueprint, request, jsonify
from src.model.transient.filter import Filter
from src.service.contabil_livro_service import ContabilLivroService

contabil_livro_bp = Blueprint('contabil-livro', __name__)
service = ContabilLivroService()

@contabil_livro_bp.route('/contabil-livro', methods=['GET'])
@contabil_livro_bp.route('/contabil-livro/', methods=['GET'])
def get_list():
    query_params = request.args
    filter_obj = Filter(query_params)    
    if filter_obj.where:
        result_list = service.get_list_filter(filter_obj)
    else:
        result_list = service.get_list()
    return jsonify([obj.serialize() for obj in result_list])

@contabil_livro_bp.route('/contabil-livro/<int:id>', methods=['GET'])
def get_object(id):
    obj = service.get_object(id)
    return jsonify(obj.serialize())

@contabil_livro_bp.route('/contabil-livro', methods=['POST'])
def insert():
    data = request.json
    result = service.insert(data)
    return jsonify(result.serialize()), 201

@contabil_livro_bp.route('/contabil-livro', methods=['PUT'])
def update():
    data = request.json
    result = service.update(data)
    return jsonify(result.serialize()), 200

@contabil_livro_bp.route('/contabil-livro/<int:id>', methods=['DELETE'])
def delete(id):
    service.delete(id)
    return jsonify({'message': 'Deleted successfully'})