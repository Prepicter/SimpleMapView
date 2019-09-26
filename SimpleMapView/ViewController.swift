//
//  ViewController.swift
//  SimpleMapView
//
//  Created by D7702_09 on 2019. 9. 17..
//  Copyright © 2019년 csd5766. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var points = [MKPointAnnotation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mapView.delegate = self
        
        // 중심점 잡기
        let center = CLLocationCoordinate2D(latitude: 35.165775, longitude: 129.072537)
        // 범위 잡기
//        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
//        let region = MKCoordinateRegion(center: center, span: span)
        
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
        

        let point = createPoint(la: 35.165775, lo: 129.072537, title: "학교" , subtitle: "학교")
        mapView.addAnnotation(point)
        
        let point2 = createPoint(la: 35.164236, lo: 129.064941, title: "송상현광장" , subtitle: "공원")
        mapView.addAnnotation(point2)
        
        let point3 = createPoint(la: 35.167629, lo: 129.070595, title: "번개반점" , subtitle: "중국 음식점")
        mapView.addAnnotation(point3)
        
        let point4 = createPoint(la: 35.071750, lo: 129.057410, title: "영도 목장원" , subtitle: "식당")
        mapView.addAnnotation(point4)
        
        
        mapView.showAnnotations(points, animated: true)
        mapView.selectAnnotation(point2, animated: true)
        
    }
     
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let alert = UIAlertController(title: view.annotation!.title!, message: view.annotation!.subtitle!, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "닫기", style: .default, handler: nil))
        present(alert, animated: false, completion: nil)
    }

    
    func createPoint(la : CLLocationDegrees, lo : CLLocationDegrees, title:String, subtitle:String) -> MKPointAnnotation {
        let center = CLLocationCoordinate2D(latitude: la, longitude: lo)
        let point = MKPointAnnotation()
        point.coordinate = center
        point.title = title
        point.subtitle = subtitle
        points.append(point)
        return point
    }
 

    @IBAction func standard(_ sender: Any) {
        mapView.mapType = MKMapType.standard
     
    }
    
    @IBAction func satelite(_ sender: Any) {
        mapView.mapType = MKMapType.satellite
       
    }
    
    @IBAction func hybrid(_ sender: Any) {
        mapView.mapType = MKMapType.hybrid
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let identifier = "RE"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
            annotationView?.pinTintColor = UIColor.blue
            annotationView?.animatesDrop = true
            
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
            
            
            
            
            let img = UIImageView(image: UIImage(named: "사진"))
            img.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            annotationView?.leftCalloutAccessoryView = img
            
        }
        else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
        
    }
    
    
}

