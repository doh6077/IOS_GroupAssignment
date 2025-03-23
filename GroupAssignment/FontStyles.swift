//
//  FontStyles.swift
//  GroupAssignment
//
//  Created by Dohee Kim on 2025-03-23.
//

import Foundation
import SwiftUI

extension Font {
    
    
    static var text: Font {
        
        return Font.custom("GeneralSans-Medium", size:16)
    }
    static var navTitle: Font {
        
        return Font.custom("GeneralSans-Medium", size:20)
    }

    static var sideText: Font {
        
        return Font.custom("GeneralSans-Regular", size:16)
    }
}
