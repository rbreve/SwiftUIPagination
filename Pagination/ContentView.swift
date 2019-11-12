//
//  ContentView.swift
//  Pagination
//
//  Created by Roberto Breve  on 12.11.2019.
//  Copyright © 2019 Roberto Breve . All rights reserved.
//

import SwiftUI

struct PageData : Identifiable {
    var id = UUID()
    var imageName : String
    var imageTitle : String
}

struct ContentView: View {
    
    let pages = [PageData(imageName: "photo1", imageTitle: "Helsinki"), PageData(imageName: "photo2", imageTitle: "Boats"), PageData(imageName: "photo3", imageTitle: "River Dock")]
    
    var body: some View {
        PaginationView(pages: pages) { page in
            Page(imageName: page.imageName, imageTitle: page.imageTitle)
        }
    }
}

 
