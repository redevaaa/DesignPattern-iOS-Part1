//
//  ViewController.swift
//  RabbleWabble
//
//  Created by admin on 2021/6/25.
//

import UIKit
import SnapKit

public class QuestionViewController: UIViewController {

    // MARK: - Instance Properties
    public var questionGroup = QuestionGroup.basicPhrases()
    public var questionIndex = 0

    public var correctCount = 0
    public var incorrectCount = 0

    public var questionView = QuestionView()

    // MARK: - View Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        self.view.addSubview(questionView)
        questionView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }

        setupGesture()
        showQuestion()
    }

    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleAnswerLabels(_:)))
        questionView.addGestureRecognizer(tapGesture)
        questionView.correctButton.addTarget(self, action: #selector(handleCorrect(_:)), for: .touchUpInside)
        questionView.incorrectButton.addTarget(self, action: #selector(handleIncorrect(_:)), for: .touchUpInside)
    }

    private func showQuestion() {
        let question = questionGroup.questions[questionIndex]

        questionView.answerLabel.text = question.answer
        questionView.promptLabel.text = question.prompt
        questionView.hintLabel.text = question.hint

        questionView.answerLabel.isHidden = true
        questionView.hintLabel.isHidden = true
    }

    // MARK: - Actions
    @objc
    func toggleAnswerLabels(_ sender: Any) {
        questionView.answerLabel.isHidden = !questionView.answerLabel.isHidden
        questionView.hintLabel.isHidden = !questionView.hintLabel.isHidden
    }

    @objc
    func handleCorrect(_ sender: Any) {
        correctCount += 1
        questionView.correctCountLabel.text = "\(correctCount)"
        showNextQuestion()
    }

    @objc
    func handleIncorrect(_ sender: Any) {
        incorrectCount += 1
        questionView.incorrectCountLabel.text = "\(incorrectCount)"
        showNextQuestion()
    }

    private func showNextQuestion() {
        questionIndex += 1
        guard questionIndex < questionGroup.questions.count else {
            // TODO: - Handle this...!
            return
        }
        showQuestion()
    }
}

