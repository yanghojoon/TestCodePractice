//
//  NetworkManager.swift
//  TestCode
//
//  Created by 양호준 on 2024/02/26.
//

import Foundation

final class NetworkManager {
    private let urlSession: URLSessionProtocol
    
    init(urlSession: URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }

    func fetchData<T: Decodable>(
        url: URL,
        decodingType: T.Type,
        completionHandler: @escaping((Result<T, Error>) -> ())
    ) {
        let request = URLRequest(url: url)
        let task = urlSession.dataTask(with: request) { data, response, error in
            let successStatusCode = 200..<300
            guard
                let httpResponse = response as? HTTPURLResponse,
                successStatusCode.contains(httpResponse.statusCode)
            else {
                if let error {
                    completionHandler(.failure(error))
                } else {
                    let statusCodeError = NSError(
                        domain: "Network",
                        code: 0,
                        userInfo: [NSLocalizedDescriptionKey: "StatusCode Error"]
                    )
                    completionHandler(.failure(statusCodeError))
                }
                return
            }
            
            if let error {
                completionHandler(.failure(error))
            }
            
            if let data {
                let decodedData: T
                do {
                    decodedData = try JSONDecoder().decode(T.self, from: data)
                    
                    completionHandler(.success(decodedData))
                } catch {
                    let decodingError = NSError(
                        domain: "Decoding",
                        code: 0,
                        userInfo: [NSLocalizedDescriptionKey: "Decoding Error"]
                    )
                    completionHandler(.failure(decodingError))
                }
            }
        }
        
        task.resume()
    }
}
