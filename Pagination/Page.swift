//
//  Page.swift
//  Pagination
//
//  Created by Roberto Breve  on 12.11.2019.
//  Copyright © 2019 Roberto Breve . All rights reserved.
//

import SwiftUI

struct Page: View {
    var imageName = "photo1"
    var imageTitle: String?
    
    var body: some View {
           GeometryReader { proxy in
                 VStack {
                    Image(self.imageName)
                         .resizable()
                         .frame(width: proxy.size.width)
                         .aspectRatio(contentMode: .fit)
                     
                    Text(self.imageTitle ?? "")
                         .fontWeight(.black)
                 }
        }
    }
}

struct Page_Previews: PreviewProvider {
    static var previews: some View {
        Page()
    }
}
