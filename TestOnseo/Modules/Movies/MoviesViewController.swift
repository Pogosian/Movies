//
//  MoviesViewController.swift
//  TestOnseo
//
//  Created by Oleg Pogosian on 04.07.2020.
//  Copyright © 2020 Oleg Pogosian All rights reserved.
//

import UIKit

protocol MoviesViewControllerProtocol: BaseViewControllerProtocol {
    func startActivityIdicator()
    func stopActivityIdicator()
    func reloadTable()
    func pushToVC(_ vc: UIViewController)
}

class MoviesViewController: UIViewController {
        
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    
    var presenter: MoviesPresenterProtocol!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = MoviesPresenter(view: self)
        setupViews()
    }
    
    // MARK: - UI
    
    private func setupViews() {
        setupTableView()
        activityIndicator.center = self.view.center
        startActivityIdicator()
        setupNavBar()
    }
    
    private func setupTableView() {
        tableView.register(MovieTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupNavBar() {
        self.title = "Movies"
    }
    
    // MARK: - IBActions
    
}

extension MoviesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        presenter.getCountItem()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.create(MovieTableViewCell.self, indexPath)
        presenter.configurateCell(cell, item: indexPath.section)
        return cell
    }
}

extension MoviesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.pressCell(indexPath.section)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        presenter.scrolingToItem(indexPath.section)
    }
    
    //Header
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        heightForHeader()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        heightForHeader()
    }
    
    private func heightForHeader() -> CGFloat {
        .leastNonzeroMagnitude
    }
    
    //Footer
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView()
        footer.backgroundColor = .clear
        return footer
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        heightForFooter()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        heightForFooter()
    }
    
    private func heightForFooter() -> CGFloat {
        presenter.heightForFooter()
    }
    
    //Cell
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        presenter.heightForCell()
    }
    
}

extension MoviesViewController: MoviesViewControllerProtocol {

    func startActivityIdicator() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
    }
    
    func stopActivityIdicator() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
    }
    
    func reloadTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func pushToVC(_ vc: UIViewController) {
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
