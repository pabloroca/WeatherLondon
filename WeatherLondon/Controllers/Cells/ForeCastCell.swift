//
//  ForeCastCell.swift
//  WeatherLondon
//
//  Created by Pablo Roca Rozas on 11/10/18.
//  Copyright © 2018 PR2Studio. All rights reserved.
//

import UIKit

class ForeCastCell: UITableViewCell {

    static let designatedHeight: CGFloat = 40

    private struct LayoutConstants {
        static let marginMultiplier: CGFloat = 7.0
        static let lblHourWidth: CGFloat = 50.0
        static let lblWeatherTypeWidth: CGFloat = 60.0
    }

    // MARK: - Views

    private let lblHour: UILabel = {
        let label = UILabel()
        label.font = UIFont.pr2FontHeader()
        label.textColor = UIColor.pr2ColorMain
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let imgIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let lblWeatherType: UILabel = {
        let label = UILabel()
        label.font = UIFont.pr2FontHeader()
        label.textColor = UIColor.pr2ColorMain
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let lblTemp: UILabel = {
        let label = UILabel()
        label.font = UIFont.pr2FontHeader()
        label.textColor = UIColor.pr2ColorMain
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        contentView.addSubview(lblHour)
        contentView.addSubview(imgIcon)
        contentView.addSubview(lblWeatherType)
        contentView.addSubview(lblTemp)

        contentView.backgroundColor = UIColor.pr2ColorLightGrey
        contentView.setNeedsUpdateConstraints()
    }

    override func updateConstraints() {

        NSLayoutConstraint.activate([
            lblHour.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstants.marginMultiplier*Constants.kMarginNormal),
            lblHour.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            lblHour.widthAnchor.constraint(equalToConstant: LayoutConstants.lblHourWidth),
            imgIcon.leftAnchor.constraint(equalTo: lblHour.rightAnchor, constant: Constants.kMarginNormal),
            imgIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            lblWeatherType.leftAnchor.constraint(equalTo: imgIcon.rightAnchor, constant: Constants.kMarginNormal),
            lblWeatherType.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            lblWeatherType.widthAnchor.constraint(equalToConstant: LayoutConstants.lblWeatherTypeWidth),
            lblTemp.leftAnchor.constraint(equalTo: lblWeatherType.rightAnchor, constant: Constants.kMarginNormal),
            lblTemp.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])

        super.updateConstraints()

    }

    override func prepareForReuse() {
        self.contentView.backgroundColor = UIColor.pr2White
        lblHour.text = nil
        lblHour.textColor = UIColor.pr2ColorMain

        lblWeatherType.text = nil
        lblWeatherType.textColor = UIColor.pr2ColorMain

        lblTemp.text = nil
        lblTemp.textColor = UIColor.pr2ColorMain
        super.prepareForReuse()

    }

    func configure(viewModel: ForeCastCellViewModel) {
        lblHour.text = viewModel.lblHour
        lblWeatherType.text = viewModel.lblWeatherType
        lblTemp.text = viewModel.lblTemp
    }

}
