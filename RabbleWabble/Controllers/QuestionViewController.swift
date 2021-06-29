//
//  ViewController.swift
//  RabbleWabble
//
//  Created by admin on 2021/6/25.
//

import UIKit
import SnapKit

public protocol QuestionViewControllerDelegate: class {

    func questionViewController(
        _ viewController: QuestionViewController,
        didCancel questionStrategy: QuestionStrategy)

    func questionViewController(
        _ viewController: QuestionViewController,
        didComplete questionStrategy: QuestionStrategy)
}

public class QuestionViewController: UIViewController {

    // MARK: - Instance Properties
    public weak var delegate: QuestionViewControllerDelegate?

    public var questionStrategy: QuestionStrategy! {
      didSet {
        navigationItem.title = questionStrategy.title
      }
    }

    private lazy var questionIndexItem: UIBarButtonItem = {
        let item = UIBarButtonItem(title: "",
                                   style: .plain,
                                   target: nil,
                                   action: nil)
        item.tintColor = .black
        navigationItem.rightBarButtonItem = item
        return item
    }()

    public var questionView = QuestionView()

    // MARK: - View Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        setupView()
        setupCancelButton()
        showQuestion()
    }

    private func setupView() {
        self.view.addSubview(questionView)
        questionView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleAnswerLabels(_:)))
        questionView.addGestureRecognizer(tapGesture)
        questionView.correctButton.addTarget(self, action: #selector(handleCorrect(_:)), for: .touchUpInside)
        questionView.incorrectButton.addTarget(self, action: #selector(handleIncorrect(_:)), for: .touchUpInside)
    }

    private func setupCancelButton() {
        let action = #selector(handleCancelPressed(sender:))
        let image = UIImage(named: "ic_menu")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image,
                                                           landscapeImagePhone: nil,
                                                           style: .plain,
                                                           target: self,
                                                           action: action)
    }

    @objc private func handleCancelPressed(sender: UIBarButtonItem) {
        delegate?.questionViewController(self,
                                         didCancel: questionStrategy)
    }

    private func showQuestion() {
        let question = questionStrategy.currentQuestion()

        questionView.answerLabel.text = question.answer
        questionView.promptLabel.text = question.prompt
        questionView.hintLabel.text = question.hint

        questionView.answerLabel.isHidden = true
        questionView.hintLabel.isHidden = true

        questionIndexItem.title = questionStrategy.questionIndexTitle()
    }

    // MARK: - Actions
    @objc
    func toggleAnswerLabels(_ sender: Any) {
        questionView.answerLabel.isHidden = !questionView.answerLabel.isHidden
        questionView.hintLabel.isHidden = !questionView.hintLabel.isHidden
    }

    @objc
    func handleCorrect(_ sender: Any) {
        let question = questionStrategy.currentQuestion()
        questionStrategy.markQuestionCorrect(question)

        questionView.correctCountLabel.text =
          String(questionStrategy.correctCount)
        showNextQuestion()
    }

    @objc
    func handleIncorrect(_ sender: Any) {
        let question = questionStrategy.currentQuestion()
        questionStrategy.markQuestionIncorrect(question)

        questionView.incorrectCountLabel.text =
          String(questionStrategy.incorrectCount)
        showNextQuestion()
    }

    private func showNextQuestion() {
        guard questionStrategy.advanceToNextQuestion() else {
          delegate?.questionViewController(self,
            didComplete: questionStrategy)
          return
        }
        showQuestion()
    }
}

