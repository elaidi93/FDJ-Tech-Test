//
//  TeamView.swift
//  Test-FDJ-Clubs
//
//  Created by Hamza EL Aidi on 28/11/2022.
//

import SwiftUI
import Combine

struct TeamView: View {
	
	var viewModel: TeamViewModel?
	@State private var image: UIImage? = UIImage()
	@State private var subscribers = Set<AnyCancellable>()
	
	init(viewModel: TeamViewModel? = nil) {
		self.viewModel = viewModel
		self.viewModel?.loadImage()
	}

    var body: some View {
		NavigationView {
			ScrollView(.vertical){
				VStack(alignment: .leading, spacing: 10) {
					if let banner = self.viewModel?.banner {
						Image(uiImage: banner)
							.resizable()
							.aspectRatio(contentMode: .fit)
							.onAppear {
								viewModel?.objectWillChange
									.receive(on: DispatchQueue.main)
									.sink(receiveValue: { _ in
										image = viewModel?.banner ?? nil
									}).store(in: &self.subscribers)
							}
					}
					
					Text(viewModel?.team?.country ?? "")
						.font(.system(size: 12))
					
					Text(viewModel?.team?.league ?? "")
						.font(.system(size: 14).bold())
					
					Text(viewModel?.team?.description ?? "")
						.font(.system(size: 14))
				}.padding()
			}
		}
		.navigationTitle(self.viewModel?.team?.name ?? "")
		.navigationBarTitleDisplayMode(.large)
    }
}

struct TeamView_Previews: PreviewProvider {
    static var previews: some View {
        TeamView()
    }
}
