import Foundation

struct CrewMemberToViewModelMapper {
    
    func map(_ crew: CrewMember) -> CrewMemberViewViewModel {
        .init(id: crew.id, name: crew.name, image: crew.image)
    }
}
