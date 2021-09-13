//
//  ContentView.swift
//  Moonshot
//
//  Created by Baptiste Cadoux on 10/09/2021.
//

import SwiftUI

let missions: [Mission] = Bundle.main.decode("missions.json")

struct ContentView: View {

    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")

    @State private var displayLaunchDate: Bool = true

    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)) {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                    
                    
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)

                        if displayLaunchDate {
                            Text(mission.formattedLaunchDate)
                        } else {
                            ForEach(mission.crew, id: \.role) { crewMember in
                                Text(getAstronautName(for: crewMember.name))
                                    .foregroundColor(.secondary)
                            }
                        }

                    }
                }
            }
            .navigationBarTitle(Text("Moonshot"))
            .navigationBarItems(
                trailing:
                    Button(action: {
                        displayLaunchDate.toggle()
                    }) {
                        Text(displayLaunchDate ?
                                "Display launch date" :
                                "Display crew")
                    }
            )
        }
    }
    
    func getAstronautName(for role: String) -> String {
        if let astronaut = astronauts.first(where: { astronaut in
            astronaut.id == role
        }) {
            return astronaut.name
        }
        return ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
