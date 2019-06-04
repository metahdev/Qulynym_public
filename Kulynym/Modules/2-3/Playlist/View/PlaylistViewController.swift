//
/*
* Kulynym
* PlaylistViewController.swift
*
* Created by: Metah on 5/12/19
*
* Copyright © 2019 Automatization X Software. All rights reserved.
*/

import UIKit

protocol PlaylistViewProtocol: class {
    var isKaraoke: Bool! { get set}
    var content: [Playlist] { get set}
}

class PlaylistViewController: UIViewController, PlaylistViewProtocol {
    // MARK:- Properties
    var isKaraoke: Bool!
    var content = [Playlist]()
    var presenter: PlaylistPresenterProtocol!
    
    private weak var listTableView: UITableView!
    private weak var closeBtn: UIButton!
    private weak var titleLabel: UILabel!
    
    private var autoLayout: PlaylistAutoLayoutProtocol!
    private let configurator: PlaylistConfiguratorProtocol = PlaylistConfigurator()
    
    
    // MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        
        initLayout()
        autoLayout.setupLayout()
        assignViews()
        setupTableView()
        assignActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getContent()
    }
    
    
    // MARK:- Layout
    private func initLayout() {
        autoLayout = PlaylistAutoLayout(view: self.view)
    }
    
    private func assignViews() {
        self.listTableView = autoLayout.listTableView
        self.closeBtn = autoLayout.closeBtn
        self.titleLabel = autoLayout.titleLabel
    }
    
    
    // MARK:- ListTableView
    private func setupTableView() {
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
    }
    
    
    // MARK:- Actions
    private func assignActions() {
        closeBtn.addTarget(self, action: #selector(closeBtnPressed), for: .touchUpInside)
    }
    
    @objc private func closeBtnPressed() {
        presenter.closeView()
    }
}

extension PlaylistViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK:- UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseID", for: indexPath) as! PlaylistTableViewCell
        cell.imageName = content[indexPath.row].name
        return cell
    }
    
    
    // MARK:- UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height * 0.4
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.openItem(at: indexPath.row)
    }
}
