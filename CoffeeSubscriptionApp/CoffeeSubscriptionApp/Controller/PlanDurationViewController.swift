//
//  PlanDurationViewController.swift
//  CoffeeSubscriptionApp
//
//  Created by WjdanMo on 04/01/2022.
//

import UIKit
import MapKit
import CoreLocation

class PlanDurationViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{
    
    @IBOutlet weak var startingDate: UIDatePicker!
    
    @IBOutlet weak var deliveryTimePicker: UIDatePicker!
    
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager : CLLocationManager!
    var currentLocationString = "Current location"
    let mkAnnotation: MKPointAnnotation = MKPointAnnotation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        determineCurrentLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
        
        // Get user's Current Location and Drop a pin
        
        mkAnnotation.coordinate = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude)
        mkAnnotation.title = self.setUsersClosestLocation(mLattitude: userLocation.coordinate.latitude, mLongitude: userLocation.coordinate.longitude)
        mapView.addAnnotation(mkAnnotation)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error - locationManager: \(error.localizedDescription)")
    }
    
    
    func setUsersClosestLocation(mLattitude: CLLocationDegrees, mLongitude: CLLocationDegrees) -> String {
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: mLattitude, longitude: mLongitude)
        
        geoCoder.reverseGeocodeLocation(location) {
            (placemarks, error) -> Void in
            
            if let placemark = placemarks{
                if let dict = placemark[0].addressDictionary as? [String: Any]{
                    if let Name = dict["Name"] as? String{
                        if let City = dict["City"] as? String{
                            self.currentLocationString = Name + ", " + City
                        }
                    }
                }
            }
        }
        return currentLocationString
    }
    
    func determineCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    
    @IBAction func continueToPlanDetailsButtonClicked(_ sender: Any) {
        
        Plan.plan.startDate = Formatter.format(date: startingDate.date)
        
        Plan.plan.startDateDateFormat = startingDate.date
        
        Plan.plan.deliveryTime = Formatter.format(time: deliveryTimePicker.date)
        
        Plan.plan.userLocation = ["lat": mkAnnotation.coordinate.latitude,
                                  "long": mkAnnotation.coordinate.longitude]
        
        performSegue(withIdentifier: K.navigateToPlanDetails, sender: self)
        
    }
    
}
