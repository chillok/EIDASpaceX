import Foundation

protocol WebserviceProtocol {
    
    func retrieveLaunches() async throws -> [Launch]
    func retrieveCrew() async throws -> [CrewMember]
    func retrieveRockets() async throws -> [Rocket]
    
    func data(for request: URLRequest) async throws -> Data
}

class Webservice: WebserviceProtocol {
    
    func retrieveLaunches() async throws -> [Launch] {
        let url = URL(string: "https://api.spacexdata.com/v4/launches")!
        return try await retrieve(from: url)
    }
    
    func retrieveCrew() async throws -> [CrewMember] {
        let url = URL(string: "https://api.spacexdata.com/v4/crew")!
        return try await retrieve(from: url)
    }
    
    func retrieveRockets() async throws -> [Rocket] {
        let url = URL(string: "https://api.spacexdata.com/v4/rockets")!
        return try await retrieve(from: url)
    }
    
    private func retrieve<T: Decodable>(from url: URL) async throws -> T {
        let request = URLRequest(url: url)
        let data = try await data(for: request)
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
    
    func data(for request: URLRequest) async throws -> Data {
        let (data, _) = try await URLSession.shared.data(for: request)
        return data
    }
}
