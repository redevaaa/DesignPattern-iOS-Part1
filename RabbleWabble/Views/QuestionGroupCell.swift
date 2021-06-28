//
//  QuestionGroupCell.swift
//  RabbleWabble
//
//  Created by admin on 2021/6/25.
//

import UIKit

public class QuestionGroupCell: UITableViewCell {
    public var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        return label
    }()
    public var percentageLabel: UILabel = {
        let label = UILabel()
        label.text = "0%"
        return label
    }()

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(percentageLabel)
        percentageLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.top.leading.bottom.equalToSuperview().inset(contentView.layoutMargins)
        }
        percentageLabel.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(titleLabel.snp.trailing).offset(8)
            make.top.trailing.bottom.equalToSuperview().inset(contentView.layoutMargins)
        }
    }
}
