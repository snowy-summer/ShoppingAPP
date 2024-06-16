//
//  RecordListHeaderView.swift
//  ShoppingApp
//
//  Created by 최승범 on 6/15/24.
//

import UIKit
import SnapKit

protocol RecordListHeaderViewDelegate: AnyObject {
    
    func deleteListAll()
    
}

final class RecordListHeaderView: UIView {
    
    private let titleLabel = UILabel()
    private let allDeleteButton = UIButton()
    
    weak var delegate: RecordListHeaderViewDelegate?
    
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

//MARK: - Method

extension RecordListHeaderView {
    
    @objc private func deleteListAll() {
        delegate?.deleteListAll()
    }
}

//MARK: - Configuration

extension RecordListHeaderView {
    
    private func configureHierarchy() {
        
        addSubview(titleLabel)
        addSubview(allDeleteButton)
        
    }
    
    private func configureUI() {
        
        titleLabel.text = "최근 검색"
        titleLabel.font = FontType.boldTitle.font
        
        allDeleteButton.setTitle("전체 삭제",
                                 for: .normal)
    
        allDeleteButton.setTitleColor(.point,
                                      for: .normal)
        allDeleteButton.titleLabel?.font = FontType.body.font
        
    }
    
    private func configureGestureAndButtonActions() {
        
        allDeleteButton.addTarget(self,
                               action: #selector(deleteListAll),
                               for: .touchUpInside)
        
    }
    
    private func configureLayout() {
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.verticalEdges.equalToSuperview().inset(4)
        }
        
        allDeleteButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.verticalEdges.equalToSuperview().inset(4)
        }
    }
    
}


