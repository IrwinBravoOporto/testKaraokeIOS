//
//  TimberjackHelper.swift
//  Data
//
//  Created by HAROL GOMEZ RUIZ on 22/11/17.
//  Copyright © 2017 HAROL GOMEZ RUIZ. All rights reserved.
//

import Foundation


let TimberjackRequestHandledKey = "Timberjack"
let TimberjackRequestTimeKey = "TimberjackRequestTime"

public enum Style {
    case verbose
    case light
}



open class TimberjackHelper: URLProtocol {
    var connection: NSURLConnection?
    var data: NSMutableData?
    var response: URLResponse?
    var newRequest: NSMutableURLRequest?
    public static var logStyle: Style = .verbose
    
    open class func register() {
        URLProtocol.registerClass(self)
    }
    
    open class func unregister() {
        URLProtocol.unregisterClass(self)
    }
    
    open class func defaultSessionConfiguration() -> URLSessionConfiguration {
        let config = URLSessionConfiguration.default
        config.protocolClasses?.insert(TimberjackHelper.self, at: 0)
        return config
    }
    
    //MARK: - NSURLProtocol
    
    open override class func canInit(with request: URLRequest) -> Bool {
        guard self.property(forKey: TimberjackRequestHandledKey, in: request) == nil else {
            return false
        }
        return true
    }
    
    open override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    open override class func requestIsCacheEquivalent(_ a: URLRequest, to b: URLRequest) -> Bool {
        return super.requestIsCacheEquivalent(a, to: b)
    }
    
    open override func startLoading() {
        guard let req = (request as NSURLRequest).mutableCopy() as? NSMutableURLRequest , newRequest == nil else { return }
        
        self.newRequest = req
        
        TimberjackHelper.setProperty(true, forKey: TimberjackRequestHandledKey, in: newRequest!)
        TimberjackHelper.setProperty(Date(), forKey: TimberjackRequestTimeKey, in: newRequest!)
        connection = NSURLConnection(request: newRequest! as URLRequest, delegate: self)
        
    }
    
    open override func stopLoading() {
        connection?.cancel()
        connection = nil
    }
    
    // MARK: NSURLConnectionDelegate
    
    func connection(_ connection: NSURLConnection!, didReceiveResponse response: URLResponse!) {
        let policy = URLCache.StoragePolicy(rawValue: request.cachePolicy.rawValue) ?? .notAllowed
        client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: policy)
        
        self.response = response
        self.data = NSMutableData()
    }
    
    func connection(_ connection: NSURLConnection!, didReceiveData data: Data!) {
        client?.urlProtocol(self, didLoad: data)
        self.data?.append(data)
    }
    
    func connectionDidFinishLoading(_ connection: NSURLConnection!) {
        client?.urlProtocolDidFinishLoading(self)
        
        if let response = response {
            logResponse(response, data: data as Data?)
        }
    }
    
    func connection(_ connection: NSURLConnection!, didFailWithError error: NSError!) {
        client?.urlProtocol(self, didFailWithError: error)
        logError(error)
    }
    
    //MARK: - Logging
    
    class func logDivider() {
        print("---------------------")
        TimberjackHelper.debugPrint(s: "---------------------")
    }
    
    open func logError(_ error: NSError) {
        TimberjackHelper.logDivider()
        print("Error: \(error.localizedDescription)")
        TimberjackHelper.debugPrint(s: "Error: \(error.localizedDescription)")
        
        if TimberjackHelper.logStyle == .verbose {
            if let reason = error.localizedFailureReason {
                print("Reason: \(reason)")
                TimberjackHelper.debugPrint(s: "Reason: \(reason)")
            }
            
            if let suggestion = error.localizedRecoverySuggestion {
                print("Suggestion: \(suggestion)")
                TimberjackHelper.debugPrint(s: "Suggestion: \(suggestion)")
            }
        }
        
    }
    
    class open func logRequest(_ request: URLRequest) {
         TimberjackHelper.logDivider()
        
        if let url = request.url?.absoluteString {
            print("Request: \(request.httpMethod!) \(url)")
            TimberjackHelper.debugPrint(s: "Request: \(request.httpMethod!) \(url)")
        }
        
        if TimberjackHelper.logStyle == .verbose {
            if let headers = request.allHTTPHeaderFields {
                self.logHeaders(headers as [String : AnyObject])
            }
        }
    }
    
    
    open func logResponse(_ response: URLResponse, data: Data? = nil) {
        TimberjackHelper.logDivider()
        
        if let url = response.url?.absoluteString {
            print("Response: \(url)")
            TimberjackHelper.debugPrint(s: "Response: \(url)")
        }
        
        if let httpResponse = response as? HTTPURLResponse {
            let localisedStatus = HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode).capitalized
            print("Status: \(httpResponse.statusCode) - \(localisedStatus)")
            TimberjackHelper.debugPrint(s: "Status: \(httpResponse.statusCode) - \(localisedStatus)")
        }
        
        if TimberjackHelper.logStyle == .verbose {
            if let headers = (response as? HTTPURLResponse)?.allHeaderFields as? [String: AnyObject] {
                TimberjackHelper.logHeaders(headers)
            }
            
            if let startDate = TimberjackHelper.property(forKey: TimberjackRequestTimeKey, in: newRequest! as URLRequest) as? Date {
                let difference = fabs(startDate.timeIntervalSinceNow)
                print("Duration: \(difference)s")
                TimberjackHelper.debugPrint(s: "Duration: \(difference)s")
            }
            
            guard let data = data else { return }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                let pretty = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                
                if let string = NSString(data: pretty, encoding: String.Encoding.utf8.rawValue) {
                    print("JSON: \(string)")
                    TimberjackHelper.debugPrint(s: "JSON: \(string)")
                }
            }
                
            catch {
                if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                    print("Data: \(string)")
                    TimberjackHelper.debugPrint(s: "Data: \(string)")
                }
            }
        }
        
    }
    
    class func logHeaders(_ headers: [String: AnyObject]) {
        print("Headers: [")
        TimberjackHelper.debugPrint(s: "Headers: [")
        for (key, value) in headers {
            print("  \(key) : \(value)")
        TimberjackHelper.debugPrint(s: "\(key) : \(value)")
        }
    }
    
    class func logBody(_newRequest:URLRequest){
        
        DispatchQueue.global(qos: .background).async {
            
            TimberjackHelper.logRequest(_newRequest)
            print("====================")
            TimberjackHelper.debugPrint(s:"====================")
            print("BODY")
            TimberjackHelper.debugPrint(s:"BODY")
            
            if(_newRequest.httpBody != nil){
                let body = String(data: (_newRequest.httpBody)!, encoding:String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
                print(body)
                TimberjackHelper.debugPrint(s: body)
            }
        }
    }
    
   public class func debugPrint(s:String) {
        
        var paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let dateString = formatter.string(from: Date())
        let fileName = "\(dateString).log"
        let logFilePath = (documentsDirectory as NSString).appendingPathComponent(fileName)
        var dump = ""
        if FileManager.default.fileExists(atPath: logFilePath) {
            dump =  try! String(contentsOfFile: logFilePath, encoding: String.Encoding.utf8)
        }
        do {
            // Write to the file
            try  "\(dump)\n\(Date()):\(s)".write(toFile: logFilePath, atomically: true, encoding: String.Encoding.utf8)
            
        } catch let error as NSError {
            print("Failed writing to log file: \(logFilePath), Error: " + error.localizedDescription)
        }
    }
    
}
