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
    var points = [MKAnnotation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mapView.delegate = self
        
        // 중심점 잡기
        let center = CLLocationCoordinate2D(latitude: 35.165775, longitude: 129.072537)
//          범위 잡기
//          let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
//          let region = MKCoordinateRegion(center: center, span: span)
        
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
        

        // plist 파일 불러오기
        let path = Bundle.main.path(forResource: "pinData", ofType: "plist")
        
        let content = NSArray(contentsOfFile: path!)
        print(content!)
        
        // 값을 뽑아 처리
        var annotations = [MKPointAnnotation]()
        
        // optional binding 처리
        if let myItems = content {
            for item in myItems {
                let lat = (item as AnyObject).value(forKey: "lat")
                let lon = (item as AnyObject).value(forKey: "lon")
                let title = (item as AnyObject).value(forKey: "title")
                let subtitle = (item as AnyObject).value(forKey: "subtitle")
                
                // 형 변환
                let mylat = (lat as! NSString).doubleValue
                let mylon = (lon as! NSString).doubleValue
                
                let pin = MKPointAnnotation()
                pin.coordinate.latitude = mylat
                pin.coordinate.longitude = mylon
                pin.title = title as? String
                pin.subtitle = subtitle as? String
                annotations.append(pin)

            }
        } else {
            print("nile 발생")
        }
        mapView.showAnnotations(annotations, animated: true)
        //mapView.selectAnnotation(point2, animated: true)
        
    }
     
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let alert = UIAlertController(title: view.annotation!.title!, message: view.annotation!.subtitle!, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "닫기", style: .default, handler: nil))
        present(alert, animated: false, completion: nil)
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
            switch annotation.title {
                case "동의과학대 ":
                    annotationView?.pinTintColor = UIColor.red
                case "송상현광장":
                    annotationView?.pinTintColor = UIColor.yellow
                case .none:
                    break
                case .some(_):
                    break
            }
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

