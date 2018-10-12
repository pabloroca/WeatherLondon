//
//  ForeCastViewController.swift
//  WeatherLondon
//
//  Created by Pablo Roca Rozas on 11/10/18.
//  Copyright © 2018 PR2Studio. All rights reserved.
//

import UIKit
import PR2StudioSwift
import Kingfisher

final class ForeCastViewController: UIViewController {

    // MARK: - Properties
    var viewModel: ForeCastViewModel!

    // MARK: - UI Elements

    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.separatorStyle = .none
        view.registerCellClass(ofType: ForeCastCell.self)
        view.registerHeaderFooterClass(ofType: ForeCastSectionHeaderView.self)
        view.tableFooterView = UIView()
        view.sectionHeaderHeight = ForeCastSectionHeaderView.LayoutConstants.headerHeight
        view.rowHeight = ForeCastCell.designatedHeight
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var waitingIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .gray
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()

    // MARK: - Init

    init(viewModel: ForeCastViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // Register to receive notification
//        NotificationCenter.default.addObserver(self, selector: #selector(ForeCastViewController.showSlowInterNet), name: Notification.Name(rawValue: PR2NetworkingNotifications.slowInternet), object: nil)

        refreshData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: PR2NetworkingNotifications.slowInternet), object: nil)
    }

    // MARK: - Private

    private func configureUI() {
        title = viewModel.title
        view.backgroundColor = UIColor.pr2White

        view.addSubview(tableView)
        view.addSubview(waitingIndicator)
        //waitingIndicator.bringSubviewToFront(view)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            waitingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            waitingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
    }

    private func refreshData() {
        waitingIndicator.isHidden = false
        waitingIndicator.startAnimating()
        viewModel.readData {[weak self] (success) in
            guard let self = self else { return }
            self.waitingIndicator.isHidden = true
            self.waitingIndicator.stopAnimating()
            if success {
                self.tableView.reloadData()
            }
        }
    }
    
}

// MARK: - UITableViewDataSource
extension ForeCastViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ofType: ForeCastCell.self, for: indexPath)
        let row = viewModel.row(at: indexPath)

        cell.imgIcon.kf.indicatorType = .activity
        let imgURL = APIConstants.image+row.icon+".png"
        let resourceOut = ImageResource(downloadURL: URL(string: imgURL)!, cacheKey: row.icon)
        cell.imgIcon.kf.setImage(with: resourceOut)

        cell.configure(viewModel: row)
        return cell
    }

}

// MARK: - UITableViewDelegate
extension ForeCastViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(ofType: ForeCastCell.self, for: indexPath)
        cell.imgIcon.kf.cancelDownloadTask()
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(ofType: ForeCastSectionHeaderView.self)
        header.viewModel = viewModel.headerViewModel(section: section)
        return header
    }

}
