import UIKit

extension MsgVC:  UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return allReturnedMessages.count
        } else if section == 1 && fetchingMore {
            return 1
        }
        return 0
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView){
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if self.offsetCount == 60 { return }
        if offsetY > contentHeight-scrollView.frame.height {
            if !fetchingMore {
                beginBatchFetch(checkOffset: offsetCount)
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as! MessageCell

            cell.messageText.text = allReturnedMessages[indexPath.row]
            cell.contentView.transform = CGAffineTransform(scaleX: 1, y: -1)
            if darkModeEnable == false { cell.messageText.textColor = .black }
            else { cell.messageText.textColor = .white }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "loadingCell", for: indexPath) as! LoadingCell
            cell.transform = CGAffineTransform(rotationAngle: (-.pi))
            
            cell.contentView.transform = CGAffineTransform(scaleX: 1, y: -1)
            cell.spinner.startAnimating()
            return cell
        }
    }
    
    
}
