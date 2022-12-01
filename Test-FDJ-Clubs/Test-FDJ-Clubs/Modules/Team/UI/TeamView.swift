//
//  TeamView.swift
//  Test-FDJ-Clubs
//
//  Created by Hamza EL Aidi on 28/11/2022.
//

import SwiftUI

struct TeamView: View {
	
	var team: Team?

    var body: some View {
		NavigationView {
			ScrollView(.vertical){
				VStack(alignment: .leading, spacing: 10) {
					
					if let url = URL(string: team?.banner ?? "") {
						AsyncImage(url: url) { banner in
							banner
								.resizable()
								.scaledToFit()
						} placeholder: {
							Color.blue
						}
					}
					
					Text(team?.country ?? "")
						.font(.system(size: 12))
					
					Text(team?.league ?? "")
						.font(.system(size: 14).bold())
					
					Text(team?.description ?? "")
						.font(.system(size: 14))
				}.padding()
			}
		}
		.navigationTitle(team?.name ?? "")
		.navigationBarTitleDisplayMode(.large)
    }
}

struct TeamView_Previews: PreviewProvider {
    static var previews: some View {
        TeamView()
    }
}
