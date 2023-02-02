//
//  ImageListViewController.swift
//  Sequis
//
//  Created by Muhammad Syafrizal on 02/02/23.
//

import Foundation
import UIKit
import SnapKit
import RxSwift

class ImageListViewController: UIViewController {
    private var tvContent: UITableView?
    
    private let viewModel: ImageListViewModel
    private var data: [Domain.ImageEntity] = []
    private var lastPage = 1
    private var vmBag = DisposeBag()
    private var isInit = true
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, viewModel: ImageListViewModel) {
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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if isInit {
            viewModel.getImageList(page: lastPage)
        }
        
        isInit = false
    }

    
    private func subscribeViewModel() {
        viewModel.lastPage = lastPage
        viewModel.errors
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
                .images
                .observeOn(MainScheduler.instance)
                .subscribe(
                        onNext: { [weak self] images in
                            guard let self = self else {
                                return
                            }
                            if self.data.isEmpty {
                                self.initImagesData(images)
                            } else {
                                self.appendImagesData(images)
                            }
                        }
                )
                .disposed(by: vmBag)
    }
}
// MARK: Function
private extension ImageListViewController {
    func initImagesData(_ datas: [Domain.ImageEntity]) {
        self.data =  datas
        tvContent?.reloadData()
    }

    func appendImagesData(_ datas: [Domain.ImageEntity]) {
        appendTableImage(datas)
    }
    
    func requestLoadMore() {
        lastPage += 1
        viewModel.getImageList(page: lastPage)
    }
    
    func appendTableImage(
        _ datas: [Domain.ImageEntity]
    ) {
        data.append(contentsOf: datas)
        tvContent?.reloadData()
        tvContent?.dequeueReusableCell(withIdentifier: ImageTableCell.identifier)
    }

}
// MARK: UIBUILDER
private extension ImageListViewController {
    func initDesign() {
        setupBaseView()
        let tvContent = generateTableView()

        view.addSubview(tvContent)
        tvContent.snp.makeConstraints { (make: ConstraintMaker) -> Void in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }

        self.tvContent = tvContent
    }

    func setupBaseView() {
        view.backgroundColor = .white
        self.navigationItem.title = "Image List"
    }

    func generateTableView() -> UITableView {
        let view = UITableView(frame: .zero,style: .plain)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}

private extension ImageListViewController {
    func initViews() {
        initTableView()
    }
    
    func initTableView() {
        tvContent?.register(
            ImageTableCell.self,
                forCellReuseIdentifier: ImageTableCell.identifier
        )
        self.tvContent?.delegate = self
        self.tvContent?.dataSource = self
        tvContent?.rowHeight = UITableView.automaticDimension
        tvContent?.estimatedRowHeight = 600
    }
}

// MARK: TABLE DELEGATE
extension ImageListViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ImageTableCell.identifier, for: indexPath
        ) as? ImageTableCell else {
            print(88)
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.updateUI(with: data[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let table = tvContent else {
            return
        }
        let y = scrollView.contentOffset.y/(scrollView.contentSize.height - scrollView.frame.size.height)
        let relativeHeight = 1 - (table.rowHeight / (scrollView.contentSize.height - scrollView.frame.size.height))
        if y >= relativeHeight{
            requestLoadMore()
        }
    }
}
