import Foundation

// DataState is useful for enforcing consistent data loading for SwiftUI
enum DataState<T> {
    case initial
    case loading
    case loaded(T)
    case failed
}
