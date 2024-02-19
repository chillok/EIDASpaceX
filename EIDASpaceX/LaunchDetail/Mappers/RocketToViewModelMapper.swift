import Foundation

struct RocketToViewModelMapper {
    
    func map(_ rocket: Rocket) -> RocketViewViewModel {
        .init(id: rocket.id, name: rocket.name, stages: rocket.stages, details: rocket.details, images: rocket.images)
    }
}
