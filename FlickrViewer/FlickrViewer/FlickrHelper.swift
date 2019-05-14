//
//  FlickrHelper.swift
//  FlickrViewer
//
//  Created by M.Can KOÇ on 7.05.2019.
//  Copyright © 2019 M.Can KOÇ. All rights reserved.
//

import UIKit
// api anahtarı kullanımı için düzenlemeler
class FlickrHelper: NSObject {

    class func URLForSearchString (searchString:String) -> String {
        let apiKey:String = "78ae04b0cf8574c248630f8bc3e880f5"
        
        
        return       "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=2cb5cd49a3d1f65cbd76483c239d3557&format=rest&api_sig=6deaa9345e36863b3f9567835c39b351"
    }
}
