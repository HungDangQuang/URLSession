//
//  Post.swift
//  URLSession
//
//  Created by QUANG HUNG on 07/Dec/2021.
//

import Foundation

struct Post: Codable {
    let _id: String
    let title: String
    let description: String
    let username: String
    let createdDate: String
    let createdAt: String
    let updatedAt: String
    let __v: Int
}

struct Posts: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
    
}
