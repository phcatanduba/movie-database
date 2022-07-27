//
//  UILabel.swift
//  Movie-Database
//
//  Created by Pedro Henrique Catanduba de Andrade on 27/07/22.
//

import Foundation
import UIKit

extension UILabel {
    var fullHeight: CGFloat {
        guard let labelText = text else { return 0 }

        let labelTextSize = (labelText as NSString).boundingRect(
            with: CGSize(width: frame.size.width, height: .infinity),
                  options: .usesLineFragmentOrigin,
                  attributes: [.font: font as Any],
                  context: nil).size

        return labelTextSize.height
    }
    
    var isTruncated: Bool {
        return fullHeight > bounds.size.height
    }
}
