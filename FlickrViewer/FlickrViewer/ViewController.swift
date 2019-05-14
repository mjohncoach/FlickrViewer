//
//  ViewController.swift
//  FlickrViewer
//
//  Created by M.Can KOÇ on 7.05.2019.
//  Copyright © 2019 M.Can KOÇ. All rights reserved.
//

import UIKit
import Alamofire // pod install metoduyla indirdiğimiz network kütüphanesinin importu
import SwiftyJSON


class ViewController: UIViewController , UITextFieldDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var searchTextField: UITextField!
    
    
    let FLICKR_API_KEY:String = "78ae04b0cf8574c248630f8bc3e880f5" // Kişiye özel erişim anahtarı
    let FLICKR_URL:String = "https://api.flickr.com/services/rest/" //api adresi
    let SEARCH_METHOD:String = "flickr.photos.search" // kullanacağımız metod
    let FORMAT_TYPE:String = "json"
    let JSON_CALLBACK:Int = 1
    let PRIVACY_FILTER:Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    @IBAction func searchClick(_ sender: AnyObject) {
    }
    // Alt taraftaki alan resim olmadığı zaman loop a girmesini önlemek için
    func urlToImageView(imageString: String){
        DispatchQueue.main.async( group: dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),  execute: {
            DispatchQueue.main.async (  execute: {
                let url = NSURL(string: imageString)
                let imageData = NSData(contentsOfURL: url!)
                if(imageData != nil){
                    self.imageView.image = UIImage(data: imageData!)
                    
                } else {
                    self.urlToImageView(imageString)
                }
                
            });
        });
        
    }
    // Alt taraftaki alan fotoğrafı gerekli yere basmak için
    func displayImage(){
        
        let random = Int(arc4random_uniform(UInt32(100))) as Int
        
        AF.request(.GET, FLICKR_URL, parameters: ["method": SEARCH_METHOD, "78ae04b0cf8574c248630f8bc3e880f5": FLICKR_API_KEY, "tags":searchTextField.text,"privacy_filter":PRIVACY_FILTER, "format":FORMAT_TYPE, "nojsoncallback": JSON_CALLBACK])
            .responseJSON { (request, response, data, error) in
                println(request)
                
                if(data != nil){
                    
                    var json:JSON = JSON(data!)
                    var innerJson:JSON = JSON(data!)
                    
                    var farm:String = innerJson["photos"]["photo"][random]["farm"].stringValue
                    var server:String = innerJson["photos"]["photo"][random]["server"].stringValue
                    var photoID:String = innerJson["photos"]["photo"][random]["id"].stringValue
                    
                    var secret:String = innerJson["photos"]["photo"][random]["secret"].stringValue
                    
                    var imageString:String = "http://farm\(farm).staticflickr.com/\(server)/\(photoID)_\(secret)_n.jpg/"
                    self.urlToImageView(imageString)
                    
                    
                }
        }
        
    }

    
    
    
    
    
    
    
}
