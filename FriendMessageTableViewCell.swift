//
//  MsgTableViewCell.swift
//  WA8_11
//
//  Created by 李凱鈞 on 11/16/23.
//

import UIKit

class FriendMessagesTableViewCell: UITableViewCell {
    
    var messageLabel: UILabel!
    var wrapperCellView: UIView!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupWrapperCellView()
        setupMessageLabel()
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupWrapperCellView() {
        wrapperCellView = UIView()
        wrapperCellView.backgroundColor = .white
        wrapperCellView.layer.cornerRadius = 6.0
        wrapperCellView.layer.shadowColor = UIColor.gray.cgColor
        wrapperCellView.layer.shadowOffset = .zero
        wrapperCellView.layer.shadowRadius = 4.0
        wrapperCellView.layer.shadowOpacity = 0.4
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(wrapperCellView)
    }
    
    func setupMessageLabel() {
        messageLabel = UILabel()
        messageLabel.font = UIFont.systemFont(ofSize: 16)
        messageLabel.numberOfLines = 0 // Allows multiple lines
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.textAlignment = .left
        wrapperCellView.addSubview(messageLabel)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            wrapperCellView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            wrapperCellView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            wrapperCellView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            messageLabel.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 16),
            messageLabel.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -16),
            messageLabel.bottomAnchor.constraint(equalTo: wrapperCellView.bottomAnchor, constant: -8)
        ])
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
