//
//  MapViewController.swift
//  RestaurantDemo
//
//  Created by linyi on 16/5/4.
//  Copyright © 2016年 linyi. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController , MKMapViewDelegate {
    var restaurant: Restaurant!
    
    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.showsUserLocation = true
        mapView.showsCompass = true
        mapView.showsBuildings = true
        mapView.showsPointsOfInterest = true
        mapView.showsScale = true
        mapView.showsTraffic = true
        
        CLGeocoder().geocodeAddressString(restaurant.location) { (placemarks, error) -> Void in
            if error != nil {
                print(error)
                return
            }
            
            if let placemarks = placemarks {
                let placemark = placemarks[0]
                
                let annotation = MKPointAnnotation()
                annotation.title = self.restaurant.name
                annotation.subtitle = self.restaurant.type
                
                if let location = placemark.location {
                    annotation.coordinate = location.coordinate
                    
                    self.mapView.selectAnnotation(annotation, animated: true)
                    self.mapView.showAnnotations([annotation], animated: true)
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let id = "MapCell"
        
        if annotation is MKUserLocation {
            return nil
        }
        
        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(id) as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: id)
            annotationView?.canShowCallout = true
        }
        
        let leftIconImageView = UIImageView(frame: CGRectMake(0, 0, 70, 70))
        leftIconImageView.image = UIImage(data: restaurant.image!)
        annotationView?.leftCalloutAccessoryView = leftIconImageView
        
        return annotationView
    }
}



















