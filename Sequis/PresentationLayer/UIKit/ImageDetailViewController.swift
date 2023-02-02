//
//  ImageDetailViewController.swift
//  Sequis
//
//  Created by Muhammad Syafrizal on 02/02/23.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import SDWebImage

class ImageDetailViewController: UIViewController {
    private var vwContainer: UIView?
    private var ivContent: UIImageView?
    private var tvComment: UITableView?
    
    private var data: Domain.ImageEntity
    
     init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, data: Domain.ImageEntity) {
        self.data = data
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initDesign()
        initViews()
    }
    
    @objc func addComment(){
         print("clicked")
    }
}

// MARK: UIBUILDER
private extension ImageDetailViewController {
    func initDesign() {
        setupBaseView()
        let vwContainer = generateContainerView()
        let ivContent = generateContentImageView()
        let tvComment = generateTableView()

        view.addSubview(vwContainer)
        vwContainer.addSubview(ivContent)
        vwContainer.addSubview(tvComment)
        
        vwContainer.snp.makeConstraints { (make: ConstraintMaker) -> Void in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
        
        ivContent.snp.makeConstraints { (make: ConstraintMaker) -> Void in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(300)
        }
        
        tvComment.snp.makeConstraints { (make: ConstraintMaker) -> Void in
            make.top.equalTo(ivContent.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview()
        }

        self.ivContent = ivContent
        self.tvComment = tvComment
    }

    func setupBaseView() {
        view.backgroundColor = .white
        self.navigationItem.title = "Image Detail"
    }

    func generateContainerView() -> UIView {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func generateContentImageView() -> UIImageView {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.sd_imageIndicator = SDWebImageActivityIndicator.gray
        if let url = URL(string: data.downloadURL) {
            view.sd_setImage(with: url)
        }
        return view
    }

    func generateTableView() -> UITableView {
        let view = UITableView(frame: .zero,style: .plain)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}

private extension ImageDetailViewController {
    func initViews() {
        initNavigationRightButton()
        initTableView()
    }
    
    func initNavigationRightButton() {
        let addComment = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: Selector("addComment"))
        self.navigationItem.rightBarButtonItem = addComment
    }
    
    func initTableView() {
        tvComment?.register(
            CommentTableCell.self,
                forCellReuseIdentifier: CommentTableCell.identifier
        )
        self.tvComment?.delegate = self
        self.tvComment?.dataSource = self
        tvComment?.rowHeight = UITableView.automaticDimension
        tvComment?.estimatedRowHeight = 600
    }
}

// MARK: TABLE DELEGATE
extension ImageDetailViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        100
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: CommentTableCell.identifier, for: indexPath
        ) as? CommentTableCell else {
            print(88)
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                // delete your item here and reload table view
                print("deleted")
            }
    }
}

