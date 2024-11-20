//
//  BibleStudyModel.swift
//  GCCBibleStudies
//
//  Created by Christian Abbott on 11/19/24.
//

import Foundation

struct BibleStudy: Identifiable, Decodable {
    var id: UUID = UUID()
    var title: String
    var location: String
    var description: String
    var category: String
    var time: Date
    var day: String
}
