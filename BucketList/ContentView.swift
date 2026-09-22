//
//  ContentView.swift
//  BucketList
//
//  Created by Juan Galeazzi on 6/25/26.
//

import SwiftUI
import MapKit
import LocalAuthentication

struct User: Identifiable, Comparable {
    let id = UUID()
    var firstName: String
    var lastName: String
    
    static func <(lh: User, rh: User) -> Bool {
        lh.lastName < rh.lastName
    }
}

struct ContentView: View {
    @State private var isUnlocked = false
    @State private var locations = [Location]()
    
    
    
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 51.50722, longitude: -0.1275),
            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        )
    )
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        // check wether biometric authentication is possible
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // is posible go ahead and use it
            let reason = "We need to unlock your data."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                // authentication has now completed
                if success {
                    isUnlocked = true
                } else {
                    // there was a problem
                }
            }
            
        } else {
            // no biometrics
        }
        
    }
    
    
    
    var body: some View {
        VStack {
            if isUnlocked {
                MapReader {
                    proxy in
                    Map(initialPosition:startPosition) {
                        ForEach(locations) { location in
                            Marker( location.name, coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
                        }
                    }
                            .onTapGesture {
                            position in
                            if let coordinate = proxy.convert(position, from: .local) {
                                let newLocation = Location(id:UUID(), name: "New location", description: "", latitude: coordinate.latitude, longitude: coordinate.longitude)
                                locations.append(newLocation)
                            }
                        }
                }
            }
            
        }.onAppear(perform: authenticate)
    }
}

#Preview {
    ContentView()
}
