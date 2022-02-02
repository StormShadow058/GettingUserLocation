//
//  MapLayoutView.swift
//  GettingUserLocation
//
//  Created by Vansh Maheshwari on 02/02/22.
//

import SwiftUI
import MapKit

struct MapLayoutView: View {
    @StateObject private var vM = MapLayoutViewModel()
    
    var body: some View {
        Map(coordinateRegion: $vM.region, showsUserLocation: true)
            .ignoresSafeArea()
            .onAppear {
                vM.ifLocationServiceEnabled()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MapLayoutView()
    }
}
