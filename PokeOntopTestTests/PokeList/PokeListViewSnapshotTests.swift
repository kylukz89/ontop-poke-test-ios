import XCTest
import SwiftUI
import SnapshotTesting
@testable import PokeOntopTest

final class PokeListViewSnapshotTests: XCTestCase {
    
    private var isRecording = false
    
    override func setUp() {
        super.setUp()
        isRecording = false
    }
    
    func testPokeListView_DefaultState() {
        let view = PokeListView()
        
        assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13)), record: isRecording)
    }
    
    func testPokeListView_WithPokemonList() {
        let viewModelMock = PokeListViewModelMock()
        viewModelMock.pokemonList = [
            PokeDetail(id: 1, name: "Bulbasaur", url: nil),
            PokeDetail(id: 2, name: "Ivysaur", url: nil)
        ]
        
        let view = PokeListView().environmentObject(viewModelMock)
        
        assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13)), record: isRecording)
    }
    
}
