import SwiftUI

private struct Constants {
    static let missionSuccess = "Mission Success"
    static let missionFailed = "Unsuccessful Launch"
    static let missionUnknown = "Mission Result Unknown"
}

/// A view for showing a single Launch item
struct LaunchCellView: View {
    
    var model: LaunchViewViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack {
                
                Image(systemName: "airplane.departure")
                    .frame(width: 60, height: 60, alignment: .center)
                    .background(Circle().fill(Color.gray.quaternary))
                    .fontDesign(.monospaced)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.gray)
                
                VStack(alignment: .leading) {
                    
                    HStack {
                        Text(model.name)
                            .font(.title3)
                            .fontWeight(.bold)
                            .fontDesign(.monospaced)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.forward")
                            .foregroundStyle(Color.gray.quaternary)
                    }
                    
                    HStack {
                        
                        VStack {
                            if let dateUTC = model.dateUTC {
                                HStack {
                                    Image(systemName: "clock.fill")
                                    Text(dateUTC.readableDate)
                                        .textCase(.uppercase)
                                }
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                            }
                            if let dateLocal = model.dateLocal {
                                HStack {
                                    Image(systemName: "mappin.and.ellipse.circle.fill")
                                    Text(dateLocal.readableDate)
                                        .textCase(.uppercase)
                                }
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
            }
            
            Spacer()
                
                HStack {
                    if model.success == false {
                        Image(systemName: "exclamationmark.square.fill")
                    }
                    Text(model.successLabel)
                }
                .foregroundStyle(model.successColor)
                .font(.footnote)
                .textCase(.uppercase)
                .fontWeight(.heavy)
            
            if let details = model.details {
                Text(details)
                    .font(.footnote)
                    .foregroundStyle(model.successDescriptionColor)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.secondary.quinary)
        .clipShape(RoundedRectangle(cornerRadius: 12.0))
        .listRowSeparator(.hidden)
    }
}

extension LaunchViewViewModel {
    
    var successColor: Color {
        if let success {
            return success ? Color.green : Color.red
        }
        return Color.gray
    }
    
    var successLabel: String {
        if let success {
            return success ? Constants.missionSuccess : Constants.missionFailed
        }
        return Constants.missionUnknown
    }
    
    var successDescriptionColor: Color {
        if let success {
            return success ? .gray : .red
        }
        return .gray
    }
}

#Preview {
    LaunchCellView(model: .init(id: "45678",
                                flightNumber: 2,
                                name: "Test launch",
                                dateUTC: Date(),
                                dateLocal: Date(),
                                details: "dtfyguh",
                                success: true,
                                upcoming: nil))
}
