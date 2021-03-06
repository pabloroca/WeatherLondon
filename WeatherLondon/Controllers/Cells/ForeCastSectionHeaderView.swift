//
//  ForeCastSectionHeaderView.swift
//  WeatherLondon
//
//  Created by Pablo Roca Rozas on 11/10/18.
//  Copyright © 2018 PR2Studio. All rights reserved.
//

import UIKit

class ForeCastSectionHeaderView: UITableViewHeaderFooterView {

    // MARK: Constants

    struct LayoutConstants {
        static let headerHeight: CGFloat = 36.0
    }

    // MARK: - Properties

    var viewModel: ForeCastSectionHeaderViewModel? {
        didSet {
            self.update()
        }
    }

    // MARK: - Views

    private let lblDate: UILabel = {
        let label = UILabel()
        label.font = UIFont.pr2FontHeader()
        label.textColor = UIColor.pr2ColorMain
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let lblTempMin: UILabel = {
        let label = UILabel()
        label.font = UIFont.pr2FontHeader()
        label.textColor = UIColor.pr2ColorBlue
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let lblTempMax: UILabel = {
        let label = UILabel()
        label.font = UIFont.pr2FontHeader()
        label.textColor = UIColor.pr2ColorRed
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let lblSuggestion: UILabel = {
        let label = UILabel()
        label.font = UIFont.pr2FontHeader()
        label.textColor = UIColor.pr2ColorMain
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Initializers

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View config

    override func updateConstraints() {

        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: LayoutConstants.headerHeight),
            lblDate.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.kMarginNormal),
            lblDate.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            lblTempMin.leftAnchor.constraint(equalTo: lblDate.rightAnchor, constant: Constants.kMarginNormal),
            lblTempMin.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            lblTempMax.leftAnchor.constraint(equalTo: lblTempMin.rightAnchor, constant: Constants.kMarginNormal),
            lblTempMax.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            lblSuggestion.leftAnchor.constraint(equalTo: lblTempMax.rightAnchor, constant: Constants.kMarginNormal),
            lblSuggestion.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])

        super.updateConstraints()
    }

    override func prepareForReuse() {
        self.contentView.backgroundColor = UIColor.pr2White
        lblDate.text = nil
        lblDate.textColor = UIColor.pr2ColorMain

        lblTempMin.text = nil
        lblTempMin.textColor = UIColor.pr2ColorBlue

        lblTempMax.text = nil
        lblTempMax.textColor = UIColor.pr2ColorRed

        lblSuggestion.text = nil
        lblSuggestion.textColor = UIColor.pr2ColorMain
        super.prepareForReuse()
    }

    private func setup() {
        contentView.backgroundColor = .white

        contentView.addSubview(lblDate)
        contentView.addSubview(lblTempMin)
        contentView.addSubview(lblTempMax)
        contentView.addSubview(lblSuggestion)
        contentView.setNeedsUpdateConstraints()
    }

    private func update() {
        if let viewModel = self.viewModel {
            lblDate.text = viewModel.title
            lblTempMin.text = viewModel.tempMin.toPriceString(decimalDigits: 1, currencySymbol: "", thousandsSeparator: ",", decimalSeparator: ".")+"°"
            lblTempMax.text = viewModel.tempMax.toPriceString(decimalDigits: 1, currencySymbol: "", thousandsSeparator: ",", decimalSeparator: ".")+"°"
            lblSuggestion.text = viewModel.suggestion
        }
    }

}
