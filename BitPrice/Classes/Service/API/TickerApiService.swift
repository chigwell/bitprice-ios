//
//  TickerApiService.swift
//  BitPrice
//
//  Created by Bruno Tortato Furtado on 27/01/18.
//  Copyright © 2018 Bruno Tortato Furtado. All rights reserved.
//

import Alamofire
import Foundation

class TickerApiService: ApiService {

    // MARK: - Public

    func get(success: @escaping (Data) -> Void,
             failure: @escaping (ServiceFailureType) -> Void) {

        _ = self.sessionManager.request(TickerApiRouter.get())
            .validate(statusCode: [200])
            .responseJSON { response in
                guard let data = response.data else {
                    failure(.connection)
                    return
                }

                if let error = response.error {
                    if error as? AFError == nil {
                        failure(.connection)
                    } else {
                        failure(.server)
                    }
                    return
                }

                success(data)
        }
    }

}
