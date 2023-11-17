//
//  MassagesTableViewCell.swift
//  WA8_11
//
//  Created by Yu Zou on 11/13/23.
//

import UIKit

class MassagesTableViewCell: UITableViewCell {
        
    var wrapperCellView: UIView!
    var labelName: UILabel!
//    var labelTextMessages: UILabel!
//    var labelDate: UILabel!
//    var labelTime: UILabel!
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
            
        setupWrapperCellView()
        setupLabelName()
//        setupLabelTextMessages()
//        setupLabelDate()
//        setupLableTime()
            
        initConstraints()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupWrapperCellView(){
        wrapperCellView = UITableViewCell()
        
        //working with the shadows and colors...
        wrapperCellView.backgroundColor = .white
        wrapperCellView.layer.cornerRadius = 6.0
        wrapperCellView.layer.shadowColor = UIColor.gray.cgColor
        wrapperCellView.layer.shadowOffset = .zero
        wrapperCellView.layer.shadowRadius = 4.0
        wrapperCellView.layer.shadowOpacity = 0.4
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(wrapperCellView)
    }
    
    func setupLabelName(){
        labelName = UILabel()
        labelName.font = UIFont.boldSystemFont(ofSize: 20)
        labelName.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelName)
    }
    
//    func setupLabelTextMessages(){
//        labelTextMessages = UILabel()
//        labelTextMessages.font = UIFont.boldSystemFont(ofSize: 14)
//        labelTextMessages.translatesAutoresizingMaskIntoConstraints = false
//        wrapperCellView.addSubview(labelTextMessages)
//    }
//    
//    func setupLabelDate(){
//        labelDate = UILabel()
//        labelDate.font = UIFont.boldSystemFont(ofSize: 14)
//        labelDate.translatesAutoresizingMaskIntoConstraints = false
//        wrapperCellView.addSubview(labelDate)
//    }
//    
//    func setupLableTime(){
//        labelTime = UILabel()
//        labelTime.font = UIFont.boldSystemFont(ofSize: 14)
//        labelTime.translatesAutoresizingMaskIntoConstraints = false
//        wrapperCellView.addSubview(labelTime)
//    }
    
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor,constant: 10),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            labelName.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 8),
            labelName.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 16),
            labelName.heightAnchor.constraint(equalToConstant: 20),
            labelName.widthAnchor.constraint(lessThanOrEqualTo: wrapperCellView.widthAnchor),
            
//            labelDate.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 8),
//            labelDate.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 20),
//            labelDate.heightAnchor.constraint(equalToConstant: 20),
//            labelDate.widthAnchor.constraint(lessThanOrEqualTo: wrapperCellView.widthAnchor),
//            
//            labelTime.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 8),
//            labelTime.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 26),
//            labelTime.heightAnchor.constraint(equalToConstant: 20),
//            labelTime.widthAnchor.constraint(lessThanOrEqualTo: wrapperCellView.widthAnchor),
//            
//            labelTextMessages.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 2),
//            labelTextMessages.leadingAnchor.constraint(equalTo: labelName.leadingAnchor),
//            labelTextMessages.heightAnchor.constraint(equalToConstant: 16),
//            labelTextMessages.widthAnchor.constraint(lessThanOrEqualTo: labelName.widthAnchor),
            
            
            wrapperCellView.heightAnchor.constraint(equalToConstant: 72)
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

        
        
        
        

        
