import Foundation
import Quick
import Nimble

@testable import TheMovieDB

final class NetworkLayerErrorTests: QuickSpec {
    override func spec() {
        var sut: NetworkLayerError!
        
        describe("#configError") {
            beforeEach {
                sut = .configError
            }
            
            it("has to return properly message") {
                expect(sut.errorMessage).to(equal("O método config não foi chamado passando todas as configurações"))
            }
        }
        
        describe("#baseURLError") {
            beforeEach {
                sut = .baseURLError
            }
            
            it("has to return properly message") {
                expect(sut.errorMessage).to(equal("A URL base não é uma URL válida"))
            }
        }
        
        describe("#dataError") {
            beforeEach {
                sut = .dataError
            }
            
            it("has to return properly message") {
                expect(sut.errorMessage).to(equal("Error de rede. Data não foi retornado"))
            }
        }
        
        describe("#generalError") {
            beforeEach {
                sut = .generalError
            }
            
            it("has to return properly message") {
                expect(sut.errorMessage).to(equal("Erro de chamada"))
            }
        }
        
        describe("#parseError") {
            beforeEach {
                sut = .parseError
            }
            
            it("has to return properly message") {
                expect(sut.errorMessage).to(equal("Erro de parse ao transformar o objeto da response no objeto requerido"))
            }
        }
    }
}
