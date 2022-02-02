//
//  MapLayoutViewModel.swift
//  GettingUserLocation
//
//  Created by Vansh Maheshwari on 02/02/22.
//

import SwiftUI
import MapKit

enum Details {
    static let statupLocation = CLLocationCoordinate2D(latitude: 28.68983, longitude: 77.13586)
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
}


final class MapLayoutViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var region = MKCoordinateRegion(center: Details.statupLocation,
                                               span: Details.defaultSpan)
    
    var locationManager: CLLocationManager?
    
    func ifLocationServiceEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
        }
        else {
            print("Alert to turn location services on")
        }
    }
    
    private func locationAuthCheck() {
        guard let locationManager = locationManager else {
            return
        }
        switch locationManager.authorizationStatus {
            
            case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            case .restricted:
                print("Your location is restricted alert")
            case .denied:
                print("Change location settings to allow them alert")
            case .authorizedAlways, .authorizedWhenInUse:
                region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            @unknown default:
                break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        locationAuthCheck()
    }
    
}
