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
        didCancel questionGroup: QuestionGroup,
        at questionIndex: Int)

    func questionViewController(
        _ viewController: QuestionViewController,
        didComplete questionGroup: QuestionGroup)
}

public class QuestionViewController: UIViewController {

    // MARK: - Instance Properties
    public weak var delegate: QuestionViewControllerDelegate?
    public var questionGroup: QuestionGroup! {
      didSet {
        navigationItem.title = questionGroup.title
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

    public var questionIndex = 0

    public var correctCount = 0
    public var incorrectCount = 0

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
                                         didCancel: questionGroup,
                                         at: questionIndex)
    }

    private func showQuestion() {
        let question = questionGroup.questions[questionIndex]

        questionView.answerLabel.text = question.answer
        questionView.promptLabel.text = question.prompt
        questionView.hintLabel.text = question.hint

        questionView.answerLabel.isHidden = true
        questionView.hintLabel.isHidden = true

        questionIndexItem.title = "\(questionIndex + 1)/" + "\(questionGroup.questions.count)"
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
            delegate?.questionViewController(self,
                                             didComplete: questionGroup)
            return
        }
        showQuestion()
    }
}

