//
//  CommentTableCell.swift
//  Sequis
//
//  Created by Muhammad Syafrizal on 02/02/23.
//

import Foundation
import UIKit
import SnapKit

class CommentTableCell: UITableViewCell {
    public static let identifier: String = "CommentTableCell"
    private var vwContainer: UIView?
    private var vwAvatar: UIView?
    private var lbName: UILabel?
    private var lbComment: UILabel?
    private var lbDate: UILabel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initDesign()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initDesign()
    }
}

// MARK: UIKIT
private extension CommentTableCell {
    func initDesign() {
        setupBaseView()
        let vwContainer = generateContainer()
        let vwAvatar = generateAvatar()
        let lbName = generateLabel(ofSize: 16, weight: .bold)
        let lbComment = generateLabel(ofSize: 12, weight: .regular)
        let lbDate = generateLabel(ofSize: 8, weight: .thin)
        
        contentView.addSubview(vwContainer)
        vwContainer.addSubview(vwAvatar)
        vwContainer.addSubview(lbName)
        vwContainer.addSubview(lbComment)
        vwContainer.addSubview(lbDate)
        
        vwContainer.snp.makeConstraints { (make: ConstraintMaker) -> Void in
            make.edges.equalToSuperview()
        }
        
        vwAvatar.snp.makeConstraints { (make: ConstraintMaker) -> Void in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
        
        lbName.snp.makeConstraints { (make: ConstraintMaker) -> Void in
            make.top.equalTo(vwAvatar)
            make.leading.equalTo(vwAvatar.snp.trailing).offset(8)
            make.trailing.lessThanOrEqualToSuperview()
        }
        
        lbComment.snp.makeConstraints { (make: ConstraintMaker) -> Void in
            make.top.equalTo(lbName.snp.bottom).offset(4)
            make.leading.equalTo(lbName)
            make.trailing.lessThanOrEqualToSuperview()
        }
        
        lbDate.snp.makeConstraints { (make: ConstraintMaker) -> Void in
            make.top.equalTo(lbComment.snp.bottom).offset(4)
            make.leading.equalTo(lbName)
            make.trailing.lessThanOrEqualToSuperview()
            make.bottom.equalToSuperview().offset(-8)
        }
    }
    
    func setupBaseView() {
        self.contentView.backgroundColor = .clear
    }
    
    func generateContainer() -> UIView {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func generateAvatar() -> UIView {
        let view = UIView(frame: .zero)
        view.layer.cornerRadius = 25;

//        let label = UILabel(frame: CGRect(x: 0, y: (50 - 20) / 2, width: 50, height: 20))
//        label.textAlignment = .center
//        label.text = "PG";
//
//        view.addSubview(label)
        view.backgroundColor = .gray
        return view
    }
    
    func generateLabel(ofSize fontSize: CGFloat, weight: UIFont.Weight) -> UILabel {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
        view.textColor = .black
        view.numberOfLines = 0
        view.textAlignment = .left
        view.text = "test testtesttesttesttesttesttesttesttest \n testtesttesttesttesttesttest"
        return view
    }
}
