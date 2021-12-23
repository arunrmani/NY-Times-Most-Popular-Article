//
//  ArticleListViewController.swift
//  NY Articles
//
//  Created by Safe City Mac 001 on 22/12/2021.
//

import UIKit
import SDWebImage
class ArticleListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
     var articleListVM = ArticleListViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindModel()
        self.articleListVM.getMostPopularArticleList()
        // Do any additional setup after loading the view.
    }
    

    private func bindModel(){
        self.articleListVM.articleList.bind {[unowned self] dataList in
            if dataList.count > 0{
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        self.articleListVM.gaTodetails.bind { status in
            if status{
                self.performSegue(withIdentifier: "ToArticleDetails", sender: self)
            }
        }
        
        self.articleListVM.showError.bind { error in
            if error != nil{
                self.showAlert(title: "Error", message: error?.description ?? "")
            }
        }
    }
        // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ArticleDetailsViewController{
            destination.articleDetailsVM = ArticleDetailsViewModel(selectedArticle: articleListVM.selectedArticle.value!)
        }
           
    }

}

extension ArticleListViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleListVM.articleListCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ArticleDataCell.identifier, for: indexPath) as! ArticleDataCell
        if let articleData = self.articleListVM.getArticle(at: indexPath.row){
            cell.setCell(data: articleData)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.articleListVM.selectArticle(index: indexPath.row)
    }
    
}


class ArticleDataCell : UITableViewCell{
    static let identifier = "ArticleDataCell"
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var articleNameLbl: UILabel!
    @IBOutlet weak var authorLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!

    func setCell(data:ArticleData) {
        
        self.articleNameLbl.text = data.title ?? ""
        self.authorLbl.text = data.byline ?? ""
        self.dateLbl.text = data.getFormatedDate() ?? ""
        if let media = data.media,media.count > 0 ,let imgUrl =  media[0].getImageUrl(imageType: .thumbNail){
            self.iconImage.sd_setImage(with: URL(string: imgUrl), placeholderImage: UIImage(named: "sampleIcon"))
        }
        
    }
}
