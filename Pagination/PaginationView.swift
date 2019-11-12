//
//  PaginationView.swift
//  3D Pagination Effect
//
//  Created by Roberto Breve  on 11.11.2019.
//  Copyright © 2019 Roberto Breve . All rights reserved.
//

import SwiftUI


struct PaginationView <Content, Pages> : View where Content: View, Pages: RandomAccessCollection, Pages.Element : Identifiable {
    var pages : Pages
    var content: (Pages.Element) -> Content
    
    @State private var translation: CGSize? = nil
    @State private var lastTranslation: CGFloat = 0
    @State private var angleTranslation: CGFloat = 0
    @State private var initPosition = CGFloat(0)
    @State private var shiftLeft = false
    @State private var shiftRight = false
    
    
    func getOffsets(size: CGFloat) -> [Pages.Element.ID: (position: CGFloat, rotation: CGFloat)] {
        var acumsize = CGFloat(0)
        var offsets = [Pages.Element.ID: (position: CGFloat, rotation: CGFloat)]()
        var angle = CGFloat(0)
        for page in pages {
            offsets[page.id] = (acumsize, angle)
            acumsize += size
            angle = CGFloat(-90)
        }
        return offsets
    }
    
    
    func isLeftSided(position: CGFloat, width: CGFloat) -> Bool{
        if (position < 0 && position > -width ) {
            return true
        }
        return false
    }
    
    func isRightSided(position: CGFloat, width: CGFloat) -> Bool{
        if (position > 0 && position < width) {
            return true
        }
        return false
    }
    
    func getRotation(position : CGFloat, width: CGFloat) -> Double {
        let pos = position + (self.translation?.width ?? 0)
        
        let sided = (self.translation?.width ?? 0) > CGFloat(0) ? -1 : 1
        if (sided > 0) {
            if(isLeftSided(position: pos, width: width)) {
                return Double((self.translation?.width ?? 0)/(width/90))
            }
            if(isRightSided(position: pos, width: width)) {
                return Double((self.translation?.width ?? 0)/(width/90)) + 90
            }
        }else{
            if(isLeftSided(position: pos, width: width)) {
                return Double((self.translation?.width ?? 0)/(width/90)) - 90
            }
            if(isRightSided(position: pos, width: width)) {
                return Double((self.translation?.width ?? 0)/(width/90))
            }
        }
        
        return 0
    }
    
    func getAnchor(position : CGFloat, width: CGFloat) -> UnitPoint {
        let pos = position + self.lastTranslation
        if(isLeftSided(position: pos, width: width)) {
            return .trailing
        } else {
            return .leading
        }
    }
    
    
    
    var body: some View {
        GeometryReader { geometry in
            self.bodyHelper(containerSize: geometry.size, offsets: self.getOffsets(size: geometry.size.width))
        }
    }
    
    private func bodyHelper(containerSize: CGSize, offsets: [Pages.Element.ID: (position: CGFloat, rotation: CGFloat)]) -> some View {
        ZStack {
            ForEach(self.pages){
                self.content($0).rotation3DEffect(.degrees(self.getRotation(position: (offsets[$0.id]?.position ?? 0) + self.initPosition, width: containerSize.width )), axis: (x: 0, y: 1, z: 0), anchor: self.getAnchor(position: (offsets[$0.id]?.position ?? 0) + self.initPosition, width: containerSize.width))
                    .offset(x: (offsets[$0.id]?.position ?? 0 ) + (self.translation?.width ?? 0) + self.initPosition )
                    .gesture(DragGesture()
                        .onChanged({ (value) in
                            self.translation = value.translation
                            self.lastTranslation = self.translation?.width ?? 0
                            
                            if(self.shiftLeft){
                                self.shiftLeft = false
                                self.initPosition -= containerSize.width
                            }
                            
                            if(self.shiftRight) {
                                self.shiftRight = false
                                self.initPosition += containerSize.width
                            }
                        })
                        .onEnded({ (value) in
                            self.lastTranslation = self.translation?.width ?? 0
                            withAnimation {
                                if(self.translation!.width > CGFloat(containerSize.width/2)) {
                                    
                                    if (self.initPosition < 0) {
                                        self.translation = CGSize(width: containerSize.width, height: 0)
                                        self.shiftRight = true
                                    }else {
                                        self.translation = .zero
                                    }
                                    
                                }
                                else
                                    if (self.translation!.width < CGFloat(-containerSize.width/2)) && (abs(self.initPosition) < containerSize.width*CGFloat(offsets.count-1)) {
                                        
                                        self.translation = CGSize(width: -containerSize.width, height: 0)
                                        self.shiftLeft=true
                                    }else{
                                        self.translation = .zero
                                }
                                
                            }
                        }))
            }
            
        }
    }
}

