//
//  QuestionView.swift
//  RabbleWabble
//
//  Created by admin on 2021/6/25.
//

import UIKit

public class QuestionView: UIView {
    public var promptLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 50)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Prompt"
        return label
    }()

    public var hintLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Hint"
        return label
    }()

    public var answerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 48)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Answer"
        return label
    }()

    public var incorrectCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 32)
        label.textAlignment = .center
        label.textColor = .red
        label.text = "0"
        return label
    }()

    public var correctCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 32)
        label.textAlignment = .center
        label.textColor = .green
        label.text = "0"
        return label
    }()

    public var incorrectButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "ic_circle_x"), for: UIControl.State.normal)
        return button
    }()

    public var correctButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "ic_circle_check"), for: UIControl.State.normal)
        return button
    }()


    public override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        self.addSubview(promptLabel)
        self.addSubview(hintLabel)
        self.addSubview(answerLabel)

        self.addSubview(incorrectButton)
        self.addSubview(correctButton)
        self.addSubview(incorrectCountLabel)
        self.addSubview(correctCountLabel)
    }

    private func setupConstraints() {
        promptLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalToSuperview().offset(60)
            make.leading.trailing.equalToSuperview()
        }
        hintLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(promptLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
        }
        answerLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(hintLabel.snp.bottom).offset(50)
            make.leading.trailing.equalToSuperview()
        }

        incorrectButton.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(incorrectCountLabel.snp.top).offset(-8)
            make.leading.equalToSuperview().inset(32)
        }
        correctButton.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(correctCountLabel.snp.top).offset(-8)
            make.trailing.equalToSuperview().inset(32)
        }
        incorrectCountLabel.snp.makeConstraints { (make) -> Void in
            make.bottom.equalToSuperview().inset(24)
            make.centerX.equalTo(incorrectButton)
        }
        correctCountLabel.snp.makeConstraints { (make) -> Void in
            make.bottom.equalToSuperview().inset(24)
            make.centerX.equalTo(correctButton)
        }
    }
}
