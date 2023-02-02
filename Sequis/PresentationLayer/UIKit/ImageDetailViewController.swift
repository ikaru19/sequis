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
    
    private var comments: [Domain.CommentEntity] = []
    private var viewModel: ImageDetailViewModel
    private var vmBag = DisposeBag()
    
    var data: Domain.ImageEntity?
    
     init(
        nibName nibNameOrNil: String?,
        bundle nibBundleOrNil: Bundle?,
        viewModel: ImageDetailViewModel
     ) {
        self.viewModel = viewModel
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        subscribeViewModel()
        fetchComments()
    }
    
    private func subscribeViewModel() {
        viewModel
                .errors
                .observeOn(MainScheduler.instance)
                .subscribe(
                        onNext: { [weak self] error in
                            guard let self = self else {
                                return
                            }
                            self.handleError(error)
                        }
                )
                .disposed(by: vmBag)
        viewModel
                .comment
                .observeOn(MainScheduler.instance)
                .subscribe(
                        onNext: { [weak self] comments in
                            guard let self = self else {
                                return
                            }
                            self.initComments(comments)
                        }
                )
                .disposed(by: vmBag)
    }
    
    @objc func addComment(){
        generateComment()
    }
}

// MARK: Function
private extension ImageDetailViewController {
    func initComments(_ comments: [Domain.CommentEntity]) {
        self.comments =  comments
        tvComment?.reloadData()
    }
    
    func generateComment() {
        guard let data = data else { return }
        let uuid = UUID().uuidString
        let comment = Domain.CommentEntity(
            id: uuid,
            firstName: viewModel.firstNameGenerator(),
            lastName: viewModel.lastNameGenerator(),
            comment: viewModel.commentGenerator(),
            contentId: data.id
        )
        insertComment(comment: comment)
    }
    func insertComment(comment: Domain.CommentEntity) {
        viewModel
            .insertComment(comment: comment)
            .subscribe(
                onCompleted: { [weak self]  in
                    self?.fetchComments()
                },
                onError: { [weak self] error in
                    self?.handleError(error)
                }
            )
    }
    
    func fetchComments() {
        if let contentId = data?.id {
            viewModel.getComment(byContentId: contentId)
            tvComment?.reloadData()
        }
    }
    
    func deleteComment(byId: String) {
        viewModel
            .deleteComment(byId: byId)
            .subscribe(
                onCompleted: { [weak self]  in
                    self?.fetchComments()
                },
                onError: { [weak self] error in
                    self?.handleError(error)
                }
            )
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
        if let url = URL(string: data?.downloadURL ?? "") {
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
        comments.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: CommentTableCell.identifier, for: indexPath
        ) as? CommentTableCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.updateUI(with: comments[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                deleteComment(byId: comments[indexPath.row].id)
            }
    }
}

