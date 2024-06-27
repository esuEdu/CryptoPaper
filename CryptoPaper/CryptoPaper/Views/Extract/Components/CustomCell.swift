import UIKit

class CustomCell: UITableViewCell {
    
    static let identifier = "CustomCell"
    
//    private var coinImage: UIImageView = {
//        let image = UIImageView()
//        image.contentMode = .scaleAspectFit
//        image.image = UIImage(systemName: "questionmark")
//        image.tintColor = .label
//        image.translatesAutoresizingMaskIntoConstraints = false
//        return image
//    }()
    
    private let coinTickerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.text = "Ticker"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let paidLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.text = "Paid"
        label.font = label.font.withSize(15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let qtdPurchasedLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.text = "Purchased"
        label.font = label.font.withSize(20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.text = "Price"
        label.font = label.font.withSize(15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        // Vertical stack for the left side labels
        let leftStackView = UIStackView(arrangedSubviews: [coinTickerLabel, paidLabel])
        leftStackView.axis = .vertical
        leftStackView.alignment = .leading
        leftStackView.distribution = .fillProportionally
        leftStackView.spacing = 4
        leftStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Vertical stack for the right side labels
        let rightStackView = UIStackView(arrangedSubviews: [qtdPurchasedLabel, priceLabel])
        rightStackView.axis = .vertical
        rightStackView.alignment = .trailing
        rightStackView.distribution = .fillProportionally
        rightStackView.spacing = 4
        rightStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Horizontal stack to contain the image and the two vertical stacks
        let mainStackView = UIStackView(arrangedSubviews: [/*coinImage, */leftStackView, rightStackView])
        mainStackView.axis = .horizontal
        mainStackView.alignment = .center
        mainStackView.distribution = .fillProportionally
        mainStackView.spacing = 16
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
//            coinImage.heightAnchor.constraint(equalToConstant: 30),
//            coinImage.widthAnchor.constraint(equalToConstant: 30),
            
            mainStackView.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor)
        ])
        
        // Setting compression resistance and hugging priority to make sure labels resize correctly
        coinTickerLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        paidLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        qtdPurchasedLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        priceLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        coinTickerLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        paidLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        qtdPurchasedLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        priceLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    }
    
    public func config(/*with image: UIImage, */tickerLabel: String, paidValue: Double, quantityPurchased: Double) {
//        self.coinImage.image = image
        self.coinTickerLabel.text = tickerLabel
        self.paidLabel.text = String(format: "Paid: $%.4f", paidValue)
        self.qtdPurchasedLabel.text = String(format: "%.4f", quantityPurchased)
        self.priceLabel.text = String(format: "Price: $%.4f", (paidValue/quantityPurchased))
    }
}
