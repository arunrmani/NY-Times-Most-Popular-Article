//
//  ArticleDetailsViewController.swift
//  NY Articles
//
//  Created by Safe City Mac 001 on 22/12/2021.
//

import UIKit

class ArticleDetailsViewController: UIViewController {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var subTitleLbl: UILabel!
    @IBOutlet weak var authorLbl: UILabel!
    @IBOutlet weak var publishedDateLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var detailsLbl: UILabel!

    @IBOutlet weak var imagePreView: UIImageView!

    
    var articleDetailsVM: ArticleDetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButtionAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func readArticle(_ sender: UIButton) {
        self.articleDetailsVM?.openReadMore()
    }
    func bindViewModel(){
        self.articleDetailsVM?.articleData.bind({[unowned self] articleData in
            self.titleLbl.text = articleData?.title ?? ""
            self.subTitleLbl.text = articleData?.abstract ?? ""
            self.authorLbl.text = articleData?.byline ?? ""
            self.publishedDateLbl.text = "Published Date: \(articleData?.getFormatedDate() ?? "")"
            self.typeLbl.text = "Section: \(articleData?.section ?? "")"
            self.detailsLbl.text = "Type: \(articleData?.type ?? "")"
            if let media = articleData?.media,media.count > 0 ,let imgUrl =  media[0].getImageUrl(imageType: .medium440){
                self.imagePreView.sd_setImage(with: URL(string: imgUrl), placeholderImage: UIImage(named: "sampleIcon"))
            }
        })
        
        self.articleDetailsVM?.errorUrl.bind({ status in
            if status{
                self.showAlert(title: "Error", message: "URL Un-available")
            }
        })
    }

}
