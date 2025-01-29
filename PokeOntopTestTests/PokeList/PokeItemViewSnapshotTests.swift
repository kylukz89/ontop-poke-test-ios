import XCTest
import SwiftUI
import SnapshotTesting
@testable import PokeOntopTest

final class PokeItemViewSnapshotTests: XCTestCase {
    
    private var isRecording = false
    
    override func setUp() {
        super.setUp()
        isRecording = false
    }
    
    func testPokeItemView_DefaultState() {
        let view = PokeItemView(id: 1, name: "Bulbasaur")
        
        assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13)), record: isRecording)
    }
    
    func testPokeItemView_WithDifferentPokemon() {
        let view = PokeItemView(id: 25, name: "Pikachu")
        
        assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13)), record: isRecording)
    }
}
