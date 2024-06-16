//
//  SearchResultHeaderView.swift
//  ShoppingApp
//
//  Created by 최승범 on 6/15/24.
//

import UIKit
import SnapKit

final class SearchResultHeaderView: UIView {
    
    private let searchResultCountLabel = UILabel()
    private let filterButtonStackView = UIStackView()
    private let simButton = SearchFilterButton(state: .selected,
                                               filterType: .sim)
    private let dateButton = SearchFilterButton(state: .notSelected,
                                                filterType: .date)
    private let ascButton = SearchFilterButton(state: .notSelected,
                                               filterType: .asc)
    private let dscButton = SearchFilterButton(state: .notSelected,
                                               filterType: .dsc)

    var viewModel: SearchViewModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureUI()
        configureGestureAndButtonActions()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchResultHeaderView {
    
    func updateContent(data: Int) {
        
        searchResultCountLabel.text = "\(data.formatted())개의 검색 결과"
        
    }
    
    @objc private func updateFilter(_ sender: SearchFilterButton) {
        
        filterButtonStackView.arrangedSubviews.forEach { view in
            guard let button = view as? SearchFilterButton else { return }
            if button.filterType != sender.filterType {
                button.updateContent(state: .notSelected)
            }
        }
        
        sender.updateContent(state: .selected)
        viewModel?.updateFiterType(type: sender.filterType)
    }
}

//MARK: - Configuration

extension SearchResultHeaderView {
    
    private func configureHierarchy() {
        
        addSubview(searchResultCountLabel)
        addSubview(filterButtonStackView)
        filterButtonStackView.addArrangedSubview(simButton) 
        filterButtonStackView.addArrangedSubview(dateButton)
        filterButtonStackView.addArrangedSubview(ascButton)
        filterButtonStackView.addArrangedSubview(dscButton)
        
    }
    
    private func configureUI() {
        
        searchResultCountLabel.font = FontType.body.font
        searchResultCountLabel.textColor = .point
        
        filterButtonStackView.spacing = 8
        filterButtonStackView.distribution = .fillProportionally
        
       
    }
    
    private func configureGestureAndButtonActions() {
        
        simButton.addTarget(self,
                             action: #selector(updateFilter),
                             for: .touchUpInside)
        dateButton.addTarget(self,
                             action: #selector(updateFilter),
                             for: .touchUpInside)
        ascButton.addTarget(self,
                             action: #selector(updateFilter),
                             for: .touchUpInside)
        dscButton.addTarget(self,
                             action: #selector(updateFilter),
                             for: .touchUpInside)
    }
    
    private func configureLayout() {
        
        searchResultCountLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.directionalHorizontalEdges.equalToSuperview()
        }
        
        filterButtonStackView.snp.makeConstraints { make in
            make.top.equalTo(searchResultCountLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview()
            make.width.equalTo(self.snp.width).multipliedBy(0.8)
            make.bottom.equalToSuperview()
        }
    }
    
}
