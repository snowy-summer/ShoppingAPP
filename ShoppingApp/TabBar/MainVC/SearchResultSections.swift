//
//  SearchResultSections.swift
//  ShoppingApp
//
//  Created by 최승범 on 6/15/24.
//

import UIKit

enum SearchResultSections: Int, CaseIterable {
    case filter
    case result
    
    var layoutSection: NSCollectionLayoutSection? {
        switch self {
        case .filter:
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(0.2),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
          
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                   heightDimension: .fractionalHeight(0.05))
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                           subitems: [item])
            
            group.interItemSpacing = .fixed(8)
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            section.contentInsets = NSDirectionalEdgeInsets(top: 4,
                                                            leading: 20,
                                                            bottom: 4,
                                                            trailing: 20)
            
            return section
            
        case .result:
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 4,
                                                          leading: 4,
                                                          bottom: 4,
                                                          trailing: 4)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .fractionalWidth(0.8))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                           subitems: [item, item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                            leading: 16,
                                                            bottom: 4,
                                                            trailing: 16)
            
            return section
        }
    }

}

enum SearchFilter: CaseIterable {
    case sim
    case date
    case asc
    case dsc
    
    var title: String {
        switch self {
        case .sim:
            return "정확도"
        case .date:
            return "날짜순"
        case .asc:
            return "가격높은순"
        case .dsc:
            return "가격낮은순"
        }
    }
}
