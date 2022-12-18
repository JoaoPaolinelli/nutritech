# Nutri tech projeto


## Descrição da API utilizada


Descrição da API TACOS:

Utilizamos o docker para utilizar a API offline, em vista que, ela não está atualmente em um servidor online.

Para isso segue o passo a passo da instalação.

Já possuindo o docker instalado.

1. docker pull raulfdm/taco-api

2. docker run -it --rm --name taco -p 4000:4000 raulfdm/taco-api

Então a api já vai estar pronta para ser consumida dentro do projeto. Os endpoints estão configurados para responder as solitações feitas via local host


## Funções utilizadas e criadas.

[Food] Funcionalidade:
 Função getAllFood(): Busca todos os alimentos disponiveis na API e os mostra na tela

 Funcao alimentoPorCategoria(id): Busca todos os alimentos de uma determinada categoria e os mostra na tela

[Categoria] - Funcionalidade:
 Função fetch: Busca todas as categorias e as mostra na tela

 Função getCategoriaX( x ): Busca uma categoria, tendo como parametro o ID da categoria.
