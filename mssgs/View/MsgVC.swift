import UIKit

class MsgVC: UIViewController {
    
    let msgTableView = UITableView()
    var offsetCount = 0
    var fetchingMore = false
    var darkModeEnable = true
    var allReturnedMessages: [String] = []
    let vm = MessageViewModel()
    let alert = UIAlertController(title: "Connection error", message: "try again", preferredStyle: .alert)
   
    override func viewWillAppear(_ animated: Bool) {
        msgTableView.estimatedRowHeight = 100.0
        msgTableView.rowHeight = UITableView.automaticDimension
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .white
        setupAlertController()
        reloadMessages()
        setupMsgTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if #available(iOS 12.0, *) {
            if self.traitCollection.userInterfaceStyle == .dark {
                self.darkModeEnable = true
            } else {
                darkModeEnable = false
            }
        }
}
    

    
    func reloadMessages() {
        let stringCount = String(offsetCount)
        vm.fetchMessages(by: stringCount, forVC: self) { [weak self] in
            self?.allReturnedMessages = (self?.vm.returnedMessages)!
          self?.msgTableView.reloadData()
        }
    }
    
    func beginBatchFetch(checkOffset: Int) {
        fetchingMore = true
        msgTableView.reloadSections(IndexSet(integer:1),with:.none)
        self.offsetCount += 20
        if checkOffset == -1 { self.offsetCount -= 20}
        let stringCount = String(self.offsetCount)
        DispatchQueue.main.asyncAfter(deadline:.now()+1.0,execute:{
        var newItems = [String]()
            self.vm.fetchMessages(by: stringCount, forVC: self) { [weak self] in
                newItems = (self?.vm.returnedMessages)!
            self?.allReturnedMessages.append(contentsOf: newItems)
            self?.fetchingMore = false
            self?.msgTableView.reloadData()
            }
        })
    }
    
    func setupAlertController() {
        alert.addAction(UIAlertAction(title: "reload", style: .cancel, handler: { [weak self] (action) in
              self?.alert.show(self!, sender: .none)
               self?.beginBatchFetch(checkOffset: -1)
           }))
    }
    
}
