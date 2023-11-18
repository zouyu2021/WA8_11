//
//  SelfMessagesTableViewCell.swift
//  WA8_11
//
//  Created by 李凱鈞 on 11/16/23.
//

import UIKit

class SelfMessagesTableViewCell: UITableViewCell {
    
    var labelDateTime:   UILabel!
    var labelSender:     UILabel!
    var wrapperCellView: UIView!
    var labelMessage:    UILabel!

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLabelDateTime()
        setupLabelSender()
        setupWrapperCellView()
        setupLabelMessage()
      
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLabelDateTime() {
        labelDateTime = UILabel()
        labelDateTime.font = UIFont.systemFont(ofSize: 10)
        labelDateTime.translatesAutoresizingMaskIntoConstraints = false
        addSubview(labelDateTime)
    }
    
    func setupLabelSender() {
        labelSender = UILabel()
        labelSender.font = UIFont.systemFont(ofSize: 20)
        labelSender.translatesAutoresizingMaskIntoConstraints = false
        labelSender.textAlignment = .right
        addSubview(labelSender)
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
    
    func setupLabelMessage() {
        labelMessage = UILabel()
        labelMessage.font = UIFont.systemFont(ofSize: 16)
        labelMessage.numberOfLines = 0 // Allows multiple lines
        labelMessage.lineBreakMode = .byWordWrapping
        labelMessage.sizeToFit()
        labelMessage.translatesAutoresizingMaskIntoConstraints = false
        labelMessage.textAlignment = .left
        wrapperCellView.addSubview(labelMessage)
    }
   
    func initConstraints() {
        NSLayoutConstraint.activate([
            labelDateTime.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            labelDateTime.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            labelDateTime.heightAnchor.constraint(equalToConstant: 24),
            
            labelSender.topAnchor.constraint(equalTo: labelDateTime.bottomAnchor, constant: 0),
            labelSender.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -8),
            labelSender.heightAnchor.constraint(equalToConstant: 20),
            
            wrapperCellView.topAnchor.constraint(equalTo: labelSender.bottomAnchor, constant: 6),
            wrapperCellView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            wrapperCellView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            // Set maximum width to 3/4 of the screen width
            wrapperCellView.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, multiplier: 3/4),

            labelMessage.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 8),
            labelMessage.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 16),
            labelMessage.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -16),
            labelMessage.bottomAnchor.constraint(equalTo: wrapperCellView.bottomAnchor, constant: -8),
        ])
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

