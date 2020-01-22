//
//  URLCreator.swift
//  RESTfulApp
//
//  Created by Ciaran Corrigan on 16/01/2020.
//  Copyright © 2020 Ciaran Corrigan. All rights reserved.
//

import Foundation

class URLCreator {
    
    func createURL(id : String) -> String {
        
        var serverAddress : String
        var params : String
        var applicationName : String
        
        serverAddress = "a1ecf0f1.ngrok.io"
        params = "Customer/\(id)"
        applicationName = "RestService"
        
        let url : String = "https://\(serverAddress)/RestfulJade/jadehttp.dll/\(params)/?\(applicationName)"
        
        return url
    }
    
}
