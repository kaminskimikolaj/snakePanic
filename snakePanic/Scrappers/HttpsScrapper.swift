//
//  Scrapper2.swift
//  sip2po
//
//  Created by Mikołaj Kamiński on 20/09/2019.
//  Copyright © 2019 Mikołaj Kamiński. All rights reserved.
//

import UIKit
import hpple
import SwiftSoup

class HttpsScrapper {
    
    enum NetworkError: Error {
        case credentaialsNotValid
        case htmlParsing
        case invalidURL
        case transmition
        case dataParsing
        case responseCastingError
        case unknownThrow1
        case unknownStringPattern(content: String)
    }
    
    let semaphore = DispatchSemaphore(value: 0)
    
    func login(user: String, pass: String, handler: @escaping (Result<(String, String), NetworkError>) -> Void) throws {
        let md5Data = Crypto().hex(string: pass)
        let md5Hex =  md5Data.map { String(format: "%02hhx", $0) }.joined()
        let headers = [ "Content-Type": "application/x-www-form-urlencoded", "Cookie": "sid=;" ]
        let stringData = "action=set&user=\(user)&pass_md5=\(md5Hex)&url_back="
        guard let data = stringData.data(using: .utf8) else { throw NetworkError.dataParsing }
        let postData = NSMutableData(data: data)
        guard let url = URL(string: "https://nasze.miasto.gdynia.pl/ed_miej/login.pl") else { throw NetworkError.invalidURL }
        let request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data
        var sid: String?
        URLSession.shared.dataTask(with: request as URLRequest) { _, response, error in
            guard error == nil else { handler(.failure(.transmition)); return }
            guard let httpResponse = response as? HTTPURLResponse else { handler(.failure(.responseCastingError)); return }
            print(httpResponse.statusCode)
            if let cookie = HTTPCookieStorage.shared.cookies?.first(where: { $0.name == "sid" }) { sid = cookie.value }
            else {  handler(.failure(.transmition)); return }
            self.semaphore.signal()
        }.resume()
        semaphore.wait()

        guard sid != nil, let redirectUrl = URL(string: "https://nasze.miasto.gdynia.pl/ed_miej/login_check.pl?sid=\(sid!))&url_back=") else { throw NetworkError.invalidURL }
        URLSession.shared.dataTask(with: redirectUrl) { data, response, error in
            guard error == nil else { handler(.failure(.transmition)); return }
            guard let httpResponse = response as? HTTPURLResponse else { handler(.failure(.responseCastingError)); return }
            print(httpResponse.statusCode)
            guard data != nil, let stringData = String(bytes: data!, encoding: .utf8) else { handler(.failure(.dataParsing)); return }
            do {
                let doc: Document = try SwiftSoup.parse(stringData)
                let info: Elements = try doc.select("#userInfo")
                let infoString = try info.text()
                switch infoString.count > 0 {
                case true:
                    let nameStart = infoString.index(infoString.startIndex, offsetBy: 66)
                    let nameEnd = infoString.index(infoString.endIndex, offsetBy: -8)
                    let nameRange = nameStart..<nameEnd
                    let name = String(infoString[nameRange])
                    let lastUpdateStart = infoString.index(infoString.startIndex, offsetBy: 26)
                    let lastUpdateEnd = infoString.index(infoString.startIndex, offsetBy: 45)
                    let lastUpdateRange = lastUpdateStart..<lastUpdateEnd
                    let lastUpdate = String(infoString[lastUpdateRange])
                    handler(.success((name, lastUpdate)))
                case false:
                    handler(.failure(.credentaialsNotValid))
                    return
                }
            } catch {
                handler(.failure(.unknownThrow1))
                return
            }
        }.resume()
    }
    
    func scrapLessonsSchedule(handler: @escaping (Result<ScheduleWeek, NetworkError>) -> Void) throws {
        guard let url = URL(string: "https://nasze.miasto.gdynia.pl/ed_miej/action_plan_zajec.pl") else { throw NetworkError.invalidURL }
        var src: String?
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else { handler(.failure(.transmition)); return }
            guard let httpResponse = response as? HTTPURLResponse else { handler(.failure(.responseCastingError)); return }
            print(httpResponse.statusCode)
            guard let responseData = data else { handler(.failure(.dataParsing)); return }
            let doc = TFHpple(htmlData: responseData)
            if let elements = doc?.search(withXPathQuery: "//iframe") as? [TFHppleElement] {
                for element in elements { src = element.attributes["src"] as? String }
                self.semaphore.signal()
            } else { handler(.failure(.dataParsing)) }
        }.resume()
        semaphore.wait()
        
        guard src != nil, let urlRedirect = URL(string: "https://nasze.miasto.gdynia.pl/ed_miej/\(src!)") else { throw NetworkError.invalidURL }
        URLSession.shared.dataTask(with: urlRedirect) { data, response, error in
            guard error == nil else { handler(.failure(.transmition)); return }
            guard let httpResponse = response as? HTTPURLResponse else { handler(.failure(.responseCastingError)); return }
            print(httpResponse.statusCode)
            guard data != nil, let responseString = String(bytes: data!, encoding: .utf8) else { handler(.failure(.dataParsing)); return }
            do { handler(.success(try HtmlScrapper().parseLessonsSchedule(html: responseString))) }
            catch let error { handler(.failure(error as! NetworkError)) }
        }.resume()
    }
}
