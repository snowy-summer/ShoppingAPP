//
//  RecordListTableViewCell.swift
//  ShoppingApp
//
//  Created by 최승범 on 6/14/24.
//

import Foundation

import UIKit
import SnapKit

protocol RecordListTableViewCellDelegate: AnyObject {
    
    func deleteList(at index: IndexPath)
    
}

final class RecordListTableViewCell: UITableViewCell {
    
    private let recordIconImageView = UIImageView()
    private let nameLabel = UILabel()
    private let deleteButton = UIButton()
    weak var delegate: RecordListTableViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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

extension RecordListTableViewCell {
    
    func getIndexPath() -> IndexPath? {
        guard let tableView = self.superview as? UITableView else {
            return nil
        }
        
        return tableView.indexPath(for: self)
    }

    func updateContent(text: String) {
        nameLabel.text = text
    }
    
    @objc private func deleteList() {
        
        guard let indexPath = getIndexPath() else { return }
        
        delegate?.deleteList(at: indexPath)
    }
}

//MARK: - Configuration

extension RecordListTableViewCell {
    
    private func configureHierarchy() {
        
        contentView.addSubview(recordIconImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(deleteButton)
    }
    
    private func configureUI() {
        
        recordIconImageView.image = UIImage(systemName: IconType.searchRecordIcon.iconString)
        recordIconImageView.tintColor = .title
        
        deleteButton.titleLabel?.text = .none
        deleteButton.setImage(UIImage(systemName: IconType.deleteIcon.iconString), for: .normal)
        deleteButton.tintColor = .title
    }
    
    private func configureGestureAndButtonActions() {
        
        deleteButton.addTarget(self,
                               action: #selector(deleteList),
                               for: .touchUpInside)
        
    }
    
    private func configureLayout() {
        
        recordIconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(recordIconImageView.snp.width)
            make.centerY.equalToSuperview()
            
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(recordIconImageView.snp.trailing).offset(20)
            make.verticalEdges.equalToSuperview()
        }
        
        deleteButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.verticalEdges.equalToSuperview()
        }
    }
}
