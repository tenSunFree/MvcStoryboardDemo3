import UIKit
import Kingfisher

class HomeUITableViewCell: UITableViewCell {
    
    @IBOutlet private weak var beerImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var descLabel: UILabel!
    
    func setupView(model: HomeModel) {
        DispatchQueue.main.async {
            self.beerImageView.kf.setImage(with: URL(string: model.imageURL ?? ""))
            self.beerImageView.layer.borderWidth = 1
            self.beerImageView.layer.masksToBounds = false
            self.beerImageView.layer.borderColor = UIColor.black.cgColor
            self.beerImageView.layer.cornerRadius = self.beerImageView.frame.height/2
            self.beerImageView.clipsToBounds = true
            self.beerImageView.contentMode = .scaleAspectFill
            self.nameLabel.text =  model.name ?? ""
            self.nameLabel.lineBreakMode = .byTruncatingTail
            self.nameLabel.numberOfLines = 1
            self.nameLabel.textAlignment = .left
            self.nameLabel.textAlignment = .left
            self.descLabel.text = model.description ?? ""
            self.descLabel.lineBreakMode = .byTruncatingTail
            self.descLabel.numberOfLines = 1
            self.descLabel.textAlignment = .left
        }
    }
}
