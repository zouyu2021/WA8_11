//
//  SelfMessagesTableViewCell.swift
//  WA8_11
//
//  Created by 李凱鈞 on 11/16/23.
//

import UIKit

class SelfMessagesTableViewCell: UITableViewCell {
    
    var labelSender:     UILabel!
    var labelDateTime:   UILabel!
    var labelMessage:    UILabel!
    var wrapperCellView: UIView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupWrapperCellView()
        setupLabelSender()
        setupLabelDateTime()
        setupLabelMessage()
        
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
        wrapperCellView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        addSubview(wrapperCellView)
    }
    
    func setupLabelSender() {
        labelSender = UILabel()
        labelSender.font = UIFont.systemFont(ofSize: 20)
        labelSender.translatesAutoresizingMaskIntoConstraints = false
        labelSender.textAlignment = .right
        wrapperCellView.addSubview(labelSender)
    }
    
    func setupLabelDateTime() {
        labelDateTime = UILabel()
        labelDateTime.font = UIFont.systemFont(ofSize: 10)
        labelDateTime.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelDateTime)
    }
    
    func setupLabelMessage() {
        labelMessage = UILabel()
        labelMessage.font = UIFont.systemFont(ofSize: 16)
        labelMessage.numberOfLines = 0 // Allows multiple lines
        labelMessage.translatesAutoresizingMaskIntoConstraints = false
        labelMessage.textAlignment = .right
        wrapperCellView.addSubview(labelMessage)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            wrapperCellView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            wrapperCellView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            wrapperCellView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            labelDateTime.topAnchor.constraint(equalTo: wrapperCellView.topAnchor),
            labelDateTime.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            labelDateTime.heightAnchor.constraint(equalToConstant: 20),
            
            labelSender.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 4),
            labelSender.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -16),
            labelSender.heightAnchor.constraint(equalToConstant: 20),

            labelMessage.topAnchor.constraint(equalTo: labelSender.bottomAnchor, constant: 8),
            labelMessage.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 16),
            labelMessage.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -16),
            labelMessage.bottomAnchor.constraint(equalTo: wrapperCellView.bottomAnchor, constant: -8)
        ])
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
