# The Movie DB

É um projeto que lista os filmes populares retornados da API do The Movie DB.

## Especificações

O projeto foi desenvolvido utilizando XCode 13.2.1 e com deployment target do iOS 15.2.

Foi desenvolvido em Swift com apenas 3 bibliotecas externas, Quick, Nimble e Nimble_Snapshot integrados via Swift Package Manager.

## Pontos de Melhoria

Não existe nada incompleto, porém segue pontos de melhoria:

* Poderia ser criado um UICollectionViewFlowLayout para melhorar o designer e fazer com que as cells tivessem tamanhos dinâmicos. Alguns textos são maiores que os outros e com a height fixa, o texto fica truncado.
* Poderia ser criada uma classe para administrar melhorar a reusabilidade de células, sem usar string oriented. 
* Poderia ser criada uma classe, talvez utilizando um design pattern factory, para criar os objetos Presentation a partir da response da API.
* Poderia ser incluído Swiftlint, Tuist ou talvez até um Swiftgen para tratar strings.
* Criar um estado, vazio, para quando não houver filmes. (OBS: muito difícil isso ocorrer com a API do TheMovieDB porém em outros casos podem ser importantes).
* Criar uma classe para Tokens de Espaço. Os espaçamentos ficaram fixos no layout
* Melhorar tratamento de erro quando houver erro na request da paginação. Atualmente, o app mostra um erro na tela inteira. Poderia ser um alert ou até mesmo uma SnackBar customizada, apesar de SnackBar não ser acessível.
* Incluiria um tratamento para fonts dinânica para acessibilidade.