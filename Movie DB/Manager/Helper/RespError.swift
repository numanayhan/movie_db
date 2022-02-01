//
//  CustomError.swift
//  Movie DB
//
//  Created by Numan Ayhan on 1.02.2022.
//

import Foundation

enum RespError: String,Error {
    case genericError = "Something went wrong"
    case incalidUrl = "incalid"
    case invalidData = "invalid"
    case authorize = "Unable to authenticate user. An error occurred during authorization, please check your connection and try again."
    case unavailableServer = "Server is unavailable"
    case tokenError = "Token Error"
    case networkError  = "Network Error"
    case domainError   = "Domain Error"
    case unknownError = "Unknown Error"
    case authFailed = "Auth Failed"
    case connectivity = "Connectivity Failed"
    case badURL = "Bad URL"
}

