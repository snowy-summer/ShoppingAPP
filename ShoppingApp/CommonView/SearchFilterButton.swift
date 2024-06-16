//
//  SearchFilterButton.swift
//  ShoppingApp
//
//  Created by 최승범 on 6/15/24.
//

import UIKit

final class SearchFilterButton: UIButton {
    var filterType: SearchFilter
    
    init(state: SearchFilterButtonState,
         filterType: SearchFilter) {
        self.filterType = filterType
        super.init(frame: .zero)
        
        updateContent(state: state)

        layer.borderWidth = 1
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = bounds.height / 2
        layer.masksToBounds = true
    }
    
    func updateContent(state: SearchFilterButtonState) {
      
        var buttonConfiguration = UIButton.Configuration.filled()
        
        var titleContainer = AttributeContainer()
        titleContainer.font = FontType.normaltitle.font
        titleContainer.foregroundColor = state.titleColor
        
        buttonConfiguration.attributedTitle = AttributedString(filterType.title,
                                                               attributes: titleContainer)
        
        configuration = buttonConfiguration
        tintColor = state.backgroundColor
        layer.borderColor = state.borderColor.cgColor
    }
}
