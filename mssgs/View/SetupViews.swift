import UIKit

extension MsgVC {
    func setupMsgTableView() {
        view.addSubview(msgTableView)
        
        msgTableView.transform = CGAffineTransform(rotationAngle: (-.pi))
        msgTableView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: msgTableView.bounds.size.width - 10)
        
        msgTableView.transform = CGAffineTransform(scaleX: 1, y: -1)
        
        msgTableView.register(UINib(nibName: "LoadingCell", bundle: nil), forCellReuseIdentifier: "loadingCell")
        msgTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "messageCell")
        msgTableView.separatorStyle = .none
        msgTableView.delegate = self
        msgTableView.dataSource = self
        msgTableView.translatesAutoresizingMaskIntoConstraints = false
        msgTableView.allowsSelection = false
        
        msgTableView.tableFooterView = UIView()
        NSLayoutConstraint.activate([
            msgTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            msgTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            msgTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            msgTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
}


