 
import Foundation

struct PokeEvolutionDetail: Codable, Identifiable {
    
    let id: Int
    let chain: EvolutionChain?
    
    struct EvolutionChain: Codable {
        let species: PokeDetail?
        let isBaby: Bool
        let evolvesTo: [EvolutionStep]?
        
        enum CodingKeys: String, CodingKey {
            case species, evolvesTo = "evolves_to", isBaby = "is_baby"
        }
    }
    
    struct EvolutionStep: Codable {
        let species: PokeDetail?
        let isBaby: Bool
        let evolvesTo: [EvolutionStep]?
        let evolutionDetails: [EvolutionDetail]?
        
        enum CodingKeys: String, CodingKey {
            case species, evolvesTo = "evolves_to", isBaby = "is_baby", evolutionDetails = "evolution_details"
        }
    }
    
    struct EvolutionDetail: Codable {
        let minLevel: Int?
        let trigger: EvolutionTrigger?
        
        enum CodingKeys: String, CodingKey {
            case minLevel = "min_level"
            case trigger
        }
    }
    
    struct EvolutionTrigger: Codable {
        let name: String
        let url: String
    }
}
